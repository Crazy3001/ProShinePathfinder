local linkExce = {}

linkExce["Route 2 Stop3"] = {
    ["Route 2_B"] = {3, 2}, -- top
    ["Route 2_D"] = {3, 12} -- down
}
linkExce["Tohjo Falls"] = {
    ["Route 27_A"] = {23, 32}, -- left
    ["Route 27_B"] = {46, 32} -- right
}
linkExce["Mt. Moon B2F_A"] = {
    ["Mt. Moon B1F_B"] = {17, 27}, -- left, towards route 4
    ["Mt. Moon B1F_D"] = {38, 40} -- right, towards route 3
}
linkExce["Mt. Moon 1F"] = {
    ["Mt. Moon B1F_A"] = {58, 33}, -- right, way to middle dig
    ["Mt. Moon B1F_C"] = {37, 29}, -- middle, way to top dig
    ["Mt. Moon B1F_D"] = {21, 20} -- topleft, way to route 4
}
linkExce["Route 4"] = {
    ["Cerulean City_A"] = {96, 22}, -- main City
    ["Cerulean City_B"] = {96, 14} -- Cerulean cave
    }
linkExce["Cerulean City_A"] = {
    ["Route 5_A"] = {17, 50}, -- daycare
    ["Route 5_B"] = {22, 50} -- fastest path
}
linkExce["Route 25"] = {
    ["Route 24_A"] = {9, 30}, -- water side to cerulean cave
    ["Route 24_B"] = {14, 30} -- bridge to main city
}
linkExce["Route 9"] = {
    ["Route 10_A"] = {85, 33}, -- pokecenter
    ["Route_10_B"] = {91, 33} -- power plant
}
linkExce["Rock Tunnel 1_B"] = {
    ["Rock Tunnel 2_A"] = {7, 7}, -- top left
    ["Rock Tunnel 2_B"] = {8, 15} -- middle left
}
linkExce["Rock Tunnel 2_A"] = {
    ["Rock Tunnel 1_A"] = {36, 16}, -- right, towards pokecenter
    ["Rock Tunnel 1_B"] = {7, 5} -- left, towards lavender
}
linkExce["Rock Tunnel 2_B"] = {
    ["Rock Tunnel 1_B"] = {10, 13}, -- middle, towards pokecenter
    ["Rock Tunnel 1_C"] = {8, 26} -- bottom, towards lavender
}
linkExce["Pokemon Tower B3_A"] = {
    ["Pokemon Tower B3_B"] = {23, 20},
}
linkExce["Pokemon Tower B3_B"] = {
    ["Pokemon Tower B3_C"] = {17, 23},
}
linkExce["Pokemon Tower B10_A"] = {
    ["Pokemon Tower B9_A"] = {18, 21},
    ["Pokemon Tower B9_B"] = {23, 17}
}
linkExce["Pokemon Tower B9_B"] = {
    ["Pokemon Tower B10_A"] = {23, 17},
    ["Pokemon Tower B10_B"] = {24, 21}
}
linkExce["Pokemon Tower B17_A"] = {
    ["Pokemon Tower B17_B"] = {20, 19}
}
linkExce["Pokemon Tower B18"] = {
    ["Pokemon Tower B19_A"] = {18, 17},
    ["Pokemon Tower B19_B"] = {23, 22},
    ["Pokemon Tower B19_C"] = {23, 17}
}
linkExce["Pokemon Tower B19_B"] = {
    ["Pokemon Tower B20_A"] = {18, 20},
    ["Pokemon Tower B20_B"] = {18, 22}
}
linkExce["Seafoam B1F"] = {
    ["Seafoam 1F_A"] = {85, 22}, -- to cinnabar
    ["Seafoam 1F_B"] = {15, 12}, -- to route 19
    ["Seafoam B2F_A"] = {26, 22}, -- bottom left
    ["Seafoam B2F_B"] = {36, 21}, -- middle left
    ["Seafoam B2F_D"] = {64, 25} -- middle right
}
linkExce["Seafoam B2F_C"] = {
    ["Seafoam B3F_C"] = {63, 27}, -- towards B4F double stairs
    ["Seafoam B3F_D"] = {35, 18} -- to upper middle B3F
}
linkExce["Seafoam B3F_E"] = {
    ["Seafoam B4F_D"] = {57, 26}, -- to nurse platform
    ["Seafoam B4F_C"] = {20, 25}, -- B4F middle path
    ["Seafoam B4F_B"] = {49, 7} -- dead end
}
linkExce["Seafoam B4F_A"] = {
    ["Seafoam B3F_B"] = {9, 6}, -- to B3F left side
    ["Seafoam B3F_C"] = {63, 27} -- to B2F isolated
}
linkExce["Seafoam B4F_C"] = {
    ["Seafoam B3F_D"] = {38, 16}, -- B3F upper part
    ["Seafoam B3F_E"] = {19, 23} -- main cave
}
linkExce["Bike Road Stop"] = {
    ["Route 18_A"] = {0, 6}, -- bike road
    ["Route 18_B"] = {10, 6} -- to fuchsia
}
linkExce["Route 16 Stop House"] = {
    ["Route 16_A"] = {0, 6}, -- bike road
    ["Route 16_B"] = {20, 6} -- to celadon
}
linkExce["Player House Pallet"] = {
    ["Pallet Town"] = {4, 10} -- to pallet
}
linkExce["Victory Road Kanto 2F_A"] = {
    ["Victory Road Kanto 3F_A"] = {14, 9}, -- to kanto league
    ["Victory Road Kanto 3F_D"] = {57, 25} -- deeper in caves
}
linkExce["Victory Road Kanto 2F_D"] = {
    ["Victory Road Kanto 3F_C"] = {62, 11} -- to isolated areas
}
linkExce["Victory Road Kanto 3F_B"] = {
    ["Victory Road Kanto 2F_C"] = {34, 37}, -- to enclosed stair zone
    ["Victory Road Kanto 2F_A"] = {29, 17} -- main path
}
linkExce["Victory Road Kanto 3F_C"] = {
    ["Victory Road Kanto 2F_B"] = {35, 33}, -- to brother npc zone
    ["Victory Road Kanto 2F_C"] = {38, 37}, -- to enclosed stair zone
    ["Victory Road Kanto 2F_D"] = {62, 24} -- back
}
linkExce["Victory Road Kanto 3F_D"] = {
    ["Victory Road Kanto 2F_A"] = {56, 32}, -- main path
    ["Victory Road Kanto 2F_D"] = {61, 35} -- right path
}
linkExce["Mt. Silver Exterior"] = {
    ["Route 28_A"] = {35, 19}, -- main
    ["Route 28_B"] = {35, 11}
}
linkExce["Mt. Silver Lower Mountainside"] = {
    ["Mt. Silver 1F_A"] = {22, 34},
    ["Mt. Silver 1F_B"] = {18, 28},
    ["Mt. Silver 1F_E"] = {14, 12},
}
linkExce["Mt. Silver 2F_C"] = {
    ["Mt. Silver Upper Mountainside_A"] = {51, 32},
    ["Mt. Silver Upper Mountainside_B"] = {51, 45},
}
linkExce["Mt. Silver Upper Mountainside_A"] = {
    ["Mt. Silver 2F_A"] = {22, 25},
    ["Mt. Silver 2F_B"] = {39, 30},
    ["Mt. Silver 2F_C"] = {39, 43},
}
linkExce["Mt. Silver Upper Mountainside_B"] = {
    ["Mt. Silver 2F_C"] = {39, 56},
    ["Mt. Silver 2F_D"] = {34, 61},
}
linkExce["Route 28_B"] = {
    ["Route 28 House"] = {19, 11},
}
linkExce["Route 27_B"] = {
    ["Route 26_A"] = {217, 23}, -- always go to the main road
}
linkExce["Cinnabar mansion 2"] = {
    ["Cinnabar mansion 3_A"] = {9, 19},
    ["Cinnabar mansion 3_B"] = {9, 4},
}
linkExce["Cinnabar mansion 3_B"] = {
    ["Cinnabar mansion B1F_A"] = {21, 19},
}

