safe_rm() {
  local original_args=("$@")
  local current_directory_absolute="$(realpath "$PWD")"
  local resolved_target user_choice input_key escape_sequence

  for argument in "${original_args[@]}"; do
    # Skip option flags
    if [[ "$argument" == -* ]]; then
      continue
    fi

    # Resolve target path
    if [[ "$argument" == "." || "$argument" == "./" ]]; then
      resolved_target="$current_directory_absolute"
    else
      resolved_target="$(realpath -m "$argument" 2>/dev/null)"
    fi

    # Check if target is the home directory
    if [[ "$resolved_target" == "$HOME" || "$resolved_target" == "$HOME/" ]]; then
      echo "WARNING: Attempting to delete your HOME directory: $resolved_target"
      echo "This action is potentially destructive."

      user_choice="No"  # Default to safe option

      while true; do
        # Clear the line and display choices
        echo -ne "\r\033[K"

        # Display choices with proper highlighting
        if [[ "$user_choice" == "Yes" ]]; then
          echo -ne "$(tput smul)$(tput setaf 1)Yes$(tput sgr0)   $(tput setaf 2)No$(tput sgr0)"
        else
          echo -ne "$(tput setaf 1)Yes$(tput sgr0)   $(tput smul)$(tput setaf 2)No$(tput sgr0)"
        fi

        # Read user input
        IFS= read -r -k1 input_key
        if [[ "$input_key" == $'\x1b' ]]; then
          read -r -k2 escape_sequence
          input_key+="$escape_sequence"
        fi

        case "$input_key" in
          $'\x1b[D')  # Left arrow key
            user_choice="Yes"
            ;;
          $'\x1b[C')  # Right arrow key
            user_choice="No"
            ;;
          $'\n'|$'\r')  # Enter key variations (removed empty string to fix infinite loop)
            echo
            if [[ "$user_choice" == "Yes" ]]; then
              echo "Proceeding with deletion..."
              command rm "$@"
            else
              echo "Aborted. Your home directory is safe."
            fi
            return
            ;;
          $'\x03')  # Ctrl+C
            echo
            echo "Operation cancelled by user."
            return
            ;;
        esac
      done
      return
    fi
  done

  # Execute normal rm if no home directory deletion detected
  command rm "$@"
}

# Set up the alias
alias rm=safe_rm