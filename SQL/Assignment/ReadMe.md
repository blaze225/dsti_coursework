# Assignment

## Problem statement

Your Python 3 application must accommodate the following requirements:
1. Gracefully handle the connection to the database server.
2. Replicate the algorithm of the dbo.fn_GetAllSurveyDataSQL stored function.
3. Replicate the algorithm of the trigger dbo.trg_refreshSurveyView for creating/altering the view vw_AllSurveyData whenever applicable.
4. For achieving (3) above, a persistence component (in any format you like: CSV, XML, JSON, etc.), storing the last known surveys’ structures should be in place. It is not acceptable to just recreate the view every time: the trigger behaviour must be replicated.
5. Of course, extract the “always-fresh” pivoted survey data, in a CSV file, adequately named.

More details available in the Pdf.

## Implementation

1. SCRIPT USAGE
    Use the command: python sql_app.py <Server_name> 
    (Replace <Server_name> by your Server name)

2. RESULT
    - The script will create/update the view [Survey_Sample_A19].[dbo].[vw_AllSurveyData] in MS SQL Server
    - "PivotedSurveyData.csv" will be generated in the local directory of this script