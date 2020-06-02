
## Reading in file with state demographic characteristics
state <- readxl::read_xlsx('D:/UMN - Materials/3. Spring/MSBA 6440/Project/State Similarity Index.xlsx')
View(state)

## Converting numeric columns from string to double
state_numeric <- data.frame(apply(state[,2:10], 2, as.double))

## Creating a normalized table for calculating Euclidean distance
xx <- normalize(state_numeric, method='standardize', range=c(0,1), margin=2)

## Calculating Euclidean distance
library(cluster)
gower.dist <- daisy(xx)
gower.dist <- as.matrix(xx)

## Taking 8th index - colorado state
View(sort(gower.dist[,8]))

## 12, 32, 15, 5, 21 - are the top 5 state indices

state %>% filter(rownames(state) %in% c('12', '32', '15', '5', '20'))


### --------------------------------------------------------------------------------------------------------------------------

#### DiD Regression ####

library(plm)
library(dplyr)
library(ggplot2)

#### Load the data ####
data = readxl::read_xlsx("D:/UMN - Materials/3. Spring/MSBA 6440/Project/CrimeCountData.xlsx", sheet = 1)

data <- data %>% group_by(State) %>% mutate(time = 1:26) %>% ungroup()
colnames(data)[3] <- "CrimeCount"

## Fixing a placebo test date for the placebo test, i.e. an artifical start time
data <- data %>% mutate(After1 = ifelse(time>=10,1,0))

## Making two datasets for later use in Dynamic DiD - one without Arizona, one without Virginia
data_az_co <- data %>% filter(State != 'Virginia')
data_va_co <- data %>% filter(State != 'Arizona')


# As descriptive visualization, we take a look at the crime trends for each of the 3 states
ggplot(data) + aes(x = time, y = CrimeCount, col=factor(State)) + geom_line() + geom_vline(xintercept = 13) + 
  xlab('Time Frame - Month number starting from Nov 2011') + ylab('Count of Crimes') + theme_bw()

ggplot(data_az_co) + aes(x = time, y = CrimeCount, col=factor(State)) + geom_line() + geom_vline(xintercept = 13)

#### Difference in Differences Regression ####
# Interpreting the treatment effect

data$Legal <- as.factor(data$Legal)
data$After <- as.factor(data$After)

## Two way panel regression to evaluate the difference in differences
did_fe <- plm(log(CrimeCount) ~ Legal + After + Legal*After, effect='twoway',
               index=c('State','time') ,model='within',data=data_az_co)
summary(did_fe)


## Two way panel regression to evaluate difference in differences with Placebo effect
did_fe_pl <- plm(log(CrimeCount) ~ Legal + After1 + Legal*After1, effect='twoway',
              index=c('State','time') ,model='within',data=data_az_co)

summary(did_fe_pl)


# Dynamic DiD to figure out the parallel trend - AZ and CO; VA and CO
did_dyn1 <- lm(log(CrimeCount) ~ Legal + factor(time) + Legal*factor(time), data=data_az_co)
summary(did_dyn1)

did_dyn2 <- lm(log(CrimeCount) ~ Legal + factor(time) + Legal*factor(time), data=data_va_co)
summary(did_dyn2)


## Making a dataframe of coefficients of the dynamic DiD test
coeff_data<- data.frame(did_dyn1$coefficients[3:14], did_dyn2$coefficients[3:14])
colnames(coeff_data) <- c('WithArizona','WithVirgnia')
coeff_data_melted <- melt(coeff_data)
coeff_data_melted <- coeff_data_melted %>% group_by(variable) %>% mutate(time = c(1:12))


## plotting dynamic DiD results
ggplot(coeff_data_melted[coeff_data_melted$time<6,]) + aes(x = time, y = value, col=factor(variable)) + geom_line() +
   geom_hline(yintercept = 0) +
   theme_bw() + xlab('Time') + ylab('Beta coefficients') +
   ggtitle('Beta coefficients for Dynamic DiD for parallel trend check')