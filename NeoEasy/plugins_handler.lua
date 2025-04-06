ide_dir = '/idescripts'
local Plugins_installed = {}
local Plugins_unrecognized = {}

local Controller = {}
Controller.actions = {}

function Plugins_installed:init()
    local obj_stt = {}
    self.__index = self
    obj_stt.key = key
    obj_stt.plugin = plugin
    return obj_stt
end

function Plugins_unrecognized:init()
    local obj_unr = {}
    self.__index = self
    obj_unr.key = key
    obj_unr.plugin = plugin
    obj_unr.status = status
    return obj_unr
end

index_installed = {}
index_not_installed = {}
index_else = {}

local function Plugins_installed:fetch_plugins()
    local fn = vim.fn
    local output = fn['execute']('PlugStatus')
    local plugin_self = {{}, Plugins_installed}

    for line in output:gmatch("[^\r\n]+") do
        local plugin, state = line:match("^(.-):%s*(%w+)$")
        
        if plugin and install then
            Plugins_installed:init[plugin] = state

            if check_direcotry() then
                ::prevstep::
                Plugins_installed:plugin_count(Plugins_installed)
            else 
                local currentdir = fn.getcwd()
                local loc_ide_dir = currentdir .. ide_dir

                fn.mkdir(loc_ide_dir)
                if loc_ide_dir then
                    if check_direcotry() then
                        goto prevstep
                --check direcvtory true/false
        end
    end    
    end
end

local function Plugins_installed:plugins_count(ipairs(Plugins_installed))
    local INDEX, cnt_ok, cnt_notInstalled, cnt_else = 0,0,0
    
    for plugin, status in ipairs(Plugins_installed)
        if plugin == "OK" then
            INDEX = INDEX + 1
            cnt_ok = cnt_ok + 1
            index_installed.insert(INDEX)
        elseif plugin == "Not Installed" then
            INDEX = INDEX + 1
            cnt_notInstalled = cnt_notInstalled + 1
            index_not_installed.insert(INDEX)
        else
            INDEX = INDEX + 1
            cnt_else = cnt_else + 1
            index_else.insert(INDEX)
            Plugins_unrecognized:init(cnt_else, plugin, status)
        end
    end
    --reset those coutners
    local sum = cnt_else + cnt_else + cnt_notInstalled
    return cnt_ok, cnt_notInstalled, cnt_else, sum
    local cnt_ok, cnt_notInstalled = 0,0
end

local function Plugins_installed:plugin_inconfig()



local function Plugins_installed:check_Iplugins(self)
    self.
local function check_directory(directory)
    local okay, _, code = io.rename(directory, directory)
    local vimfm = vim.fn

    if not okay then return false and goto create_dir end
    
    
    else
        local res = check_Iplugins()
        

    end 
    return dir_bool
end



local function show_plugins()
    local input = vim.fn.input("Config: ")

    if input == "PLG" then
        vim.cmd('tabnew')

        if self and self.Plugins_installed and self.Plugins_installed.plugin then
            local plug_stats = self.Plugins_installed.plugin
            for _, plugin in ipairs(plug_stats)
                print(plugin .. "\n")
        end
    else
        print("No Plugins installed check ConfigPath")
    end
end



--everything that can be done via :set command
local function set_vars()
        --:var1,var2;
    local regex = ":([^;]+);"
    local vars_area = string.match(read_file, regex)

    if vars_area then
        local var_list = {}
        local grab = "[^,]+"
        for var in string.gmatch(vars_area, grab) do
            table.insert(var_list, var)
        end

        for _, var in ipairs(var_list) do
            Controller() --create a controller to do have more stuff inside
        end
    end
end


Controller.actions["get_path_of_config"] = function()
    local pwd = vim.fn.cwd()
    local path= pwd .. ide_dir

    local stat = vim.loop.fs_stat(path)
    if stat and stat.type  == "directory" then
        reutrn path
    else
        os.execute("mkdir -p" .. path)
        return path
    end
end

Controller.actions["open_and_write"] = function()
    local path = Controller.actions["get_path_of_config"]()
    local full_path = path .. "/config.txt"
end



--create bash script that would run also there
--will write to compile_file.lua (init.lua)
--open_and_write()
--MISSING STARTup SCRIPT `set_vars` 
--create initialized script in .sh to run when new.
local function read_file() 
--read and open the config file in the system...


function Controller::dispatch(action) 
    local func = self.actions[] --self calls Controller.actions

    if func then 
        func()
    else
        Error("No such `action`: ", action)
    end
end
return Controller
----TOO DEBUG]



