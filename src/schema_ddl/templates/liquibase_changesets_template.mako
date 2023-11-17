  - changeSet:
      id: 'mgssfsysadmin-raw-${entity['entity_group']}-${entity['name']}-sql'
      author: Vishal
      changes:
        - sqlFile:
            dbms: 'snowflake'
            path: db/create/create_raw_${entity['entity_group']}_${entity['name']}.sql
            stripComments: true
      rollback:
        - sqlFile:
            dbms: 'snowflake'
            path: db/create/rb_raw_${entity['entity_group']}_${entity['name']}.sql
            stripComments: true

  - changeSet:
      id: 'mgssfsysadmin-trusted-${entity['entity_group']}-${entity['name']}-sql'
      author: Vishal
      changes:
        - sqlFile:
            dbms: 'snowflake'
            path: db/create/create_trusted_${entity['entity_group']}_${entity['name']}.sql
            stripComments: true
      rollback:
        - sqlFile:
            dbms: 'snowflake'
            path: db/create/rb_trusted_${entity['entity_group']}_${entity['name']}.sql
            stripComments: true
