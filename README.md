# Impact-of-Legalization-of-Marijuana-on-Crime-Rate
Marijuana is the most commonly used illicit drug in the United States. Over 94 million people have reported using it at least once, which accounts for nearly 30% of the total population. In 2012, Colorado became the first state to legalize the recreational use of marijuana. However, the impact of this policy remains difficult to evaluate, specifically its impact on crime rates. This analysis aims to evaluate the causal relationship between marijuana legalization and crime rates through a difference in differences regression model. 

### Data Collection
There are two parts of data being collected. 
State Characteristics
In order to identify similar states as Colorado, we need to find attributes at a state level. These attributes/features include median age, total population, population of male, education level, employment rate and so on. The data is generated from the US Census Bureau and can be found here: https://factfinder.census.gov/faces/nav/jsf/pages/index.xhtml. 
The unit of observation is one state in the US
The data collected is in 2012

Crime Data
After we identified similar states, we need to find monthly crime data to test the parallel trend. All of the data is generated directly and indirectly from the government source, which includes the Department of Public Safety and the Department of State Police. The feature that we collected is the number of violent crimes at a monthly level. The violent crime consistent of different crime types, including rape, aggravated assault,  homicide and robbery. The link can be found below (Note that some data are manually collected from the annual report)
https://coloradocrimestats.state.co.us/public/View/dispview.aspx?ReportId=32  (Colorado)
https://www.azdps.gov/sites/default/files/media/Crime_In_Arizona_Report_2011.pdf https://www.azdps.gov/sites/default/files/media/Crime_In_Arizona_Report_2012.pdf 
https://www.azdps.gov/sites/default/files/media/Crime_In_Arizona_Report_2013.pdf (Arizona)
https://www.vsp.virginia.gov/downloads/Crime_in_Virginia/Crime_in_Virginia_2011.pdf 
https://www.vsp.virginia.gov/downloads/Crime_in_Virginia/Crime_in_Virginia_2012.pdf 
https://www.vsp.virginia.gov/downloads/Crime_in_Virginia/Crime_in_Virginia_2013.pdf (Virginia)
The unit of observation is the counts of violent crimes at a monthly level
The data collected is from November 2011 - December 2013, which is one year before and after marijuana was legalized in Colorado. The reason behind this was the assumption that there would be no significant changes within a state in a year prior and after

