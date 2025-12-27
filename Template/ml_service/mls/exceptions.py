class MlsException(Exception):
    """Base exception for Mls."""


class OperationalException(MlsException):
    """Exception for operational errors."""


class ConfigurationError(OperationalException):
    """Exception for configuration-related errors."""
