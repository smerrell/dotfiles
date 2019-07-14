# pygmentize comes from Pygments
# sudo pip install Pygments

function ccat
    #pygmentize -f terminal -O linenos=True,bg=dark -g $argv
    pygmentize -f terminal -O bg=dark -g $argv
end

