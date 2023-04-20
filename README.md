# Getting Started

Welcome to your new project.

It contains these folders and files, following our recommended project layout:

File or Folder | Purpose
---------|----------
`app/` | content for UI frontends goes here
`approuter/` | approuter routes go here
`db/` | your domain models and data go here
`srv/` | your service models and code go here
`package.json` | project metadata and configuration
`readme.md` | this getting started guide

## First step
first install the following npm package
```npm i -g recursive-install```
open terminal, and in root folder install all dependecies via
```npm install:all ```

## Initial deployment
to deploy you can open git bash terminal and use 
``` mbt build && cf deploy mta_archives/allmyorders_1.0.0.mtar ```

## note
make sure to access endpoints using app router. if you directly access service you will not be authorized. app router url can be found in the applications within the space
## for local runs
after succesfull deployment you can test your changes locally by following the steps listed below.
you would need to run individual modules seperately.
first check if you have relevant plugins installed using
``` cf plugins ```
if you dont have default-env plugin installed
please install using following command
``` cf install-plugin DefaultEnv ```

### running approuter locally
open a new git bash terminal and execute
``` cd approuter && cf default-env ordermonitoring-approuter ```
this will create a default-env.json file in approuter folder with credential details from BTP
now you just need to run the approuter using the following command
``` npm run start ```
### running service locally
to run service locally, first update default-env.json in the root folder using the following command
``` cf default-env allmyorders-srv ```
your enviornment variables would be packed in default-env.json file in root.
you can now run your application in local mode using 
```cds watch/run ```
result would be coming from data stored in BTP
