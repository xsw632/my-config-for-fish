#!/usr/bin/env fish

function nvm
  bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
end

