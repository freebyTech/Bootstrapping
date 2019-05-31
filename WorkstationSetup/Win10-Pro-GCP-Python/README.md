# Adding Support for Google Cloud SDK and Python 2.7

## Development Workstation Requirements
This is a supplemental to the installation procedures found in Win10-Pro that will also install Python 2.7 and the Google Cloud SDK for fully supported interaction with GCP via their tools like gcloud, gsutil, and bq.

## Base Setup (Manual)
Below is the list of required tools needed to run and also work with GCP locally, python 2.7 is "mostly required" when using Google Cloud SDK functionality.

## Required Tools

| Tool                               | URL                                                                  | Notes                                     |
| ---------------------------------- | -------------------------------------------------------------------- | ----------------------------------------- |
| Python 2.7                         | https://www.python.org/downloads/windows/                            | At time of writing python 2.7 was the version used by Google Cloud SDK |
| Google Cloud SDK                   | https://cloud.google.com/sdk/ | Python requirements are discussed here, they may change in the future: https://cloud.google.com/sdk/install |

## Google Cloud SDK Installation.
1. You should already have the user and project you are expecting to use, as when you install the Google Cloud SDK you can run the initial `gcloud init` command to login the user and set the working project. After installation you can verify python and SDK installs by running the following:
```
python --version
gcloud --version
