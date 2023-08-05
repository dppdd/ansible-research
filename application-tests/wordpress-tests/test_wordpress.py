import subprocess
import pytest
import re


def verify_checksums(path) -> subprocess.CompletedProcess:
    """ We run a native WP CLI command, which downloads the
    md5 checksums of the current WP version's file and compares them with the
    files of the existing/indeslled app. No core files should be edited.

    The exit status of the command is 0 only for successful checksums 
    verify.

    return -> Exit code of the command.
    """
    return subprocess.run(
        [f"wp core verify-checksums --path={path}"],
        shell=True,
        capture_output=True,
        text=True
    ).returncode
    
def test_verify_checksums(path):
    assert verify_checksums(path) == 0


def get_home_domain(path) -> subprocess.CompletedProcess:
    """ Query the domain defined for the application in the database.
    WordPress is a domain-dependent application, so this 'home domain' 
    record should equals to the expected one(passed as pytest param), 
    including the protocol:
    http:// != https://
    """
    return subprocess.run(
        [f"wp option get home --path={path}"], 
        shell=True,
        capture_output=True,
        text=True
    )

def test_get_home_domain(path, domain):
    assert get_home_domain(path).stdout.strip() == domain


@pytest.fixture
def get_http_headers(domain) -> subprocess.CompletedProcess:
    """ Obtain the headers of requested domain.
    Note: A local DNS zone could be fetched.

    We set the value as a fixture as it is used in later tests.
    """
    return subprocess.run(
        [f"curl -IX GET {domain}"],
        shell=True,
        capture_output=True,
        text=True
    )

def test_http_headers_status_code(get_http_headers):
    """ Confirm that request against the expected domain
    completes with status code of 200.
    """
    status_code = get_http_headers.stdout.strip().split("\n")[0].split(" ")[1]
    assert status_code == '200'


def install_plugin(path) -> subprocess.CompletedProcess:
    """ Install simple plugin using wp-cli.
    0 exit code is returned only on successful install.
    """
    return subprocess.run(
        [f"wp plugin install hello-dolly --path={path}"],
        shell=True,
        capture_output=True,
        text=True
    )
    
def test_install_plugin(path):
    assert install_plugin(path).returncode == 0


def execute_wp_cron(path) -> subprocess.CompletedProcess:
    """ Execute wp-cli built-in test command for WP Cron.
    0 exit code is returned only on successful wp-cli test.
    """
    return subprocess.run(
        [f"wp cron test --path={path}"],
        shell=True,
        capture_output=True,
        text=True
    )

def test_execute_wp_cron(path):
    assert execute_wp_cron(path).returncode == 0


def check_ssl(domain, get_http_headers) -> subprocess.CompletedProcess:
    """For the simplicity of the task a curl is executed against 
    the domain over HTTPS.

    We check if the domain is defined with https, if not we just 
    set the https protocol.

    0 exit code is returned only on successful 
    connection(valid, not expired ssl).

    This could also be validated with an openssl command, e.g.:
        echo | openssl s_client -connect
        $expected_domain:443 2>/dev/null
        | openssl x509 -crl_check_all -noout 2>/dev/null

    0 exit code is expected here, too.

    In case you use the openssl approach, you may need to check the 
    expiration date of the cert against the date now(), so you can 
    confirm if the SSL is still valid:
    1. Get cert dates(date_from, date_to) by modifying the last path to:
        openssl x509 -noout -dates
    2. Split the openssl output to a list by '\n' separator.
    3. Extract date_to value. It is the second line of the openssl
    output, so the first index in the list now.
        date_to = open_ssl_output[1].split("=")[1]
    4. Convert the date_to to native py date object:
        format_str = '%b %d %H:%M:%S %Y %Z'
        py_date_to = datetime.strptime(date_to, format_str)
    5. And you can compare now:
        assert datetime.now(tz=None) < py_date_to
    """
    if 'https' in domain:
        return get_http_headers
    else:
        https_domain = re.sub(r'http://', r'https://', domain)
        return subprocess.run(
            [f"curl -sIX GET {https_domain}"],
            shell=True,
            capture_output=True,
            text=True
        )
        return result

def test_check_ssl(domain, get_http_headers):
    assert check_ssl(domain, get_http_headers).returncode == 0