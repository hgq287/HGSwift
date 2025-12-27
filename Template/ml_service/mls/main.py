import logging
import sys
from typing import Any, Optional

from mls import __version__
from mls.exceptions import OperationalException

# check min. python version (>= 3.10 required)
if sys.version_info < (3, 10):  # pragma: no cover
    sys.exit("Mls requires Python version >= 3.10")

from mls.commands import Arguments

logger = logging.getLogger("mls")


def main(sysargv: Optional[list[str]] = None) -> None:
    return_code: Any = 1
    try:
        print("Mls Cli")
        arguments = Arguments(sysargv)
        args = arguments.get_parsed_arg()

        # Call subcommand.
        if "func" in args:
            logger.info(f"mls {__version__}")
            return_code = args["func"](args)
        else:
            # No subcommand was issued.
            raise OperationalException(
                "Usage of Mls requires a subcommand to be specified.\n"
                "To see the full list of options available, please use "
                "`mls --help` or `mls <command> --help`."
            )
    finally:
        print("Exiting Mls")
        sys.exit(return_code)


if __name__ == "__main__":  # pragma: no cover
    main()
