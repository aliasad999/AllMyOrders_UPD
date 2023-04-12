# Getting Started

Welcome to your new project.

It contains these folders and files, following our recommended project layout:

File or Folder | Purpose
---------|----------
`app/` | content for UI frontends goes here
`db/` | your domain models and data go here
`srv/` | your service models and code go here
`package.json` | project metadata and configuration
`readme.md` | this getting started guide


## Next Steps

- Open a new terminal and run `cds watch` 
- (in VS Code simply choose _**Terminal** > Run Task > cds watch_)
- Start adding content, for example, a [db/schema.cds](db/schema.cds).


## Learn More

Learn more at https://cap.cloud.sap/docs/get-started/.


## Initial deployment
to deploy you can open git bash terminal and use 
mbt build && cf deploy mta_archives/allmyorders_1.0.0.mtar

## note
make sure to access endpoints using app router. if you directly access service you will not be authorized. app router url can be found in the applications within the space
## for local runs
after succesfull deployment you can test your changes locally by following the steps listed below
first check if you have relevant plugins installed using
cf plugins
if you dont have default-env plugin installed
please install using following command
cf install-plugin DefaultEnv
after succesfully installing run 
cf default-env allmyorders-srv
your enviornment variables would be packed in default-env.json file in root.
you can now run your application in local mode using cds watch/run. result would be coming from data stored in BTP