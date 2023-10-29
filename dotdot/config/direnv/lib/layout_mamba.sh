layout_mamba() {
  local env_spec=$1
  local env_name
  local env_loc
  local env_config
  local mamba
  local REPLY
  if [[ $# -gt 1 ]]; then
    mamba=${2}
  else
    mamba=$(command -v mamba)
  fi
  realpath.dirname "$mamba"
  PATH_add "$REPLY"

  if [[ "${env_spec##*.}" == "yml" ]]; then
    env_config=$env_spec
  elif [[ "${env_spec%%/*}" == "." ]]; then
    # "./foo" relative prefix
    realpath.absolute "$env_spec"
    env_loc="$REPLY"
  elif [[ ! "$env_spec" == "${env_spec#/}" ]]; then
    # "/foo" absolute prefix
    env_loc="$env_spec"
  elif [[ -n "$env_spec" ]]; then
    # "name" specified
    env_name="$env_spec"
  else
    # Need at least one
    env_config=environment.yml
  fi

  # If only config, it needs a name field
  if [[ -n "$env_config" ]]; then
    if [[ -e "$env_config" ]]; then
      env_name="$(grep -- '^name:' "$env_config")"
      env_name="${env_name/#name:*([[:space:]])}"
      if [[ -z "$env_name" ]]; then
        log_error "Unable to find 'name' in '$env_config'"
        return 1
      fi
    else
      log_error "Unable to find config '$env_config'"
      return 1
    fi
  fi

  # Try to find location based on name
  if [[ -z "$env_loc" ]]; then
    # Update location if already created
    env_loc=$("$mamba" env list | grep -- '^'"$env_name"'\s')
    env_loc="${env_loc##* }"
  fi

  # Check for environment existence
  if [[ ! -d "$env_loc" ]]; then

    # Create if necessary
    if [[ -z "$env_config" ]] && [[ -n "$env_name" ]]; then
      if [[ -e environment.yml ]]; then
        "$mamba" env create --file environment.yml --name "$env_name"
      else
        "$mamba" create -y --name "$env_name"
      fi
    elif [[ -n "$env_config" ]]; then
      "$mamba" env create --file "$env_config"
    elif [[ -n "$env_loc" ]]; then
      if [[ -e environment.yml ]]; then
        "$mamba" env create --file environment.yml --prefix "$env_loc"
      else
        "$mamba" create -y --prefix "$env_loc"
      fi
    fi

    if [[ -z "$env_loc" ]]; then
      # Update location if already created
      env_loc=$("$mamba" env list | grep -- '^'"$env_name"'\s')
      env_loc="${env_loc##* }"
    fi
  fi

  eval "$( "$mamba" shell hook --shell zsh )"
  "$mamba" activate "$env_loc"
}
