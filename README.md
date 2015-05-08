
Dictionary

By Alexandar Castaneda

@ Epicodus Programming School, Portland, OR

GNU General Public License, version 3 (see below). Copyright (c) 2015 Alexandar Castaneda.

Description

Dictionary

This is a management system for a hair salon.  It allows user to add, edit, delete stylists and clients.  It allows user to assign clients to a stylist.

Author

Alexandar Castaneda

Setup

This app was written in ruby '2.0.0'.

Clone this repo with

https://github.com/alexcaste/hair_salon.git

Install and run:
bundle install
ruby app.rb

Database structure used in this app:
# psql
username=# CREATE DATABASE hair_salon;
username=# \c hair_salon;
hair_salon=# CREATE TABLE stylists (id serial PRIMARY KEY, s_name varchar);
hair_salon=# CREATE TABLE clients (id serial PRIMARY KEY, c_name varchar, stylist_id int);
hair_salon=# CREATE DATABASE hair_salon_test WITH TEMPLATE hair_salon;

License Copyright (C) 2015 Alexandar Castaneda

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see http://www.gnu.org/licenses/.
