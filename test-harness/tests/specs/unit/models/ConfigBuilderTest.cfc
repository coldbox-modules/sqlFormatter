/**
 * The base model test case will use the 'model' annotation as the instantiation path
 * and then create it, prepare it for mocking and then place it in the variables scope as 'model'. It is your
 * responsibility to update the model annotation instantiation path and init your model.
 */
component extends="tests.specs.unit.BaseModelTest" model="SQLFormatter.models.ConfigBuilder" {

	function run(){
		describe( "ConfigBuilder", function(){
			it( "can initialize", function(){
				expect( isInstanceOf( variables.model, "SQLFormatter.models.ConfigBuilder" ) ).toBeTrue();
			} );

			it( "builds a FormatConfig", function(){
				var config = variables.model.build();
				expect( isObject( config ) ).toBeTrue();
			} );

			it( "throws on invalid options", function(){
				expect( function(){
					variables.model.setUppercase( "please" );
				} ).toThrow();

				expect( function(){
					variables.model.setLinesBetweenQueries( 2.5 );
				} ).toThrow( "sqlFormatter.ConfigBuilder.InvalidTypeException" );

				expect( function(){
					variables.model.setMaxColumnLength( 80.8 );
				} ).toThrow( "sqlFormatter.ConfigBuilder.InvalidTypeException" );
			} );

			it( "can set advanced formatting config", function(){
				var config = variables.model
					.setIndent( "<TAB>" ) // Defaults to two spaces
					.setUppercase( true ) // Defaults to false (not safe to use when SQL dialect has case-sensitive identifiers)
					.setLinesBetweenQueries( 2 ) // Defaults to 1
					.setMaxColumnLength( 100 ) // Defaults to 50
					.setParams( [ "a", "b", "c" ] ) // Map or List. See Placeholders replacement.
					.build();

				expect( config.indent ).toBe( "<TAB>" );
				expect( config.uppercase ).toBeTrue();
				expect( config.linesBetweenQueries ).toBe( 2 );
				expect( config.maxColumnLength ).toBe( 100 );
			} );

			it( "works with positional placeholders", function(){
				var formatted = getInstance( "Formatter@sqlFormatter" )
					.of( "db2" )
					.format(
						"SELECT * FROM pages WHERE slug IN (?,?,?)",
						getInstance( "ConfigBuilder@sqlFormatter" )
							.setIndent( "__" )
							.setParams( [ "a", "b", "c" ] )
							.build()
					);
				expect( formatted ).toBe(
					"SELECT
__*
FROM
__pages
WHERE
__slug IN (a, b, c)"
				);
			} );

			/**
			 * Skipped due to issue with SQLFormatter lib
			 *
			 * @cite https://github.com/vertical-blank/sql-formatter/issues/57
			 */
			xit( "works with named placeholders", function(){
				var formatted = getInstance( "Formatter@sqlFormatter" )
					.of( "postgresql" )
					.format(
						"SELECT * FROM users WHERE name = :name AND age = :age",
						getInstance( "ConfigBuilder@sqlFormatter" )
							.setParams( { "name" : "Michael", "age" : "18" } )
							.build()
					);
				writeOutput( "<pre>#formatted#</pre>" );
				expect( formatted ).toBe(
					"SELECT
  *
FROM
  users
WHERE
  name = 'Michael'
  AND age = '17'"
				);
			} );
		} );
	}

}
