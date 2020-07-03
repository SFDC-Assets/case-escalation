sfdx force:org:create -f config/project-scratch-def.json -d 1 -s -w 3
sfdx force:source:push
sfdx force:user:password:generate
#assign permset to user
sfdx force:user:permset:assign --permsetname Audit_Fields
#Load data
sfdx force:data:bulk:upsert -s Account -f data/CaseEscalationAccounts.csv -i External_ID__c -w 3
sfdx force:data:bulk:upsert -s Asset -f data/CaseAssets.csv -i External_ID__c -w 3
sfdx shane:data:dates:update -r 7-1-2020
sfdx force:data:bulk:upsert -s Case -f data-modified/ClosedCases.csv -i External_ID__c -w 3
sfdx force:data:bulk:upsert -s Case -f data-modified/OpenCases.csv -i External_ID__c -w 3
#Install EPB Model Accuracy Package
sfdx force:package:install -p 04t4J000002ASSJ
#Open org
sfdx force:org:open -p /lightning/setup/SetupOneHome/home
