from __future__ import print_function
import json
from google_auth_oauthlib import flow
from googleapiclient.discovery import build
import requests as reqs

 

appflow = flow.InstalledAppFlow.from_client_secrets_file(
    # Replace client_secrets.json with your own client secret file.
    './client_secret_524501812029-7096ti1gll7q3ods7dnf3himvrr33cli.apps.googleusercontent.com.json',
    scopes=['https://www.googleapis.com/auth/adsdatahub'])
appflow.run_local_server()
credentials = appflow.credentials
developer_key = 'AIzaSyBb1_dtbnFfJSt4iGK1NBMJD3sETgrG2w0'
service = build(
    'AdsDataHub',
    'v1',
    credentials=credentials,
    developerKey=developer_key,
    discoveryServiceUrl='https://adsdatahub.googleapis.com/$discovery/rest?version=v1',
    static_discovery=False
)

def pprint(x):
  print(json.dumps(x, sort_keys=True, indent=4))

customer_query_list = service.customers().analysisQueries().list(parent = 'customers/992193288').execute() # Listing out the queries

AnalysisQuery = {
    "title": "sok_hp_py_test_query",
  "queryText": "SELECT count(distinct(user_id)) FROM adh.cm_dt_impressions"
}

customer_create_query = service.customers().analysisQueries().create(parent = 'customers/992193288', body = AnalysisQuery).execute() #Create a Query - Query already created

customer_start_query = service.customers().analysisQueries().start(name = customer_create_query['name']).execute() #Starting the query

customer_delete_query = service.customers().analysisQueries().delete(name = 'customers/992193288/analysisQueries/337e877be0bb4f25a5f9248e654d48d9').execute() #Deleting the query

customer_list = service.customers().list().execute() #Listing out the user accounts

for customer in customer_list['customers']:
  print(customer.get("name")) #Calling the customers

# Taking User input
customer_name = input('Customer name (e.g. "customer/123"): ').strip()
pprint(service.customers().analysisQueries().list(parent=customer_name).execute())