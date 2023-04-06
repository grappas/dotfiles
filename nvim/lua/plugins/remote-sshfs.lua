return {
    'nosduco/remote-sshfs.nvim',
    init = function ()
        require('remote-sshfs').setup{}
        require('telescope').load_extension 'remote-sshfs'
    end
}
