class AimoException(Exception):
    """Base exception for Aimo."""


class OperationalException(AimoException):
    """Exception for operational errors."""


class ConfigurationError(OperationalException):
    """Exception for configuration-related errors."""
