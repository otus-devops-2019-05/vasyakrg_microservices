{
"_meta": {
"hostvars": {
  "appserver" : {
    "ansible_host": "${app_address}"
  },
  "dbserver" : {
    "ansible_host": "${db_address}"
  }
}
},
  "app": {
    "hosts": ["appserver"]
  },
  "db": {
    "hosts": ["dbserver"]
  }
}
