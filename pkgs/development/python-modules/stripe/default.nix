{ lib
, buildPythonPackage
, fetchPypi
, requests
, pythonOlder
, typing-extensions
}:

buildPythonPackage rec {
  pname = "stripe";
  version = "7.5.0";
  format = "setuptools";

  disabled = pythonOlder "3.7";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-duDfcHHaXvORNNkpuMf6zxMZqkfCIr8ScrSKxVq/PW8=";
  };

  propagatedBuildInputs = [
    requests
    typing-extensions
  ];

  # Tests require network connectivity and there's no easy way to disable them
  doCheck = false;

  pythonImportsCheck = [
    "stripe"
  ];

  meta = with lib; {
    description = "Stripe Python bindings";
    homepage = "https://github.com/stripe/stripe-python";
    changelog = "https://github.com/stripe/stripe-python/blob/v${version}/CHANGELOG.md";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}
