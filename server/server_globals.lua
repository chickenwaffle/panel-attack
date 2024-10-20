leagues = { {league="Provisional",     min_rating = -1000},
            {league="Newbie",       min_rating = 0},
            {league="Beginner",       min_rating = 250},
            {league="Iron",       min_rating = 500},
            {league="Copper",       min_rating = 750},
            {league="Bronze",       min_rating = 1000},
            {league="Silver",       min_rating = 1250},
            {league="Gold",       min_rating = 1500},
            {league="Platinum",       min_rating = 1750},
            {league="Diamond",  min_rating = 2000},
            {league="Master",  min_rating = 2250},
            {league="Grandmaster",  min_rating = 2500},
            {league="Super Grandmaster",       min_rating = 2750},
            {league="Panel Overlord",       min_rating = 3000},
          }
PLACEMENT_MATCH_COUNT_REQUIREMENT = 20
DEFAULT_RATING = 1500
RATING_SPREAD_MODIFIER = 1000 -- affects expected outcomes. Recommended to set this to 1/3 of MAX_TARGET_RATING.
DEVIATION_SPREAD = 500 -- -- affects how much a player's rating can change.
MIN_ALLOWED_RATING = 100 -- the lowest allowed rating. Do not set this lower than 1.
MAX_TARGET_RATING = 3000
ALLOWABLE_RATING_SPREAD_MULITPLIER = 1 --set this to a huge number like 100 if you want everyone to be able to play with anyone, regardless of rating gap
PLACEMENT_MATCH_MULTIPLIER = 4 -- Raises a player's RD by the multiple of the set number during the provisional period. Recommended is 4.
NAME_LENGTH_LIMIT = 16
PLACEMENT_MATCHES_ENABLED = true
COMPRESS_REPLAYS_ENABLED = true
COMPRESS_SPECTATOR_REPLAYS_ENABLED = false -- Send current replay inputs over the internet in a compressed format to spectators who join.
TCP_NODELAY_ENABLED = true -- Disables Nagle's Algorithm for TCP. Decreases data packet delivery delay, but increases amount of bandwidth and data used.
ANY_ENGINE_VERSION_ENABLED = true -- The server will accept any engine version. Mainly to be used for debugging.
ENGINE_VERSION = "952"
MIN_LEVEL_FOR_RANKED = 1
MAX_LEVEL_FOR_RANKED = 11
SERVER_PORT = 48248 -- default: 49569
