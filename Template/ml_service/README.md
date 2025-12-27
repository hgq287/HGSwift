# Setup Python virtual environment (virtualenv)

You will run mls in separated `virtual environment`

```bash
# create virtualenv in directory /ml_service/.venv
python3 -m venv .venv

# run virtualenv
source .venv/bin/activate

# deactivate virtualenv
deactivate
```

# Install python dependencies

```bash
python3 -m pip install --upgrade pip
python3 -m pip install -r requirements.txt
python3 -m pip install -e .
```

# Usage 

To create ml model, simply run the following command:
```bash
mls train
```
