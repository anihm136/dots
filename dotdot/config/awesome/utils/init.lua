local table = table
local ipairs = ipairs
local gfs = require("gears.filesystem")
local theme = require("beautiful")
local lgi = require("lgi")
local glib = lgi.GLib
local unpack = unpack or table.unpack -- luacheck: globals unpack (compatibility with Lua 5.1)
local inspect = require('utils.inspect')

local utils = {}

local default_icon = nil

local all_icon_sizes = {
    'scalable',
    '128x128',
    '96x96',
    '72x72',
    '64x64',
    '48x48',
    '36x36',
    '32x32',
    '24x24',
    '22x22',
    '16x16'
}

--- List of supported icon exts.
local supported_icon_file_exts = { png = 1, xpm = 2, svg = 3 }

local icon_lookup_path = nil

--- Get a list of icon lookup paths.
-- @treturn table A list of directories, without trailing slash.
local function get_icon_lookup_path()
    if icon_lookup_path then return icon_lookup_path end

    local function ensure_args(t, paths)
        if type(paths) == 'string' then paths = { paths } end
        return t or {}, paths
    end

    local function add_if_readable(t, paths)
        t, paths = ensure_args(t, paths)

        for _, path in ipairs(paths) do
            if gfs.dir_readable(path) then
                table.insert(t, path)
            end
        end
        return t
    end

    local function add_with_dir(t, paths, dir)
        t, paths = ensure_args(t, paths)
        dir = { nil, dir }

        for _, path in ipairs(paths) do
            dir[1] = path
            table.insert(t, glib.build_filenamev(dir))
        end
        return t
    end

    icon_lookup_path = {}
    local theme_priority = { 'hicolor' }
    if theme.icon_theme then table.insert(theme_priority, 1, theme.icon_theme) end

    local paths = add_with_dir({}, glib.get_home_dir(), '.icons')
    add_with_dir(paths, {
        glib.get_user_data_dir(),           -- $XDG_DATA_HOME, typically $HOME/.local/share
        unpack(glib.get_system_data_dirs()) -- $XDG_DATA_DIRS, typically /usr/{,local/}share
    }, 'icons')
    add_with_dir(paths, glib.get_system_data_dirs(), 'pixmaps')

    local icon_theme_paths = {}
    for _, theme_dir in ipairs(theme_priority) do
        add_if_readable(icon_theme_paths,
                        add_with_dir({}, paths, theme_dir))
    end

    local app_in_theme_paths = {}
    for _, icon_theme_directory in ipairs(icon_theme_paths) do
        for _, size in ipairs(all_icon_sizes) do
            table.insert(app_in_theme_paths,
                         glib.build_filenamev({ icon_theme_directory,
                                                size, 'apps' }))
            table.insert(app_in_theme_paths,
                         glib.build_filenamev({ icon_theme_directory,
                                                size, 'categories' }))
        end
    end
    add_if_readable(icon_lookup_path, app_in_theme_paths)

    return add_if_readable(icon_lookup_path, paths)
end

--- Lookup an icon in different folders of the filesystem.
-- @tparam string icon_file Short or full name of the icon.
-- @treturn string|boolean Full name of the icon, or false on failure.
-- @staticfct menubar.utils.lookup_icon_uncached
function utils.lookup_icon_uncached(icon_file, search_paths)
    if not icon_file or icon_file == "" then
        return false
    end

    local icon_file_ext = icon_file:match(".+%.(.*)$")
    if icon_file:sub(1, 1) == '/' and supported_icon_file_exts[icon_file_ext] then
        -- If the path to the icon is absolute do not perform a lookup [nil if unsupported ext or missing]
        return gfs.file_readable(icon_file) and icon_file or nil
    else
        -- Look for the requested file in the lookup path
		for _, directory in ipairs(get_icon_lookup_path()) do
			table.insert(search_paths, directory)
		end
        for _, directory in ipairs(search_paths) do
            local possible_file = directory .. "/" .. icon_file
            -- Check to see if file exists if requested with a valid extension
            if supported_icon_file_exts[icon_file_ext] and gfs.file_readable(possible_file) then
                return possible_file
            else
                -- Find files with any supported extension if icon specified without, eg: 'firefox'
                for ext, _ in pairs(supported_icon_file_exts) do
                    local possible_file_new_ext = possible_file .. "." .. ext
                    if gfs.file_readable(possible_file_new_ext) then
                        return possible_file_new_ext
                    end
                end
            end
        end
        -- No icon found
        return false
    end
end

local lookup_icon_cache = {}
--- Lookup an icon in different folders of the filesystem (cached).
-- @param icon Short or full name of the icon.
-- @return full name of the icon.
-- @staticfct menubar.utils.lookup_icon
function utils.lookup_icon(icon, search_paths)
    if not lookup_icon_cache[icon] and lookup_icon_cache[icon] ~= false then
        lookup_icon_cache[icon] = utils.lookup_icon_uncached(icon, search_paths)
    end
    return lookup_icon_cache[icon] or default_icon
end

function utils.deepcopy(o, seen)
  seen = seen or {}
  if o == nil then return nil end
  if seen[o] then return seen[o] end

  local no
  if type(o) == 'table' then
    no = {}
    seen[o] = no

    for k, v in next, o, nil do
      no[utils.deepcopy(k, seen)] = utils.deepcopy(v, seen)
    end
    setmetatable(no, utils.deepcopy(getmetatable(o), seen))
  else -- number, string, boolean, etc
    no = o
  end
  return no
end

function utils.log(item, opts)
    opts = opts or {}
    local log_method = opts.log_method or "notif"
    local log_file = opts.log_file or "{{@@ home @@}}/.cache/awesome/log.txt"
    if log_method == 'notif' then
        require('naughty').notification{title="Log", message=inspect(item)}
    else
        local file = io.open(log_file, 'a')
        io.output(file)
        io.write(inspect(item) .. '\n')
        io.close(file)
    end
end

return utils
