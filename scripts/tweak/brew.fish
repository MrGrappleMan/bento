#!/usr/bin/env fish

# Enable Homebrew analytics - https://docs.brew.sh/Analytics
# Saves Time: The team knows exactly which tools to update.
# Stops Errors: They can track which tools fail to install and fix them.
# Keeps it Safe: The data is anonymous. It only tracks the package name and your command.
brew analytics on

# Load declarative packages
 # Run the general packages to be installed
  brew bundle install --file main

 # Ask user for what else to install
 function brew_explorer --description "Explore and install homebrew bundles"
     set -l brew_dir "export/brew"
 
     # 1. Environment and Prerequisite Validation
     if not test -d $brew_dir
         echo "❌ Error: Directory '$brew_dir' does not exist."
         return 1
     end
 
     set -l files (string match -r -v '^\..*' (ls $brew_dir))
     if test (count $files) -eq 0
         echo "⚠️  No files found in $brew_dir"
         return 0
     end
 
     # 2. File Discovery and Parsing Loop
     set -l idx 1
     echo "📋 Available Brew Bundles in $brew_dir:"
     echo "----------------------------------------"
     
     for file in $files
         set -l filepath "$brew_dir/$file"
         if test -f $filepath
             # Read only the first line safely without spawning external tools
             set -l desc (head -n 1 $filepath | string trim)
             
             # Fallback if the file is completely empty
             if test -z "$desc"
                 set desc "No description available"
             end
             
             echo "[ $idx ] $file - $desc"
             set -g bundle_name_$idx $file
             set idx (math $idx + 1)
         end
     end
     echo "----------------------------------------"
 
     # 3. User Interaction and Execution Block
     set -l max_idx (math $idx - 1)
     while true
         read -l -P "Select a bundle number to install (1-$max_idx) or 'q' to quit: " selection
         
         if test "$selection" = "q"
             echo "👋 Exiting."
             break
         end
 
         # Validate that input is strictly a number within the valid index range
         if string match -r -q '^\d+$' -- "$selection"
             if test $selection -ge 1 -a $selection -le $max_idx
                 set -l selected_name \$bundle_name_$selection
                 set -l final_name (eval echo $selected_name)
                 set -l target_file "$brew_dir/$final_name"
 
                 echo "🚀 Running: brew bundle install --file=$target_file"
                 brew bundle install --file=$target_file
                 break
             else
                 echo "❌ Invalid range. Please choose between 1 and $max_idx."
             end
         else
             echo "❌ Invalid input. Please enter a valid number."
         end
     end
 
     # Cleanup global dynamic variables to keep environment clean
     for i in (seq 1 $max_idx)
         set -e bundle_name_$i
     end
 end