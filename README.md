# SQLFormatter

A CFML wrapper for the Vertical Blank sql-formatter java library.

[![Release](https://github.com/coldbox-modules/sqlFormatter/actions/workflows/ci.yml/badge.svg)](https://github.com/coldbox-modules/sqlFormatter/actions/workflows/ci.yml)

## Installation

Using CommandBox:

```js
box install sqlFormatter
```

## Usage

Basic formatting is done via the `format()` method:

```js
var prettySQL = getInstance( "Formatter@sqlformatter" )
                    .format( "SELECT COUNT(*) FROM users" );
```

For database-specific syntax, you can [choose a dialect](#dialect) using `.of()`:

```js
var prettySQL = getInstance( "Formatter@sqlformatter" )
                    .of( "postgres" )
                    .format( "SELECT COUNT(*) FROM users" );
```

### Advanced Formatting Configuration

You can also specify advanced configuration options via the `ConfgBuilder`:

```js
var formatConfig = getInstance( "ConfigBuilder@sqlformatter" )
                        .setIndent("    ") // Defaults to two spaces
                        .setUppercase(true) // Defaults to false (not safe to use when SQL dialect has case-sensitive identifiers)
                        .setLinesBetweenQueries(2) // Defaults to 1
                        .setMaxColumnLength(80) // Defaults to 50
                        .build();
```

You can then pass the `FormatConfig` object as the second parameter in the `Formatter.format()` method call:

```js
var prettySQL = getInstance( "Formatter@sqlformatter" )
                    .format( "SELECT * FROM pages ORDER BY 'name'", formatConfig );
```

### Parameter Replacement

SQLFormatter supports parameter replacement using either an array of parameters or a struct of key/value params passed to the `.withParams()` method.

For positional parameters, pass an array:

```js
var prettySQL = getInstance( "Formatter@sqlformatter" )
                    .of( "mysql" )
                    .withParams( [ "a", "b", "c" ] )
                    .format( "SELECT * FROM pages WHERE slug IN [?, ?, ?]" );
```

or for named parameters, use a key/value struct:

```js
var prettySQL = getInstance( "Formatter@sqlformatter" )
                    .of( "postgres" )
                    .withParams( { "name" : "Michael", "age" : "18" } )
                    .format( "SELECT * FROM user WHERE name= :michael and age= :age" );
```

> **Warning:** Only certain dialects support parameters, and each dialect uses different syntax. Use the `postgresql` dialect for the `:name` syntax, or `tsql` for `@foo` syntax.

> **Warning:** There is an issue in the underlying library with named placeholders. See [issue #57 on the SQLFormatter repository](https://github.com/vertical-blank/sql-formatter/issues/57) for more details.

### Dialect

[Supported dialects](https://github.com/vertical-blank/sql-formatter#dialect):

* `sql` - Standard SQL
* `mariadb` - MariaDB
* `mysql` - MySQL
* `postgresql` - PostgreSQL
* `db2` - IBM DB2
* `plsql` - Oracle PL/SQL
* `n1ql` - Couchbase N1QL
* `redshift` - Amazon Redshift
* `spark` - Spark
* `tsql` - SQL Server Transact-SQL

## Thanks

Special thanks to the [SQLFormatter library](https://github.com/vertical-blank/sql-formatter). I could'na dunnit without ya. 😉

## Contributing

All contributions welcome! Fixing typos or adding tests are especially easy ways to help out.

To get started hacking on SQLFormatter:

1. Clone the module - `git clone git@github.com:michaelborn/sqlFormatter.git`
2. Install dependencies - `box install`
3. Start up a Lucee server - `box server start serverConfigFile=server-lucee@5.json`
4. Write code
5. Run tests - `box testbox run`
6. Push up a [pull request](https://github.com/michaelborn/sqlFormatter/pulls)

### Updating the SQLFormatter Dependency

To bump the embedded [SQLFormatter library](https://github.com/vertical-blank/sql-formatter), run the following from the module directory root - making sure to replace `2.0.3` with the latest version number:

```bash
rm lib/sql-formatter-*.jar && cd lib && curl -LO https://search.maven.org/remotecontent?filepath=com/github/vertical-blank/sql-formatter/2.0.3/sql-formatter-2.0.3.jar
```

This should place a `sql-formatter-<VERSION>.jar` jar file in the `lib/` directory. All that's needed after that is a `git add lib && git commit && git push` to update the repo.

********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************

# HONOR GOES TO GOD ABOVE ALL

Because of His grace, this project exists. If you don't like this, then don't read it, its not for you.

>"Therefore being justified by faith, we have peace with God through our Lord Jesus Christ:
By whom also we have access by faith into this grace wherein we stand, and rejoice in hope of the glory of God.
And not only so, but we glory in tribulations also: knowing that tribulation worketh patience;
And patience, experience; and experience, hope:
And hope maketh not ashamed; because the love of God is shed abroad in our hearts by the
Holy Ghost which is given unto us. ." Romans 5:5

## THE DAILY BREAD

> "I am the way, and the truth, and the life; no one comes to the Father, but by me (JESUS)" Jn 14:1-12