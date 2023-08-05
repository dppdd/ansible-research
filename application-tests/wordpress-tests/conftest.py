import pytest


def type_checker_domain(value):
    """Validate input: Application Domain"""
    msg = "The domain should be defined including a protocol."
    if not (value.startswith("http://") or value.startswith("https://")):
        raise pytest.UsageError(msg)
    return value


def type_checker_path(value):
    """Validate input: Application Path"""
    msg = "Full and valid path required here, e.g. /home/foo/app"
    if value.startswith("/") == False:
        raise pytest.UsageError(msg)
    return value


def pytest_addoption(parser):
    parser.addoption(
        "--domain",
        action="store",
        required=True, 
        type=type_checker_domain,
        help="The domain of the site. Protocol required, e.g. http://foo.bar",
    )
    parser.addoption(
        "--path",
        action="store",
        required=True,
        type=type_checker_path,
        help="Path to the app on the server. Full Path required.",
    )


@pytest.fixture
def domain(request):
    return request.config.getoption("--domain")


@pytest.fixture
def path(request):
    return request.config.getoption("--path")