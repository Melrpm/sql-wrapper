# sql-wrapper
A small wrapper made for Nanos World to help you execute queries.

Requires module 

- luasql

Require the package on top of your script.

`Package:RequirePackage("mysql")`


Example Usage
```
local result = sqlFetch("SELECT characters_names FROM accounts WHERE username='%s'", "Resmurf")
local query = sqlExecute("UPDATE accounts SET characters='%s' WHERE username='%d'", JSON.encode(characters), accountId)
local result = sqlFetchAll('accounts')
```

Will be detailed more indepth later on.

Feel free to report any bugs directly to this github thread.
