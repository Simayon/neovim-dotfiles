return {
  {
    'anurag3301/nvim-platformio.lua',
    dependencies = {
      { 'akinsho/nvim-toggleterm.lua' },
      { 'nvim-telescope/telescope.nvim' },
      { 'nvim-lua/plenary.nvim' },
    },
    cmd = {
      'Pioinit',
      'Piorun',
      'Piocmd',
      'Piolib',
      'Piomon',
      'Piodebug',
      'Piodb',
    },
    config = function()
      require('platformio').setup()

      -- PlatformIO setup script
      local function run_command(command)
        local exit_code = os.execute(command)
        if exit_code ~= 0 then
          print('Error executing command: ' .. command)
          os.exit(1)
        end
      end

      local function setup_platformio()
        print 'Starting PlatformIO setup...'
        -- Download PlatformIO installer
        run_command 'curl -fsSL -o get-platformio.py https://raw.githubusercontent.com/platformio/platformio-core-installer/master/get-platformio.py'
        -- Run the installer
        run_command 'python3 get-platformio.py'
        -- Create symbolic links
        run_command 'ln -s ~/.platformio/penv/bin/platformio ~/.local/bin/platformio'
        run_command 'ln -s ~/.platformio/penv/bin/pio ~/.local/bin/pio'
        run_command 'ln -s ~/.platformio/penv/bin/piodebuggdb ~/.local/bin/piodebuggdb'
        print 'PlatformIO setup completed successfully!'
      end

      -- Create a new command to run the setup
      vim.api.nvim_create_user_command('PlatformIOSetup', setup_platformio, {})
    end,
  },
}
