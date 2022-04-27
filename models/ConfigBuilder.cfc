component accessors="true" {

	property name="FormatConfig" inject="javaloader:com.github.vertical_blank.sqlformatter.core.FormatConfig";

	property
		name   ="linesBetweenQueries"
		type   ="numeric"
		default="1";
	property
		name   ="maxColumnLength"    
		type   ="numeric"
		default="50";
	property
		name   ="uppercase"          
		type   ="boolean"
		default="false";
	property
		name   ="indent"             
		type   ="string" 
		default="  ";
	property
		name   ="params"             
		type   ="any"    
		default="{}";

	/**
	 * Constructor.
	 */
	public ConfigBuilder function init(){
		return this;
	}

	/**
	 * Builder method to generate the FormatConfig object.
	 *
	 * @return com.github.vertical_blank.sqlformatter.core.FormatConfig
	 */
	public any function build(){
		return getFormatConfig()
			.builder()
			.indent( javacast( "string", getIndent() ) )
			.maxColumnLength( javacast( "int", getMaxColumnLength() ) )
			.params( getParams() )
			.uppercase( javacast( "boolean", getUppercase() ) )
			.linesBetweenQueries( javacast( "int", getLinesBetweenQueries() ) )
			.build();
	}

	/**
	 * Set indent option via typesafe setter.
	 *
	 * @indent preferred indentation string - two spaces, four spaces, or even `<tab>` characters, if you're crazy. 😜
	 */
	public ConfigBuilder function setIndent( required string indent ){
		variables.indent = arguments.indent;
		return this;
	}

	/**
	 * Set uppercase option via typesafe setter.
	 *
	 * @uppercase If 'true', force uppercasing of SQL tokens. Not safe to use when SQL dialect has case-sensitive identifiers. Default false.
	 */
	public ConfigBuilder function setUppercase( required boolean uppercase ){
		variables.uppercase = arguments.uppercase;
		return this;
	}

	/**
	 * Set linesBetweenQueries option via typesafe setter.
	 *
	 * @linesBetweenQueries Integer number of whitespace lines to place between queries. Default 1.
	 */
	public ConfigBuilder function setLinesBetweenQueries( required numeric linesBetweenQueries ){
		typeCheck(
			arguments.linesBetweenQueries,
			"linesBetweenQueries",
			"integer"
		);
		variables.linesBetweenQueries = arguments.linesBetweenQueries;
		return this;
	}

	/**
	 * Set maxColumnLength via typesafe setter.
	 *
	 * @maxColumnLength Max characters to include in a single line before wrapping. Default 50.
	 */
	public ConfigBuilder function setMaxColumnLength( required numeric maxColumnLength ){
		typeCheck(
			arguments.maxColumnLength,
			"maxColumnLength",
			"integer"
		);
		variables.maxColumnLength = arguments.maxColumnLength;
		return this;
	}

	/**
	 * Set query params option via typesafe setter.
	 *
	 * @params Array or struct of query params to expand into SQL string.
	 */
	public ConfigBuilder function setParams( required any params ){
		variables.params = arguments.params;
		return this;
	}

	/**
	 * Helper for ensuring integer or other types before setting config properties.
	 *
	 * @value        The value to type check
	 * @name         The name of the field (used in error messages)
	 * @expectedType The type we expect to see. Passed to `isValid()`.
	 *
	 * @throws sqlFormatter.ConfigBuilder.InvalidTypeException
	 */
	private void function typeCheck(
		required any value,
		required string name,
		required string expectedType
	){
		if ( !isValid( arguments.expectedType, arguments.value ) ) {
			throw(
				message = "Invalid #arguments.expectedType# value for #arguments.name# config option",
				type    = "sqlFormatter.ConfigBuilder.InvalidTypeException"
			);
		}
	}

	/**
	 * Getter overload to return a Java-safe parameter array or struct.
	 * Only an array or struct can be cast to the appropriate type upon passing to the Formatter object.
	 *
	 * @return Array|Struct parameters.
	 */
	private function getParams(){
		if ( !isStruct( variables.params ) && !isArray( variables.params ) ) {
			return [];
		}
		return variables.params;
	}

}
