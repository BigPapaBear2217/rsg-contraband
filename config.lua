Config = Config or {}

Config.MinimumLawmen = 0 -- number of lawmen on server to be able to deal

-- contraband list
Config.ContrabandList = {
	"60coke",
    "40coke",
    "20coke",
    "10coke",
    "5coke",
    "coke",
}

-- contraband price
Config.ContrabandPrice = { -- set your contraband selling and scam prices
    ["60coke"] = { min = 30, max = 50, scammin = 1, scammax = 1 },
    ["20coke"] = { min = 15, max = 30, scammin = 1, scammax = 1 },
    ["10coke"] = { min = 10, max = 17, scammin = 1, scammax = 1 },
    ["5coke"] = { min = 3, max = 5, scammin = 1, scammax = 1 },
    ["coke"] = { min = 20, max = 60, scammin = 1, scammax = 1 },
    ["40coke"] = { min = 20, max = 60, scammin = 1, scammax = 1 },
}
