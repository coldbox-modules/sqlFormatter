/**
 * Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
 * www.ortussolutions.com
 * ---
 */
component {

	// Module Properties
	this.title       = "sqlFormatter";
	this.author      = "Ortus Solutions";
	this.webURL      = "https://www.ortussolutions.com";
	this.description = "A CFML wrapper for the Vertical Blank sql-formatter java library";

	// Model Namespace
	this.modelNamespace = "sqlformatter";

	// CF Mapping
	this.cfmapping = "sqlformatter";

	// Dependencies
	this.dependencies = [ "cbjavaloader" ];

	/**
	 * Configure Module
	 */
	function configure(){
		settings = { libPath : modulePath & "/lib" };
	}

	/**
	 * Fired when the module is registered and activated.
	 */
	function onLoad(){
		wireBox.getInstance( "loader@cbjavaloader" ).appendPaths( settings.libPath );
	}

	/**
	 * Fired when the module is unregistered and unloaded
	 */
	function onUnload(){
	}

}
