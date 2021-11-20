#! /bin/sh
#
# Create a new database named Property_in_Lyme.sqlite
# Read the file of commands to create the tables & views and initialize them
# Then import the CSV files

# This is cool because it's idempotent - it can be run multiple times using
# the same data and not change the result.

# Discard earlier database if it exists
test -f Property_in_Lyme.sqlite && rm Property_in_Lyme.sqlite

# Re-create database tables and views
sqlite3 Property_In_Lyme.sqlite < Create_Property_in_Lyme_db.sql

# Import the concatenated CSV files into the tables
sqlite3 Property_In_Lyme.sqlite < import_crunched_data.sql

open Property_In_Lyme.sqlite
