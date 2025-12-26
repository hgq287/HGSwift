import logging
import sys
from typing import Any, Optional

from aimo import __version__
from aimo.exceptions import OperationalException

# check min. python version (>= 3.10 required)
if sys.version_info < (3, 10):  # pragma: no cover
    sys.exit("Aimo requires Python version >= 3.10")

from aimo.commands import Arguments

logger = logging.getLogger("aimo")


def main(sysargv: Optional[list[str]] = None) -> None:
    return_code: Any = 1
    try:
        print("Aimo CLI")
        arguments = Arguments(sysargv)
        args = arguments.get_parsed_arg()

        # Call subcommand.
        if "func" in args:
            logger.info(f"aimo {__version__}")
            return_code = args["func"](args)
        else:
            # No subcommand was issued.
            raise OperationalException(
                "Usage of Aimo requires a subcommand to be specified.\n"
                "To see the full list of options available, please use "
                "`aimo --help` or `aimo <command> --help`."
            )
    finally:
        print("Exiting aimo")
        sys.exit(return_code)


if __name__ == "__main__":  # pragma: no cover
    main()