----------------------
------ JOHTO ---------
----------------------

linkExce["Route 42_E"] = {
    ["Route 42_D"] = {90, 9},
}
linkExce["Mt. Mortar Lower Cave"] = {
    ["Mt. Mortar 1F_A"] = {26, 57},
    ["Mt. Mortar 1F_C"] = {47, 57},
    ["Mt. Mortar 1F_D"] = {65, 58},
    ["Mt. Mortar 1F_F"] = {17, 45},
    ["Mt. Mortar 1F_G"] = {56, 46},
}
linkExce["Route 43"] = {
    ["Lake of Rage_A"] = {22, 0}, -- main lake
    ["Lake of Rage_B"] = {7, 0}, -- left of lake
}
linkExce["Ice Path B3F"] = {
    ["Ice Path B2F_A"] = {13, 16}, -- to route 44
    ["Ice Path B2F_B"] = {32, 17}, -- to blackthorn
}
linkExce["Route 30"] = {
    ["Cherrygrove City_A"] = {9, 96}, -- to main city
    ["Cherrygrove City_B"] = {25, 96}, -- to isolated water
}
linkExce["Union Cave 1F_C"] = {
    ["Union Cave B1F_A"] = {19, 31},
}
linkExce["Union Cave 1F_D"] = {
    ["Union Cave B1F_C"] = {23, 82},
}
linkExce["Union Cave B1F_B"] = {
    ["Union Cave B2F_A"] = {16, 24},
    ["Union Cave B2F_B"] = {16, 16},
}
linkExce["Whirl Islands 1F NorthEast_B"] = {
    ["Whirl Islands B1F_A"] = {24, 18},
    ["Whirl Islands B1F_C"] = {27, 12},
}
linkExce["Whirl Islands B2F"] = {
    ["Whirl Islands B1F_A"] = {19, 25},
    ["Whirl Islands B1F_C"] = {24, 13},
}
linkExce["Sprout Tower F1_B"] = {
    ["Sprout Tower F2_A"] = {24, 3},
    ["Sprout Tower F2_B"] = {2, 11},
}
linkExce["Sprout Tower F2_A"] = {
    ["Sprout Tower F1_A"] = {9, 9},
    ["Sprout Tower F1_B"] = {23, 4},
}
linkExce["Bell Tower Floor 4_A"] = {
    ["Bell Tower Floor 3"] = {20, 6},
    ["Bell Tower Floor 4_B"] = {20, 14},
    ["Bell Tower Floor 5_A"] = {2, 6},
}
linkExce["Bell Tower Floor 4_B"] = {
    ["Bell Tower Floor 5_D"] = {20, 20},
    ["Bell Tower Floor 4_C"] = {11, 16},
}
linkExce["Bell Tower Floor 4_C"] = {
    ["Bell Tower Floor 5_B"] = {2, 20},
    ["Bell Tower Floor 4_A"] = {6, 14},
}
linkExce["Bell Tower Floor 5_A"] = {
    ["Bell Tower Floor 4_A"] = {2, 6},
    ["Bell Tower Floor 5_C"] = {5, 8},
    ["Bell Tower Floor 5_E"] = {17, 8},
}
linkExce["Bell Tower Floor 5_B"] = {
    ["Bell Tower Floor 4_C"] = {2, 20},
}
linkExce["Bell Tower Floor 5_C"] = {
    ["Bell Tower Floor 5_E"] = {9, 10},
    ["Bell Tower Floor 5_F"] = {5, 10},
}
linkExce["Bell Tower Floor 5_D"] = {
    ["Bell Tower Floor 4_B"] = {20, 20},
}
linkExce["Bell Tower Floor 5_E"] = {
    ["Bell Tower Floor 5_D"] = {16, 15},
}
linkExce["Bell Tower Floor 5_F"] = {
    ["Bell Tower Floor 5_B"] = {4, 17},
    ["Bell Tower Floor 5_G"] = {6, 17},
    ["Bell Tower Floor 5_E"] = {7, 15},
}
linkExce["Bell Tower Floor 5_G"] = {
    ["Bell Tower Floor 5_B"] = {4, 21},
}
linkExce["Bell Tower Floor 7_A"] = {
    ["Bell Tower Floor 8_A"] = {11, 22},
    ["Bell Tower Floor 7_B"] = {5, 7},
}
linkExce["Bell Tower Floor 7_B"] = {
    ["Bell Tower Floor 8_C"] = {8, 13},
    ["Bell Tower Floor 7_A"] = {14, 13},
}
linkExce["Bell Tower Floor 8_A"] = {
    ["Bell Tower Floor 7_A"] = {4, 9},
    ["Bell Tower Floor 9_A"] = {3, 17},
    ["Bell Tower Floor 9_C"] = {20, 20},
}
linkExce["Bell Tower Floor 8_B"] = {
    ["Bell Tower Floor 9_A"] = {19, 14},
    ["Bell Tower Floor 9_B"] = {13, 6},
}
linkExce["Bell Tower Floor 8_C"] = {
    ["Bell Tower Floor 7_B"] = {8, 14},
}
linkExce["Bell Tower Floor 9_A"] = {
    ["Bell Tower Floor 8_A"] = {16, 5},
    ["Bell Tower Floor 8_B"] = {2, 10},
}
linkExce["Bell Tower Floor 9_B"] = {
    ["Bell Tower Floor 10"] = {8, 14},
    ["Bell Tower Floor 8_B"] = {14, 12},
}
linkExce["Bell Tower Floor 9_C"] = {
    ["Bell Tower Floor 8_A"] = {21, 13},
}
linkExce["Bell Tower Floor 10"] = {
    ["Bell Tower Floor 9_B"] = {7, 14},
}

