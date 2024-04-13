--[[ Lua code. See documentation: https://api.tabletopsimulator.com/ --]]

currentTrack = 1

local customPokeballs = {"a927cf", "acd90d", "63bb92", "88b157", "8aaeef", "915bb4", "47780a" }

-- Setup Variables
leadersGen = 1 -- 0 = Custom
hasEnoughPokemon = true
customAndTooFewLeaders = false
randomStarters = false
battleScripting = false
aiDifficulty = 0
  -- Save Data
  customGen = false
  selectedGens = {true, false, false}

-- Pokeball Colours
PINK = 1
GREEN = 2
BLUE = 3
YELLOW = 4
RED = 5

-- Status Effects
BURN = 0
FREEZE = 1
PARALYSIS = 2
POISON = 3
SLEEP = 4
CONFUSE = 5

playlist =
{
  {url="http://cloud-3.steamusercontent.com/ugc/1023948871898689460/46D48965B1EEDADAB14C15184FCDB41C9998C83D/",title="Route Music 1"},
  {url="http://cloud-3.steamusercontent.com/ugc/1023948871898697980/2D46041C40896534AC54D157FC6C3CAC1F00A7E9/",title="Route Music 2"},
  {url="http://cloud-3.steamusercontent.com/ugc/1023948871898696675/0CC89B7B48CAF248149CF2DE43DADBC1FDD260E2/",title="Route Music 3"},
  {url="http://cloud-3.steamusercontent.com/ugc/1023948871898694456/A95CDF7833368368BFB8EDCDB6E77E19785F3B7F/",title="Route Music 4"}
}

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  DATA
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

customPokemonData =
{
  {name="Pikachu",    level=1,  types={"Electric"},           moves={"Electroweb", "Leer"},           guids={"77331c"}}
}

gen1PokemonData =
{
  -- Gen 1 1-50
  {name="Bulbasaur",  level=1,  types={"Grass", "Poison"},    moves={"Vine Whip", "Tackle"},          guids={"d79fc7"},                   evoData={{cost=2, ball=BLUE, gen=1, guids={"8d43e0"}}} },
  {name="Ivysaur",    level=3,  types={"Grass", "Poison"},    moves={"Poison Powder", "Razor Leaf"},  guids={"60bde3","8d43e0"},          evoData={{cost=2, ball=RED, gen=1, guids={"85a0be","6e6869"}}} },
  {name="Venusaur",   level=5,  types={"Grass", "Poison"},    moves={"Double-Edge", "Solar Beam"},    guids={"e69464","85a0be","6e6869"}  },
  {name="Charmander", level=1,  types={"Fire"},               moves={"Ember", "Scratch"},             guids={"28e8ab"},                   evoData={{cost=2, ball=BLUE, gen=1, guids={"7c5381"}}} },
  {name="Charmeleon", level=3,  types={"Fire"},               moves={"Flamethrower", "Slash"},        guids={"e40822","7c5381"},          evoData={{cost=2, ball=RED, gen=1, guids={"6a3112","8b9dab"}}} },
  {name="Charizard",  level=5,  types={"Fire", "Flying"},     moves={"Fire Spin", "Wing Attack"},     guids={"1c82ed","6a3112","8b9dab"}  },
  {name="Squirtle",   level=1,  types={"Water"},              moves={"Bubble", "Tackle"},             guids={"88717f"},                   evoData={{cost=2, ball=BLUE, gen=1, guids={"e89741"}}} },
  {name="Wartortle",  level=3,  types={"Water"},              moves={"Water Gun", "Bite"},            guids={"cb8d39","e89741"},          evoData={{cost=2, ball=RED, gen=1, guids={"1783ad","427b16"}}} },
  {name="Blastoise",  level=5,  types={"Water"},              moves={"Hydro Pump", "Skull Bash"},     guids={"80eaa8","1783ad","427b16"}  },
  {name="Caterpie",   level=1,  types={"Bug"},                moves={"String Shot"},                  guids={"1b2082"},                   evoData={{cost=1, ball=PINK, gen=1, guids={"358aff"}}} },
  {name="Metapod",    level=2,  types={"Bug"},                moves={"Harden", "Tackle"},             guids={"7d6dcc","358aff"},          evoData={{cost=1, ball=GREEN, gen=1, guids={"25d791","d36522"}}} },
  {name="Butterfree", level=3,  types={"Bug", "Flying"},      moves={"Psybeam", "Gust"},              guids={"3cb9ed","25d791","d36522"}  },
  {name="Weedle",     level=1,  types={"Bug", "Poison"},      moves={"String Shot"},                  guids={"4dd71c"},                   evoData={{cost=1, ball=PINK, gen=1, guids={"91bded"}}} },
  {name="Kakuna",     level=2,  types={"Bug", "Poison"},      moves={"Poison Sting", "Harden"},       guids={"daa46b","91bded"},          evoData={{cost=1, ball=GREEN, gen=1, guids={"73c602","61f84a"}}} },
  {name="Beedrill",   level=3,  types={"Bug", "Poison"},      moves={"Twineedle", "Rage"},            guids={"f8894f","73c602","61f84a"}  },
  {name="Pidgey",     level=1,  types={"Flying", "Normal"},   moves={"Sand Attack", "Gust"},          guids={"ffa899"},                   evoData={{cost=2, ball=BLUE, gen=1, guids={"35b436"}}} },
  {name="Pidgeotto",  level=3,  types={"Flying", "Normal"},   moves={"Quick Attack", "Whirlwind"},    guids={"7d5ef0","35b436"},          evoData={{cost=2, ball=RED, gen=1, guids={"45e30a","9f1834"}}} },
  {name="Pidgeot",    level=5,  types={"Flying", "Normal"},   moves={"Mirror Move", "Wing Attack"},   guids={"1d36ba","45e30a","9f1834"}  },
  {name="Rattata",    level=1,  types={"Normal"},             moves={"Tail Whip", "Tackle"},          guids={"e2226d"},                   evoData={{cost=2, ball=BLUE, gen=1, guids={"1533cd"}}} },
  {name="Raticate",   level=3,  types={"Normal"},             moves={"Hyper Fang", "Super Fang"},     guids={"50866f","1533cd"}           },
  {name="Spearow",    level=1,  types={"Flying", "Normal"},   moves={"Leer", "Peck"},                 guids={"b2ebc5"},                   evoData={{cost=2, ball=BLUE, gen=1, guids={"7598db"}}} },
  {name="Fearow",     level=3,  types={"Flying", "Normal"},   moves={"Mirror Move", "Drill Peck"},    guids={"5b5a42","7598db"}			      },
  {name="Ekans",      level=1,  types={"Poison"},             moves={"Wrap", "Leer"},                 guids={"a04efa"},                   evoData={{cost=2, ball=BLUE, gen=1, guids={"297aec"}}} },
  {name="Arbok",      level=3,  types={"Poison"},             moves={"Acid", "Bite"},                 guids={"4d4660","297aec"}           },
  {name="Pikachu",    level=1,  types={"Electric"},           moves={"Thunder Shock", "Growl"},       guids={"a17986","e5c82a"},          evoData={{cost=2, ball=BLUE, gen=1, guids={"654bd9","3541ed"}}} },
  {name="Raichu",     level=3,  types={"Electric"},           moves={"Thunderbolt", "Slam"},          guids={"ffd6fb","654bd9","3541ed"}  },
  {name="Sandshrew",  level=1,  types={"Ground"},             moves={"Sand Attack", "Scratch"},       guids={"6a3193"},                   evoData={{cost=2, ball=BLUE, gen=1, guids={"f4408c"}}} },
  {name="Sandslash",  level=3,  types={"Ground"},             moves={"Swift", "Dig"},                 guids={"53db8f","f4408c"}           },
  {name="Nidoran",    level=1,  types={"Poison"},             moves={"Growl", "Scratch"},             guids={"a89779"},                   evoData={{cost=2, ball=BLUE, gen=1, guids={"1809dc"}}} },
  {name="Nidorina",   level=3,  types={"Poison"},             moves={"Poison Sting", "Bite"},         guids={"ea4a3c","1809dc"},          evoData={{cost=2, ball=RED, gen=1, guids={"965607","4e6a63"}}} },
  {name="Nidoqueen",  level=5,  types={"Poison", "Ground"},   moves={"Superpower", "Body Slam"},      guids={"95b3f2","965607","4e6a63"}  },
  {name="Nidoran",    level=1,  types={"Poison"},             moves={"Leer", "Tackle"},               guids={"593d68"},                   evoData={{cost=2, ball=BLUE, gen=1, guids={"ed4f88"}}} },
  {name="Nidorino",   level=3,  types={"Poison"},             moves={"Poison Sting", "Horn Attack"},  guids={"2978c9","ed4f88"},          evoData={{cost=2, ball=RED, gen=1, guids={"faca75","1ede33"}}} },
  {name="Nidoking",   level=5,  types={"Poison", "Ground"},   moves={"Megahorn", "Thrash"},           guids={"7c6422","faca75","1ede33"}  },
  {name="Clefairy",   level=2,  types={"Fairy"},              moves={"Double Slap", "Sing"},          guids={"ed88e4","04404a"},          evoData={{cost=1, ball=BLUE, gen=1, guids={"a4ce76", "b56e5c"}}} },
  {name="Clefable",   level=3,  types={"Fairy"},              moves={"Disarming Voice", "Metronome"}, guids={"b31265","a4ce76","b56e5c"}  },
  {name="Vulpix",     level=2,  types={"Fire"},               moves={"Quick Attack", "Ember"},        guids={"11e2aa"},                   evoData={{cost=3, ball=YELLOW, gen=1, guids={"ea4691"}}} },
  {name="Ninetails",  level=5,  types={"Fire"},               moves={"Flamethrower", "Fire Spin"},    guids={"7cfe42","ea4691"}           },
  {name="Jigglypuff", level=1,  types={"Normal"},             moves={"Sing", "Pound"},                guids={"8d3afd","81f395"},          evoData={{cost=3, ball=YELLOW, gen=1, guids={"e72190","247fe0"}}} },
  {name="Wigglytuff", level=4,  types={"Normal"},             moves={"Play Rough", "Body Slam"},      guids={"e4e003","e72190","247fe0"}  },
  {name="Zubat",      level=1,  types={"Poison", "Flying"},   moves={"Leech Life", "Screech"},        guids={"e36eed"},                   evoData={{cost=2, ball=BLUE, gen=1, guids={"975f18"}}} },
  {name="Golbat",     level=3,  types={"Poison", "Flying"},   moves={"Supersonic", "Bite"},           guids={"77b2b2","975f18"},          evoData={{cost=2, ball=YELLOW, gen=2, guids={"79419e","1d7367"}}} },
  {name="Oddish",     level=2,  types={"Grass", "Poison"},    moves={"Poison Powder", "Absorb"},      guids={"f5c9ab"},                   evoData={{cost=1, ball=BLUE, gen=1, guids={"3e7844"}}} },
  {name="Gloom",      level=3,  types={"Grass", "Poison"},    moves={"Stun Spore", "Acid"},           guids={"22f1f2","3e7844"},          evoData={{cost=1, ball=YELLOW, gen=1, guids={"529150","19dbd1"}}, {cost=1, ball=YELLOW, gen=2, guids={"fd44a1","14e4ad"}}} },
  {name="Vileplume",  level=4,  types={"Grass", "Poison"},    moves={"Sludge Bomb", "Solar Beam"},    guids={"a65fdf","529150","19dbd1"}  },
  {name="Paras",      level=2,  types={"Bug", "Grass"},       moves={"Stun Spore", "Scratch"},        guids={"f3604e"},                   evoData={{cost=1, ball=BLUE, gen=1, guids={"7bae4e"}}} },
  {name="Parasect",   level=3,  types={"Bug", "Grass"},       moves={"Spore", "Slash"},               guids={"021746","7bae4e"}           },
  {name="Venonat",    level=3,  types={"Bug", "Poison"},      moves={"Stun Spore", "Confusion"},      guids={"c85b55"},                   evoData={{cost=1, ball=YELLOW, gen=1, guids={"25e898"}}} },
  {name="Venomoth",   level=4,  types={"Bug", "Poison"},      moves={"Sleep Powder", "Leech Life"},   guids={"2c7de6","25e898"}           },
  -- Gen 1 51-99
  {name="Diglett",    level=2,  types={"Ground"},             moves={"Scratch", "Dig"},               guids={"b79f00"},                   evoData={{cost=2, ball=BLUE, gen=1, guids={"3f6942"}}} },
  {name="Dugtrio",    level=4,  types={"Ground"},             moves={"Earthquake", "Slash"},          guids={"cfcb95","3f6942"}           },
  {name="Meowth",     level=2,  types={"Normal"},             moves={"Pay Day", "Bite"},              guids={"312c52"},                   evoData={{cost=2, ball=BLUE, gen=1, guids={"98722a"}}} },
  {name="Persian",    level=4,  types={"Normal"},             moves={"Fury Swipes", "Slash"},         guids={"d56c1a","98722a"}           },
  {name="Psyduck",    level=2,  types={"Water"},              moves={"Fury Swipes", "Disable"},       guids={"eeee17"},                   evoData={{cost=3, ball=RED, gen=1, guids={"4696b8"}}} },
  {name="Golduck",    level=5,  types={"Water"},              moves={"Confusion", "Hydro Pump"},      guids={"5b9964","4696b8"}           },
  {name="Mankey",     level=2,  types={"Fighting"},           moves={"Low Kick", "Scratch"},          guids={"c8da5c"},                   evoData={{cost=2, ball=YELLOW, gen=1, guids={"8b1126"}}} },
  {name="Primeape",   level=4,  types={"Fighting"},           moves={"Seismic Toss", "Thrash"},       guids={"a237dd","8b1126"}           },
  {name="Growlithe",  level=2,  types={"Fire"},               moves={"Ember", "Roar"},                guids={"7c2b34"},                   evoData={{cost=3, ball=YELLOW, gen=1, guids={"43d4c1"}}} },
  {name="Arcanine",   level=5,  types={"Fire"},               moves={"Flamethrower", "Bite"},         guids={"e52b25","43d4c1"}           },
  {name="Poliwag",    level=2,  types={"Water"},              moves={"Hypnosis", "Bubble"},           guids={"ecd6a3"},                   evoData={{cost=2, ball=BLUE, gen=1, guids={"10f79d"}}} },
  {name="Poliwhirl",  level=4,  types={"Water"},              moves={"Amnesia", "Water Gun"},         guids={"fd5498","10f79d"},          evoData={{cost=2, ball=RED, gen=1, guids={"b75a29","50bf9d"}}, {cost=2, ball=RED, gen=2, guids={"9a1b0b","b21ff9"}}} },
  {name="Poliwrath",  level=6,  types={"Water", "Fighting"},  moves={"Body Slam", "Hydro Pump"},      guids={"133f27","b75a29","50bf9d"}  },
  {name="Abra",       level=2,  types={"Psychic"},            moves={"Teleport"},                     guids={"4986cd"},                   evoData={{cost=1, ball=BLUE, gen=1, guids={"345d18"}}} },
  {name="Kadabra",    level=3,  types={"Psychic"},            moves={"Confusion", "Disable"},         guids={"da1937","345d18"},          evoData={{cost=2, ball=RED, gen=1, guids={"fa44b9","74c0b4"}}} },
  {name="Alakazam",   level=5,  types={"Psychic"},            moves={"Psychic", "Reflect"},           guids={"7117a7","fa44b9","74c0b4"}  },
  {name="Machop",     level=2,  types={"Fighting"},           moves={"Low Kick"},                     guids={"646972"},                   evoData={{cost=2, ball=BLUE, gen=1, guids={"0821c2"}}} },
  {name="Machoke",    level=4,  types={"Fighting"},           moves={"Karate Chop", "Leer"},          guids={"797adf","0821c2"},          evoData={{cost=2, ball=RED, gen=1, guids={"ff6a7f","518720"}}} },
  {name="Machamp",    level=6,  types={"Fighting"},           moves={"Submission", "Seismic Toss"},   guids={"b5109b","ff6a7f","518720"}  },
  {name="Bellsprout", level=2,  types={"Grass", "Poison"},    moves={"Vine Whip", "Wrap"},            guids={"a3cef8"},                   evoData={{cost=1, ball=BLUE, gen=1, guids={"4e1d04"}}} },
  {name="Weepinbell", level=3,  types={"Grass", "Poison"},    moves={"Sleep Powder", "Acid"},         guids={"77bc48","4e1d04"},          evoData={{cost=2, ball=YELLOW, gen=1, guids={"1b329c","e31246"}}} },
  {name="Victreebell",level=5,  types={"Grass", "Poison"},    moves={"Razor Leaf", "Slam"},           guids={"a380e7","1b329c","e31246"}  },
  {name="Tentacool",  level=1,  types={"Water", "Poison"},    moves={"Poison Sting", "Wrap"},         guids={"7701e4"},                   evoData={{cost=3, ball=BLUE, gen=1, guids={"71015b"}}} },
  {name="Tentacruel", level=4,  types={"Water", "Poison"},    moves={"Hydro Pump", "Acid"},           guids={"4afcb3","71015b"}           },
  {name="Geodude",    level=1,  types={"Rock", "Ground"},     moves={"Defense Curl", "Rock Throw"},   guids={"57f1ed"},                   evoData={{cost=3, ball=BLUE, gen=1, guids={"f54a1b"}}} },
  {name="Graveler",   level=4,  types={"Rock", "Ground"},     moves={"Self-Destruct", "Rollout"},     guids={"fbe7bb","f54a1b"},          evoData={{cost=2, ball=RED, gen=1, guids={"4cbb8a","0a8182"}}} },
  {name="Golem",      level=6,  types={"Rock", "Ground"},     moves={"Explosion", "Earthquake"},      guids={"904780","4cbb8a","0a8182"}  },
  {name="Ponyta",     level=4,  types={"Fire"},               moves={"Take Down", "Ember"},           guids={"67fd81"},                   evoData={{cost=2, ball=RED, gen=1, guids={"b92f63"}}} },
  {name="Rapidash",   level=6,  types={"Fire"},               moves={"Stomp", "Fire Spin"},           guids={"f651d6","b92f63"}           },
  {name="Slowpoke",   level=2,  types={"Water", "Psychic"},   moves={"Confusion", "Disable"},         guids={"fb1925"},                   evoData={{cost=3, ball=RED, gen=1, guids={"4b8280"}}, {cost=3, ball=RED, gen=2, guids={"83160e"}}} },
  {name="Slowbro",    level=5,  types={"Water", "Psychic"},   moves={"Water Gun", "Psychic"},         guids={"adce28","4b8280"}           },
  {name="Magnemite",  level=3,  types={"Electric", "Steel"},  moves={"Thunder Shock", "Tackle"},      guids={"23a41e"},                   evoData={{cost=1, ball=BLUE, gen=1, guids={"7a8fae"}}} },
  {name="Magneton",   level=4,  types={"Electric", "Steel"},  moves={"Thunderbolt", "Swift"},         guids={"0e43ae","7a8fae"},          evoData={{cost=2, ball=RED, gen=4, guids={"dedadf","618210"}}} },
  {name="Farfetch'd", level=3,  types={"Flying", "Normal"},   moves={"Swords Dance", "Peck"},         guids={"489e66"}                    },
  {name="Doduo",      level=3,  types={"Flying", "Normal"},   moves={"Fury Attack", "Peck"},          guids={"9e2524"},                   evoData={{cost=1, ball=YELLOW, gen=1, guids={"ee2d7d"}}} },
  {name="Dodrio",     level=4,  types={"Flying", "Normal"},   moves={"Tri Attack", "Drill Peck"},     guids={"bdd1d3","ee2d7d"}           },
  {name="Seel",       level=4,  types={"Water"},              moves={"Aurora Beam", "Take Down"},     guids={"e71d19"},                   evoData={{cost=1, ball=RED, gen=1, guids={"8621ed"}}} },
  {name="Dewgong",    level=5,  types={"Water", "Ice"},       moves={"Headbutt", "Ice Beam"},         guids={"46abb5","8621ed"}           },
  {name="Grimer",     level=4,  types={"Poison"},             moves={"Poison Gas", "Pound"},          guids={"b0bb78"},                   evoData={{cost=1, ball=RED, gen=1, guids={"e86ddd"}}} },
  {name="Muk",        level=5,  types={"Poison"},             moves={"Acid Armor", "Sludge"},         guids={"78a11c","e86ddd"}           },
  {name="Shellder",   level=2,  types={"Water"},              moves={"Clamp", "Protect"},             guids={"b7a634"},                   evoData={{cost=2, ball=YELLOW, gen=1, guids={"24e258"}}} },
  {name="Cloyster",   level=4,  types={"Water", "Ice"},       moves={"Aurora Beam", "Water Pulse"},   guids={"fb7658","24e258"}           },
  {name="Gastly",     level=3,  types={"Ghost", "Poison"},    moves={"Confuse Ray"},                  guids={"36f853"},                   evoData={{cost=1, ball=BLUE, gen=1, guids={"f1eac8"}}} },
  {name="Haunter",    level=4,  types={"Ghost", "Poison"},    moves={"Hypnosis", "Lick"},             guids={"0f5b22","f1eac8"},          evoData={{cost=1, ball=RED, gen=1, guids={"7d5d39","ad0856"}}} },
  {name="Gengar",     level=5,  types={"Ghost", "Poison"},    moves={"Dream Eater", "Night Shade"},   guids={"fe0809","7d5d39","ad0856"}  },
  {name="Onix",       level=2,  types={"Rock", "Ground"},     moves={"Rock Throw", "Screech"},        guids={"575fcf"},                   evoData={{cost=2, ball=BLUE, gen=2, guids={"9248b4"}}} },
  {name="Drowzee",    level=2,  types={"Psychic"},            moves={"Confusion", "Disable"},         guids={"5bda37"},                   evoData={{cost=2, ball=YELLOW, gen=1, guids={"56108c"}}} },
  {name="Hypno",      level=4,  types={"Psychic"},            moves={"Headbutt", "Psychic"},          guids={"08ee2c","56108c"}           },
  {name="Krabby",     level=2,  types={"Water"},              moves={"Vise Grip", "Bubble"},          guids={"54a03e"},                   evoData={{cost=2, ball=YELLOW, gen=1, guids={"aa3008"}}} },
  {name="Kingler",    level=4,  types={"Water"},              moves={"Crabhammer", "Guillotine"},    guids={"f18035","aa3008"}           },
  -- Gen 1 100-151
  {name="Voltorb",    level=2,  types={"Electric"},           moves={"Self-Destruct", "Screech"},     guids={"7963a6"},                   evoData={{cost=2, ball=BLUE, gen=1, guids={"fd080d"}}} },
  {name="Electrode",  level=4,  types={"Electric"},           moves={"Explosion", "Rollout"},         guids={"d292b7","fd080d"}           },
  {name="Exeggcute",  level=3,  types={"Grass", "Psychic"},   moves={"Hypnosis", "Barrage"},          guids={"c271ca"},                   evoData={{cost=2, ball=RED, gen=1, guids={"a29b99"}}} },
  {name="Exeggutor",  level=5,  types={"Grass", "Psychic"},   moves={"Solar Beam", "Egg Bomb"},       guids={"61be01","a29b99"}           },
  {name="Cubone",     level=3,  types={"Ground"},             moves={"Bone Club", "Rage"},            guids={"9bb943"},                   evoData={{cost=1, ball=YELLOW, gen=1, guids={"921715"}}} },
  {name="Marowak",    level=4,  types={"Ground"},             moves={"Bonemerang", "Thrash"},         guids={"f416a8","921715"}           },
  {name="Hitmonlee",  level=4,  types={"Fighting"},           moves={"Double Kick", "Mega Kick"},     guids={"1e6425","10087d"}           },
  {name="Hitmonchan", level=4,  types={"Fighting"},           moves={"Mega Punch", "Counter"},        guids={"ffe3b0","d55591"}           },
  {name="Lickitung",  level=4,  types={"Normal"},             moves={"Lick", "Slam"},                 guids={"6abe93"},                   evoData={{cost=1, ball=YELLOW, gen=4, guids={"5d1069"}}} },
  {name="Koffing",    level=3,  types={"Poison"},             moves={"Smog", "Tackle"},               guids={"902c83"},                   evoData={{cost=2, ball=RED, gen=1, guids={"923b8f"}}} },
  {name="Weezing",    level=5,  types={"Poison"},             moves={"Self-Destruct", "Sludge"},      guids={"934454","923b8f"}           },
  {name="Rhyhorn",    level=4,  types={"Ground", "Rock"},     moves={"Fury Attack", "Horn Attack"},   guids={"b40a42"},                   evoData={{cost=2, ball=RED, gen=1, guids={"6922c6"}}} },
  {name="Rhydon",     level=6,  types={"Ground", "Rock"},     moves={"Horn Drill", "Earthquake"},     guids={"2cb778","6922c6"},          evoData={{cost=1, ball=RED, gen=4, guids={"1665fe","f2b985"}}} },
  {name="Chansey",    level=4,  types={"Normal"},             moves={"Double Slap", "Sing"},          guids={"0f0dcb","ee10ff"},          evoData={{cost=1, ball=RED, gen=2, guids={"5b9024","774d72"}}} },
  {name="Tangela",    level=3,  types={"Grass"},              moves={"Vine Whip", "Bind"},            guids={"1ca74c"},                   evoData={{cost=1, ball=YELLOW, gen=4, guids={"5965cd"}}} },
  {name="Kangaskhan", level=4,  types={"Normal"},             moves={"Dizzy Punch", "Bite"},          guids={"cf2b95"}                    },
  {name="Horsea",     level=2,  types={"Water"},              moves={"Bubble", "Leer"},               guids={"17d28f"},                   evoData={{cost=3, ball=RED, gen=1, guids={"a87dc7"}}} },
  {name="Seadra",     level=5,  types={"Water"},              moves={"Smokescreen", "Bubble Beam"},   guids={"f5b456","a87dc7"},          evoData={{cost=1, ball=RED, gen=2, guids={"0b677f","3b17f1"}}} },
  {name="Goldeen",    level=2,  types={"Water"},              moves={"Horn Attack", "Peck"},          guids={"7ba0cd"},                   evoData={{cost=3, ball=YELLOW, gen=1, guids={"4d1c92"}}} },
  {name="Seaking",    level=5,  types={"Water"},              moves={"Fury Attack", "Waterfall"},     guids={"0fbe89","4d1c92"}           },
  {name="Staryu",     level=2,  types={"Water"},              moves={"Water Gun", "Tackle"},          guids={"887830"},                   evoData={{cost=3, ball=YELLOW, gen=1, guids={"e03570"}}} },
  {name="Starmie",    level=5,  types={"Water", "Psychic"},   moves={"Hydro Pump", "Swift"},          guids={"4f6664","e03570"}           },
  {name="Mr. Mime",   level=3,  types={"Psychic"},            moves={"Confusion", "Barrier"},         guids={"5c3184","8315de"}           },
  {name="Scyther",    level=4,  types={"Bug", "Flying"},      moves={"Fury Cutter", "Slash"},         guids={"36242b"},                   evoData={{cost=1, ball=RED, gen=2, guids={"22e6a3"}}} },
  {name="Jynx",       level=4,  types={"Ice", "Psychic"},     moves={"Lovely Kiss", "Ice Punch"},     guids={"7fad23","4bc360"}           },
  {name="Electabuzz", level=4,  types={"Electric"},           moves={"Thunder Punch", "Screech"},     guids={"00e028","749909"},          evoData={{cost=2, ball=RED, gen=4, guids={"11f593","896d6e"}}} },
  {name="Magmar",     level=4,  types={"Fire"},               moves={"Fire Punch", "Smog"},           guids={"e92ee6","a0aed6"},          evoData={{cost=2, ball=RED, gen=4, guids={"bc96fe","ebafae"}}} },
  {name="Pinsir",     level=4,  types={"Bug"},                moves={"X-Scissor", "Vise Grip"},       guids={"141f37"}                    },
  {name="Tauros",     level=4,  types={"Normal"},             moves={"Take Down", "Swagger"},         guids={"904903"}                    },
  {name="Magikarp",   level=1,  types={"Water"},              moves={"Splash"},                       guids={"f877ca"},                   evoData={{cost=2, ball=GREEN, gen=1, guids={"985830"}}} },
  {name="Gyarados",   level=3,  types={"Water", "Flying"},    moves={"Dragon Rage", "Bite"},          guids={"d14d19","985830"}           },
  {name="Lapras",     level=3,  types={"Water", "Ice"},       moves={"Body Slam", "Ice Beam"},        guids={"a465e9"}                    },
  {name="Ditto",      level=4,  types={"Normal"},             moves={"Transform"},                    guids={"c2023e"}                    },
  {name="Eevee",      level=3,  types={"Normal"},             moves={"Quick Attack", "Bite"},         guids={"690870"},                   evoData={{cost=2, ball=YELLOW, gen=1, guids={"98756d"}},{cost=2, ball=YELLOW, gen=1, guids={"090cce"}},{cost=2, ball=YELLOW, gen=1, guids={"901417"}},{cost=2, ball=YELLOW, gen=2, guids={"63caca"}},{cost=2, ball=YELLOW, gen=2, guids={"5daac2"}},{cost=2, ball=YELLOW, gen=4,guids={"25ef7b"}},{cost=2, ball=YELLOW, gen=4,guids={"549166"}}} },
  {name="Vaporeon",   level=5,  types={"Water"},              moves={"Aurora Beam", "Hydro Pump"},    guids={"dc74f4","98756d"}           },
  {name="Jolteon",    level=5,  types={"Electric"},           moves={"Pin Missile", "Thunder"},       guids={"7309b7","090cce"}           },
  {name="Flareon",    level=5,  types={"Fire"},               moves={"Fire Blast", "Smog"},           guids={"2eadbb","901417"}           },
  {name="Porygon",    level=2,  types={"Normal"},             moves={"Conversion", "Sharpen"},        guids={"f4d087"},                   evoData={{cost=2, ball=BLUE, gen=2, guids={"145660"}}} },
  {name="Omanyte",    level=4,  types={"Rock", "Water"},      moves={"Spike Cannon", "Water Gun"},    guids={"7c9350"},                   evoData={{cost=2, ball=RED, gen=1, guids={"4bad46"}}} },
  {name="Omastar",    level=6,  types={"Rock", "Water"},      moves={"Hydro Pump", "Horn Attack"},    guids={"fcdf06","4bad46"}           },
  {name="Kabuto",     level=4,  types={"Rock", "Water"},      moves={"Harden", "Absorb"},             guids={"adad5d"},                   evoData={{cost=2, ball=RED, gen=1, guids={"b99ba9"}}} },
  {name="Kabutops",   level=6,  types={"Rock", "Water"},      moves={"Hydro Pump", "Slash"},          guids={"2fbb99","b99ba9"}           },
  {name="Aerodactyl", level=4,  types={"Rock", "Flying"},     moves={"Hyper Beam", "Wing Attack"},    guids={"b69470"}                    },
  {name="Snorlax",    level=4,  types={"Normal"},             moves={"Double-Edge", "Body Slam"},     guids={"2ef955","81f09a","a017f9"}  },
  {name="Articuno",   level=7,  types={"Ice", "Flying"},      moves={"Mirror Coat", "Blizzard"},      guids={"0e47e0"}                    },
  {name="Zapdos",     level=7,  types={"Electric", "Flying"}, moves={"Thunder", "Drill Peck"},        guids={"810844"}                    },
  {name="Moltres",    level=7,  types={"Fire", "Flying"},     moves={"Sky Attack", "Fire Spin"},      guids={"cf5cee"}                    },
  {name="Dratini",    level=2,  types={"Dragon"},             moves={"Wrap", "Leer"},                 guids={"7a8c75"},                   evoData={{cost=2, ball=YELLOW, gen=1, guids={"3add33"}}} },
  {name="Dragonair",  level=4,  types={"Dragon"},             moves={"Thunder Wave", "Slam"},         guids={"7189e9","3add33"},          evoData={{cost=3, ball=RED, gen=1, guids={"bd4406","1b136e"}}} },
  {name="Dragonite",  level=7,  types={"Dragon", "Flying"},   moves={"Dragon Rage", "Hyper Beam"},    guids={"907860","bd4406","1b136e"}  },
  {name="Mewtwo",     level=7,  types={"Psychic"},            moves={"Shadow Ball", "Future Sight"},  guids={"d78d06"}                    },
  {name="Mew",        level=7,  types={"Psychic"},            moves={"Ancient Power", "Psychic"},     guids={"d68dfc"}                    }
}

gen2PokemonData =
{
  -- Gen 2 152-200
  {name="Chikorita",  level=1,  types={"Grass"},              moves={"Bullet Seed", "Growl"},         guids={"cbe3c6"},                   evoData={{cost=2, ball=BLUE, gen=2, guids={"7ca3d7"}}} },
  {name="Bayleef",    level=3,  types={"Grass"},              moves={"Razor Leaf", "Reflect"},        guids={"e64a46","7ca3d7"},          evoData={{cost=2, ball=RED, gen=2, guids={"595e82","1d0c75"}}} },
  {name="Meganium",   level=5,  types={"Grass"},              moves={"Body Slam", "Solar Beam"},      guids={"97ddd4","595e82","1d0c75"}  },
  {name="Cyndaquil",  level=1,  types={"Fire"},               moves={"Smokescreen", "Ember"},         guids={"8b91c9"},                   evoData={{cost=2, ball=GREEN, gen=2, guids={"4fe850"}}} },
  {name="Quilava",    level=3,  types={"Fire"},               moves={"Flame Wheel", "Quick Attack"},  guids={"ec0bac","4fe850"},          evoData={{cost=2, ball=RED, gen=2, guids={"444d49","aef275"}}} },
  {name="Typhlosion", level=5,  types={"Fire"},               moves={"Flamethrower", "Swift"},        guids={"7ce124","444d49","aef275"}, evolveGen=2},
  {name="Totodile",   level=1,  types={"Water"},              moves={"Growl", "Bite"},                guids={"9f245a"},                   evoData={{cost=2, ball=BLUE, gen=2, guids={"1915a6"}}} },
  {name="Croconaw",   level=3,  types={"Water"},              moves={"Water Gun", "Rage"},            guids={"0f1ac8","1915a6"},          evoData={{cost=2, ball=RED, gen=2, guids={"d723a2","4c2d4e"}}} },
  {name="Feraligatr", level=5,  types={"Water"},              moves={"Waterfall", "Slash"},           guids={"b382a4","d723a2","4c2d4e"}  },
  {name="Sentret",    level=1,  types={"Normal"},             moves={"Defense Curl", "Scratch"},      guids={"dc2eea"},                   evoData={{cost=1, ball=GREEN, gen=2, guids={"db025b"}}} },
  {name="Furret",     level=2,  types={"Normal"},             moves={"Fury Swipes", "Slam"},          guids={"bddff6","db025b"}           },
  {name="Hoothoot",   level=1,  types={"Flying", "Normal"},   moves={"Growl", "Peck"},                guids={"2cd22d"},                   evoData={{cost=2, ball=BLUE, gen=2, guids={"57ec65"}}} },
  {name="Noctowl",    level=3,  types={"Flying", "Normal"},   moves={"Take Down", "Reflect"},         guids={"89f5ff","57ec65"}           },
  {name="Ledyba",     level=1,  types={"Bug", "Flying"},      moves={"Comet Punch", "Tackle"},        guids={"83168b"},                   evoData={{cost=2, ball=BLUE, gen=2, guids={"0b2791"}}} },
  {name="Ledian",     level=3,  types={"Bug", "Flying"},      moves={"Reflect", "Swift"},             guids={"3d93ed","0b2791"}           },
  {name="Spinarak",   level=1,  types={"Bug", "Poison"},      moves={"Poison Sting", "Constrict"},    guids={"4a74ab"},                   evoData={{cost=2, ball=BLUE, gen=2, guids={"f8e383"}}} },
  {name="Ariados",    level=3,  types={"Bug", "Poison"},      moves={"Night Shade", "Leech Life"},    guids={"6027c1","f8e383"}           },
  {name="Crobat",     level=5,  types={"Poison", "Flying"},   moves={"Confuse Ray", "Wing Attack"},   guids={"c8cb11","79419e","1d7367"}  },
  {name="Chinchou",   level=3,  types={"Water", "Electric"},  moves={"Thunder Wave", "Bubble"},       guids={"5cd23a"},                   evoData={{cost=1, ball=YELLOW, gen=2, guids={"3bb655"}}} },
  {name="Lanturn",    level=4,  types={"Water", "Electric"},  moves={"Hydro Pump", "Spark"},          guids={"ca2f7d","3bb655"}           },
  {name="Pichu",      level=0,  types={"Electric"},           moves={"Tail Whip"},                    guids={"7a0478"},                   evoData={{cost=1, ball=PINK, gen=2, guids={"e5c82a"}}} },
  {name="Cleffa",     level=0,  types={"Fairy"},              moves={"Sweet Kiss"},                   guids={"5f28fe"},                   evoData={{cost=2, ball=PINK, gen=2, guids={"04404a"}}} },
  {name="Igglybuff",  level=0,  types={"Normal"},             moves={"Defense Curl"},                 guids={"c288dc"},                   evoData={{cost=1, ball=PINK, gen=2, guids={"81f395"}}} },
  {name="Togepi",     level=0,  types={"Fairy"},              moves={"Charm"},                        guids={"b85f3c"},                   evoData={{cost=2, ball=PINK, gen=2, guids={"abaff2"}}} },
  {name="Togetic",    level=2,  types={"Fairy", "Flying"},    moves={"Fairy Wind", "Safeguard"},      guids={"f8ed52","abaff2"},          evoData={{cost=2, ball=YELLOW, gen=4, guids={"020ecc","3786d0"}}} },
  {name="Natu",       level=3,  types={"Psychic", "Flying"},  moves={"Leer", "Peck"},                 guids={"d743cd"},                   evoData={{cost=1, ball=YELLOW, gen=2, guids={"a31065"}}} },
  {name="Xatu",       level=4,  types={"Psychic", "Flying"},  moves={"Future Sight", "Confuse Ray"},  guids={"c056ff","a31065"}           },
  {name="Mareep",     level=1,  types={"Electric"},           moves={"Growl", "Tackle"},              guids={"64aa14"},                   evoData={{cost=1, ball=GREEN, gen=2, guids={"6e25fb"}}} },
  {name="Flaaffy",    level=2,  types={"Electric"},           moves={"Thunder Shock", "Light Screen"},guids={"65023c","6e25fb"},          evoData={{cost=2, ball=YELLOW, gen=2, guids={"433542","089edd"}}} },
  {name="Ampharos",   level=4,  types={"Electric"},           moves={"Thunder Wave", "Thunder"},      guids={"57b26e","433542","089edd"}  },
  {name="Bellossom",  level=4,  types={"Grass"},              moves={"Sleep Powder", "Solar Beam"},   guids={"eda382","14e4ad","fd44a1"}  },
  {name="Marill",     level=2,  types={"Water"},              moves={"Defense Curl", "Water Gun"},    guids={"d42c6f","e76d9a"},          evoData={{cost=1, ball=BLUE, gen=2, guids={"47a0c6","1ad3a2"}}} },
  {name="Azumarill",  level=3,  types={"Water"},              moves={"Waterfall", "Rollout"},         guids={"972ac4","47a0c6","1ad3a2"}  },
  {name="Sudowoodo",  level=3,  types={"Rock"},               moves={"Rock Throw", "Mimic"},          guids={"539dea","eeca81"}           },
  {name="Politoed",   level=6,  types={"Water"},              moves={"Hydro Pump", "Swagger"},        guids={"67f2a8","9a1b0b","b21ff9"}  },
  {name="Hoppip",     level=1,  types={"Grass", "Flying"},    moves={"Tail Whip", "Tackle"},          guids={"485f54"},                   evoData={{cost=2, ball=BLUE, gen=2, guids={"996e19"}}} },
  {name="Skiploom",   level=3,  types={"Grass", "Flying"},    moves={"Poison Powder", "Stun Spore"},  guids={"e1c8ca","996e19"},          evoData={{cost=1, ball=YELLOW, gen=2, guids={"18d441","66e564"}}} },
  {name="Jumpluff",   level=4,  types={"Grass", "Flying"},    moves={"Sleep Powder", "Mega Drain"},   guids={"766518","18d441","66e564"}  },
  {name="Aipom",      level=2,  types={"Normal"},             moves={"Sand Attack", "Scratch"},       guids={"7da245"},                   evoData={{cost=2, ball=BLUE, gen=4, guids={"06f1a9"}}} },
  {name="Sunkern",    level=2,  types={"Grass"},              moves={"Absorb", "Pound"},              guids={"2a0f37"},                   evoData={{cost=2, ball=BLUE, gen=2, guids={"da3544"}}} },
  {name="Sunflora",   level=4,  types={"Grass"},              moves={"Petal Dance", "Razor Leaf"},    guids={"f43c37","da3544"}           },
  {name="Yanma",      level=2,  types={"Bug", "Flying"},      moves={"Quick Attack", "Hypnosis"},     guids={"df3c90"},                   evoData={{cost=2, ball=YELLOW, gen=4, guids={"e093cb"}}} },
  {name="Wooper",     level=1,  types={"Water", "Ground"},    moves={"Water Gun", "Tail Whip"},       guids={"3403ab"},                   evoData={{cost=2, ball=BLUE, gen=2, guids={"5281dd"}}} },
  {name="Quagsire",   level=3,  types={"Water", "Ground"},    moves={"Earthquake", "Slam"},           guids={"1813f8","5281dd"}           },
  {name="Espeon",     level=5,  types={"Psychic"},            moves={"Psybeam", "Swift"},             guids={"6fdb1c","5daac2"}           },
  {name="Umbreon",    level=5,  types={"Dark"},               moves={"Confuse Ray", "Feint Attack"},  guids={"a074fb","63caca"}           },
  {name="Murkrow",    level=3,  types={"Dark", "Flying"},     moves={"Feint Attack", "Peck"},         guids={"d39237"},                   evoData={{cost=1, ball=YELLOW, gen=4, guids={"4f1558"}}} },
  {name="Slowking",   level=5,  types={"Water", "Psychic"},   moves={"Headbutt", "Psychic"},          guids={"f0d007","83160e"}           },
  {name="Misdreavus", level=4,  types={"Ghost"},              moves={"Confuse Ray", "Psywave"},       guids={"86b019"},                   evoData={{cost=1, ball=YELLOW, gen=4, guids={"496256"}}} },
  -- Gen 2 201-251
  {name="Unown",      level=1,  types={"Psychic"},            moves={"Hidden Power"},                 guids={"0dc6f9"}                    },
  {name="Wobbuffet",  level=2,  types={"Psychic"},            moves={"Safeguard", "Counter"},         guids={"5dd7a5","0bbbae"}           },
  {name="Girafarig",  level=2,  types={"Normal", "Psychic"},  moves={"Confusion", "Tackle"},          guids={"1fc55d"}                    },
  {name="Pineco",     level=2,  types={"Bug"},                moves={"Protect", "Tackle"},            guids={"0d263c"},                   evoData={{cost=2, ball=YELLOW, gen=2, guids={"7b0bfe"}}} },
  {name="Forretress", level=4,  types={"Bug", "Steel"},       moves={"Double-Edge", "Spikes"},        guids={"669297","7b0bfe"}           },
  {name="Dunsparce",  level=1,  types={"Normal"},             moves={"Glare", "Rage"},                guids={"e86d8a"}                    },
  {name="Gligar",     level=4,  types={"Ground", "Flying"},   moves={"Feint Attack", "Quick Attack"}, guids={"f15436"},                   evoData={{cost=1, ball=YELLOW, gen=4, guids={"96a4fa"}}} },
  {name="Steelix",    level=4,  types={"Steel", "Ground"},    moves={"Iron Tail", "Crunch"},          guids={"93482a","9248b4"}           },
  {name="Snubbull",   level=2,  types={"Fairy"},              moves={"Charm", "Rage"},                guids={"d85741"},                   evoData={{cost=1, ball=BLUE, gen=2, guids={"5351ec"}}} },
  {name="Granbull",   level=3,  types={"Fairy"},              moves={"Bite", "Lick"},                 guids={"13fcb1","5351ec"}           },
  {name="Qwilfish",   level=4,  types={"Water", "Poison"},    moves={"Poison Sting", "Water Gun"},    guids={"d28384"}                    },
  {name="Scizor",     level=5,  types={"Bug", "Steel"},       moves={"Metal Claw", "Wing Attack"},    guids={"7e05b1","22e6a3"}           },
  {name="Shuckle",    level=2,  types={"Bug", "Rock"},        moves={"Withdraw", "Wrap"},             guids={"3d91d1"}                    },
  {name="Heracross",  level=4,  types={"Bug", "Fighting"},    moves={"Horn Attack", "Counter"},       guids={"6f8ffe"}                    },
  {name="Sneasel",    level=3,  types={"Dark", "Ice"},        moves={"Feint Attack", "Quick Attack"}, guids={"c13dc3"},                   evoData={{cost=1, ball=YELLOW, gen=4, guids={"9b517e"}}} },
  {name="Teddiursa",  level=3,  types={"Normal"},             moves={"Fury Swipes", "Lick"},          guids={"e9f2b7"},                   evoData={{cost=1, ball=YELLOW, gen=2, guids={"415c99"}}} },
  {name="Ursaring",   level=4,  types={"Normal"},             moves={"Feint Attack", "Thrash"},       guids={"e48590","415c99"}           },
  {name="Slugma",     level=4,  types={"Fire"},               moves={"Ember", "Smog"},                guids={"9c822d"},                   evoData={{cost=1, ball=RED, gen=2, guids={"b1cc91"}}} },
  {name="Magcargo",   level=5,  types={"Fire", "Rock"},       moves={"Flamethrower", "Rock Slide"},   guids={"3cadf7","b1cc91"}           },
  {name="Swinub",     level=3,  types={"Ice", "Ground"},      moves={"Powder Snow", "Tackle"},        guids={"cbd281"},                   evoData={{cost=2, ball=YELLOW, gen=2, guids={"e3f6d9"}}} },
  {name="Piloswine",  level=5,  types={"Ice", "Ground"},      moves={"Take Down", "Blizzard"},        guids={"79cc3d","e3f6d9"},          evoData={{cost=1, ball=RED, gen=4, guids={"bac5e2","3e9a5e"}}} },
  {name="Corsola",    level=3,  types={"Water", "Rock"},      moves={"Ancient Power", "Waterfall"},   guids={"180047"}                    },
  {name="Remoraid",   level=3,  types={"Water"},              moves={"Psybeam", "Water Gun"},         guids={"c6633d"},                   evoData={{cost=1, ball=YELLOW, gen=2, guids={"93e4e2"}}} },
  {name="Octillery",  level=4,  types={"Water"},              moves={"Octazooka", "Ice Beam"},        guids={"ae520a","93e4e2"}           },
  {name="Delibird",   level=3,  types={"Ice", "Flying"},      moves={"Present"},                      guids={"6588c5"}                    },
  {name="Mantine",    level=3,  types={"Water", "Flying"},    moves={"Bubble Beam", "Wing Attack"},   guids={"1142f0","6fd093"}           },
  {name="Skarmory",   level=4,  types={"Steel", "Flying"},    moves={"Steel Wing", "Swift"},          guids={"cfa0f1"}                    },
  {name="Houndour",   level=2,  types={"Dark", "Fire"},       moves={"Ember", "Bite"},                guids={"0e8e22"},                   evoData={{cost=2, ball=YELLOW, gen=2, guids={"cf82ee"}}} },
  {name="Houndoom",   level=4,  types={"Dark", "Fire"},       moves={"Flamethrower", "Crunch"},       guids={"5ef848","cf82ee"}           },
  {name="Kingdra",    level=6,  types={"Dragon", "Water"},    moves={"Hydro Pump", "Twister"},        guids={"bc99c5","0b677f","3b17f1"}  },
  {name="Phanpy",     level=3,  types={"Ground"},             moves={"Take Down", "Rollout"},         guids={"7c1ad0"},                   evoData={{cost=1, ball=YELLOW, gen=2, guids={"980292"}}} },
  {name="Donphan",    level=4,  types={"Ground"},             moves={"Horn Attack", "Earthquake"},    guids={"dcdc1d","980292"}           },
  {name="Porygon2",   level=4,  types={"Normal"},             moves={"Tri Attack", "Conversion2"},    guids={"b7c99b","145660"},          evoData={{cost=1, ball=YELLOW, gen=4, guids={"89624f","ccdbee"}}} },
  {name="Stantler",   level=2,  types={"Normal"},             moves={"Hypnosis", "Tackle"},           guids={"3ba296"}                    },
  {name="Smeargle",   level=3,  types={"Normal"},             moves={"Sketch", "Sketch"},             guids={"5496a6"}                    },
  {name="Tyrogue",    level=1,  types={"Fighting"},           moves={"Tackle"},                       guids={"b896b9"},                   evoData={{cost=3, ball=BLUE, gen=1, guids={"d55591"}},{cost=3, ball=BLUE, gen=1, guids={"10087d"}},{cost=3, ball=BLUE, gen=2, guids={"b53d14"}}} },
  {name="Hitmontop",  level=4,  types={"Fighting"},           moves={"Triple Kick", "Quick Attack"},  guids={"1aeec6","b53d14"}           },
  {name="Smoochum",   level=1,  types={"Ice", "Psychic"},     moves={"Pound", "Lick"},                guids={"961d64"},                   evoData={{cost=3, ball=YELLOW, gen=2, guids={"4bc360"}}} },
  {name="Elekid",     level=1,  types={"Electric"},           moves={"Quick Attack", "Leer"},         guids={"b6056a"},                   evoData={{cost=3, ball=YELLOW, gen=2, guids={"749909"}}} },
  {name="Magby",      level=1,  types={"Fire"},               moves={"Smokescreen",  "Smog"},         guids={"a47ff8"},                   evoData={{cost=3, ball=YELLOW, gen=2, guids={"a0aed6"}}} },
  {name="Miltank",    level=2,  types={"Normal"},             moves={"Heal Bell", "Tackle"},          guids={"8d2189"}                    },
  {name="Blissey",    level=5,  types={"Normal"},             moves={"Double-Edge", "Egg Bomb"},      guids={"27e857","5b9024","774d72"}  },
  {name="Raikou",     level=7,  types={"Electric"},           moves={"Crunch", "Spark"},              guids={"07ea8b"}                    },
  {name="Entei",      level=7,  types={"Fire"},               moves={"Fire Blast", "Bite"},           guids={"dbfb71"}                    },
  {name="Suicune",    level=7,  types={"Water"},              moves={"Aurora Beam", "Hydro Pump"},    guids={"ab44f1"}                    },
  {name="Larvitar",   level=2,  types={"Rock", "Ground"},     moves={"Bite", "Leer"},                 guids={"625880"},                   evoData={{cost=2, ball=YELLOW, gen=2, guids={"aa8662"}}} },
  {name="Pupitar",    level=4,  types={"Rock", "Ground"},     moves={"Earthquake", "Screech"},        guids={"159d4d","aa8662"},          evoData={{cost=3, ball=RED, gen=2, guids={"7195d5","5764be"}}} },
  {name="Tyranitar",  level=7,  types={"Rock", "Dark"},       moves={"Rock Slide", "Crunch"},         guids={"d2d545","7195d5","5764be"}  },
  {name="Lugia",      level=7,  types={"Psychic", "Flying"},  moves={"Future Sight", "Aeroblast"},    guids={"5e4745"}                    },
  {name="Ho-oh",      level=7,  types={"Fire", "Flying"},     moves={"Ancient Power", "Sacred Fire"}, guids={"22569b"}                    },
  {name="Celebi",     level=7,  types={"Psychic", "Grass"},   moves={"Solar Beam", "Psychic"},        guids={"4d10a7"}                    }
}

gen3PokemonData =
{
  -- Gen 3 252-300
  {name="Treecko",    level=1,  types={"Grass"},              moves={"Quick Attack", "Absorb"},       guids={"cd2a1e"},                   evoData={{cost=2, ball=BLUE, gen=3, guids={"71f6d0"}}} },
  {name="Grovyle",    level=3,  types={"Grass"},              moves={"Leaf Blade", "Slam"},           guids={"fc07df","71f6d0"},          evoData={{cost=2, ball=RED, gen=3, guids={"6acdb2","8d967c"}}} },
  {name="Sceptile",   level=5,  types={"Grass"},              moves={"Solar Beam", "Iron Tail"},      guids={"01d5b8","6acdb2","8d967c"}  },
  {name="Torchic",    level=1,  types={"Fire"},               moves={"Growl", "Ember"},               guids={"dfac41"},                   evoData={{cost=2, ball=BLUE, gen=3, guids={"0d3fc1"}}} },
  {name="Combusken",  level=3,  types={"Fire"},               moves={"Double Kick", "Blaze Kick"},    guids={"af5888","0d3fc1"},          evoData={{cost=2, ball=RED, gen=3, guids={"6b6eaa","e4fcc7"}}} },
  {name="Blaziken",   level=5,  types={"Fire"},               moves={"Sky Uppercut", "Overheat"},     guids={"b3e3d0","6b6eaa","e4fcc7"}  },
  {name="Mudkip",     level=1,  types={"Water"},              moves={"Mud-Slap", "Water Gun"},        guids={"18d937"},                    evoData={{cost=2, ball=BLUE, gen=3, guids={"80e724"}}} },
  {name="Marshtomp",  level=3,  types={"Water"},              moves={"Muddy Water", "Take Down"},     guids={"9d8a4b","80e724"},           evoData={{cost=2, ball=RED, gen=3, guids={"0f2fe4","93c652"}}} },
  {name="Swampert",   level=5,  types={"Water"},              moves={"Hydro Pump", "Earthquake"},     guids={"46c207","0f2fe4","93c652"}, },
  {name="Poochyena",  level=1,  types={"Dark"},               moves={"Howl", "Tackle"},               guids={"484c8e"},                   evoData={{cost=2, ball=BLUE, gen=3, guids={"ad5677"}}} },
  {name="Mightyena",  level=3,  types={"Dark"},               moves={"Take Down", "Crunch"},          guids={"d14a45","ad5677"}           },
  {name="Zigzagoon",  level=1,  types={"Normal"},             moves={"Sand Attack", "Tackle"},        guids={"8effad"},                   evoData={{cost=2, ball=BLUE, gen=3, guids={"fea2c0"}}} },
  {name="Linoone",    level=3,  types={"Normal"},             moves={"Fury Swipes", "Slash"},         guids={"49547c","fea2c0"}          },
  {name="Wurmple",    level=1,  types={"Bug"},                moves={"String Shot"},                  guids={"3b1e3a"},                   evoData={{cost=1, ball=PINK, gen=3, guids={"3756cf"}},{cost=1, ball=PINK, gen=3, guids={"b2567d"}}} },
  {name="Silcoon",    level=2,  types={"Bug"},                moves={"Harden", "Tackle"},             guids={"814073","3756cf"},          evoData={{cost=1, ball=GREEN, gen=3, guids={"64e59c","4a79ea"}}} },
  {name="Beautifly",  level=3,  types={"Bug"},                moves={"Silver Wind", "Mega Drain"},    guids={"f16171","64e59c","4a79ea"}  },
  {name="Cascoon",    level=2,  types={"Bug"},                moves={"Poison Sting", "Harden"},       guids={"2e69ca","b2567d"},          evoData={{cost=1, ball=GREEN, gen=3, guids={"bf6b7d","2ee4fc"}}} },
  {name="Dustox",     level=3,  types={"Bug"},                moves={"Silver Wind", "Light Screen"},  guids={"f63e23","bf6b7d","2ee4fc"}  },
  {name="Lotad",      level=1,  types={"Water"},              moves={"Astonish", "Absorb"},           guids={"497b82"},                   evoData={{cost=2, ball=GREEN, gen=3, guids={"92c70d"}}} },
  {name="Lombre",     level=3,  types={"Water"},              moves={"Fury Swipes", "Water Gun"},     guids={"3081f1","92c70d"},          evoData={{cost=1, ball=BLUE, gen=3, guids={"043d72","6c7ae8"}}} },
  {name="Ludicolo",   level=4,  types={"Water"},              moves={"Nature Power", "Razor Leaf"},   guids={"8f090f","043d72","6c7ae8"}  },
  {name="Seedot",     level=1,  types={"Grass"},              moves={"Quick Attack", "Growth"},       guids={"b3dcac"},                   evoData={{cost=2, ball=GREEN, gen=3, guids={"9e2cc8"}}} },
  {name="Nuzleaf",    level=3,  types={"Grass"},              moves={"Extrasensory", "Fake Out"},     guids={"489f1b","9e2cc8"},          evoData={{cost=2, ball=YELLOW, gen=3, guids={"f02406","288090"}}} },
  {name="Shiftry",    level=5,  types={"Grass"},              moves={"Feint Attack", "Nature Power"}, guids={"eb4137","f02406","288090"}  },
  -- Gen 3 276-300
  {name="Taillow",    level=2,  types={"Flying"},             moves={"Growl", "Peck"},                guids={"93cbde"},                   evoData={{cost=2, ball=BLUE, gen=3, guids={"3e7919"}}} },
  {name="Swellow",    level=4,  types={"Flying"},             moves={"Quick Attack", "Aerial Ace"},   guids={"fd1fd2","3e7919"}           },
  {name="Wingull",    level=1,  types={"Water"},              moves={"Water Gun", "Mist"},            guids={"018621"},                   evoData={{cost=2, ball=BLUE, gen=3, guids={"b53aec"}}} },
  {name="Pelipper",   level=3,  types={"Water"},              moves={"Water Pulse", "Wing Attack"},   guids={"3fd851","b53aec"}           },
  {name="Ralts",      level=1,  types={"Psychic"},            moves={"Confusion"},                    guids={"92ca7a"},                   evoData={{cost=2, ball=BLUE, gen=3, guids={"61a3fe"}}} },
  {name="Kirlia",     level=3,  types={"Psychic"},            moves={"Will-O-Wisp", "Psychic"},       guids={"260dd4","61a3fe"},          evoData={{cost=2, ball=RED, gen=3, guids={"a58279","9ef381"}},{cost=2, ball=RED, gen=4, guids={"491632","2956c7"}}} },
  {name="Gardevoir",  level=5,  types={"Psychic"},            moves={"Future Sight", "Shock Wave"},   guids={"fe8f9a","a58279","9ef381"}  },
  {name="Surskit",    level=1,  types={"Bug"},                moves={"Bubble"},                       guids={"f47f95"},                   evoData={{cost=2, ball=GREEN, gen=3, guids={"899d71"}}} },
  {name="Masquerain", level=3,  types={"Bug"},                moves={"Bubble Beam", "Mud Shot"},      guids={"6f6a4b","899d71"}           },
  {name="Shroomish",  level=1,  types={"Grass"},              moves={"Stun Spore", "Tackle"},         guids={"afce65"},                   evoData={{cost=2, ball=GREEN, gen=3, guids={"b2b675"}}} },
  {name="Breloom",    level=3,  types={"Grass"},              moves={"Dynamic Punch", "Mega Drain"},  guids={"54f6b2","b2b675"}           },
  {name="Slakoth",    level=2,  types={"Normal"},             moves={"Scratch"},                      guids={"0e7e5b"},                   evoData={{cost=1, ball=BLUE, gen=3, guids={"bb497c"}}} },
  {name="Vigoroth",   level=3,  types={"Normal"},             moves={"Counter", "Slash"},             guids={"167d17","bb497c"},          evoData={{cost=3, ball=RED, gen=3, guids={"9e0b51","eed73b"}}} },
  {name="Slaking",    level=6,  types={"Normal"},             moves={"Feint Attack", "Covet"},        guids={"beea0e","9e0b51","eed73b"}  },
  {name="Nincada",    level=2,  types={"Bug"},                moves={"Fury Swipes", "Mud-Slap"},      guids={"6a52b9"},                   evoData={{cost=2, ball=BLUE, gen=3, guids={"2f18cb"}},{cost=2, ball=BLUE, gen=3, guids={"b9a6c3"}}} },
  {name="Ninjask",    level=4,  types={"Bug"},                moves={"Swords Dance", "Leech Life"},   guids={"5fca25","2f18cb"}           },
  {name="Shedinja",   level=4,  types={"Bug"},                moves={"Shadow Ball", "Metal Claw"},    guids={"1a8813","b9a6c3"}           },
  {name="Whismur",    level=2,  types={"Normal"},             moves={"Astonish", "Pound"},            guids={"86e898"},                   evoData={{cost=2, ball=BLUE, gen=3, guids={"9b89d3"}}} },
  {name="Loudred",    level=4,  types={"Normal"},             moves={"Hyper Voice", "Screech"},       guids={"c874a8","9b89d3"},          evoData={{cost=2, ball=RED, gen=3, guids={"f2324f", "5b1de6"}}} },
  {name="Exploud",    level=6,  types={"Normal"},             moves={"Extrasensory", "Stomp"},        guids={"bebdb9","f2324f","5b1de6"}  },
  {name="Makuhita",   level=2,  types={"Fighting"},           moves={"Arm Thrust", "Tackle"},         guids={"52f60d"},                   evoData={{cost=2, ball=BLUE, gen=3, guids={"9266af"}}} },
  {name="Hariyama",   level=4,  types={"Fighting"},           moves={"Smelling Salts", "Vital Throw"},guids={"840d39","9266af"}           },
  {name="Azurill",    level=0,  types={"Normal"},             moves={"Bubble"},                       guids={"4132b8"},                   evoData={{cost=2, ball=GREEN, gen=2, guids={"e76d9a"}}} },
  {name="Nosepass",   level=3,  types={"Rock"},               moves={"Thunder Wave", "Rock Throw"},   guids={"d3a1d5"},                   evoData={{cost=2, ball=YELLOW, gen=4, guids={"261bac"}}} },
  {name="Skitty",     level=2,  types={"Normal"},             moves={"Double Slap","Attract"},        guids={"2ded89"},                   evoData={{cost=2, ball=BLUE, gen=3, guids={"9cca58"}}} },
  -- Gen 3 301-325
  {name="Delcatty",   level=4,  types={"Normal"},             moves={"Double-Edge", "Feint Attack"},  guids={"5498b5","9cca58"}           },
  {name="Sableye",    level=4,  types={"Dark"},               moves={"Shadow Ball", "Knock Off"},     guids={"d0ddb7"}                    },
  {name="Mawile",     level=4,  types={"Steel"},              moves={"Iron Defense", "Crunch"},       guids={"825f3c"}                    },
  {name="Aron",       level=2,  types={"Steel"},              moves={"Headbutt", "Mud-Slap"},         guids={"2bdf79"},                   evoData={{cost=2, ball=YELLOW, gen=3, guids={"1ad335"}}} },
  {name="Lairon",     level=4,  types={"Steel"},              moves={"Metal Claw", "Take Down"},      guids={"fc819f","1ad335"},          evoData={{cost=2, ball=RED, gen=3, guids={"19c95d","037e57"}}} },
  {name="Aggron",     level=6,  types={"Steel"},              moves={"Earthquake", "Iron Tail"},      guids={"a5daad","19c95d","037e57"}  },
  {name="Meditite",   level=2,  types={"Fighting"},           moves={"Hidden Power", "Detect"},       guids={"8cae23"},                   evoData={{cost=2, ball=YELLOW, gen=3, guids={"925a8f"}}} },
  {name="Medicham",   level=4,  types={"Fighting"},           moves={"High Jump Kick", "Confusion"},  guids={"1b2da9","925a8f"}           },
  {name="Electrike",  level=2,  types={"Electric"},           moves={"Thunder Wave", "Quick Attack"}, guids={"e37270"},                   evoData={{cost=2, ball=YELLOW, gen=3, guids={"24b582"}}} },
  {name="Manectric",  level=4,  types={"Electric"},           moves={"Thunder", "Bite"},              guids={"66eddf","24b582"}           },
  {name="Plusle",     level=2,  types={"Electric"},           moves={"Thunder Wave", "Spark"},        guids={"78d266"}                    },
  {name="Minun",      level=2,  types={"Electric"},           moves={"Quick Attack", "Spark"},        guids={"37efd6"}                    },
  {name="Volbeat",    level=2,  types={"Bug"},                moves={"Signal Beam", "Double-Edge"},   guids={"b1d72d"}                    },
  {name="Illumise",   level=2,  types={"Bug"},                moves={"Silver Wind", "Covet"},         guids={"d3520a"}                    },
  {name="Roselia",    level=3,  types={"Grass"},              moves={"Magical Leaf", "Body Slam"},    guids={"6c4ab2","7e165f"},          evoData={{cost=2, ball=YELLOW, gen=4, guids={"4aa1de","46f8dc"}}} },
  {name="Gulpin",     level=2,  types={"Poison"},             moves={"Poison Gas", "Pound"},          guids={"c08fc1"},                   evoData={{cost=2, ball=YELLOW, gen=3, guids={"aac35d"}}} },
  {name="Swalot",     level=4,  types={"Poison"},             moves={"Sludge Bomb", "Body Slam"},     guids={"2a3068","aac35d"}           },
  {name="Carvanha",   level=2,  types={"Water"},              moves={"Bite", "Rage"},                 guids={"1f850b"},                   evoData={{cost=2, ball=YELLOW, gen=3, guids={"7d206a"}}} },
  {name="Sharpedo",   level=4,  types={"Water"},              moves={"Waterfall", "Crunch"},          guids={"852350","7d206a"}           },
  {name="Wailmer",    level=3,  types={"Water"},              moves={"Whirlpool", "Amnesia"},         guids={"bf7581"},                   evoData={{cost=2, ball=RED, gen=3, guids={"58fe14"}}} },
  {name="Wailord",    level=5,  types={"Water"},              moves={"Body Slam", "Water Spout"},     guids={"b1528a","58fe14"}           },
  {name="Numel",      level=2,  types={"Fire"},               moves={"Take Down", "Ember"},           guids={"dda685"},                   evoData={{cost=2, ball=YELLOW, gen=3, guids={"4bfb16"}}} },
  {name="Camerupt",   level=4,  types={"Fire"},               moves={"Magnitude", "Eruption"},        guids={"2bbebf","4bfb16"}           },
  {name="Turkoal",    level=3,  types={"Fire"},               moves={"Flamethrower", "Iron Defense"}, guids={"61c078"}                   },
  {name="Spoink",     level=2,  types={"Psychic"},            moves={"Confuse Ray", "Magic Coat"},    guids={"93357d"},                   evoData={{cost=2, ball=YELLOW, gen=3, guids={"b51484"}}} },
  -- Gen 3 326-350
  {name="Grumpig",    level=4,  types={"Psychic"},            moves={"Psywave", "Bounce"},            guids={"23135a","b51484"}           },
  {name="Spinda",     level=3,  types={"Normal"},             moves={"Teeter Dance", "Thrash"},       guids={"35a124"}                    },
  {name="Trapich",    level=2,  types={"Ground"},             moves={"Sand Attack", "Bite"},          guids={"4c47d2"},                   evoData={{cost=2, ball=YELLOW, gen=3, guids={"17e4c4"}}} },
  {name="Vibrava",    level=4,  types={"Ground"},             moves={"Crunch", "Dig"},                guids={"df1c5c","17e4c4"},          evoData={{cost=2, ball=RED, gen=3, guids={"7bb147","5974bb"}}} },
  {name="Flygon",     level=6,  types={"Ground"},             moves={"Dragon Breath", "Sand Tomb"},   guids={"7574b6","7bb147","5974bb"}  },
  {name="Cacnea",     level=2,  types={"Grass"},              moves={"Pin Missile", "Absorb"},        guids={"62770e"},                   evoData={{cost=2, ball=YELLOW, gen=3, guids={"16b950"}}} },
  {name="Cactune",    level=4,  types={"Grass"},              moves={"Needle Arm", "Spikes"},         guids={"f8b287","16b950"}           },
  {name="Swablu",     level=2,  types={"Flying"},             moves={"Sing", "Peck"},                 guids={"6b6c4b"},                   evoData={{cost=3, ball=RED, gen=3, guids={"d2b5c5"}}} },
  {name="Altaria",    level=5,  types={"Dragon"},             moves={"Dragon Breath", "Sky Attack"},  guids={"10ef80","d2b5c5"}           },
  {name="Zangoose",   level=3,  types={"Normal"},             moves={"Crush Claw", "False Swipe"},    guids={"5b9f59"}                    },
  {name="Seviper",    level=3,  types={"Poison"},             moves={"Poison Tail", "Glare"},         guids={"b7456d"}                    },
  {name="Lunatone",   level=4,  types={"Rock"},               moves={"Psychic", "Rock Throw"},        guids={"79e4f0"}                    },
  {name="Solrock",    level=4,  types={"Rock"},               moves={"Rock Slide", "Solar Beam"},     guids={"563547"}                    },
  {name="Barboach",   level=3,  types={"Water"},              moves={"Mud-Slap", "Water Gun"},        guids={"3bd71b"},                   evoData={{cost=1, ball=YELLOW, gen=3, guids={"acc732"}}} },
  {name="Whiscash",   level=4,  types={"Water"},              moves={"Future Sight", "Earthquake"},   guids={"f40ebb","acc732"}           },
  {name="Corpish",    level=2,  types={"Water"},              moves={"Bubble", "Leer"},               guids={"b159a5"},                   evoData={{cost=2, ball=BLUE, gen=3, guids={"193126"}}} },
  {name="Crawdaunt",  level=4,  types={"Water"},              moves={"Crabhammer", "Knock Off"},      guids={"cb83d3","193126"}           },
  {name="Baltoy",     level=2,  types={"Ground"},             moves={"Ancient Power", "Rapid Spin"},  guids={"9d4ab4"},                   evoData={{cost=2, ball=YELLOW, gen=3, guids={"cadeb5"}}} },
  {name="Claydol",    level=4,  types={"Ground"},             moves={"Hyper Beam", "Psybeam"},        guids={"406223","cadeb5"}           },
  {name="Lileep",     level=2,  types={"Rock"},               moves={"Confuse Ray", "Acid"},          guids={"c92a11"},                   evoData={{cost=3, ball=RED, gen=3, guids={"87d1f8"}}} },
  {name="Cradily",    level=5,  types={"Rock"},               moves={"Ancient Power", "Amnesia"},     guids={"6d9326","87d1f8"}           },
  {name="Anorith",    level=2,  types={"Rock"},               moves={"Rock Blast", "Water Gun"},      guids={"8ac1a7"},                   evoData={{cost=3, ball=RED, gen=3, guids={"388697"}}} },
  {name="Armaldo",    level=5,  types={"Rock"},               moves={"Ancient Power", "Fury Cutter"}, guids={"7438a0","388697"}           },
  {name="Feebas",     level=3,  types={"Water"},              moves={"Confuse Ray", "Tackle"},        guids={"4e5c37"},                   evoData={{cost=2, ball=RED, gen=3, guids={"51191e"}}} },
  {name="Milotic",    level=5,  types={"Water"},              moves={"Dragon Breath", "Hydro Pump"},  guids={"8933c3","51191e"}           },
  -- Gen 3 351-375
  {name="Castform",   level=3,  types={"Normal"},             moves={"Body Slam", "Future Sight"},    guids={"95eabc"}                    },
  {name="Castform",   level=3,  types={"Water"},              moves={"Flamethrower", "Weather Ball Water"},guids={"4d93ae"}               },
  {name="Castform",   level=3,  types={"Ice"},                moves={"Water Pulse", "Weather Ball Ice"},guids={"0a700e"}                  },
  {name="Castform",   level=3,  types={"Fire"},               moves={"Ice Beam", "Weather Ball Fire"},guids={"1c9e4b"}                    },
  {name="Kecleon",    level=3,  types={"Normal"},             moves={"Psybeam", "Slash"},             guids={"964da3"}                    },
  {name="Shuppet",    level=3,  types={"Ghost"},              moves={"Will-O-Wisp", "Feint Attack"},  guids={"7db1af"},                   evoData={{cost=2, ball=YELLOW, gen=3, guids={"8da560"}}} },
  {name="Banette",    level=5,  types={"Ghost"},              moves={"Shadow Ball", "Night Shade"},   guids={"8845d6","8da560"}           },
  {name="Duskull",    level=3,  types={"Ghost"},              moves={"Confuse Ray", "Astonish"},      guids={"d12d2a"},                   evoData={{cost=2, ball=YELLOW, gen=3, guids={"6ad885"}}} },
  {name="Dusclops",   level=5,  types={"Ghost"},              moves={"Shadow Punch", "Future Sight"}, guids={"f0f2a2","6ad885"},          evoData={{cost=1, ball=RED, gen=4, guids={"59c3d9","0a1b22"}}} },
  {name="Tropius",    level=4,  types={"Grass"},              moves={"Magical Leaf", "Body Slam"},    guids={"bc8bd9"}                    },
  {name="Chimecho",   level=4,  types={"Psychic"},            moves={"Psychic", "Heal Bell"},         guids={"a3b83f","a78de8"}           },
  {name="Absol",      level=4,  types={"Dark"},               moves={"Bite", "Slash"},                guids={"ae6097"}                    },
  {name="Wynaut",     level=1,  types={"Psychic"},            moves={"Mirror Coat"},                  guids={"00fb6f"},                   evoData={{cost=1, ball=GREEN, gen=2, guids={"0bbbae"}}} },
  {name="Snorunt",    level=3,  types={"Ice"},                moves={"Powder Snow", "Bite"},          guids={"ea6e1a"},                   evoData={{cost=2, ball=YELLOW, gen=2, guids={"c7849b"}},{cost=2, ball=YELLOW, gen=4, guids={"f5d09d"}}} },
  {name="Glalie",     level=5,  types={"Ice"},                moves={"Headbutt", "Ice Beam"},         guids={"dda975","c7849b"}           },
  {name="Spheal",     level=3,  types={"Ice"},                moves={"Powder Snow", "Growl"},         guids={"2bdc76"},                   evoData={{cost=1, ball=YELLOW, gen=2, guids={"c38813"}}} },
  {name="Sealleo",    level=4,  types={"Ice"},                moves={"Aurora Beam", "Water Gun"},     guids={"3bb7d0","c38813"},          evoData={{cost=2, ball=RED, gen=2, guids={"3e2333","cd24a1"}}} },
  {name="Walrein",    level=6,  types={"Ice"},                moves={"Body Slam", "Blizzard"},        guids={"426535","3e2333","cd24a1"}  },
  {name="Clamperl",   level=3,  types={"Water"},              moves={"Iron Defense", "Clamp"},        guids={"e5e8a2"},                   evoData={{cost=2, ball=YELLOW, gen=2, guids={"abf53c"}},{cost=2, ball=YELLOW, gen=2, guids={"f9ff3b"}}} },
  {name="Huntail",    level=5,  types={"Water"},              moves={"Water Pulse", "Crunch"},        guids={"c1decf","abf53c"}           },
  {name="Gorebyss",   level=5,  types={"Water"},              moves={"Water Pulse", "Psychic"},       guids={"3f3ac3","f9ff3b"}           },
  {name="Relicanth",  level=4,  types={"Water"},              moves={"Hydro Pump", "Rock Tomb"},      guids={"4f27e5"}                    },
  {name="Luvdisc",    level=3,  types={"Water"},              moves={"Take Down", "Sweet Kiss"},      guids={"ccfa1c"}                    },
  {name="Bagon",      level=3,  types={"Dragon"},             moves={"Bite", "Rage"},                 guids={"b2c277"},                   evoData={{cost=2, ball=YELLOW, gen=2, guids={"69d8be"}}} },
  {name="Shelgon",    level=5,  types={"Dragon"},             moves={"Headbutt", "Crunch"},           guids={"bc895a","69d8be"},          evoData={{cost=2, ball=RED, gen=2, guids={"5bca28","c6ee70"}}} },
  {name="Salamence",  level=7,  types={"Dragon"},             moves={"Dragon Claw", "Fly"},           guids={"17dd50","5bca28","c6ee70"}  },
  {name="Beldum",     level=2,  types={"Steel"},              moves={"Take Down"},                    guids={"ddca67"},                   evoData={{cost=2, ball=BLUE, gen=2, guids={"3292b4"}}} },
  {name="Metang",     level=4,  types={"Steel"},              moves={"Metal Claw", "Confusion"},      guids={"61c017","3292b4"},          evoData={{cost=3, ball=RED, gen=2, guids={"566a44","a7b544"}}} },
  -- Gen 3 376-386
  {name="Metagross",  level=7,  types={"Steel"},              moves={"Meteor Mash", "Psychic"},       guids={"b13068","566a44","a7b544"}  },
  {name="Regirock",   level=7,  types={"Rock"},               moves={"Ancient Power", "Superpower"},  guids={"f0f700"}                    },
  {name="Regice",     level=7,  types={"Ice"},                moves={"Hyper Beam", "Icy Wind"},       guids={"3cc4aa"}                    },
  {name="Registeel",  level=7,  types={"Steel"},              moves={"Zap Cannon", "Metal Claw"},     guids={"c73d22"}                    },
  {name="Latias",     level=7,  types={"Dragon"},             moves={"Dragon Breath", "Mist Ball"},   guids={"605532"}                    },
  {name="Latios",     level=7,  types={"Dragon"},             moves={"Dragon Breath", "Luster Purge"},guids={"2ef165"}                    },
  {name="Kyrogre",    level=7,  types={"Water"},              moves={"Ice Beam", "Water Spout"},      guids={"2fd702"}                    },
  {name="Groudon",    level=7,  types={"Ground"},             moves={"Fire Blast", "Earthquake"},     guids={"ef5ee2"}                    },
  {name="Rayquaza",   level=7,  types={"Dragon"},             moves={"Dragon Claw", "Fly"},           guids={"3ae691"}                    },
  {name="Jirachi",    level=7,  types={"Steel"},              moves={"Doom Desire", "Psychic"},       guids={"48d5bf"}                    },
  {name="Droxys",     level=7,  types={"Psychic"},            moves={"Psycho Boost", "Knock Off"},    guids={"f4e2fe"}                    }
}

gen4PokemonData =
{
  -- Gen 4 387-400
  {name="Turtwig",    level=1,  types={"Grass"},              moves={"Withdraw","Tackle"},            guids={"cacd94"},                   evoData={{cost=2, ball=BLUE, gen=4, guids={"ff1b43"}}} },
  {name="Grotle",     level=3,  types={"Grass"},              moves={"Razor Leaf","Bite"},            guids={"20d958","ff1b43"},          evoData={{cost=2, ball=RED, gen=4, guids={"cfebcb","3f2eaa"}}} },
  {name="Torterra",   level=5,  types={"Grass"},              moves={"Leaf Storm","Earthquake"},      guids={"902030","cfebcb","3f2eaa"}  },
  {name="Chimchar",   level=1,  types={"Fire"},               moves={"Fury Swipes","Ember"},          guids={"cd904d"},                   evoData={{cost=2, ball=BLUE, gen=4, guids={"8cd8f7"}}} },
  {name="Monferno",   level=3,  types={"Fire"},               moves={"Flame Wheel","Mach Punch"},     guids={"2ba1c0","8cd8f7"},          evoData={{cost=2, ball=RED, gen=4, guids={"aa0bb2","38ad9f"}}} },
  {name="Infernape",  level=5,  types={"Fire"},               moves={"Close Combat","Flare Blitz"},   guids={"6c7166","aa0bb2","38ad9f"}  },
  {name="Piplup",     level=1,  types={"Water"},              moves={"Growl","Peck"},                 guids={"ad1a53"},                   evoData={{cost=2, ball=BLUE, gen=4, guids={"707fe1"}}} },
  {name="PrinPlup",   level=3,  types={"Water"},              moves={"Bubble Beam","Metal Claw"},     guids={"7a3199","707fe1"},          evoData={{cost=2, ball=RED, gen=4, guids={"0e9d7b","fe588c"}}} },
  {name="Empoleon",   level=5,  types={"Water"},              moves={"Hydro Pump","Drill Peck"},      guids={"3cdce6","0e9d7b","fe588c"}  },
  {name="Starly",     level=1,  types={"Flying"},             moves={"Quick Attack","Growl"},         guids={"d5a011"},                   evoData={{cost=2, ball=BLUE, gen=4, guids={"4bb90a"}}} },
  {name="Staravia",   level=3,  types={"Flying"},             moves={"Wing Attack","Whirlwind"},      guids={"54063f","4bb90a"},          evoData={{cost=2, ball=RED, gen=4, guids={"799437","7ab20e"}}} },
  {name="Staraptor",  level=5,  types={"Flying"},             moves={"Close Combat","Brave Bird"},    guids={"efc2ec","799437","7ab20e"}  },
  {name="Bidoof",     level=1,  types={"Normal"},             moves={"Defense Curl","Rollout"},       guids={"8d27fd"},                   evoData={{cost=2, ball=GREEN, gen=4, guids={"29158c"}}} },
  {name="Bibarel",    level=3,  types={"Normal"},             moves={"Hyper Fang","Water Gun"},       guids={"56a0e9","29158c"}           },
  -- Gen 4 401-425
  {name="Kricketot",  level=1,  types={"Bug"},                moves={"Growl"},                        guids={"f48a32"},                   evoData={{cost=2, ball=GREEN, gen=4, guids={"9adb49"}}} },
  {name="Kricketune", level=3,  types={"Bug"},                moves={"Night Slash","Bug Buzz"},       guids={"8351a3","9adb49"}           },
  {name="Shinx",      level=1,  types={"Electric"},           moves={"Tackle","Roar"},                guids={"1215b7"},                   evoData={{cost=2, ball=BLUE, gen=4, guids={"fee2be"}}} },
  {name="Luxio",      level=3,  types={"Electric"},           moves={"Discharge","Bite"},             guids={"bfac8d","fee2be"},          evoData={{cost=1, ball=YELLOW, gen=4, guids={"d7fc60","782359"}}} },
  {name="Luxray",     level=4,  types={"Electric"},           moves={"Thunder Fang","Crunch"},        guids={"dbd6ac","d7fc60","782359"}  },
  {name="Budew",      level=1,  types={"Grass"},              moves={"Stun Spore","Absorb"},          guids={"235bf8"},                   evoData={{cost=2, ball=BLUE, gen=3, guids={"7e165f"}}} },
  {name="Roserade",   level=5,  types={"Grass"},              moves={"Sludge Bomb","Leaf Storm"},     guids={"dbf33b","4aa1de","46f8dc"}  },
  {name="Cranidos",   level=2,  types={"Rock"},               moves={"Assurance","Headbutt"},         guids={"e230a3"},                   evoData={{cost=2, ball=BLUE, gen=4, guids={"9bc735"}}} },
  {name="Rampardos",  level=4,  types={"Rock"},               moves={"Zen Headbutt","Head Smash"},    guids={"fa103e","9bc735"}           },
  {name="Shildon",    level=2,  types={"Rock"},               moves={"Metal Sound","Taunt"},          guids={"f7d63e"},                   evoData={{cost=2, ball=BLUE, gen=4, guids={"c13d61"}}} },
  {name="Bastiodon",  level=4,  types={"Rock"},               moves={"Ancient Power","Iron Head"},    guids={"904ec7","c13d61"}           },
  {name="Burmy",      level=1,  types={"Bug"},                moves={"Hidden Power"},                 guids={"5d3c35"},                   evoData={{cost=2, ball=GREEN, gen=4, guids={"679480","0cf537","bdc120"}},{cost=2, ball=GREEN, gen=4, guids={"50757b"}}} }, -- Sandy
  {name="Burmy",      level=1,  types={"Bug"},                moves={"Hidden Power"},                 guids={"398f3a"},                   evoData={{cost=2, ball=GREEN, gen=4, guids={"679480","0cf537","bdc120"}},{cost=2, ball=GREEN, gen=4, guids={"b53138"}}} }, -- Plant
  {name="Burmy",      level=1,  types={"Bug"},                moves={"Hidden Power"},                 guids={"ebd97a"},                   evoData={{cost=2, ball=GREEN, gen=4, guids={"679480","0cf537","bdc120"}},{cost=2, ball=GREEN, gen=4, guids={"2ed231"}}} }, -- Trash
  {name="Mothim",     level=3,  types={"Bug"},                moves={"Silver Wind","Air Slash"},      guids={"f97f24","679480","0cf537","bdc120"}},
  {name="Wormadam",   level=3,  types={"Ground"},             moves={"Bug Bite","Psychic"},           guids={"1f8c4d","50757b"}           }, -- Sandy
  {name="Wormadam",   level=3,  types={"Grass"},              moves={"Razor Leaf","Bug Bite"},        guids={"ae14d4","b53138"}           }, -- Plant
  {name="Wormadam",   level=3,  types={"Steel"},              moves={"Mirror Shot","Bug Bite"},       guids={"9bfe68","2ed231"}           }, -- Trash
  {name="Combee",     level=2,  types={"Bug"},                moves={"Gust"},                         guids={"1e577e"},                   evoData={{cost=1, ball=BLUE, gen=4, guids={"caab8e"}}} },
  {name="Vespiquen",  level=3,  types={"Bug"},                moves={"Attack Order","Power Gem"},     guids={"13494d","caab8e"}           },
  {name="Pachirisu",  level=2,  types={"Electric"},           moves={"Spark","Swift"},                guids={"bc8f33"}                    },
  {name="Buizel",     level=2,  types={"Water"},              moves={"Sonic Boom","Aqua Jet"},        guids={"445666"},                   evoData={{cost=1, ball=GREEN, gen=4, guids={"4e2c8a"}}} },
  {name="Floatzel",   level=3,  types={"Water"},              moves={"Razor Wind","Whirlpool"},       guids={"d3a821","4e2c8a"}           },
  {name="Cherubi",    level=2,  types={"Grass"},              moves={"Growth","Tackle"},              guids={"d8ddcb"},                   evoData={{cost=1, ball=GREEN, gen=4, guids={"c2a7bd"}}} },
  {name="Cherrim",    level=3,  types={"Grass"},              moves={"Take Down","Solar Beam"},       guids={"72c4b8","c2a7bd"}           },
  {name="Shellos",    level=2,  types={"Water"},              moves={"Trump Card","Counter"},         guids={"aa6021"},                   evoData={{cost=2, ball=BLUE, gen=4, guids={"9cf8af"}}} },
  {name="Shellos",    level=2,  types={"Water"},              moves={"Mirror Coat","Mud-Slap"},       guids={"45b543"},                   evoData={{cost=2, ball=BLUE, gen=4, guids={"ad747a"}}} },
  {name="Gastrodon",  level=4,  types={"Water"},              moves={"Mud Bomb","Body Slam"},         guids={"8d67bb","9cf8af"}           },
  {name="Gastrodon",  level=4,  types={"Water"},              moves={"Muddy Water","Hidden Power"},   guids={"dc4e3a","ad747a"}           },
  {name="Ambipom",    level=4,  types={"Normal"},             moves={"Double Hit","Nasty Plot"},      guids={"892365","06f1a9"}           },
  {name="Drifloon",   level=2,  types={"Ghost"},              moves={"Astonish","Gust"},              guids={"04345a"},                   evoData={{cost=2, ball=BLUE, gen=4, guids={"f87c2e"}}} },
  -- Gen 4 426-450
  {name="Drifblim",   level=4,  types={"Ghost"},              moves={"Ominous Wind","Explosion"},     guids={"36bed9","f87c2e"}           },
  {name="Buneary",    level=2,  types={"Normal"},             moves={"Quick Attack","Jump Kick"},     guids={"73996a"},                   evoData={{cost=2, ball=BLUE, gen=4, guids={"1d4012"}}} },
  {name="Lopunny",    level=4,  types={"Normal"},             moves={"Dizzy Punch","Bounce"},         guids={"ca0de0","1d4012"}           },
  {name="Mismagius",  level=5,  types={"Ghost"},              moves={"Shadow Sneak","Power Gem"},     guids={"f0ec65","496256"}           },
  {name="Honchkrow",  level=4,  types={"Dark"},               moves={"Wing Attack","Dark Pulse"},     guids={"a76d5e","4f1558"}           },
  {name="Glameow",    level=2,  types={"Normal"},             moves={"Fury Swipes","Charm"},          guids={"c31fe7"},                   evoData={{cost=2, ball=BLUE, gen=4, guids={"468535"}}} },
  {name="Purugly",    level=4,  types={"Normal"},             moves={"Sucker Punch","Slash"},         guids={"739efa","468535"}           },
  {name="Chingling",  level=2,  types={"Psychic"},            moves={"Confusion","Wrap"},             guids={"3c321b"},                   evoData={{cost=2, ball=YELLOW, gen=3, guids={"a78de8"}}} },
  {name="Stunky",     level=2,  types={"Poison"},             moves={"Poison Gas","Scratch"},         guids={"350900"},                   evoData={{cost=2, ball=BLUE, gen=4, guids={"ce1be6"}}} },
  {name="Skuntank",   level=4,  types={"Poison"},             moves={"Flamethrower","Night Slash"},   guids={"b80e55","ce1be6"}           },
  {name="Bronzor",    level=2,  types={"Steel"},              moves={"Confuse Ray","Confusion"},      guids={"76ab01"},                   evoData={{cost=2, ball=BLUE, gen=4, guids={"793185"}}} },
  {name="Bronzong",   level=4,  types={"Steel"},              moves={"Extrasensory","Iron Head"},     guids={"c70883","793185"}           },
  {name="Bonsly",     level=1,  types={"Rock"},               moves={"Fake Tears"},                   guids={"992ede"},                   evoData={{cost=2, ball=GREEN, gen=2, guids={"eeca81"}}} },
  {name="Mime Jr.",   level=1,  types={"Psychic"},            moves={"Double Slap"},                  guids={"6a4ef5"},                   evoData={{cost=2, ball=GREEN, gen=1, guids={"8315de"}}} },
  {name="Happiny",    level=1,  types={"Normal"},             moves={"Pound"},                        guids={"f6fbf5"},                   evoData={{cost=3, ball=YELLOW, gen=1, guids={"ee10ff"}}} },
  {name="Chatot",     level=3,  types={"Flying"},             moves={"Hyper Voice","Chatter"},        guids={"85be31"}                    },
  {name="Spiritomb",  level=3,  types={"Ghost"},              moves={"Shadow Sneak","Dark Pulse"},    guids={"3ade63"}                    },
  {name="Gible",      level=2,  types={"Dragon"},             moves={"Sand Attack","Tackle"},         guids={"190d89"},                   evoData={{cost=2, ball=BLUE, gen=4, guids={"9b47dd"}}} },
  {name="Gabite",     level=4,  types={"Dragon"},             moves={"Dragon Rage","Take Down"},      guids={"75db3d","9b47dd"},          evoData={{cost=3, ball=RED, gen=4, guids={"998146","935739"}}} },
  {name="Garchomp",   level=7,  types={"Dragon"},             moves={"Dragon Rush","Slash"},          guids={"16aa2c","998146","935739"}  },
  {name="Munchlax",   level=2,  types={"Normal"},             moves={"Tackle","Lick"},                guids={"ca2ab3"},                   evoData={{cost=2, ball=BLUE, gen=1, guids={"a017f9"}}} },
  {name="Riolu",      level=2,  types={"Fighting"},           moves={"Quick Attack","Counter"},       guids={"7bef81"},                   evoData={{cost=2, ball=YELLOW, gen=4, guids={"153e4f"}}} },
  {name="Lucario",    level=4,  types={"Fighting"},           moves={"Dragon Pulse","Force Palm"},    guids={"cd3901","153e4f"}           },
  {name="Hippopotas", level=2,  types={"Ground"},             moves={"Sand Attack","Take Down"},      guids={"48588f"},                   evoData={{cost=2, ball=YELLOW, gen=4, guids={"5f7329"}}} },
  {name="Hippowdon",  level=4,  types={"Ground"},             moves={"Earthquake","Crunch"},          guids={"073c65","5f7329"}           },
  -- Gen 4 451-475
  {name="Skorupi",    level=2,  types={"Poison"},             moves={"Poison Fang","Pin Missile"},    guids={"12a4d7"},                   evoData={{cost=2, ball=YELLOW, gen=4, guids={"2cdfe7"}}} },
  {name="Drapion",    level=4,  types={"Poison"},             moves={"Cross Poison","Crunch"},        guids={"7faa88","2cdfe7"}           },
  {name="Croagunk",   level=2,  types={"Poison"},             moves={"Mud-Slap","Pursuit"},           guids={"8a87c5"},                   evoData={{cost=2, ball=YELLOW, gen=4, guids={"edeba6"}}} },
  {name="Toxicroak",  level=4,  types={"Poison"},             moves={"Poison Jab","Revenge"},         guids={"2f6517","edeba6"}           },
  {name="Carnivine",  level=3,  types={"Grass"},              moves={"Power Whip","Feint Attack"},    guids={"6ae25c"}                    },
  {name="Finneon",    level=2,  types={"Water"},              moves={"Water Gun","Attract"},          guids={"4e7881"},                   evoData={{cost=2, ball=YELLOW, gen=4, guids={"eff442"}}} },
  {name="Lumineon",   level=4,  types={"Water"},              moves={"Water Pulse","U-Turn"},         guids={"5e8443","eff442"}           },
  {name="Mantyke",    level=1,  types={"Water"},              moves={"Supersonic","Bubble"},          guids={"ea3133"},                   evoData={{cost=2, ball=BLUE, gen=2, guids={"6fd093"}}} },
  {name="Snover",     level=4,  types={"Ice"},                moves={"Powder Snow","Razor Leaf"},     guids={"770f5b"},                   evoData={{cost=2, ball=RED, gen=4, guids={"985066"}}} },
  {name="Abomasnow",  level=6,  types={"Ice"},                moves={"Wood Hammer","Ice Punch"},      guids={"fc423f","985066"}           },
  {name="Weavile",    level=4,  types={"Dark"},               moves={"Dark Pulse","Icy Wind"},        guids={"57a02c","9b517e"}           },
  {name="Magnezone",  level=6,  types={"Electric"},           moves={"Zap Cannon","Mirror Shot"},     guids={"c53a51","dedadf","618210"}  },
  {name="Lickilicky", level=5,  types={"Normal"},             moves={"Power Whip","Me First"},        guids={"dc8977","5d1069"}           },
  {name="Rhyperior",  level=7,  types={"Rock"},               moves={"Rock Wrecker","Megahorn"},      guids={"ee964b","1665fe","f2b985"}  },
  {name="Tangrowth",  level=4,  types={"Grass"},              moves={"Ancient Power","Power Whip"},   guids={"c5ddd7","5965cd"}           },
  {name="Electivire", level=6,  types={"Electric"},           moves={"Giga Impact","Thunder"},        guids={"6787dc","11f593","896d6e"}  },
  {name="Magmortar",  level=6,  types={"Fire"},               moves={"Lava Plume","Hyper Beam"},      guids={"f7000a","bc96fe","ebafae"}  },
  {name="Togekiss",   level=4,  types={"Fairy"},              moves={"Aura Sphere","Air Slash"},      guids={"d9bab2","020ecc","3786d0"}  },
  {name="Yanmega",    level=4,  types={"Bug"},                moves={"Night Slash","Air Slash"},      guids={"040022","e093cb"}           },
  {name="Leafeon",    level=5,  types={"Grass"},              moves={"Fury Cutter","Leaf Blade"},     guids={"e6b356","25ef7b"}           },
  {name="Glaceon",    level=5,  types={"Ice"},                moves={"Aqua Tail","Ice Fang"},         guids={"d990cc","549166"}           },
  {name="Gliscor",    level=5,  types={"Ground"},             moves={"Poison Jab","X-Scissor"},       guids={"9344ba","96a4fa"}           },
  {name="Mamoswine",  level=6,  types={"Ice"},                moves={"Earthquake","Blizzard"},        guids={"ae18c1","bac5e2","3e9a5e"}  },
  {name="Porygon-Z",  level=5,  types={"Normal"},             moves={"Zap Cannon","Hyper Beam"},      guids={"8b5275","89624f","ccdbee"}  },
  {name="Gallade",    level=5,  types={"Psychic"},            moves={"Close Combat","Psycho Cut"},    guids={"e00be3","491632","2956c7"}  },
  -- Gen 4 476-493
  {name="Probopass",  level=5,  types={"Rock"},               moves={"Magnet Bomb","Stone Edge"},     guids={"c36f28","261bac"}           },
  {name="Dusknoir",   level=6,  types={"Ghost"},              moves={"Shadow Punch","Seismic Toss"},  guids={"40e69b","59c3d9","0a1b22"}  },
  {name="Frosslass",  level=5,  types={"Ice"},                moves={"Ominous Wind","Ice Fang"},      guids={"44d36b","f5d09d"}           },
  {name="Rotom",      level=3,  types={"Electric"},           moves={"Ominous Wind","Thunder Shock"}, guids={"631643"}                    },
  {name="Rotom",      level=3,  types={"Electric"},           moves={"Ominous Wind","Leaf Storm"},    guids={"9c2b53"}                    },
  {name="Rotom",      level=3,  types={"Electric"},           moves={"Ominous Wind","Overheat"},      guids={"119ba7"}                    },
  {name="Rotom",      level=3,  types={"Electric"},           moves={"Ominous Wind","Hydro Pump"},    guids={"e60f49"}                    },
  {name="Rotom",      level=3,  types={"Electric"},           moves={"Ominous Wind","Air Slash"},     guids={"2fc387"}                    },
  {name="Rotom",      level=3,  types={"Electric"},           moves={"Ominous Wind","Blizzard"},      guids={"313204"}                    },
  {name="Uxie",       level=7,  types={"Psychic"},            moves={"Thunder Punch","Psychic"},      guids={"7161bc"}                    },
  {name="Mesprit",    level=7,  types={"Psychic"},            moves={"Extrasensory","Fire Punch"},    guids={"206d05"}                    },
  {name="Azelf",      level=7,  types={"Psychic"},            moves={"Zen Headbutt","Ice Punch"},     guids={"51e346"}                    },
  {name="Dialga",     level=7,  types={"Steel"},              moves={"Flash Cannon","Roar of Time"},  guids={"99da0e"}                    },
  {name="Palkia",     level=7,  types={"Water"},              moves={"Spacial Rend","Aqua Tail"},     guids={"99bbae"}                    },
  {name="Heatran",    level=7,  types={"Fire"},               moves={"Magma Storm","Earth Power"},    guids={"d6bd2b"}                    },
  {name="Regigigas",  level=7,  types={"Normal"},             moves={"Dizzy Punch","Revenge"},        guids={"04ae8e"}                    },
  {name="Giratina",   level=7,  types={"Ghost"},              moves={"Shadow Force","Dragon Claw"},   guids={"e1ea2d"}                    },
  {name="Cresselia",  level=7,  types={"Psychic"},            moves={"Aurora Beam","Psycho Cut"},     guids={"d22af4"}                    },
  {name="Phione",     level=5,  types={"Water"},              moves={"Acid Armor","Dive"},            guids={"3379b4"}                    },
  {name="Manaphy",    level=7,  types={"Water"},              moves={"Water Pulse","Tail Glow"},      guids={"4eb57f"}                    },
  {name="Darkrai",    level=7,  types={"Dark"},               moves={"Dream Eater","Dark Pulse"},     guids={"dd87aa"}                    },
  {name="Shaymin",    level=7,  types={"Grass"},              moves={"Seed Flare","Air Slash"},       guids={"215c3b"}                    },
  {name="Arceus",     level=7,  types={"Normal"},             moves={"Earth Power","Judgement"},      guids={"fbb914"}                    },
}

genData = {gen1PokemonData, gen2PokemonData, gen3PokemonData, gen4PokemonData}

moveData =
{
  
    -- Bug
    {name="Attack Order",   power=2,      type="Bug",       dice=8, STAB=true   },
    {name="Bug Bite",       power=2,      type="Bug",       dice=6, STAB=true   },
    {name="Bug Buzz",       power=2,      type="Bug",       dice=6, STAB=true,  effects={{name="AttackUp", target="Self", chance=6}} },
    {name="Defend Order",   power=0,      type="Bug",       dice=6, STAB=false, effects={{name="AttackDown2", target="Enemy"}} },
    {name="Fell Stinger",   power=1,      type="Bug",       dice=6, STAB=true,  effects={{name="???"}} },
    {name="First Impression",power=2,     type="Bug",       dice=6, STAB=true,  effects={{name="Priority", target="Self"}} },
    {name="Fury Cutter",    power=1,      type="Bug",       dice=6, STAB=true,  effects={{name="Custom"}} },
    {name="Heal Order"},
    {name="Infestation"},
    {name="Leech Life",     power=2,      type="Bug",       dice=6, STAB=true   },
    {name="Lunge"},
    {name="Megahorn",       power=3,      type="Bug",       dice=6, STAB=true   },
    {name="Pin Missile",    power=1,      type="Bug",       dice=4, STAB=true,  effects={{name="ExtraDice", target="Self", chance=4}} },
    {name="Pounce"},
    {name="Powder"},
    {name="Quiver Dance",   power=0,      type="Bug",       dice=6, STAB=false, effects={{name="Custom"}} },
    {name="Rage Powder"},
    {name="Signal Beam",    power=2,      type="Bug",       dice=6, STAB=true,  effects={{name="Confuse", target="Enemy", chance=6}} },
    {name="Silk Trap"},
    {name="Silver Wind",    power=2,      type="Bug",       dice=6, STAB=true,  effects={{name="AttackUp", target="Self", chance=6},{name="AttackDown", target="Enemy", chance=6}} },
    {name="Skitter Smack"},
    {name="Spider Web"},
    {name="Steamroller",    power=2,      type="Bug",       dice=6, STAB=true,  effects={{name="AttackDown", target="Enemy", chance=5}} },
    {name="Sticky Web"},
    {name="String Shot",    power=0,      type="Bug",       dice=6, STAB=false  },
    {name="Struggle Bug"},
    {name="Tail Glow",      power=0,      type="Bug",       dice=4, STAB=false, effects={{name="AttackUp2", target="Self"}} },
    {name="Twineedle",      power=1,      type="Bug",       dice=4, STAB=true,  effects={{name="Poison", target="Enemy", chance=5},{name="ExtraDice", target="Self"}} },
    {name="U-Turn",         power=2,      type="Bug",       dice=6, STAB=true,  effects={{name="Switch", target="Self"}} },
    {name="X-Scissor",      power=2,      type="Bug",       dice=6, STAB=true   },

    -- Dark
    {name="Assurance",      power=2,      type="Dark",      dice=6, STAB=true,  effects={{name="AttackUp", target="Self", condition="Power"}} },
    {name="Bite",           power=2,      type="Dark",      dice=6, STAB=true,  effects={{name="AttackDown", target="Enemy", chance=5}} },
    {name="Crunch",         power=2,      type="Dark",      dice=6, STAB=true,  effects={{name="AttackUp", target="Self", chance=6}} },
    {name="Dark Pulse",     power=2,      type="Dark",      dice=6, STAB=true,  effects={{name="AttackDown", target="Enemy", chance=5}} },
    {name="Embargo",        power=0,      type="Dark",      dice=6, STAB=false, effects={{name="Custom"}} },
    {name="Fake Tears",     power=0,      type="Dark",      dice=6, STAB=false, effects={{name="AttackUp2", target="Self"}} },
    {name="Feint Attack",   power=2,      type="Dark",      dice=6, STAB=true,  effects={{name="AttackUp", target="Self"}} },
    {name="Foul Play",      power="Enemy",type="Dark",      dice=6, STAB=false  },
    {name="Knock Off",      power=3,      type="Dark",      dice=6, STAB=true,  effects={{name="Custom"}} },
    {name="Nasty Plot",     power=0,      type="Dark",      dice=6, STAB=false, effects={{name="AttackUp2", target="Self"}} },
    {name="Night Slash",    power=2,      type="Dark",      dice=8, STAB=true   }, 
    {name="Payback",        power=2,      type="Dark",      dice=6, STAB=true,  effects={{name="Custom"}} },
    {name="Pursuit",        power=1,      type="Dark",      dice=6, STAB=true,  effects={{name="Custom"}} }, 
    {name="Punishment",     power=3,      type="Dark",      dice=6, STAB=true,  effects={{name="Custom"}} }, 
    {name="Sucker Punch",   power=2,      type="Dark",      dice=6, STAB=true,  effects={{name="Priority", target="Self"}}},
    {name="Taunt",          power=0,      type="Dark",      dice=6, STAB=false, effects={{name="Custom"}} },
    {name="Torment",        power=0,      type="Dark",      dice=6, STAB=false, effects={{name="Custom"}} },

    -- Dragon
    {name="Dragon Claw",    power=3,      type="Dragon",    dice=6, STAB=true   },
    {name="Dragon Breath",  power=2,      type="Dragon",    dice=6, STAB=true,  effects={{name="Paralyse", target="Enemy", chance=5}} },
    {name="Dragon Pulse",   power=2,      type="Dragon",    dice=6, STAB=true   },
    {name="Dragon Rage",    power=4,      type="Dragon",    dice=4, STAB=true,  effects={{name="Neutral", target="Self"}} },
    {name="Dragon Rush",    power=2,      type="Dragon",    dice=4, STAB=true,  effects={{name="AttackDown", target="Enemy", chance=5}} },
    {name="Dual Chop",      power=1,      type="Dragon",    dice=4, STAB=true,  effects={{name="ExtraDice", target="Self"}} },
    {name="Outrage",        power=4,      type="Dragon",    dice=6, STAB=true,  effects={{name="Confuse", target="Self", chance=5}} },
    {name="Roar of Time",   power=4,      type="Dragon",    dice=6, STAB=true,  effects={{name="Recharge", target="Self"}} },
    {name="Spacial Rend",   power=3,      type="Dragon",    dice=8, STAB=true   },
    {name="Twister",        power=1,      type="Dragon",    dice=6, STAB=true,  effects={{name="AttackDown", target="Enemy", chance=5}} },

    -- Electric
    {name="Bolt Strike",    power=5,      type="Electric",  dice=6, STAB=true,  effects={{name="Paralyse", target="Enemy", chance=6}} },
    {name="Discharge",      power=3,      type="Electric",  dice=6, STAB=true,  effects={{name="Paralyse", target="Enemy", chance=5}} },
    {name="Electroweb",     power=2,      type="Electric",  dice=6, STAB=true},
    {name="Electro Ball",   power="Self", type="Electric",  dice=6, STAB=false},
    {name="Shock Wave",     power=2,      type="Electric",  dice=6, STAB=true,  effects={{name="AttackUp", target="Self"}} },
    {name="Spark",          power=2,      type="Electric",  dice=6, STAB=true,  effects={{name="Paralyse", target="Enemy", chance=5}} },
    {name="Thunderbolt",    power=2,      type="Electric",  dice=6, STAB=true,  effects={{name="Paralyse", target="Enemy", chance=6}} },
    {name="Thunder",        power=3,      type="Electric",  dice=6, STAB=true,  effects={{name="Paralyse", target="Enemy", chance=5}} },
    {name="Thunder Fang",   power=2,      type="Electric",  dice=6, STAB=true,  effects={{name="Paralyse", target="Enemy", chance=6},{name="AttackDown", target="Enemy", chance=6}} },
    {name="Thunder Shock",  power=1,      type="Electric",  dice=6, STAB=true,  effects={{name="Paralyse", target="Enemy", chance=6}} },
    {name="Thunder Punch",  power=2,      type="Electric",  dice=6, STAB=true,  effects={{name="Paralyse", target="Enemy", chance=6}} },
    {name="Thunder Wave",   power=0,      type="Electric",  dice=6, STAB=false, effects={{name="Paralyse", target="Enemy"}} },
    {name="Wild Charge",    power=3,      type="Electric",  dice=6, STAB=false, effects={{name="Paralyse", target="Enemy", chance=5}} },
    {name="Zap Cannon",     power=3,      type="Electric",  dice=6, STAB=false, effects={{name="Paralyse", target="Enemy", chance=4}} },
    
    -- Fairy
    {name="Baby-Doll Eyes", power=0,      type="Fairy",     dice=6, STAB=false, effects={{name="AttackDown", target="Enemy"}} },
    {name="Disarming Voice",power=1,      type="Fairy",     dice=6, STAB=true,  effects={{name="AttackUp", target="Self"}} },
    {name="Charm",          power=0,      type="Fairy",     dice=6, STAB=false, effects={{name="AttackDown2", target="Enemy"}} },
    {name="Fairy Wind",     power=2,      type="Fairy",     dice=6, STAB=true},
    {name="Play Rough",     power=3,      type="Fairy",     dice=6, STAB=true,  effects={{name="AttackDown", target="Enemy", chance=6}} },
    {name="Sweet Kiss",     power=0,      type="Fairy",     dice=6, STAB=false, effects={{name="Confuse", target="Enemy", chance=2}} },
    
    -- Fighting
    {name="Aura Sphere",    power=2,      type="Fighting",  dice=6, STAB=true,  effects={{name="AttackUp", target="Self"}} },
    {name="Arm Thrust",     power=1,      type="Fighting",  dice=4, STAB=true,  effects={{name="ExtraDice", target="Self", chance=4}} },
    {name="Bulk Up",        power=0,      type="Fighting",  dice=6, STAB=false, effects={{name="AttackDown", target="Enemy"},{name="AttackUp", target="Self"}} },
    {name="Brick Break",    power=3,      type="Fighting",  dice=6, STAB=true,  effects={{name="Custom"}} },
    {name="Counter",        power=0,      type="Fighting",  dice=6, STAB=false, effects={{name="Custom"}} },
    {name="Close Combat",   power=3,      type="Fighting",  dice=6, STAB=true,  effects={{name="AttackDown", target="Self"}} },
    {name="Cross Chop",     power=2,      type="Fighting",  dice=8, STAB=true},
    {name="Detect",         power=0,      type="Fighting",  dice=6, STAB=false, effects={{name="Custom"}} },
    {name="Double Kick",    power=1,      type="Fighting",  dice=4, STAB=true,  effects={{name="ExtraDice", target="Self"}} },
    {name="Drain Punch",    power=3,      type="Fighting",  dice=4, STAB=true},
    {name="Dynamic Punch",  power=2,      type="Fighting",  dice=6, STAB=true,  effects={{name="Confuse", target="Enemy", chance=4}} },
    {name="Focus Punch",    power=3,      type="Fighting",  dice=6, STAB=true},
    {name="Force Palm",     power=3,      type="Fighting",  dice=6, STAB=true,  effects={{name="Paralyse", target="Enemy", chance=5}} },
    {name="High Jump Kick", power=3,      type="Fighting",  dice=6, STAB=true,  effects={{name="KO", target="Self", chance=6}} },
    {name="Jump Kick",      power=2,      type="Fighting",  dice=6, STAB=true,  effects={{name="KO", target="Self", chance=6}} },
    {name="Karate Chop",    power=1,      type="Fighting",  dice=8, STAB=true},
    {name="Low Kick",       power=1,      type="Fighting",  dice=4, STAB=true},
    {name="Mach Punch",     power=3,      type="Fighting",  dice=6, STAB=true,  effects={{name="Priority", target="Self"}} },
    {name="Revenge",        power=2,      type="Fighting",  dice=6, STAB=true,  effects={{name="AttackUp", target="Self", condition="Power"}} },
    {name="Sacred Sword",   power=3,      type="Fighting",  dice=6, STAB=false, effects={{name="Custom"}} },
    {name="Seismic Toss",   power="Self", type="Fighting",  dice=6, STAB=false, effects={{name="Neutral", target="Self"}}},
    {name="Sky Uppercut",   power=3,      type="Fighting",  dice=6, STAB=true},
    {name="Storm Throw",    power=3,      type="Fighting",  dice=8, STAB=true},
    {name="Submission",     power=2,      type="Fighting",  dice=6, STAB=true,  effects={{name="KO", target="Self", chance=6}} },
    {name="Superpower",     power=3,      type="Fighting",  dice=6, STAB=true,  effects={{name="Custom"}} },
    {name="Triple Kick",    power=1,      type="Fighting",  dice=4, STAB=false, effects={{name="ExtraDice", target="Self", chance=2},{name="ExtraDice", target="Self", chance=2}} },
    {name="Vital Throw",    power=2,      type="Fighting",  dice=6, STAB=true},
    {name="Wake-up Slap",   power=3,      type="Fighting",  dice=6, STAB=true,  effects={{name="Custom"}} },

    -- Fire
    {name="Blaze Kick",     power=3,      type="Fire",    dice=8, STAB=true,    effects={{name="Burn", target="Enemy", chance=6}} },
    {name="Blue Flare",     power=4,      type="Fire",    dice=6, STAB=true,    effects={{name="Burn", target="Enemy", chance=5}} },
    {name="Ember",          power=1,      type="Fire",    dice=6, STAB=true,    effects={{name="Burn", target="Enemy", chance=6}} },
    {name="Eruption",       power=4,      type="Fire",    dice=6, STAB=true},
    {name="Fiery Dance",    power=3,      type="Fire",    dice=6, STAB=true,    effects={{name="AttackUp", target="Self", chance=4}} },
    {name="Fire Fang",      power=2,      type="Fire",    dice=6, STAB=true,    effects={{name="Burn", target="Enemy", chance=6},{name="AttackDown", target="Enemy", chance=6}} },
    {name="Fire Blast",     power=3,      type="Fire",    dice=6, STAB=true,    effects={{name="Burn", target="Enemy", chance=6}} },
    {name="Fire Lash",      power=3,      type="Fire",    dice=6, STAB=true,    effects={{name="AttackUp", target="Self"}} },
    {name="Fire Punch",     power=2,      type="Fire",    dice=6, STAB=true,    effects={{name="Burn", target="Enemy", chance=6}} },
    {name="Fire Spin",      power=1,      type="Fire",    dice=6, STAB=true,    effects={{name="ExtraDice", target="Self", chance=4}} },
    {name="Flame Wheel",    power=2,      type="Fire",    dice=6, STAB=true,    effects={{name="Burn", target="Enemy", chance=6}} },
    {name="Flame Burst",    power=3,      type="Fire",    dice=6, STAB=true},
    {name="Flamethrower",   power=2,      type="Fire",    dice=6, STAB=true,    effects={{name="Burn", target="Enemy", chance=6}} },
    {name="Flare Blitz",    power=4,      type="Fire",    dice=6, STAB=true,    effects={{name="KO", target="Self", chance=6},{name="Burn", target="Enemy", chance=6}} },
    {name="Heat Crash",     power=3,      type="Fire",    dice=6, STAB=true,    effects={{name="Custom", chance=4}} },
    {name="Incinerate",     power=2,      type="Fire",    dice=6, STAB=true,    effects={{name="Custom"}} },
    {name="Inferno",        power=3,      type="Fire",    dice=6, STAB=true,    effects={{name="Burn", target="Enemy", chance=4}} },
    {name="Lava Plume",     power=3,      type="Fire",    dice=6, STAB=true,    effects={{name="Burn", target="Enemy", chance=5}} },
    {name="Magma Storm",    power=3,      type="Fire",    dice=6, STAB=true,    effects={{name="ExtraDice", target="Self", chance=4}} },
    {name="Overheat",       power=4,      type="Fire",    dice=6, STAB=true,    effects={{name="Custom"}} },
    {name="Sacred Fire",    power=2,      type="Fire",    dice=6, STAB=true,    effects={{name="Burn", target="Enemy", chance=4}} },
    {name="Searing Shot",   power=3,      type="Fire",    dice=6, STAB=true,    effects={{name="Burn", target="Enemy", chance=5}} },
    {name="Weather Ball Fire",power=3,    type="Fire",    dice=6, STAB=true},
    {name="Will-O-Wisp",    power=0,      type="Fire",    dice=6, STAB=false,   effects={{name="Burn", target="Enemy", chance=2}} },

    -- Flying
    {name="Aerial Ace",     power=3,      type="Flying",  dice=6, STAB=true,    effects={{name="AttackUp", target="Self"}} },
    {name="Air Cutter",     power=2,      type="Flying",  dice=8, STAB=true},
    {name="Air Slash",      power=3,      type="Flying",  dice=8, STAB=true,    effects={{name="AttackDown", target="Enemy", chance=5}} },
    {name="Aeroblast",      power=3,      type="Flying",  dice=8, STAB=true,    effects={{name="AttackUp", target="Self"}} },
    {name="Bounce",         power=2,      type="Flying",  dice=6, STAB=true,    effects={{name="Paralyse", target="Enemy", chance=5}}},
    {name="Brave Bird",     power=4,      type="Flying",  dice=6, STAB=true,    effects={{name="KO", target="Self"}} },
    {name="Chatter",        power=2,      type="Flying",  dice=6, STAB=true,    effects={{name="Confuse", target="Enemy", chance=6}} },
    {name="Drill Peck",     power=3,      type="Flying",  dice=6, STAB=true},
    {name="Gust",           power=1,      type="Flying",  dice=6, STAB=true},
    {name="Fly",            power=3,      type="Flying",  dice=6, STAB=true},
    {name="Feather Dance",  power=0,      type="Flying",  dice=6, STAB=false,   effects={{name="AttackDown2", target="Enemy"}} },
    {name="Hurricane",      power=4,      type="Flying",  dice=6, STAB=true,    effects={{name="Confuse", target="Enemy", chance=5}} },
    {name="Mirror Move",    power=0,      type="Flying",  dice=6, STAB=false,   effects={{name="Custom"}} },
    {name="Peck",           power=1,      type="Flying",  dice=6, STAB=true},
    {name="Sky Attack",     power=1,      type="Flying",  dice=8, STAB=true,    effects={{name="Recharge", target="Self"},{name="AttackDown", target="Enemy", chance=5}} },
    {name="Sunny Day",      power=0,      type="Flying",  dice=8, STAB=true,    effects={{name="Custom"}} },
    {name="Wing Attack",    power=2,      type="Flying",  dice=6, STAB=true},

    -- Ghost
    {name="Astonish",       power=1,      type="Ghost",   dice=6, STAB=true,    effects={{name="AttackDown", target="Enemy", chance=5}} },
    {name="Confuse Ray",    power=0,      type="Ghost",   dice=6, STAB=false,   effects={{name="Confuse", target="Enemy"}} },
    {name="Hex",            power=2,      type="Ghost",   dice=6, STAB=true,    effects={{name="Custom"}} },
    {name="Lick",           power=1,      type="Ghost",   dice=6, STAB=true,    effects={{name="Paralyse", target="Enemy", chance=5}} },
    {name="Night Shade",    power="Self", type="Ghost",   dice=6, STAB=false},
    {name="Ominous Wind",   power=3,      type="Ghost",   dice=6, STAB=true,    effects={{name="AttackUp", target="Self", chance=6},{name="AttackDown", target="Enemy", chance=6}} },
    {name="Shadow Ball",    power=2,      type="Ghost",   dice=6, STAB=true},
    {name="Shadow Force",   power=4,      type="Ghost",   dice=6, STAB=true,    effects={{name="Recharge", target="Self"}} },
    {name="Shadow Punch",   power=3,      type="Ghost",   dice=6, STAB=true,    effects={{name="AttackUp", target="Self", chance=5}} },
    {name="Shadow Sneak",   power=2,      type="Ghost",   dice=6, STAB=true,    effects={{name="Priority", target="Self"}} },

    -- Grass
    {name="Absorb",         power=1,      type="Grass",   dice=6, STAB=true},
    {name="Aromatherapy",   power=0,      type="Grass",   dice=6, STAB=false,   effects={{name="Custom"}} },
    {name="Bullet Seed",    power=1,      type="Grass",   dice=4, STAB=true,    effects={{name="ExtraDice", target="Self", chance=4}} },
    {name="Cotton Spore",   power=0,      type="Grass",   dice=6, STAB=false,   effects={{name="AttackDown2", target="Enemy"}} },
    {name="Giga Drain",     power=3,      type="Grass",   dice=6, STAB=true},
    {name="Horn Leech",     power=4,      type="Grass",   dice=6, STAB=true},
    {name="Leaf Blade",     power=3,      type="Grass",   dice=8, STAB=true},
    {name="Leaf Storm",     power=4,      type="Grass",   dice=4, STAB=true,    effects={{name="AttackDown", target="Self"}} },
    {name="Magical Leaf",   power=3,      type="Grass",   dice=6, STAB=true,    effects={{name="AttackUp", target="Self", chance=5}} },
    {name="Mega Drain",     power=2,      type="Grass",   dice=6, STAB=true},
    {name="Needle Arm",     power=3,      type="Grass",   dice=6, STAB=true,    effects={{name="AttackDown", target="Enemy", chance=5}} },
    {name="Petal Dance",    power=3,      type="Grass",   dice=6, STAB=true,    effects={{name="Confuse", target="Self", chance=5}} },
    {name="Power Whip",     power=3,      type="Grass",   dice=6, STAB=true},
    {name="Razor Leaf",     power=2,      type="Grass",   dice=8, STAB=true},
    {name="Seed Bomb",      power=3,      type="Grass",   dice=6, STAB=true},
    {name="Seed Flare",     power=3,      type="Grass",   dice=6, STAB=true,    effects={{name="AttackUp2", target="Self", chance=4}} },
    {name="Sleep Powder",   power=0,      type="Grass",   dice=6, STAB=false,   effects={{name="Sleep", target="Enemy", chance=3}} },
    {name="Solar Beam",     power=3,      type="Grass",   dice=6, STAB=true,    effects={{name="Recharge", target="Self"}} },
    {name="Spiky Shild",    power=1,      type="Grass",   dice=6, STAB=true,    effects={{name="Custom"}} },
    {name="Spore",          power=0,      type="Grass",   dice=6, STAB=false,   effects={{name="Sleep", target="Enemy"}} },
    {name="Stun Spore",     power=0,      type="Grass",   dice=6, STAB=false,   effects={{name="Paralyse", target="Enemy", chance=3}} },
    {name="Vine Whip",      power=1,      type="Grass",   dice=6, STAB=true},
    {name="Wood Hammer",    power=4,      type="Grass",   dice=6, STAB=true,    effects={{name="KO", target="Self", chance=6}} },
    
    -- Ground
    {name="Bone Club",      power=2,      type="Ground",  dice=6, STAB=true,    effects={{name="AttackDown", target="Enemy", chance=6}} },
    {name="Bone Rush",      power=1,      type="Ground",  dice=4, STAB=true,    effects={{name="ExtraDice", target="Self", chance=4}} },
    {name="Bonemerang",     power=2,      type="Ground",  dice=4, STAB=true,    effects={{name="ExtraDice", target="Self"}} },
    {name="Dig",            power=2,      type="Ground",  dice=6, STAB=true},
    {name="Drill Run",      power=3,      type="Ground",  dice=8, STAB=true},
    {name="Earth Power",    power=3,      type="Ground",  dice=6, STAB=true,    effects={{name="AttackUp", target="Self", chance=6}} },
    {name="Earthquake",     power=2,      type="Ground",  dice=6, STAB=true},
    {name="Fissure",        power=0,      type="Ground",  dice=6, STAB=false,   effects={{name="KO", chance=5, target="Enemy"}} },
    {name="Magnitude",      power=2,      type="Ground",  dice=6, STAB=false,   effects={{name="D4Dice", target="Self", chance=3},{name="ExtraDice", target="Self", chance="6"}}},
    {name="Mud Bomb",       power=3,      type="Ground",  dice=6, STAB=false,   effects={{name="AttackDown", target="Enemy", chance=5}} },
    {name="Mud Shot",       power=2,      type="Ground",  dice=6, STAB=false},
    {name="Mud-Slap",       power=1,      type="Ground",  dice=6, STAB=false,   effects={{name="AttackDown", target="Enemy"}} },
    {name="Sand Attack",    power=0,      type="Ground",  dice=6, STAB=false,   effects={{name="AttackDown", target="Enemy"}} },
    {name="Sand Tomb",      power=1,      type="Ground",  dice=6, STAB=false,   effects={{name="ExtraDice", target="Self", chance=4}} },
    {name="Spikes",         power=0,      type="Ground",  dice=6, STAB=false,   effects={{name="Custom"}} },

    -- Ice
    {name="Aurora Beam",    power=2,      type="Ice",     dice=6, STAB=true,    effects={{name="AttackDown", target="Enemy", chance=6}} },
    {name="Blizzard",       power=3,      type="Ice",     dice=6, STAB=true,    effects={{name="Freeze", target="Enemy", chance=6}} },
    {name="Freeze-Dry",     power=3,      type="Ice",     dice=6, STAB=true,    effects={{name="Custom"}} },
    {name="Hail",           power=0,      type="Ice",     dice=6, STAB=false,   effects={{name="Custom"}} },
    {name="Ice Beam",       power=2,      type="Ice",     dice=6, STAB=true,    effects={{name="Freeze", target="Enemy", chance=6}} },
    {name="Ice Fang",       power=2,      type="Ice",     dice=6, STAB=true,    effects={{name="Freeze", target="Enemy", chance=6},{name="AttackDown", target="Enemy", chance=6}} },
    {name="Ice Punch",      power=3,      type="Ice",     dice=6, STAB=true,    effects={{name="Freeze", target="Enemy", chance=6}} },
    {name="Icicle Crash",   power=3,      type="Ice",     dice=4, STAB=true,    effects={{name="AttackDown", target="Enemy", chance=5}} },
    {name="Icicle Spear",   power=1,      type="Ice",     dice=4, STAB=true,    effects={{name="ExtraDice", target="Self", chance=4}} },
    {name="Icy Wind",       power=2,      type="Ice",     dice=6, STAB=true},
    {name="Mist",           power=0,      type="Ice",     dice=6, STAB=false,   effects={{name="Custom"}} },
    {name="Powder Snow",    power=1,      type="Ice",     dice=6, STAB=true,    effects={{name="Freeze", target="Enemy", chance=6}} },
    {name="Sheer Cold",     power=0,      type="Ice",     dice=6, STAB=true,    effects={{name="KO", target="Enemy", chance=5}} },
    {name="Weather Ball Ice",power=3,     type="Ice",     dice=6, STAB=true},

    -- Normal
    {name="Attract",        power=0,      type="Normal",  dice=6, STAB=false,   effects={{name="AttackDown", target="Enemy"}} },
    {name="Barrage",        power=1,      type="Normal",  dice=4, STAB=true,    effects={{name="ExtraDice", target="Self", chance=4}} },
    {name="Body Slam",      power=2,      type="Normal",  dice=6, STAB=false,   effects={{name="Paralyse", target="Enemy", chance=5}} },
    {name="Bind",           power=1,      type="Normal",  dice=6, STAB=true,    effects={{name="ExtraDice", target="Self", chance=4}} },
    {name="Comet Punch",    power=1,      type="Normal",  dice=4, STAB=true,    effects={{name="ExtraDice", target="Self", chance=4}} },
    {name="Constrict",      power=1,      type="Normal",  dice=6, STAB=false},
    {name="Conversion",     power=0,      type="Normal",  dice=6, STAB=false,   effects={{name="Custom"}} },
    {name="Conversion2",    power=0,      type="Normal",  dice=6, STAB=false,   effects={{name="Custom"}} },
    {name="Covet",          power=3,      type="Normal",  dice=6, STAB=false,   effects={{name="Custom"}} },
    {name="Crush Claw",     power=3,      type="Normal",  dice=6, STAB=false,   effects={{name="AttackUp", target="Self", chance=4}} },
    {name="Defense Curl",   power=0,      type="Normal",  dice=6, STAB=false,   effects={{name="AttackDown", target="Enemy"}} },
    {name="Disable",        power=0,      type="Normal",  dice=6, STAB=false,   effects={{name="Custom"}} },
    {name="Dizzy Punch",    power=2,      type="Normal",  dice=6, STAB=true,    effects={{name="Confuse", target="Enemy", chance=5}} },
    {name="Double-Edge",    power=3,      type="Normal",  dice=6, STAB=true,    effects={{name="KO", target="Self", chance=6}} },
    {name="Double Hit",     power=1,      type="Normal",  dice=4, STAB=true,    effects={{name="ExtraDice", target="Self"}} },
    {name="Double Slap",    power=1,      type="Normal",  dice=4, STAB=true,    effects={{name="ExtraDice", target="Self", chance=4}} },
    {name="Double Team",    power=0,      type="Normal",  dice=6, STAB=false,   effects={{name="AttackDown", target="Enemy"}} },
    {name="Egg Bomb",       power=2,      type="Normal",  dice=6, STAB=true},
    {name="Encore",         power=0,      type="Normal",  dice=6, STAB=false,   effects={{name="Custom"}} },
    {name="Explosion",      power=5,      type="Normal",  dice=6, STAB=true,    effects={{name="KO", target="Self"}} },
    {name="Facade",         power=3,      type="Normal",  dice=6, STAB=true,    effects={{name="Custom"}} },
    {name="Fake Out",       power=1,      type="Normal",  dice=6, STAB=true,    effects={{name="AttackDown", target="Enemy"}} },
    {name="False Swipe",    power=2,      type="Normal",  dice=6, STAB=true,    effects={{name="Custom"}} },
    {name="Focus Energy",   power=0,      type="Normal",  dice=6, STAB=false,   effects={{name="Custom"}} },
    {name="Fury Attack",    power=1,      type="Normal",  dice=4, STAB=true,    effects={{name="ExtraDice", target="Self", chance=4}} },
    {name="Fury Swipes",    power=1,      type="Normal",  dice=4, STAB=true,    effects={{name="ExtraDice", target="Self", chance=4}} },
    {name="Giga Impact",    power=3,      type="Normal",  dice=6, STAB=true,    effects={{name="Recharge", target="Self"}} },
    {name="Glare",          power=0,      type="Normal",  dice=6, STAB=false,   effects={{name="Paralyse", target="Enemy"}} },
    {name="Growl",          power=0,      type="Normal",  dice=6, STAB=false,   effects={{name="AttackDown", target="Enemy", chance=6}} },
    {name="Growth",         power=0,      type="Normal",  dice=6, STAB=false,   effects={{name="AttackUp2", target="Self"}} },
    {name="Guillotine",     power=0,      type="Normal",  dice=6, STAB=false,   effects={{name="KO", target="Enemy", chance=5}} },
    {name="Harden",         power=0,      type="Normal",  dice=6, STAB=false,   effects={{name="AttackDown", target="Enemy"}} },
    {name="Head Charge",    power=4,      type="Normal",  dice=6, STAB=true,    effects={{name="KO", target="Self", chance=6}} },
    {name="Headbutt",       power=2,      type="Normal",  dice=6, STAB=true,    effects={{name="AttackDown", target="Enemy", chance=5}} },
    {name="Heal Bell",      power=0,      type="Normal",  dice=6, STAB=false,   effects={{name="Custom"}} },
    {name="Hidden Power",   power=0,      type="Normal",  dice=6, STAB=false,   effects={{name="Custom"}} },
    {name="Horn Attack",    power=2,      type="Normal",  dice=6, STAB=true},
    {name="Horn Drill",     power=0,      type="Normal",  dice=6, STAB=false,   effects={{name="KO", target="Enemy", chance=5}} },
    {name="Howl",           power=0,      type="Normal",  dice=6, STAB=false,   effects={{name="AttackUp", target="Self"}} },
    {name="Hyper Beam",     power=3,      type="Normal",  dice=6, STAB=true,    effects={{name="Recharge", target="Self"}} },
    {name="Hyper Fang",     power=2,      type="Normal",  dice=6, STAB=false,   effects={{name="AttackDown", target="Enemy", chance=6}} },
    {name="Hyper Voice",    power=2,      type="Normal",  dice=6, STAB=false},
    {name="Judgement",      power=3,      type="Normal",  dice=6, STAB=true,    effects={{name="Custom"}} },
    {name="Leer",           power=0,      type="Normal",  dice=6, STAB=false,   effects={{name="AttackUp", target="Self"}} },
    {name="Lovely Kiss",    power=0,      type="Normal",  dice=6, STAB=false,   effects={{name="Sleep", target="Enemy", chance=3}} },
    {name="Mean Look",      power=0,      type="Normal",  dice=6, STAB=false,   effects={{name="Custom"}} },
    {name="Me First",       power=0,      type="Normal",  dice=6, STAB=false,   effects={{name="Custom"}} },
    {name="Mega Kick",      power=3,      type="Normal",  dice=6, STAB=true},
    {name="Mega Punch",     power=2,      type="Normal",  dice=6, STAB=true},
    {name="Metronome",      power=0,      type="Normal",  dice=6, STAB=false,   effects={{name="Custom"}} },
    {name="Mimic",          power=0,      type="Normal",  dice=6, STAB=false,   effects={{name="Custom"}} },
    {name="Minimize",       power=0,      type="Normal",  dice=6, STAB=false,   effects={{name="AttackDown", target="Enemy"}} },
    {name="Nature Power",   power=0,      type="Normal",  dice=6, STAB=true,    effects={{name="Custom"}} },
    {name="Pay Day",        power=1,      type="Normal",  dice=6, STAB=true,    effects={{name="Custom", chance=6}} },
    {name="Perish Song",    power=0,      type="Normal",  dice=6, STAB=false,   effects={{name="Custom"}} },
    {name="Pound",          power=1,      type="Normal",  dice=6, STAB=true},
    {name="Present",        power=0,      type="Normal",  dice=6, STAB=false,   effects={{name="Extra Dice", target="Self", chance=6}} },
    {name="Protect",        power=0,      type="Normal",  dice=6, STAB=false,   effects={{name="Custom"}} },
    {name="Quick Attack",   power=1,      type="Normal",  dice=6, STAB=true,    effects={{name="Priority", target="Self"}} },
    {name="Rage",           power=1,      type="Normal",  dice=6, STAB=true,    effects={{name="AttackUp", target="Self", condition="Power"}} },
    {name="Rapid Spin",     power=1,      type="Normal",  dice=6, STAB=true},
    {name="Retaliate",      power=2,      type="Normal",  dice=6, STAB=true,    effects={{name="Custom"}} },
    {name="Roar",           power=0,      type="Normal",  dice=6, STAB=false,   effects={{name="Switch", target="Enemy"}} },
    {name="Razor Wind",     power=2,      type="Normal",  dice=8, STAB=true,    effects={{name="Recharge", target="Self"}} },
    {name="Safeguard",      power=0,      type="Normal",  dice=6, STAB=false,   effects={{name="Custom"}} },
    {name="Self-Destruct",  power=4,      type="Normal",  dice=6, STAB=true,    effects={{name="KO", target="Self"}} },
    {name="Scratch",        power=1,      type="Normal",  dice=6, STAB=true},
    {name="Screech",        power=0,      type="Normal",  dice=6, STAB=false,   effects={{name="AttackUp2", target="Self"}} },
    {name="Sharpen",        power=0,      type="Normal",  dice=6, STAB=false,   effects={{name="AttackUp", target="Self"}} },
    {name="Sing",           power=0,      type="Normal",  dice=6, STAB=false,   effects={{name="Sleep", target="Enemy", chance=4}} },
    {name="Sketch",         power=0,      type="Normal",  dice=6, STAB=false,   effects={{name="Custom"}} },
    {name="Skull Bash",     power=3,      type="Normal",  dice=6, STAB=true,    effects={{name="Recharge", target="Self"}} },
    {name="Slam",           power=2,      type="Normal",  dice=6, STAB=true},
    {name="Slash",          power=2,      type="Normal",  dice=8, STAB=true},
    {name="Smelling Salts", power=0,      type="Normal",  dice=6, STAB=false,   effects={{name="Custom"}} },
    {name="Smokescreen",    power=0,      type="Normal",  dice=6, STAB=false,   effects={{name="AttackDown", target="Enemy"}} },
    {name="Sonic Boom",     power=2,      type="Normal",  dice=4, STAB=false,   effects={{name="Neutral", target="Self"}} },
    {name="Spike Cannon",   power=1,      type="Normal",  dice=4, STAB=true,    effects={{name="ExtraDice", target="Self", chance=4}} },
    {name="Splash",         power=0,      type="Normal",  dice=6, STAB=false},
    {name="Stomp",          power=2,      type="Normal",  dice=6, STAB=false,   effects={{name="AttackDown", target="Enemy", chance=5}} },
    {name="Super Fang",     power="Enemy",type="Normal",  dice=6, STAB=false},
    {name="Supersonic",     power=0,      type="Normal",  dice=6, STAB=false,   effects={{name="Confuse", target="Enemy", chance=4}} },
    {name="Swagger",        power=0,      type="Normal",  dice=6, STAB=false,   effects={{name="Confuse", target="Enemy"}} },
    {name="Swift",          power=2,      type="Normal",  dice=6, STAB=true,    effects={{name="AttackUp", target="Self"}} },
    {name="Swords Dance",   power=0,      type="Normal",  dice=6, STAB=false,   effects={{name="AttackUp2", target="Self"}} },
    {name="Tackle",         power=1,      type="Normal",  dice=6, STAB=true},
    {name="Tail Slap",      power=2,      type="Normal",  dice=4, STAB=false,   effects={{name="ExtraDice", target="Self"}} },
    {name="Tail Whip",      power=0,      type="Normal",  dice=6, STAB=false,   effects={{name="AttackUp", target="Self"}} },
    {name="Take Down",      power=2,      type="Normal",  dice=6, STAB=true,    effects={{name="KO", target="Self", chance=6}} },
    {name="Techno Blast",   power=3,      type="Normal",  dice=6, STAB=true,    effects={{name="Confuse", target="Enemy"}} },
    {name="Teeter Dance",   power=0,      type="Normal",  dice=6, STAB=false,   effects={{name="Confuse", target="Enemy"}} },
    {name="Thrash",         power=3,      type="Normal",  dice=6, STAB=true,    effects={{name="Confuse", target="Self", chance=5}} },
    {name="Transform",      power=0,      type="Normal",  dice=6, STAB=false,   effects={{name="Custom"}} },
    {name="Tri Attack",     power=2,      type="Normal",  dice=6, STAB=true,    effects={{name="Custom", chance=5}} },
    {name="Trump Card",     power=1,      type="Normal",  dice=6, STAB=true,    effects={{name="Custom"}} },
    {name="Uproar",         power=2,      type="Normal",  dice=6, STAB=true,    effects={{name="Custom"}} },
    {name="Vise Grip",      power=2,      type="Normal",  dice=6, STAB=true},
    {name="Whirlwind",      power=0,      type="Normal",  dice=6, STAB=false,   effects={{name="Switch", target="Enemy"}} },
    {name="Wrap",           power=1,      type="Normal",  dice=6, STAB=true,    effects={{name="ExtraDice", target="Self", chance=4}} },
    {name="Wring Out",      power="Enemy",type="Normal",  dice=6, STAB=true},

    -- Poison
    {name="Acid",           power=1,      type="Poison",  dice=6, STAB=true,    effects={{name="AttackUp", target="Self", chance=6}} },
    {name="Acid Armor",     power=0,      type="Poison",  dice=6, STAB=false,   effects={{name="AttackDown2", target="Enemy"}} },
    {name="Acid Spray",     power=2,      type="Poison",  dice=6, STAB=true,    effects={{name="AttackDown2", target="Enemy"}} },
    {name="Clear Smog",     power=3,      type="Poison",  dice=6, STAB=true,    effects={{name="Custom"}} },
    {name="Cross Poison",   power=3,      type="Poison",  dice=6, STAB=true},
    {name="Coil",           power=0,      type="Poison",  dice=6, STAB=true,    effects={{name="AttackUp", target="Self"},{name="AttackDown", target="Enemy"}} },
    {name="Poison Fang",    power=2,      type="Poison",  dice=8, STAB=true,    effects={{name="Poison", target="Enemy", chance=4}} },
    {name="Poison Gas",     power=0,      type="Poison",  dice=6, STAB=false,   effects={{name="Poison", target="Enemy", chance=2}} },
    {name="Poison Jab",     power=3,      type="Poison",  dice=6, STAB=true,    effects={{name="Poison", target="Enemy", chance=5}} },
    {name="Poison Powder",  power=0,      type="Poison",  dice=6, STAB=false,   effects={{name="Poison", target="Enemy", chance=3}} },
    {name="Poison Sting",   power=1,      type="Poison",  dice=6, STAB=true,    effects={{name="Poison", target="Enemy", chance=5}} },
    {name="Poison Tail",    power=2,      type="Poison",  dice=8, STAB=true,    effects={{name="Poison", target="Enemy", chance=6}} },
    {name="Smog",           power=1,      type="Poison",  dice=6, STAB=true,    effects={{name="Poison", target="Enemy", chance=4}} },
    {name="Sludge",         power=2,      type="Poison",  dice=6, STAB=true,    effects={{name="Poison", target="Enemy", chance=5}} },
    {name="Sludge Bomb",    power=3,      type="Poison",  dice=6, STAB=true,    effects={{name="Poison", target="Enemy", chance=5}} },
    {name="Toxic",          power=0,      type="Poison",  dice=6, STAB=false,   effects={{name="Poison", target="Enemy", chance=2}} },
    {name="Venoshock",      power=3,      type="Poison",  dice=6, STAB=false,   effects={{name="Custom"}} },

    -- Psychic
    {name="Agility",        power=0,      type="Psychic", dice=6, STAB=false,   effects={{name="AttackUp2", target="Self"}} },
    {name="Amnesia",        power=0,      type="Psychic", dice=6, STAB=false,   effects={{name="AttackDown2", target="Enemy"}} },
    {name="Barrier",        power=0,      type="Psychic", dice=6, STAB=false,   effects={{name="AttackDown2", target="Enemy"}} },
    {name="Confusion",      power=1,      type="Psychic", dice=6, STAB=true,    effects={{name="Confuse", target="Enemy", chance=6}} },
    {name="Dream Eater",    power="Sleep",type="Psychic", dice=6, STAB=false,   effects={{name="Sleep", target="Enemy", chance=4}} },
    {name="Extrasensory",   power=2,      type="Psychic", dice=6, STAB=false,   effects={{name="AttackDown", target="Enemy", chance=6}} },
    {name="Future Sight",   power=3,      type="Psychic", dice=6, STAB=true,    effects={{name="Recharge", target="Self"}} },
    {name="Hypnosis",       power=0,      type="Psychic", dice=6, STAB=false,   effects={{name="Sleep", target="Enemy", chance=4}} },
    {name="Heal Pulse",     power=0,      type="Psychic", dice=6, STAB=false,   effects={{name="Custom"},{name="Recharge", target="Self"}} },
    {name="Healing Wish",   power=0,      type="Psychic", dice=6, STAB=false,   effects={{name="Custom"},{name="KO", target="Self"}} },
    {name="Imprison",       power=0,      type="Psychic", dice=6, STAB=false,   effects={{name="Custom"}} },
    {name="Light Screen",   power=0,      type="Psychic", dice=6, STAB=false,   effects={{name="AttackDown2", target="Enemy"}} },
    {name="Luster Purge",   power=3,      type="Psychic", dice=6, STAB=true,    effects={{name="AttackDown", target="Enemy", chance=4}} },
    {name="Magic Coat",     power=0,      type="Psychic", dice=6, STAB=false,   effects={{name="Custom"}} },
    {name="Mirror Coat",    power=0,      type="Psychic", dice=6, STAB=false,   effects={{name="Custom"}} },
    {name="Mist Ball",      power=3,      type="Psychic", dice=6, STAB=true,    effects={{name="AttackDown", target="Enemy", chance=4}} },
    {name="Psybeam",        power=2,      type="Psychic", dice=6, STAB=true,    effects={{name="Confuse", target="Enemy", chance=4}} },
    {name="Psywave",        power="Self", type="Psychic", dice=6, STAB=false    },
    {name="Psychic",        power=2,      type="Psychic", dice=6, STAB=true,    effects={{name="AttackUp", target="Self", chance=6}} },
    {name="Psycho Boost",   power=4,      type="Psychic", dice=6, STAB=true     },
    {name="Psycho Cut",     power=3,      type="Psychic", dice=8, STAB=true     },
    {name="Psyshock",       power=3,      type="Psychic", dice=6, STAB=true     },
    {name="Reflect",        power=0,      type="Psychic", dice=6, STAB=false,   effects={{name="AttackDown2", target="Enemy"}} },
    {name="Telekinesis",    power=0,      type="Psychic", dice=6, STAB=false,   effects={{name="Custom"}} },
    {name="Teleport",       power=0,      type="Psychic", dice=6, STAB=false,   effects={{name="Switch", target="Self"}} },
    {name="Zen Headbutt",   power=2,      type="Psychic", dice=6, STAB=true,    effects={{name="AttackDown", target="Enemy", chance=5}} },

    -- Rock
    {name="Ancient Power",  power=2,      type="Rock",    dice=6, STAB=true,    effects={{name="AttackDown", target="Enemy", chance=6},{name="AttackUp", target="Self", chance=6}} },
    {name="Head Smash",     power=3,      type="Rock",    dice=6, STAB=true,    effects={{name="KO", target="Self", chance=6}} },
    {name="Power Gem",      power=2,      type="Rock",    dice=6, STAB=true},
    {name="Rock Slide",     power=3,      type="Rock",    dice=6, STAB=true,    effects={{name="AttackDown", target="Enemy", chance=5}} },
    {name="Rock Throw",     power=1,      type="Rock",    dice=6, STAB=true},
    {name="Rollout",        power=1,      type="Rock",    dice=6, STAB=true,    effects={{name="Custom"}} },
    {name="Rock Blast",     power=1,      type="Rock",    dice=4, STAB=true,    effects={{name="ExtraDice", target="Self", chance=4}}},
    {name="Rock Tomb",      power=3,      type="Rock",    dice=6, STAB=true},
    {name="Rock Wrecker",   power=4,      type="Rock",    dice=6, STAB=true,    effects={{name="KO", target="Self", chance=6}} },
    {name="Sandstorm",      power=0,      type="Rock",    dice=8, STAB=false,   effects={{name="Custom"}} },
    {name="Stone Edge",     power=3,      type="Rock",    dice=8, STAB=true},

    -- Steel
    {name="Autotomize",     power=0,      type="Steel",  dice=6, STAB=false,    effects={{name="AttackUp2", target="Self"}} },
    {name="Doom Desire",    power=4,      type="Steel",  dice=6, STAB=true,     effects={{name="Recharge", target="Self"}} },
    {name="Flash Cannon",   power=3,      type="Steel",  dice=6, STAB=true,     effects={{name="AttackUp", target="Self", chance=6}} },
    {name="Gear Grind",     power=2,      type="Steel",  dice=4, STAB=true,     effects={{name="ExtraDice", target="Self"}} },
    {name="Gyro Ball",      power="Self", type="Steel",  dice=6, STAB=false},
    {name="Iron Defense",   power=0,      type="Steel",  dice=6, STAB=true,     effects={{name="AttackDown2", target="Enemy"}} },
    {name="Iron Head",      power=3,      type="Steel",  dice=6, STAB=true,     effects={{name="AttackDown", target="Enemy", chance=5}} },
    {name="Iron Tail",      power=2,      type="Steel",  dice=6, STAB=true,     effects={{name="AttackUp", target="Self", chance=5}} },
    {name="Magnet Bomb",    power=3,      type="Steel",  dice=6, STAB=true,     effects={{name="AttackUp", target="Self"}} },
    {name="Metal Claw",     power=1,      type="Steel",  dice=6, STAB=true,     effects={{name="AttackUp", target="Self", chance=6}} },
    {name="Metal Mash",     power=1,      type="Steel",  dice=6, STAB=true,     effects={{name="AttackUp", target="Self", chance=6}} },
    {name="Metal Sound",    power=0,      type="Steel",  dice=6, STAB=false,    effects={{name="AttackUp2", target="Self"}} },
    {name="Meteor Mash",    power=3,      type="Steel",  dice=6, STAB=true,     effects={{name="AttackUp", target="Self", chance=5}} },
    {name="Mirror Shot",    power=3,      type="Steel",  dice=6, STAB=true,     effects={{name="AttackDown", target="Enemy", chance=5}} },
    {name="Shift Gear",     power=0,      type="Steel",  dice=6, STAB=false,    effects={{name="AttackUp2", target="Self", chance=6}} },
    {name="Steel Wing",     power=2,      type="Steel",  dice=6, STAB=true,     effects={{name="AttackDown", target="Enemy", chance=6}} },

    -- Water
    {name="Aqua Jet",       power=2,      type="Water",  dice=6, STAB=true,     effects={{name="Priority", target="Self"}} },
    {name="Aqua Tail",      power=2,      type="Water",  dice=6, STAB=true},
    {name="Brine",          power=3,      type="Water",  dice=6, STAB=true},
    {name="Bubble",         power=1,      type="Water",  dice=6, STAB=true},
    {name="Bubble Beam",    power=2,      type="Water",  dice=6, STAB=true},
    {name="Clamp",          power=1,      type="Water",  dice=4, STAB=true,     effects={{name="ExtraDice", target="Self", chance=4}} },
    {name="Crabhammer",     power=3,      type="Water",  dice=8, STAB=true},
    {name="Dive",           power=3,      type="Water",  dice=6, STAB=true},
    {name="Hydro Pump",     power=3,      type="Water",  dice=6, STAB=true},
    {name="Muddy Water",    power=3,      type="Water",  dice=6, STAB=true,     effects={{name="AttackDown", target="Enemy", chance=5}} },
    {name="Octazooka",      power=2,      type="Water",  dice=6, STAB=true,     effects={{name="AttackUp", target="Enemy", chance=4}} },
    {name="Rain Dance",     power=3,      type="Water",  dice=6, STAB=false,    effects={{name="Custom"}} },
    {name="Razor Shell",    power=3,      type="Water",  dice=8, STAB=true},
    {name='Scald',          power=3,      type="Water",  dice=6, STAB=true,     effects={{name="Burn", target="Enemy", chance=5}} },
    {name="Surf",           power=2,      type="Water",  dice=6, STAB=true},
    {name="Water Gun",      power=1,      type="Water",  dice=6, STAB=true},
    {name="Water Pulse",    power=2,      type="Water",  dice=6, STAB=true,     effects={{name="Confuse", target="Enemy", chance=6}} },
    {name="Water Spout",    power=4,      type="Water",  dice=6, STAB=true},
    {name="Waterfall",      power=2,      type="Water",  dice=6, STAB=true,     effects={{name="AttackDown", target="Enemy", chance=5}} },
    {name="Whirlpool",      power=1,      type="Water",  dice=6, STAB=true,     effects={{name="ExtraDice", target="Self"}} },
    {name="Withdraw",       power=0,      type="Water",  dice=6, STAB=false,    effects={{name="AttackDown", target="Enemy"}} },
    {name="Weather Ball Water",power=3,   type="Water",  dice=6, STAB=true}
}

gymData =
{
    {guid="559fc4", trainerName="Team Rocket", pokemon={
      {name="Kangaskhan", level=5, types={"Normal"},          moves={"Comet Punch", "Rage", "Slash"}},
      {name="Nidoqueen",  level=6, types={"Poison","Ground"}, moves={"Scratch", "Poison Sting", "Body Slam"}}}},

    -- Gen I
    -- Gym Leaders
    {guid="1856e6", trainerName="Brock", pokemon={
      {name="Geodude",    level=2, types={"Rock","Ground"},   moves={"Defense Curl", "Tackle", "Rock Throw"}},
      {name="Onix",       level=2, types={"Rock","Ground"},   moves={"Screech", "Tackle", "Bind"}}}},
    {guid="bb825e", trainerName="Misty", pokemon={
      {name="Staryu",     level=3, types={"Water"},           moves={"Harden", "Tackle", "Water Gun"}},
      {name="Starmie",    level=3, types={"Water"},           moves={"Tackle", "Water Gun", "Bubble Beam"}}}},
    {guid="79261f", trainerName="Lt. Surge", pokemon={
      {name="Pikachu",    level=3, types={"Electric"},        moves={"Growl", "Thunder Wave", "Thunder Shock"}},
      {name="Raichu",     level=4, types={"Electric"},        moves={"Growl", "Thunder Shock", "Thunderbolt"}}}},
    {guid="831b51", trainerName="Erika", pokemon={
      {name="Tangela",    level=4, types={"Grass"},           moves={"Poison Powder", "Constrict", "Bind"}},
      {name="Vileplume",  level=4, types={"Grass","Poison"},  moves={"Poison Powder", "Sleep Powder", "Petal Dance"}}}},
    {guid="0e26dd", trainerName="Koga", pokemon={
      {name="Muk",        level=5, types={"Poison"},          moves={"Disable", "Minimize", "Sludge"}},
      {name="Weezing",    level=6, types={"Poison"},          moves={"Smog", "Sludge", "Self-Destruct"}}}},
    {guid="d66786", trainerName="Sabrina", pokemon={
      {name="Mr. Mime",   level=5, types={"Psychic"},         moves={"Barrier", "Double Slap", "Confusion"}},
      {name="Alakazam",   level=6, types={"Psychic"},         moves={"Reflect", "Psybeam", "Psywave"}}}},
    {guid="8f1b84", trainerName="Blaine", pokemon={
      {name="Rapidash",   level=7, types={"Fire"},            moves={"Tail Whip", "Stomp", "Fire Spin"}},
      {name="Arcanine",   level=7, types={"Fire"},            moves={"Ember", "Take Down", "Fire Blast"}}}},
    {guid="c55cac", trainerName="Giovanni", pokemon={
      {name="Dugtrio",    level=7, types={"Ground"},          moves={"Sand Attack", "Slash", "Dig"}},
      {name="Rhydon",     level=7, types={"Ground","Rock"},   moves={"Take Down", "Stomp", "Fissure"}}}},

    -- Elite Four + Champion
    {guid="b9137c", trainerName="Lorelei", pokemon={
      {name="Cloyster",   level=8,  types={"Water","Ice"},     moves={"Supersonic", "Clamp", "Aurora Beam"}},
      {name="Lapras",     level=9,  types={"Water","Ice"},     moves={"Body Slam", "Hydro Pump", "Blizzard"}}}},
    {guid="c4f40c", trainerName="Bruno", pokemon={
      {name="Hitmonlee",  level=8,  types={"Fighting"},        moves={"Mega Kick", "Jump Kick", "High Jump Kick"}},
      {name="Machamp",    level=9,  types={"Fighting"},        moves={"Leer", "Fissure", "Submission"}}}},
    {guid="52dc6e", trainerName="Agatha", pokemon={
      {name="Arbok",      level=8,  types={"Poison"},          moves={"Glare", "Acid", "Bite"}},
      {name="Gengar",     level=9,  types={"Ghost"},           moves={"Toxic", "Confuse Ray", "Night Shade"}}}},
    {guid="78c0e0", trainerName="Lance", pokemon={
      {name="Gyarados",   level=8,  types={"Water","Flying"},  moves={"Hyper Beam", "Dragon Rage", "Hydro Pump"}},
      {name="Dragonite",  level=9,  types={"Dragon","Flying"}, moves={"Reflect", "Slam", "Hyper Beam"}}}},

    {guid="04e46d", trainerName="Gary", pokemon={
      {name="Pidgeot",    level=9,  types={"Flying","Normal"}, moves={"Mirror Move", "Wing Attack", "Sky Attack"}},
      {name="Venusaur",   level=10, types={"Grass"},           moves={"Growth", "Razor Leaf", "Solar Beam"}}}},
    {guid="fe306a", trainerName="Gary", pokemon={
      {name="Pidgeot",    level=9,  types={"Flying","Normal"}, moves={"Mirror Move", "Wing Attack", "Sky Attack"}},
      {name="Blastoise",   level=10, types={"Water"},          moves={"Bite", "Blizzard", "Hydro Pump"}}}},
    {guid="7a6571", trainerName="Gary", pokemon={
      {name="Pidgeot",    level=9,  types={"Flying","Normal"}, moves={"Mirror Move", "Wing Attack", "Sky Attack"}},
      {name="Charizard",  level=10, types={"Fire","Flying"},   moves={"Slash", "Fire Blast", "Fire Spin"}}}},

    -- Gen II
    -- Gym Leaders
    {guid="9ce6fb", trainerName="Falkner", pokemon={
      {name="Pidgey",     level=2, types={"Flying","Normal"},   moves={"Sand Attack", "Mud-Slap", "Tackle"}},
      {name="Pidgeotto",  level=2, types={"Flying","Normal"},   moves={"Mud-Slap", "Tackle", "Gust"}}}},
    {guid="3e463b", trainerName="Bugsy", pokemon={
      {name="Metapod",    level=3, types={"Bug"},               moves={"String Shot", "Harden", "Tackle"}},
      {name="Scyther",    level=3, types={"Bug","Flying"},      moves={"Leer", "Quick Attack", "Fury Cutter"}}}},
    {guid="b7bc70", trainerName="Whitney", pokemon={
      {name="Clefairy",   level=3, types={"Normal"},            moves={"Mimic", "Metronome", "Double Slap"}},
      {name="Miltank",    level=4, types={"Normal"},            moves={"Attract", "Rollout", "Stomp"}}}},
    {guid="5f139d", trainerName="Morty", pokemon={
      {name="Gengar",    level=4, types={"Ghost"},              moves={"Mean Look", "Dream Eater", "Shadow Ball"}},
      {name="Haunter",   level=4, types={"Ghost"},              moves={"Mimic", "Hypnosis", "Night Shade"}}}},
    {guid="0bbc14", trainerName="Chuck", pokemon={
      {name="Primeape",   level=5, types={"Fighting"},          moves={"Leer", "Rage", "Karate Chop"}},
      {name="Poliwrath",  level=6, types={"Water","Fighting"},  moves={"Hypnosis", "Surf", "Dynamic Punch"}}}},
    {guid="8f27b4", trainerName="Jasmine", pokemon={
      {name="Magnemite",  level=5, types={"Electric","Steel"},  moves={"Thunder Wave", "Sonic Boom", "Thunderbolt"}},
      {name="Steelix",    level=6, types={"Steel","Ground"},    moves={"Screech", "Rock Throw", "Iron Tail"}}}},
    {guid="a713db", trainerName="Pryce", pokemon={
      {name="Dewgong",    level=7, types={"Water","Ice"},       moves={"Headbutt", "Icy Wind", "Aurora Beam"}},
      {name="Piloswine",  level=7, types={"Ice","Ground"},      moves={"Mist", "Icy Wind", "Blizzard"}}}},
    {guid="aa6e6e", trainerName="Clair", pokemon={
      {name="Dragonair",  level=7, types={"Dragon"},            moves={"Slam", "Surf", "Dragon Breath"}},
      {name="Kingdra",    level=7, types={"Dragon","Water"},    moves={"Hyper Beam", "Surf", "Dragon Breath"}}}},

    -- Elite Four + champion
    {guid="9447fd", trainerName="Will", pokemon={
      {name="Xatu",       level=8, types={"Psychic","Flying"},  moves={"Confuse Ray", "Quick Attack", "Psychic"}},
      {name="Exeggutor",  level=9, types={"Grass","Psychic"},   moves={"Reflect", "Egg Bomb", "Psychic"}}}},
    {guid="d55f10", trainerName="Koga", pokemon={
      {name="Forretress", level=8, types={"Bug","Steel"},       moves={"Spikes", "Swift", "Explosion"}},
      {name="Crobat",     level=9, types={"Poison","Flying"},   moves={"Toxic", "Double Team", "Wing Attack"}}}},
    {guid="746880", trainerName="Bruno", pokemon={
      {name="Hitmontop",  level=8, types={"Fighting"},          moves={"Quick Attack", "Dig", "Pursuit"}},
      {name="Machamp",    level=9, types={"Fighting"},          moves={"Rock Slide", "Cross Chop", "Vital Throw"}}}},
    {guid="d99872", trainerName="Karen", pokemon={
      {name="Umbreon",    level=8, types={"Dark"},              moves={"Sand Attack", "Confuse Ray", "Feint Attack"}},
      {name="Houndoom",   level=9, types={"Dark","Fire"},       moves={"Flamethrower", "Pursuit", "Crunch"}}}},

    {guid="175d3c", trainerName="Red", pokemon={
      {name="Espeon",    level=9,  types={"Psychic"},           moves={"Reflect", "Mud-Slap", "Psychic"}},
      {name="Pikachu",   level=10, types={"Electric"},          moves={"Quick Attack", "Thunderbolt", "Thunder"}}}},

    -- Gym GenIII
    -- Gym Leaders
    {guid="028a01", trainerName="Roxanne", pokemon={
      {name="Geodude",   level=2, types={"Rock"},               moves={"Tackle", "Defense Curl", "Rock Throw"}},
      {name="Nosepass",  level=2, types={"Rock"},               moves={"Tackle", "Rock Throw", "Rock Tomb"}}}},
    {guid="eee9d7", trainerName="Brawly", pokemon={
      {name="Machop",    level=3, types={"Fighting"},           moves={"Bulk Up", "Leer", "Karate Chop"}},
      {name="Makuhita",  level=3, types={"Fighting"},           moves={"Knock Off", "Arm Thrust", "Sand Attack"}}}},
    {guid="06f9af", trainerName="Wattson", pokemon={
      {name="Voltorb",   level=3, types={"Electric"},           moves={"Spark", "Sonic Boom", "Self-Destruct"}},
      {name="Magneton",  level=4, types={"Electric"},           moves={"Shock Wave", "Sonic Boom", "Thunder Wave"}}}},
    {guid="219352", trainerName="Flannery", pokemon={
      {name="Slugma",    level=4, types={"Fire"},               moves={"Flamethrower", "Rock Slide", "Light Screen"}},
      {name="Torkoal",   level=4, types={"Fire"},               moves={"Overheat", "Body Slam", "Attract"}}}},
    {guid="508e05", trainerName="Norman", pokemon={
      {name="Vigoroth",  level=5, types={"Normal"},             moves={"Slash", "Feint Attack", "Facade"}},
      {name="Slaking",   level=6, types={"Normal"},             moves={"Focus Punch", "Feint Attack", "Facade"}}}},
    {guid="21668a", trainerName="Winona", pokemon={
      {name="Pelipper",  level=5, types={"Water"},              moves={"Water Gun", "Supersonic", "Aerial Ace"}},
      {name="Altaria",   level=6, types={"Dragon"},             moves={"Earthquake", "Dragon Breath", "Aerial Ace"}}}},
    {guid="29bfc7", trainerName="Tate & Liza", pokemon={
      {name="Lunatone",  level=7, types={"Psychic"},            moves={"Light Screen", "Psychic", "Hypnosis"}},
      {name="Solrock",   level=7, types={"Psychic"},            moves={"Solar Beam", "Psychic", "Flamethrower"}}}},
    {guid="505fdb", trainerName="Wallace", pokemon={
      {name="Sealeo",    level=7, types={"Ice"},                moves={"Body Slam", "Aurora Beam", "Water Pulse"}},
      {name="Milotic",   level=7, types={"Water"},              moves={"Twister", "Ice Beam", "Water Pulse"}}}},
    
    -- Elite Four
    {guid="8d5b51", trainerName="Phoebe", pokemon={
      {name="Sableye",   level=8, types={"Dark"},               moves={"Feint Attack", "Shadow Ball", "Psychic"}},
      {name="Dusclops",  level=9, types={"Ghost"},              moves={"Shadow Ball", "Ice Beam", "Earthquake"}}}},
    {guid="3b1f11", trainerName="Drake", pokemon={
      {name="Flygon",    level=8, types={"Ground"},             moves={"Fly", "Dig", "Dragon Breath"}},
      {name="Salamence", level=9, types={"Dragon"},             moves={"Flamethrower", "Dragon Claw", "Crunch"}}}},
    {guid="bfdb2c", trainerName="Glacia", pokemon={
      {name="Glalie",    level=8, types={"Ice"},                moves={"Ice Beam", "Shadow Ball", "Crunch"}},
      {name="Walrein",   level=9, types={"Ice"},                moves={"Blizzard", "Surf", "Sheer Cold"}}}},
    {guid="01b451", trainerName="Sidney", pokemon={
      {name="Sharpedo",  level=8, types={"Water"},              moves={"Surf", "Crunch", "Slash"}},
      {name="Absol",     level=9, types={"Dark"},               moves={"Swords Dance", "Aerial Ace", "Slash"}}}},
    -- Champion
    {guid="a27094", trainerName="Steven", pokemon={
      {name="Claydol",   level=9,  types={"Ground"},            moves={"Earthquake", "Ancient Power", "Reflect"}},
      {name="Aggron",    level=10, types={"Steel"},             moves={"Thunder", "Earthquake", "Solar Beam"}}}},
    {guid="857b59", trainerName="Steven", pokemon={
      {name="Armaldo",   level=9,  types={"Rock"},              moves={"Slash", "Ancient Power", "Water Pulse"}},
      {name="Skarmory",  level=10, types={"Steel"},             moves={"Steel Wing", "Aerial Ace", "Spikes"}}}},
    {guid="9b5e32", trainerName="Steven", pokemon={
      {name="Cradily",   level=9,  types={"Rock"},              moves={"Ancient Power", "Sludge Bomb", "Giga Drain"}},
      {name="Metagross", level=10, types={"Steel"},             moves={"Meteor Mash", "Earthquake", "Psychic"}}}},
}

typeData =
{
    {name="Bug",      effective={"Grass","Psychic","Dark"},                   weak={"Fire","Flying","Fighting","Poison","Ghost","Fairy","Steel"}},
    {name="Dark",     effective={"Ghost","Psychic"},                          weak={"Fighting","Dark","Fairy"}},
    {name="Dragon",   effective={"Dragon"},                                   weak={"Steel","Fairy"}},
    {name="Electric", effective={"Water","Flying"},                           weak={"Electric","Grass","Dragon","Ground"}},
    {name="Fairy",    effective={"Fighting","Dragon","Dark"},                 weak={"Fire","Poison","Steel"}},
    {name="Fighting", effective={"Normal","Rock","Ice","Dark","Steel"},       weak={"Flying","Poison","Psychic","Fairy","Bug","Ghost"}},
    {name="Fire",     effective={"Grass","Bug","Ice","Steel"},                weak={"Water","Fire","Rock","Dragon"}},
    {name="Flying",   effective={"Grass","Fighting","Bug"},                   weak={"Rock","Electric","Steel"}},
    {name="Ghost",    effective={"Ghost","Psychic"},                          weak={"Dark","Normal"}},
    {name="Grass",    effective={"Water","Rock","Ground"},                    weak={"Grass","Fire","Flying","Bug","Poison","Dragon","Steel"}},
    {name="Ground",   effective={"Fire","Electric","Rock","Poison","Steel"},  weak={"Grass","Bug","Flying"}},
    {name="Ice",      effective={"Grass","Flying","Ground","Dragon"},         weak={"Water","Fire","Ice","Steel"}},
    {name="Normal",   effective={"None"},                                     weak={"Rock","Steel","Ghost"}},
    {name="Poison",   effective={"Grass","Fairy"},                            weak={"Rock","Ground","Poison","Ghost","Steel"}},
    {name="Psychic",  effective={"Fighting","Poison"},                        weak={"Psychic","Steel","Dark"}},
    {name="Rock",     effective={"Fire","Flying","Ice","Bug"},                weak={"Fighting","Ground","Steel"}},
    {name="Steel",    effective={"Ice","Rock","Fairy"},                       weak={"Fire","Water","Electric","Steel"}},
    {name="Water",    effective={"Fire","Rock","Ground"},                     weak={"Water","Grass","Dragon"}},
}

tmData =
{
    {guid="4a45a3", move="Body Slam"},
    {guid="745ecf", move="Bubble Beam"},
    {guid="d27b1b", move="Counter"},
    {guid="13a856", move="Dig"},
    {guid="b2e24d", move="Double-Edge"},
    {guid="a6fb79", move="Dragon Rage"},
    {guid="084a17", move="Earthquake"},
    {guid="14ef52", move="Fissure"},
    {guid="891c3b", move="Horn Drill"},
    {guid="f91f7a", move="Hyper Beam"},
    {guid="dc75e7", move="Ice Beam"},
    {guid="895553", move="Mega Drain"},
    {guid="0a0adf", move="Metronome"},
    {guid="23537a", move="Mimic"},
    {guid="79c3f6", move="Pay Day"},
    {guid="99286f", move="Psychic"},
    {guid="b23894", move="Psywave"},
    {guid="ad8b9c", move="Reflect"},
    {guid="dbf2c8", move="Razor Wind"},
    {guid="7d8029", move="Rock Slide"},
    {guid="945e69", move="Seismic Toss"},
    {guid="28f8ea", move="Self-Destruct"},
    {guid="8e245d", move="Solar Beam"},
    {guid="987bb8", move="Swords Dance"},
    {guid="16d087", move="Teleport"},
    {guid="b5d272", move="Thunderbolt"},
    {guid="8623fb", move="Thunder Wave"},
    {guid="e6b811", move="Toxic"},
    {guid="7c32ac", move="Tri Attack"},
    {guid="5caa62", move="Whirlwind"},
}

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  CAMERA
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  function showArena(obj, color)
      Player[color].lookAt({
          position = {x=-34.89,y=0.96,z=0.7},
          pitch    = 90,
          yaw      = 0,
          distance = 20,
      })
  end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  DATA GETTERS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function GetPokemonDataByGUID(params)

  local data
  for i=1, #selectedGens do
    if selectedGens[i] then
      --print("Searching Gen " .. i .. " data for GUID: " .. params.guid)
      data = getPokemonData(genData[i], params.guid)
      if data != nil then
        return data
      end
    end
  end
  if customGen then
    --print("Searching custom data for GUID")
    data = getPokemonData(customPokemonData, params.guid)
    if data != nil then
      return data
    end
  end
  print("No Pokémon Data Found")
end

function GetPokemonDataByName(params)

    local data
    for i=1, #selectedGens do
      if selectedGens[i] then
        --print("Searching Gen " .. i .. " data for GUID")
        data = getPokemonDataName(genData[i], params.guid)
        if data != nil then
          return data
        end
      end
    end
    if customGen then
      --print("Searching custom data for Name")
      data = getPokemonDataName(customPokemonData, params.guid)
      if data != nil then
        return data
      end
    end
    print("No Pokémon Data Found")
end

function getPokemonData(pokemonList, guid)
  for i=1, #pokemonList do
    local data = pokemonList[i]
    local guids = data.guids
    for j=1, #guids do
      if guids[j] == guid then
        --print("Found Pokémon Data")
        return data
      end
    end
  end
  return nil
end

function getPokemonDataName(pokemonList, name)
    for i=1, #pokemonList do
        local data = pokemonList[i]
        local names = data.name
        if names == name then
            --print("Found Pokémon Data")
            return data
        end
    end
  return nil
end

function GetTypeDataByName(name)
  for i=1, #typeData do
    local data = typeData[i]
    local typeName = data.name
    if typeName == name then
      return data
    end
  end
end

function GetTypeDataByGUID(params)
  for abcde=1, #typeData do
    local data = typeData[abcde]
    local guids2 = data.guids
    for efghj=1, #guids2 do
      if guids2[efghj] == params.guid then
        return data
      end
    end
  end
end

function GetGymDataByGUID(params)
  for i=1, #gymData do
    local data = gymData[i]
    local guid = data.guid
    if guid == params.guid then
      return data
    end
  end
end

function GetMoveDataByName(name)
  for i=1, #moveData do
    local data = moveData[i]
    local moveName = data.name
    if moveName == name then
      return data
    end
  end
end

function GetMoveDataByGUID(params)
  for abcdefg=1, #moveData do
    local data = moveData[abcdefg]
    local guids4 = data.guids
    for efghijk=1, #guids4 do
      if guids4[efghijk] == params.guid then
        return data
      end
    end
  end
end

function GetTmDataByGUID(params)
  for i=1, #tmData do
    local data = tmData[i]
    local guid = data.guid
    if guid == params then
      return data
    end
  end
end

function GetSelectedGens()

  return selectedGens
end

function GetAIDifficulty()

  return aiDifficulty
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  SETUP
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function start(player, value, id)

    MusicPlayer.setPlaylist(playlist)

end

function ShowSettingsPopup()

    UI.show('Settings')

end

function closeSettings(player, value, id)

    UI.hide('Settings')
end

function onLoad(saved_data)
    if saved_data ~= "" then
        local loaded_data = JSON.decode(saved_data)
        selectedGens = loaded_data.selectedGens
        customGen = loaded_data.customGen
        print("Save Data loaded!")
    end

    UI.setAttribute("gen1ToggleBtn", "isOn", selectedGens[1] )
    UI.setAttribute("gen2ToggleBtn", "isOn", selectedGens[2] )
    UI.setAttribute("gen3ToggleBtn", "isOn", selectedGens[3] )
    UI.setAttribute("gen4ToggleBtn", "isOn", selectedGens[4] )
    UI.setAttribute("customToggleBtn", "isOn", customGen )
    checkBeginState()
end

function onSave()

    saved_data = JSON.encode({selectedGens=selectedGens, customGen=customGen})
    return saved_data
end

function beginSetup(player, value, id)
    UI.hide('Settings')
    local params = {
      selectedGens=selectedGens,
      customGen=customGen,
      leadersGen=leadersGen,
      randomStarters=randomStarters
    }

    local battleManager = getObjectFromGUID("de7152")
    battleManager.call("setScriptingEnabled", battleScripting)

    local starterPokeball = getObjectFromGUID("ec1e4b")
    starterPokeball.call("beginSetup2", params)
end

function gen1Toggle()

    selectedGens[1] = not selectedGens[1]
    enoughPokemon()
    checkBeginState()
end

function gen2Toggle()

    selectedGens[2] = not selectedGens[2]
    enoughPokemon()
    checkBeginState()
end

function gen3Toggle()
  
  selectedGens[3] = not selectedGens[3]
  enoughPokemon()
  checkBeginState()
end

function gen4Toggle()
  
  selectedGens[4] = not selectedGens[4]
  enoughPokemon()
  checkBeginState()
end

function customToggle()

    customGen = not customGen
    enoughPokemon()
    checkBeginState()
end


function enoughPokemon()

  local numPokemon = 0
  if selectedGens[1] then
    numPokemon = numPokemon + 151
  end
  if selectedGens[2] then
    numPokemon = numPokemon + 100
  end
  if selectedGens[3] then
    numPokemon = numPokemon + 136
  end
  if selectedGens[4] then
    numPokemon = numPokemon + 107
  end
  if customGen then
    local pokeball
    for i=1, #customPokeballs do
      pokeball = getObjectFromGUID(customPokeballs[i])
      numPokemon = numPokemon + #pokeball.getObjects()
    end
  end
  hasEnoughPokemon = numPokemon >= 150
end

function randomStartersToggle()

  randomStarters = not randomStarters
end

function battleScriptingToggle()

  battleScripting = not battleScripting
end

function gen1LeadersToggle(player, isOn)

    setLeaders(1, isOn)
end

function gen2LeadersToggle(player, isOn)

    setLeaders(2, isOn)
end

function gen3LeadersToggle(player, isOn)

    setLeaders(3, isOn)
end

function customLeadersToggle(player, isOn)

    setLeaders(0, isOn)
end

function randomLeadersToggle(player, isOn)

    setLeaders(-1, isOn)
end

function aiOff(player, isOn)

    setAIDifficulty(0, isOn)
end

function aiEasy(player, isOn)

    setAIDifficulty(1, isOn)
end

function aiMedium(player, isOn)

    setAIDifficulty(2, isOn)
end

function aiHard(player, isOn)

    setAIDifficulty(3, isOn)
end

function setAIDifficulty(difficulty, isOn)
  if isOn == "True" then isOn = true end
  if isOn != true then return end
  aiDifficulty = difficulty
end

function setLeaders(gen, isOn)
  if isOn == "True" then isOn = true end
  if isOn != true then return end
  leadersGen = gen

  if leadersGen == 0 then
    local starterPokeball = getObjectFromGUID("ec1e4b")
    customAndTooFewLeaders = not starterPokeball.call("hasEnoughCustomLeaders")
  else
    customAndTooFewLeaders = false
  end

  checkBeginState()
end

function checkBeginState()

    UI.setAttribute("beginBtn", "interactable", hasEnoughPokemon and customAndTooFewLeaders == false )

end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  MUSIC
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function PlayRouteMusic()
  local song = playlist[currentTrack]
  --parameters = { url=song.url, title=song.title }
  MusicPlayer.setCurrentAudioclip({ url=song.url, title=song.title })
  MusicPlayer.repeat_track = false
  MusicPlayer.playlistIndex = currentTrack - 1
  --MusicPlayer.repeat_track = false
  MusicPlayer.play()

end

function PlayTrainerBattleMusic()
  currentTrack = MusicPlayer.playlistIndex + 1
  parameters =
  {
      url="http://cloud-3.steamusercontent.com/ugc/1023948871898692339/1921C30F85D84D3DA42FB922B89E8C3EDBA0035F/",
      title="Battle Music"
  }
  MusicPlayer.setCurrentAudioclip(parameters)
  MusicPlayer.repeat_track = true
end

function PlayGymBattleMusic()
  currentTrack = MusicPlayer.playlistIndex + 1
  parameters =
  {
      url="http://cloud-3.steamusercontent.com/ugc/1023949407635181294/DF75C7F7429A20B290E9C39CA1A391F5217CB3BB/",
      title="Battle Music"
  }
  MusicPlayer.setCurrentAudioclip(parameters)
  MusicPlayer.repeat_track = true
end

function PlayFinalBattleMusic()
  currentTrack = MusicPlayer.playlistIndex + 1
  parameters =
  {
      url="http://cloud-3.steamusercontent.com/ugc/1023948871898724461/766C5BF1EB28C474D2366F8223F98C5F083770D0/",
      title="Battle Music"
  }
  MusicPlayer.setCurrentAudioclip(parameters)
  MusicPlayer.repeat_track = true
end

function PlayVictoryMusic()
  parameters =
  {
      url="http://cloud-3.steamusercontent.com/ugc/1025076138129942019/D4A62C26EC339551E33D0319D0340384B1BDC69A/",
      title="Victory Music"
  }
  MusicPlayer.setCurrentAudioclip(parameters)
end