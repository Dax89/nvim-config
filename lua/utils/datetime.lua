-- https://www.lua.org/pil/22.1.html

local DATE_FORMAT = "%w %A %Y-%m-%d %H:%M:%S"
local SECONDS_IN_MINUTE = 60
local SECONDS_IN_HOUR = 60 * SECONDS_IN_MINUTE
local SECONDS_IN_DAY = 24 * SECONDS_IN_HOUR

local function update_datetime(dt, delta)
  if delta == nil then delta = 1 end

  local time = os.time(dt)
  local newtime = time + (delta * SECONDS_IN_DAY)
  local newdate = os.date("*t", newtime)
  newdate.weekday = tonumber(os.date("%w", newtime))
  newdate.weekname = os.date("%a", newtime)
  return newdate
end

local function now()
    local d = os.date(DATE_FORMAT)
    assert(type(d) == "string")
    local weekday, weekname, year, month, day, hour, minute, second = d:match("(%d+) (%S+)%s(%d+)-(%d+)-(%d+)%s(%d+):(%d+):(%d+)")

    return {
        weekname = weekname,
        weekday = tonumber(weekday),
        year = tonumber(year),
        month = tonumber(month),
        day = tonumber(day),
        hour = tonumber(hour),
        min = tonumber(minute),
        sec = tonumber(second)
    }
end

local function new(year, month, day, hour, min, sec)
    local date = {
        year = year,
        month = month or 1,
        day = day or 1,
        hour = hour or 0,
        min = min or 0,
        sec = sec or 0,
    }

    local ts = os.time(date)
    date.weekday = tonumber(os.date("%w", ts))
    date.weekname = os.date("%a", ts)
    return date
end

local function iterate(date, callback)
    local current = date

    while callback(current) do
        current = update_datetime(current)
    end
end

local function is_weekend(date)
    vim.print(date)
    return date.weekday == 0 or date.weekday == 6
end

return {
    now = now,
    new = new,
    iterate = iterate,
    is_weekend = is_weekend,
}
