One Offs
========

The purpose of this gem is to organise and log database operations for our releases. It has been updated to support MongoDB and mongoid 6.x.


## Installation

Add this line to your application's Gemfile:

    gem 'one_offs'

And then execute:

    $ bundle

## Usage

After installing the gem, In your Rakefile add the following line

    require 'one_offs/tasks'

A new task has now been created that allows you to create the one_off files themselves. When you need to run database operations on your
feature, run this command: 

    rake one_offs:create_one_off my_file_name
    
Replace 'my_file_name' with something short and concise to describe the operation. This will generate a file as so:

    class MyFileName
       def self.process
         # Enter your migration code here....
       end
     end
     
Simply replace the comment with the database operations you need to run.   
   
__*** IMPORTANT ***__

__The filename is converted into a class name and therefore cannot end with the letter S. 
It has been modified to singularise any filename to catch most of them, but double S's will probably not work.__ 
    
Finally to run pending one_off scripts, or to run ones other people have created after pulling a branch use this command:

    rake one_offs:run

This can be set as part of the deployment process too.
