# Overview

When choosing between different technical solutions in the open source world having a vibrant community backing the project can make the difference between a full rewrite of your application, and a simple upgrade when maintaining your own systems.

This application allows you to compare stats about different publicly available github repositories.  Currently it is only comparing pull request rate.  Having current pull requests is an indicator that a repository is actively being maintained.

## Technologies Used

This is a full stack solution.  Technologies I have used in this project are:

* Frontend
    * Angular.js, cause it's cool.
    * Bootstrap, ditto.
    * jQuery, for dropdowns.
    * Google Graph API, cause I didn't realize I should be playing with d3.js
    * Jasmine, for Angular Unit Testing
* Backend
    * Python
    * Django
    * MySQL
    * Github API

# Installation

* Pull down this repository.  
* Setup Github API
    * cp /projects/populargithub/settings/__init__.py--template /projects/populargithub/settings/__init__.py
    * log into github -> https://github.com/settings/applications
    * ->Register New Application
    * ->Fill out Information
    * Put ClientID and Client Secret into __init__.py created in step 1
* Run the vagrant file.  This will assemble an appropriate box for you.

How to run:
python manage.py runserver 0.0.0.0:8000 

Web site should be running on 192.168.33.10:8000

## Requirements

At the moment this application requires mysql--there are some mysql specific queries in it.

# TODO
* Add Pagination Processing for the pull requests.  Currently it only imports the last 30 pull requests that have been closed.
* Parse out Month/Date from pull_request dates on cache so that the application can be database agnostic.
* Render statistical success rates for Repo Processing.
* Mobile testing.
* Throw in a D3.js example.
* set up web test runner for python: http://tungwaiyip.info/software/HTMLTestRunner.html
* Set up a cron job for scraping.
* Additional Metrics
    * Ticket Re-closure Rate
	* Number of Contributors