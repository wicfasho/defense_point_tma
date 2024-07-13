component {
    cfsetting (showdebugoutput="false");
    
    system_env = {}; structAppend(system_env, server.system.environment);
    system_prop = server.system.properties;

    // Define the application settings. 
    this.name = "Defense Point TMA";

    // SCOPE HANDLING
	// lifespan of an untouched application scope
	this.applicationTimeout = createTimeSpan( 1, 0, 0, 0 ); 
	
	// session handling enabled or not
	this.sessionManagement = true; 

	// cfml or jee based sessions
	this.sessionType = "application"; 

	// untouched session lifespan
	this.sessionTimeout = createTimeSpan( 0, 0, 30, 0 ); 
	this.sessionStorage = "defensePointTMA";
	
	// client scope enabled or not
	this.clientManagement = false; 
	this.clientTimeout = createTimeSpan( 90, 0, 0, 0 );
	this.clientStorage = "cookie";
						
	// using domain cookies or not
	this.setDomainCookies = false; 
	this.setClientCookies = true;

	// prefer the local scope at un-scoped write
	this.localMode = "classic"; 
	
	// buffer the output of a tag/function body to output in case of an exception
	this.bufferOutput = false; 
	this.compression = false;
	this.suppressRemoteComponentContent = false;
	
	// If set to false Lucee ignores type definitions with function arguments and return values
	this.typeChecking = true;

    // REQUEST
	// max lifespan of a running request
	this.requestTimeout=createTimeSpan(0,0,0,50); 

    // charset
	this.charset.web="UTF-8";
	this.charset.resource="UTF-8";
	
	this.scopeCascading = "standard";
	this.searchResults = true;

    // regex
	this.regex.type = "perl";

    // MAPPINGS
    this.webrootDir = getDirectoryFromPath( getCurrentTemplatePath() );
    this.mappings = {
        "/com/defensepoint/tma": this.webrootDir & "cfcs"
    }

    //DATASOURCE
    this.datasources[system_env.TMA_DSN] = {
	    class: system_env.TMA_DSN_CLASS
        , bundleName: system_env.TMA_DSN_BUNDLE_NAME
        , bundleVersion: system_env.TMA_DSN_BUNDLE_VERSION
        , connectionString: system_env.TMA_DSN_CONNECTION_STRING
        , username: system_env.TMA_DSN_USERNAME
        , password: (system_env.keyExists('TMA_DSN_PASSWORD_FILE') && fileExists(system_env.TMA_DSN_PASSWORD_FILE)) ? fileRead(system_env.TMA_DSN_PASSWORD_FILE) : system_env.keyExists('TMA_DSN_PASSWORD') ? system_env.TMA_DSN_PASSWORD : ''
        
        // optional settings
        , blob:true // default: false
        , clob:true // default: false
        , connectionLimit:-1 // default:-1 (infinity)
        , connectionTimeout:1 // connection timeout in minutes (0 == connection is released after usage)
        , liveTimeout:-1 // default: -1; unit: minutes
        , timezone:'Africa/Lagos'
        , storage:true // default: false
        , alwaysSetTimeout:true // default: false
        , validate:true // default: false
        // , custom: {useUnicode:true,characterEncoding:'UTF-8'} // a struct that contains type specific settings
    };

    //Set Datasource
    this.defaultdatasource = system_env.TMA_DSN;

    //MAPPINGS
    this.mappings["/lucee/admin"]={
        physical:"{lucee-config}/context/admin"
        ,archive:"{lucee-config}/context/lucee-admin.lar"
    };

    this.mappings["/lucee/doc"]={
        archive:"{lucee-config}/context/lucee-doc.lar"
    };
    
    //Init App
    public void function onApplicationStart(){
        structClear(application)
        application.name = "TaskManagementApplication";
        application.dateInitialized = now();

        application.DEVELOPMENT_MODE = system_env.DEVELOPMENT_MODE;
        
    }

    // On Request
    public void function onRequest(targetPage){
        cfheader( name = "Access-Control-Allow-Origin", value = "" )

        if(!session.keyExists("environment")){
            system = createObject( "java", "java.lang.System" );
            environment = system.getenv();

            session.environment = environment;
        }

        try{
            include arguments.targetPage
        }
        catch(any e){
            if( application.DEVELOPMENT_MODE ){
                writeDump(e)
            }else{
                writeOutput('An Error has occurred. Please, contact the web admin.')
            }
        }
    }

    // On RequestStart
    public void function onRequestStart(){
    }

    //Init Session
    public void function onSessionStart(){
        session.dateInitialized = now();
        cfcookie (name="timeUserLoggedIn" value="" expires="now" preserveCase = "true");
        return;
    }
}