# Issue with prepared statements

## Preparations

- Connect to a SAP BTP Cloud Foundry having a HANA DB space using `cf login`
- Install packages using `npm install`
- Check versions running using `npx cds version`
- Deploy the db using `npx cds deploy --to hana`

## To show the issue

Run `DEBUG=hana npx cds watch --profile hybrid`

The server will start up. There is code inside `server.js` which will run sample queries showcasing the issue. The output will be the following

```
[hana] - BEGIN
[hana] - SELECT id AS "id" FROM my_IntegerKeyedEntity ALIAS_1 WHERE ( id = 123456789 ) LIMIT 1 []
[hana] - COMMIT
[hana] - BEGIN
[hana] - SELECT id AS "id" FROM my_IntegerKeyedEntity ALIAS_1 WHERE ( id = ? ) LIMIT 1 [ '123456789' ]
[hana] - COMMIT
[hana] - BEGIN
[hana] - SELECT id AS "id" FROM my_StringKeyedEntity ALIAS_1 WHERE ( id = ? ) LIMIT 1 [ '123456789' ]
[hana] - COMMIT
```

The first SQL statement is genreated from `await SELECT.from(IntegerKeyedEntity, { id: integerKey });` in `server.js`. The `ìd` is not properly parameterized in this query.

The second SQL statement is querying with a string value for the key (while the models datatype is integer). This makes a properly paramterized statement, but it is not the right way to query this data entity.

The same issue can be observed on the URL's
- `http://localhost:4004/my/StringKeyedEntity('123456789')` - query is properly parameterized
- `http://localhost:4004/my/IntegerKeyedEntity(123456789)` - query is **not** properly parameterized