----------------------
------ HOENN ---------
----------------------

linkExce["Route 124_A"] = {
    ["Route 124 Underwater_A"] = {28, 43},
    ["Route 124 Underwater_B"] = {41, 36},
    ["Route 124 Underwater_D"] = {73, 27},
    ["Route 124 Underwater_E"] = {61, 46},
}
linkExce["Route 124_B"] = {
    ["Route 124 Underwater_C"] = {12, 8},
    ["Route 124 Underwater_D"] = {71, 8},
}
linkExce["Route 124 Underwater_A"] = {
    ["Route 124_A"] = {29, 52},
    ["Route 124_C"] = {14, 54},
    ["Route 124_D"] = {36, 67},
}
linkExce["Route 124 Underwater_D"] = {
    ["Route 124_A"] = {52, 17},
    ["Route 124_B"] = {52, 8},
}
linkExce["Route 126_A"] = {
    ["Route 126 Underwater_A"] = {15, 71}, -- to main underwater
    ["Route 126 Underwater_B"] = {20, 105}, -- to isolated bottom 
}
linkExce["Route 126_C"] = {
    ["Route 126 Underwater_A"] = {46, 31}, -- to main underwater
    ["Route 126 Underwater_C"] = {66, 8}, -- to top left side
}
linkExce["Route 126 Underwater_A"] = {
    ["Route 126_A"] = {15, 71},
    ["Route 126_C"] = {46, 31},
}
linkExce["Route 126 Underwater_B"] = {
    ["Route 126_A"] = {20, 105},
    ["Route 126_B"] = {11, 114},
}
linkExce["Route 126 Underwater_C"] = {
    ["Route 126_C"] = {66, 8},
    ["Route 126_D"] = {15, 14},
}
linkExce["Route 127_A"] = {
    ["Route 127 Underwater_A"] = {37, 25}, -- to main road
    ["Route 127 Underwater_B"] = {96, 72}, -- to isolated island
}
linkExce["Route 127 Underwater_B"] = {
    ["Route 127_A"] = {83, 60}, -- to main road
    ["Route 127_B"] = {90, 54}, -- to isolated island
}
linkExce["Route 128"] = {
    ["Route 128 Underwater_B"] = {31, 19}, -- to middle isolated
    ["Route 128 Underwater_C"] = {70, 27}, -- to right side dive
}
linkExce["Route 129_A"] = {
    ["Route 129 Underwater"] = {127, 23}, -- missing link in pro
}
linkExce["Route 129_B"] = {
    ["Route 129 Underwater"] = {82, 43}, -- missing link in pro
}
linkExce["Route 130_A"] = {
    ["Route 130 Underwater_B"] = {75, 10}, -- missing link in pro
}
linkExce["Route 130_B"] = {
    ["Route 130 Underwater_A"] = {15, 6}, -- missing link in pro
}
linkExce["Route 129 Underwater"] = {
    ["Route 129_A"] = {56, 16}, -- to main path
    ["Route 129_B"] = {38, 32}, -- to isolated part
}
linkExce["Sootopolis City Underwater"] = {
    ["Sootopolis City"] = {17, 11}, -- link is missing in pro
}
linkExce["Sootopolis City"] = {
    ["Sootopolis City Underwater"] = {50, 91}, -- link is missing in pro
}
linkExce["Victory Road Hoenn 1F_A"] = {
    ["Ever Grande City_A"] = {21, 55},
}
linkExce["Victory Road Hoenn B1F_A"] = {
    ["Victory Road Hoenn 1F_A"] = {13, 4},
    ["Victory Road Hoenn 1F_B"] = {46, 7},
    ["Victory Road Hoenn 1F_C"] = {53, 35},
}
linkExce["Victory Road Hoenn B2F_A"] = {
    ["Victory Road Hoenn B1F_A"] = {29, 41},
    ["Victory Road Hoenn B1F_D"] = {56, 3},
}
linkExce["Victory Road Hoenn B2F_E"] = {
    ["Victory Road Hoenn B1F_B"] = {26, 14},
}
linkExce["Sky Pillar Entrance Cave 1F"] = {
    ["Sky Pillar Entrance_A"] = {7, 17},
    ["Sky Pillar Entrance_B"] = {17, 6},
}
linkExce["Cycle Road Stop House 1"] = {
    ["Route 110_B"] = {3, 11}, -- to route 110 left
    ["Route 110_D"] = {12, 11}, -- to bike road
}
linkExce["Cycle Road Stop House 2"] = {
    ["Route 110_A"] = {3, 11}, -- to route 110 left
    ["Route 110_D"] = {12, 11}, -- to bike road
}
linkExce["Fiery Path"] = {
    ["Route 112_A"] = {38, 8}, -- to top exit
    ["Route 112_B"] = {36, 48}, -- to bottom exit
}
linkExce["Route 115_A"] = {
    ["Meteor falls 1F 1R_C"] = {74, 73},
}
linkExce["Route 115_D"] = {
    ["Meteor falls 1F 1R_C"] = {58, 30},
}
linkExce["Meteor falls 1F 1R_X"] = { -- tmp fix for proshine cascade pathfind
    ["Meteor falls 1F 1R_A"] = {21, 25},
}
linkExce["Meteor falls B1F 1R_A"] = {
    ["Meteor Falls 1F 2R_A"] = {6, 8},
    ["Meteor Falls 1F 2R_B"] = {22, 21},
}
linkExce["Meteor Falls 1F 2R_B"] = {
    ["Meteor falls B1F 1R_A"] = {33, 41},
    ["Meteor falls B1F 1R_B"] = {11, 35},
}
linkExce["Rusturf Tunnel_A"] = {
    ["Route 116_A"] = {11, 19},
}
linkExce["Rusturf Tunnel_B"] = {
    ["Route 116_B"] = {24, 32},
}
linkExce["Route 104_A"] = {
    ["Rustboro City_A"] = {41, 0},
    ["Rustboro City_B"] = {58, 0},
}
linkExce["Petalburg Woods_A"] = {
    ["Route 104_A"] = {21, 0},
    ["Route 104_B"] = {24, 60},
    ["Route 104_C"] = {51, 60},
}
linkExce["Hoenn Safari Zone Area 1"] = {
    ["Hoenn Safari Zone Area 2_A"] = {0, 42},
    ["Hoenn Safari Zone Area 2_B"] = {0, 22},
}
linkExce["Hoenn Safari Zone Area 3"] = {
    ["Hoenn Safari Zone Area 2_C"] = {28, 50},
    ["Hoenn Safari Zone Area 2_D"] = {17, 50},
}

----------------------
---- INTER MAP -------
----------------------

linkExce["Vermilion City_A"] = {
    ["Lilycove City Harbor"] = {40, 67},
}
-- linkExce[""] = {
--     [""] = {},
-- }

return linkExce