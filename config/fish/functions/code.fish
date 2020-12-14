function code
    if command -v code-insiders > /dev/null
        code-insiders $argv
    else
        code $argv
    end
end

