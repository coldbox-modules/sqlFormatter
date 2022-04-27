component accessors="true" {

	property name="SQLFormatter" inject="javaloader:com.github.vertical_blank.sqlformatter.SqlFormatter";

	property name="params" type="any";

	/**
	 * Constructor.
	 */
	public Formatter function init(){
		return this;
	}

	/**
	 * Configure parameters to use for query placeholders.
	 *
	 * @params Array|Struct
	 */
	public Formatter function withParams( any params ){
		setParams( arguments.params );
		return this;
	}

	/**
	 * Format SQL with the set dialect or `configuration` argument.
	 *
	 * Not chainable.
	 *
	 * @sql          messy SQL string to format.
	 * @formatConfig instance of com.github.vertical_blank.sqlformatter.core.FormatConfig.
	 *
	 * @return prettified SQL string
	 */
	public string function format( required string sql, any formatConfig ){
		var formatter = getSQLFormatter();
		if ( !isNull( arguments.formatConfig ) ) {
			return formatter.format( arguments.sql, arguments.formatConfig );
		}
		if ( !isNull( getParams() ) ) {
			return formatter.format( arguments.sql, getParams() );
		}
		return formatter.format( arguments.sql );
	}

	/**
	 * Set the dialect to use when formatting SQL.
	 *
	 * @cite    https://github.com/vertical-blank/sql-formatter#dialect
	 * @dialect SQL dialect name. Support dialects are `sql`, `mariadb`, `mysql`, `postgresql`, `db2`, `plsql`, `n1ql`, `redshift`, `spark`, `tsql`.
	 */
	public Formatter function of( required string dialect ){
		getSQLFormatter().of( arguments.dialect );
		return this;
	}

	/**
	 * Getter overload to return a Java-safe parameter array or struct.
	 * Only an array or struct can be cast to the appropriate type upon passing to the Formatter object.
	 *
	 * @return Array|Struct parameters.
	 */
	private function getParams(){
		if ( isNull( variables.params ) ) {
			return [];
		}
		if ( !isStruct( variables.params ) && !isArray( variables.params ) ) {
			return [];
		}
		return variables.params;
	}

}
