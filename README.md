# Toolkit

Quick Sunday project to handle simple tasks via command line. The purpose of this app is to allow a user to quickly generate scripts to handle routine tasks on a machine / server / etc. The command line arguments are pretty straightforward:

    ./tools.rb class:method arg arg2 ...

The above example would: 

 - Load `classes/class.rb`
 - Call *method* on *class*
 - Pass arg, arg2 to the method *method* as an array


There is a sample class included to organize files in your current working directory. Execute it with the following command:

    ./tools.rb files:cleanup <organized directory name>

This would results in the following class / method call:

    class Files
        def cleanup(args = [])
        end
    end

