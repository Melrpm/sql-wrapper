local luasql = require("luasql.mysql")
local mysql = luasql.mysql()
local dbInfo = {
    db = "nanosworld",
    user = "root",
    password = "",
    host = "localhost",
    port = "3306"
}

local connection = mysql:connect(dbInfo.db, dbInfo.user, dbInfo.password, dbInfo.host, dbInfo.port)

if not connection or not connection:ping() then
    Package:Log("[DATABASE]: Connection unsuccessful.")
else
    Package:Log("[DATABASE]: Connection established successfully.")
end

function escaper(...)
    local params = {...}
    local result = {}
    for _, value in ipairs(params) do
        table.insert(result, connection:escape(value))
    end
    return table.unpack(result)
end

function sqlExecute(query, ...) -- Used to execute stuff into the DB.
    local cursor, error = connection:execute(string.format(query, escaper(...)))

    if error then
        return false
    elseif cursor then
        return true
    end
end

function sqlFetch (query, ...) -- Used to fetch data from the your DB.
    local cursor, error = connection:execute(string.format(query, escaper(...)))

    if error then
        Package:Log("[MYSQL]: "..error)
        return false
    elseif cursor then
        local value = true
        local i = 0
        local table = {}

        while value ~= nil do
            i = i + 1
            local dataFetched = cursor:fetch({}, 'a')
            if dataFetched == nil then
                value = nil
            elseif dataFetched ~= "null" and dataFetched then
                table[i] = dataFetched
            end
        end
        --[[ if table[2] then
            return table
        else
            return table[1]
        end ]]

        return table
    end
end

function sqlFetchAll(table)

    local cursor, error = connection:execute(string.format("SELECT * FROM %s", table))

    if error then
        Package:Log("[MYSQL]: "..error)
        return false
    elseif cursor then
        local value = true
        local i = 0
        local table = {}

        while value ~= nil do
            i = i + 1
            local dataFetched = cursor:fetch({}, 'a')
            if dataFetched == nil then
                value = nil
            elseif dataFetched ~= "null" and dataFetched then
                table[i] = dataFetched
            end
        end
        return table
    end
end