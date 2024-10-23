sf demoutil org create scratch -f config/project-scratch-def.json -d 30 -s -w 60 -p case -e escalation.workshop
sf project deploy start

sf demoutil user password set -p salesforce1 -g User -l User
#assign permset to user
sf org assign permset -n Audit_Fields

#Load data
sf data upsert bulk --sobject Account --file data/CaseEscalationAccounts.csv --external-id External_ID__c -w 3
sf data upsert bulk --sobject Asset --file data/CaseAssets.csv --external-id External_ID__c -w 3
sfdx shane:data:dates:update -r 7-1-2020
sf data upsert bulk --sobject Case --file data-modified/ClosedCases.csv --external-id External_ID__c -w 3
sf data upsert bulk --sobject Case --file data-modified/OpenCases.csv --external-id External_ID__c -w 3

#Install EPB Model Accuracy Package
sf package install -p 04t4J000002ASSJ
#Open org
sf org open --url-only --path /lightning/setup/SetupOneHome/home
