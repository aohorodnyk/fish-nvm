function nvm
  bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
end

function nvm_find_nvmrc
  bass source ~/.nvm/nvm.sh --no-use ';' nvm_find_nvmrc $argv
end

# Apply applyNvmRcUse settings.
function applyNvmRcUse
  # Find nvmrc file location using builtin nvm_find_nvmrc command.
  set -l __nvmrc_file (nvm_find_nvmrc)

  # Check if nvmrc file not found.
  if test -z $__nvmrc_file
    # No nvmrc file found.
    if test $nvmrc_applied != "N/A"
      # nvmrc was applied, but no nvmrc file found.
      # Unload nvm.
      nvm unload
      set -g nvmrc_applied "N/A"
      set -g nvmrc_node_version "N/A"
    end

    return
  end

  # Check if current nvmrc is in use.
  if test $__nvmrc_file = $nvmrc_applied
    # nvmrc file is already applied.
    return
  end

  set -l __nvmrc_node_version (nvm version (cat $__nvmrc_file))
  # nvmrc file found.
  if test $__nvmrc_node_version = "N/A"
    # nvmrc file specifies a version that nvm does not have installed.
    # Install the version.
    nvm install
  else if test $__nvmrc_node_version = $nvmrc_node_version
    # nvmrc file specifies the same version that is already in use.
    return
  end

  # Load node version from nvmrc file.
  # If we applied the same version from another nvmrc file, it's not a problem.
  # We will reload the same version.
  nvm use --silent

  # Set nvmrc_applied to the current nvmrc file.
  set -g nvmrc_applied $__nvmrc_file
  # Set nvmrc_node_version to the current node version.
  set -g nvmrc_node_version (nvm version)
end

# We need to run applyNvmRcUse on the initialization of each session.
if status is-interactive
  # Set nvmrc_applied to default "N/A" value if not set.
  if test -z $nvmrc_applied
    set -g nvmrc_applied "N/A"
  end

  # Set nvmrc_node_version to default "N/A" value if not set.
  if test -z $nvmrc_node_version
    set -g nvmrc_node_version "N/A"
  end

  applyNvmRcUse
end

## nvmrc Function.
# Activates on directory changes.
function nvmrc --on-variable PWD -d "Automatic activation of NVM version from .nvmrc file."
  applyNvmRcUse
end
