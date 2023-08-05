# WordPress Tests  

My focus here was to become familiar with the Pytest lib. Currently, no Class based tests are written, all functional.  

### Project Structure.  
    ├── conftest.py 
    └── pytest.ini
    └── readme.md
    └── test_wordpress.py     
    
### Test cases:  
    - Check md5 checksums of all files against public app files.
    - If the configured(db) app's domain is equal to the expected one.
    - If the domain returns 200 status code when requested with the defined expected domain.
    - If a plugin could be successfully installed
    - If WP Cron script works
    - If SSL exists and the site could be loaded over the HTTPS protocol.

### Requirements:  
  - Python3.9+
  - Pytest 7.4.*
  - WordPress 6.*
  - WP-CLI set as a command 'wp'.  

### Running the tests.  
The tests are not meant to be executed remotely. Download/clone this directory to the server which hosts the WordPress application. It is not required to be in the root application's directory. Assure that the wp-cli is available via `wp` command. Then:

1. Prepare the environment
```console
python -m venv venv

. venv/bin/activate
```

2. Run tests:
```console
pytest test_wordpress.py --domain {expected_domain} --path {application_directory}
```

Required params:  
  `--domain` -> Define the domain with its **protocol**. This is the expected domain configured in the app's database.  
  `--path`   -> Define the **full path** to the application's files.

### Additional notes on the project:  
The structure of the file containg the tests(test_wordpress.py) strictly follows the pattern  
`helper function, then test function`.  
The test function executes the helper function.  
Every helper function has a string comment.  
Command parameters are set as fixtures in `conftest.py` along with simple type checks.  
Pytest command params, like -r,-a,-q are defined in pytest.ini