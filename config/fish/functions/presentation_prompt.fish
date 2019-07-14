function presentation_prompt
    function fish_prompt
        echo -s (prompt_pwd) (set_color cyan) (__fish_vcs_prompt)
        echo -s (set_color "blue") "➔ "
    end
end

