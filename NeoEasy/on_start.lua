--luarocks install luafilesystem
--reads the configuration file for compialation
local function readFile(nameOfFile) 
    local file = file:open(nameOfFile, "r")
    local content = file:read("*a")

    local numberOfLines = 0
    if content then
        
        for _ in content:lines() do
            numberOfLines = numberOfLines + 1
        end

        content:close()
        return numberOfLines
    end
    local empty_lines_limit = 5
    local empty_lines_count = 0
    local startIndex = content:find(content, "{") and >= numberOfLines
    local _endIndex = content:find(content, "}") and <= numberOfLines 
    
    if not content:find(content, "{") and content:find(content, "}")
        goto runInstall
    end

    --avoiding empty configuration file
    local line_count = 0
    for line in content:lines() do
        local no_borders = {}
        while not (_endIndex == line_count) do
            line_count = line_count + 1
            table.insert(line, no_borders)
            goto continue
         end --sets delay for reaching _endIndex

            empty_lines_count = empty_lines_count + 1
            if empty_lines_count <= empty_lines_limit then
                line_count:close()
                goto continue
            end

            local trimmed_space = line:match("^%s*(.-)%s*$")    
            
            if trimmed_space == "" then
                empty_lines_count = empty_lines_count + 1
            else 
                empty_lines_count = 0
            end
        end
        return no_borders
    end
    ::continue::
      
    --startup script
        
    ::runInstall:: install_and_run() --outside of scope function

    local step = 1
    startScript = {}
    
    for i = startIndex, _endIndex, step do
        table.insert(startScript, i)
    end

local function directory_exist(dir_name)
    local attr = lfs.attributes(dir_name)
    return (attr and attr.mode == "directory")
end

local function write_script() 
    local current_directory = lfs.currnetdir()
    local config_directory = current_directory .. "/configuration"

    if directory_exist(config_directory) then
        write_script()
    else 
        local succ, err = lfs.mkdir(config_directory)
        if succ then
            goto writecontent
        else
            error("Error creating directory: " .. err)
        end
    ::writecontent::
    --WRITING CONFIG FILE

    end
end

--FUNKCE: WAS_UPDATED ? CHECK FOR UPDATES IN CONFIG FILE
--FUNKCE: PARAMS ? CHECK FOR PARAMETERS IN INSTALL
--DEBUG MODE: CREATE DEBUGING VERSION
--****************************************
--FUNCTION MAIN CAN'T HANDLE ANY ARGUMENTS!
--****************************************

local function main()
    local function_calls = {
        {func = function1, condition = function() return should_run_func1(give_name) end},
    }

    for _, entry in ipairs(function_calls) do
        if entry.condition() then entry.func() 
        end
    end
end
