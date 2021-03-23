___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Data Hash For PII",
  "brand": {
    "id": "brand_dummy",
    "displayName": ""
  },
  "description": "This template to hash all data you need to use for any platform pixels.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "event",
    "displayName": "Event Name",
    "simpleValueType": true,
    "defaultValue": "EH_HASH",
    "alwaysInSummary": false,
    "help": "Please add the name of event you want to use."
  },
  {
    "type": "TEXT",
    "name": "fname",
    "displayName": "First Name",
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "lname",
    "displayName": "Last Name",
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "name",
    "displayName": "Full Name",
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "email",
    "displayName": "Emal",
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "mobile",
    "displayName": "Mobile",
    "simpleValueType": true
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

//APIs
const log = require('logToConsole');
const check = require('queryPermission');
const create = require('createQueue');
const hash = require('sha256');
const map = require('makeTableMap');

// create the function for the dataLayer push
const push = create('dataLayer');
// a function to merge all the object key value pairs
const merge = function(){ 
  const obj = {},
 	     l = arguments.length;
  let i = 0,
      key;
  for (; i < l; i++){
    for (key in arguments[i]) {
      obj[key] = arguments[i][key];
    }
  }
  return obj;
};

const event = {'event': data.event};
var other = [];
if(data.add_fields){
  other = map(data.add_fields, 'key', 'value');
}
else {
  other = [];
  }

//success/failure const

const onSuccess = () =>{
  data.gtmOnSuccess();
};

const onFailure = () => {
  data.gtmOnFailure();
};
  

//Now let's hash

hash(data.fname, (digest1) => {
  hash(data.lname, (digest2) => {
    hash(data.name, (digest3) => {
      hash(data.email, (digest4) => {
        hash(data.mobile, (digest5) => {

    const hashes = {'fname': digest1, 'lname': digest2, 'name': digest3, 'email': digest4, 'mobile': digest5,};
    const dlayer = merge(event, hashes, other);
    if (check('access_globals', 'readwrite', 'dataLayer')) {
    push(dlayer);
    onSuccess();
  }},() =>{onFailure();});
});});});});


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "dataLayer"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 3/23/2021, 1:22:00 PM


