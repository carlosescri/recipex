defmodule Recipex.Chars do
  @moduledoc false

  # Unicode Category: Zs
  @space_separator [
    0x0020,
    0x00A0,
    0x1680,
    0x2000..0x200A,
    0x202F,
    0x205F,
    0x3000
  ]

  # Unicode Category: Pc
  @connector_punctuation [
    0x005F,
    0x203F,
    0x2040,
    0x2054,
    0xFE33,
    0xFE34,
    0xFE4D,
    0xFE4E,
    0xFE4F,
    0xFF3F
  ]

  # Unicode Category: Pd
  @dash_punctuation [
    0x002D,
    0x058A,
    0x05BE,
    0x1400,
    0x1806,
    0x2010,
    0x2011,
    0x2012,
    0x2013,
    0x2014,
    0x2015,
    0x2E17,
    0x2E1A,
    0x2E3A,
    0x2E3B,
    0x2E40,
    0x301C,
    0x3030,
    0x30A0,
    0xFE31,
    0xFE32,
    0xFE58,
    0xFE63,
    0xFF0D,
    0x10EAD
  ]

  # Unicode Category: Pe
  @close_punctuation [
    0x0029,
    0x005D,
    0x007D,
    0x0F3B,
    0x0F3D,
    0x169C,
    0x2046,
    0x207E,
    0x208E,
    0x2309,
    0x230B,
    0x232A,
    0x2769,
    0x276B,
    0x276D,
    0x276F,
    0x2771,
    0x2773,
    0x2775,
    0x27C6,
    0x27E7,
    0x27E9,
    0x27EB,
    0x27ED,
    0x27EF,
    0x2984,
    0x2986,
    0x2988,
    0x298A,
    0x298C,
    0x298E,
    0x2990,
    0x2992,
    0x2994,
    0x2996,
    0x2998,
    0x29D9,
    0x29DB,
    0x29FD,
    0x2E23,
    0x2E25,
    0x2E27,
    0x2E29,
    0x3009,
    0x300B,
    0x300D,
    0x300F,
    0x3011,
    0x3015,
    0x3017,
    0x3019,
    0x301B,
    0x301E,
    0x301F,
    0xFD3E,
    0xFE18,
    0xFE36,
    0xFE38,
    0xFE3A,
    0xFE3C,
    0xFE3E,
    0xFE40,
    0xFE42,
    0xFE44,
    0xFE48,
    0xFE5A,
    0xFE5C,
    0xFE5E,
    0xFF09,
    0xFF3D,
    0xFF5D,
    0xFF60,
    0xFF63
  ]

  # Unicode Category: Pf
  @final_punctuation [
    0x00BB,
    0x2019,
    0x201D,
    0x203A,
    0x2E03,
    0x2E05,
    0x2E0A,
    0x2E0D,
    0x2E1D,
    0x2E21
  ]

  # Unicode Category: Pi
  @initial_punctuation [
    0x00AB,
    0x2018,
    0x201B,
    0x201C,
    0x201F,
    0x2039,
    0x2E02,
    0x2E04,
    0x2E09,
    0x2E0C,
    0x2E1C,
    0x2E20
  ]

  # Unicode Category: Po
  @other_punctuation [
    0x0021,
    0x0022,
    0x0023,
    0x0025,
    0x0026,
    0x0027,
    0x002A,
    0x002C,
    0x002E,
    0x002F,
    0x003A,
    0x003B,
    0x003F,
    0x0040,
    0x005C,
    0x00A1,
    0x00A7,
    0x00B6,
    0x00B7,
    0x00BF,
    0x037E,
    0x0387,
    0x055A,
    0x055B,
    0x055C,
    0x055D,
    0x055E,
    0x055F,
    0x0589,
    0x05C0,
    0x05C3,
    0x05C6,
    0x05F3,
    0x05F4,
    0x0609,
    0x060A,
    0x060C,
    0x060D,
    0x061B,
    0x061E,
    0x061F,
    0x066A,
    0x066B,
    0x066C,
    0x066D,
    0x06D4,
    0x0700,
    0x0701,
    0x0702,
    0x0703,
    0x0704,
    0x0705,
    0x0706,
    0x0707,
    0x0708,
    0x0709,
    0x070A,
    0x070B,
    0x070C,
    0x070D,
    0x07F7,
    0x07F8,
    0x07F9,
    0x0830,
    0x0831,
    0x0832,
    0x0833,
    0x0834,
    0x0835,
    0x0836,
    0x0837,
    0x0838,
    0x0839,
    0x083A,
    0x083B,
    0x083C,
    0x083D,
    0x083E,
    0x085E,
    0x0964,
    0x0965,
    0x0970,
    0x09FD,
    0x0A76,
    0x0AF0,
    0x0C77,
    0x0C84,
    0x0DF4,
    0x0E4F,
    0x0E5A,
    0x0E5B,
    0x0F04,
    0x0F05,
    0x0F06,
    0x0F07,
    0x0F08,
    0x0F09,
    0x0F0A,
    0x0F0B,
    0x0F0C,
    0x0F0D,
    0x0F0E,
    0x0F0F,
    0x0F10,
    0x0F11,
    0x0F12,
    0x0F14,
    0x0F85,
    0x0FD0,
    0x0FD1,
    0x0FD2,
    0x0FD3,
    0x0FD4,
    0x0FD9,
    0x0FDA,
    0x104A,
    0x104B,
    0x104C,
    0x104D,
    0x104E,
    0x104F,
    0x10FB,
    0x1360,
    0x1361,
    0x1362,
    0x1363,
    0x1364,
    0x1365,
    0x1366,
    0x1367,
    0x1368,
    0x166E,
    0x16EB,
    0x16EC,
    0x16ED,
    0x1735,
    0x1736,
    0x17D4,
    0x17D5,
    0x17D6,
    0x17D8,
    0x17D9,
    0x17DA,
    0x1800,
    0x1801,
    0x1802,
    0x1803,
    0x1804,
    0x1805,
    0x1807,
    0x1808,
    0x1809,
    0x180A,
    0x1944,
    0x1945,
    0x1A1E,
    0x1A1F,
    0x1AA0,
    0x1AA1,
    0x1AA2,
    0x1AA3,
    0x1AA4,
    0x1AA5,
    0x1AA6,
    0x1AA8,
    0x1AA9,
    0x1AAA,
    0x1AAB,
    0x1AAC,
    0x1AAD,
    0x1B5A,
    0x1B5B,
    0x1B5C,
    0x1B5D,
    0x1B5E,
    0x1B5F,
    0x1B60,
    0x1BFC,
    0x1BFD,
    0x1BFE,
    0x1BFF,
    0x1C3B,
    0x1C3C,
    0x1C3D,
    0x1C3E,
    0x1C3F,
    0x1C7E,
    0x1C7F,
    0x1CC0,
    0x1CC1,
    0x1CC2,
    0x1CC3,
    0x1CC4,
    0x1CC5,
    0x1CC6,
    0x1CC7,
    0x1CD3,
    0x2016,
    0x2017,
    0x2020,
    0x2021,
    0x2022,
    0x2023,
    0x2024,
    0x2025,
    0x2026,
    0x2027,
    0x2030,
    0x2031,
    0x2032,
    0x2033,
    0x2034,
    0x2035,
    0x2036,
    0x2037,
    0x2038,
    0x203B,
    0x203C,
    0x203D,
    0x203E,
    0x2041,
    0x2042,
    0x2043,
    0x2047,
    0x2048,
    0x2049,
    0x204A,
    0x204B,
    0x204C,
    0x204D,
    0x204E,
    0x204F,
    0x2050,
    0x2051,
    0x2053,
    0x2055,
    0x2056,
    0x2057,
    0x2058,
    0x2059,
    0x205A,
    0x205B,
    0x205C,
    0x205D,
    0x205E,
    0x2CF9,
    0x2CFA,
    0x2CFB,
    0x2CFC,
    0x2CFE,
    0x2CFF,
    0x2D70,
    0x2E00,
    0x2E01,
    0x2E06,
    0x2E07,
    0x2E08,
    0x2E0B,
    0x2E0E,
    0x2E0F,
    0x2E10,
    0x2E11,
    0x2E12,
    0x2E13,
    0x2E14,
    0x2E15,
    0x2E16,
    0x2E18,
    0x2E19,
    0x2E1B,
    0x2E1E,
    0x2E1F,
    0x2E2A,
    0x2E2B,
    0x2E2C,
    0x2E2D,
    0x2E2E,
    0x2E30,
    0x2E31,
    0x2E32,
    0x2E33,
    0x2E34,
    0x2E35,
    0x2E36,
    0x2E37,
    0x2E38,
    0x2E39,
    0x2E3C,
    0x2E3D,
    0x2E3E,
    0x2E3F,
    0x2E41,
    0x2E43,
    0x2E44,
    0x2E45,
    0x2E46,
    0x2E47,
    0x2E48,
    0x2E49,
    0x2E4A,
    0x2E4B,
    0x2E4C,
    0x2E4D,
    0x2E4E,
    0x2E4F,
    0x2E52,
    0x3001,
    0x3002,
    0x3003,
    0x303D,
    0x30FB,
    0xA4FE,
    0xA4FF,
    0xA60D,
    0xA60E,
    0xA60F,
    0xA673,
    0xA67E,
    0xA6F2,
    0xA6F3,
    0xA6F4,
    0xA6F5,
    0xA6F6,
    0xA6F7,
    0xA874,
    0xA875,
    0xA876,
    0xA877,
    0xA8CE,
    0xA8CF,
    0xA8F8,
    0xA8F9,
    0xA8FA,
    0xA8FC,
    0xA92E,
    0xA92F,
    0xA95F,
    0xA9C1,
    0xA9C2,
    0xA9C3,
    0xA9C4,
    0xA9C5,
    0xA9C6,
    0xA9C7,
    0xA9C8,
    0xA9C9,
    0xA9CA,
    0xA9CB,
    0xA9CC,
    0xA9CD,
    0xA9DE,
    0xA9DF,
    0xAA5C,
    0xAA5D,
    0xAA5E,
    0xAA5F,
    0xAADE,
    0xAADF,
    0xAAF0,
    0xAAF1,
    0xABEB,
    0xFE10,
    0xFE11,
    0xFE12,
    0xFE13,
    0xFE14,
    0xFE15,
    0xFE16,
    0xFE19,
    0xFE30,
    0xFE45,
    0xFE46,
    0xFE49,
    0xFE4A,
    0xFE4B,
    0xFE4C,
    0xFE50,
    0xFE51,
    0xFE52,
    0xFE54,
    0xFE55,
    0xFE56,
    0xFE57,
    0xFE5F,
    0xFE60,
    0xFE61,
    0xFE68,
    0xFE6A,
    0xFE6B,
    0xFF01,
    0xFF02,
    0xFF03,
    0xFF05,
    0xFF06,
    0xFF07,
    0xFF0A,
    0xFF0C,
    0xFF0E,
    0xFF0F,
    0xFF1A,
    0xFF1B,
    0xFF1F,
    0xFF20,
    0xFF3C,
    0xFF61,
    0xFF64,
    0xFF65,
    0x10100,
    0x10101,
    0x10102,
    0x1039F,
    0x103D0,
    0x1056F,
    0x10857,
    0x1091F,
    0x1093F,
    0x10A50,
    0x10A51,
    0x10A52,
    0x10A53,
    0x10A54,
    0x10A55,
    0x10A56,
    0x10A57,
    0x10A58,
    0x10A7F,
    0x10AF0,
    0x10AF1,
    0x10AF2,
    0x10AF3,
    0x10AF4,
    0x10AF5,
    0x10AF6,
    0x10B39,
    0x10B3A,
    0x10B3B,
    0x10B3C,
    0x10B3D,
    0x10B3E,
    0x10B3F,
    0x10B99,
    0x10B9A,
    0x10B9B,
    0x10B9C,
    0x10F55,
    0x10F56,
    0x10F57,
    0x10F58,
    0x10F59,
    0x11047,
    0x11048,
    0x11049,
    0x1104A,
    0x1104B,
    0x1104C,
    0x1104D,
    0x110BB,
    0x110BC,
    0x110BE,
    0x110BF,
    0x110C0,
    0x110C1,
    0x11140,
    0x11141,
    0x11142,
    0x11143,
    0x11174,
    0x11175,
    0x111C5,
    0x111C6,
    0x111C7,
    0x111C8,
    0x111CD,
    0x111DB,
    0x111DD,
    0x111DE,
    0x111DF,
    0x11238,
    0x11239,
    0x1123A,
    0x1123B,
    0x1123C,
    0x1123D,
    0x112A9,
    0x1144B,
    0x1144C,
    0x1144D,
    0x1144E,
    0x1144F,
    0x1145A,
    0x1145B,
    0x1145D,
    0x114C6,
    0x115C1,
    0x115C2,
    0x115C3,
    0x115C4,
    0x115C5,
    0x115C6,
    0x115C7,
    0x115C8,
    0x115C9,
    0x115CA,
    0x115CB,
    0x115CC,
    0x115CD,
    0x115CE,
    0x115CF,
    0x115D0,
    0x115D1,
    0x115D2,
    0x115D3,
    0x115D4,
    0x115D5,
    0x115D6,
    0x115D7,
    0x11641,
    0x11642,
    0x11643,
    0x11660,
    0x11661,
    0x11662,
    0x11663,
    0x11664,
    0x11665,
    0x11666,
    0x11667,
    0x11668,
    0x11669,
    0x1166A,
    0x1166B,
    0x1166C,
    0x1173C,
    0x1173D,
    0x1173E,
    0x1183B,
    0x11944,
    0x11945,
    0x11946,
    0x119E2,
    0x11A3F,
    0x11A40,
    0x11A41,
    0x11A42,
    0x11A43,
    0x11A44,
    0x11A45,
    0x11A46,
    0x11A9A,
    0x11A9B,
    0x11A9C,
    0x11A9E,
    0x11A9F,
    0x11AA0,
    0x11AA1,
    0x11AA2,
    0x11C41,
    0x11C42,
    0x11C43,
    0x11C44,
    0x11C45,
    0x11C70,
    0x11C71,
    0x11EF7,
    0x11EF8,
    0x11FFF,
    0x12470,
    0x12471,
    0x12472,
    0x12473,
    0x12474,
    0x16A6E,
    0x16A6F,
    0x16AF5,
    0x16B37,
    0x16B38,
    0x16B39,
    0x16B3A,
    0x16B3B,
    0x16B44,
    0x16E97,
    0x16E98,
    0x16E99,
    0x16E9A,
    0x16FE2,
    0x1BC9F,
    0x1DA87,
    0x1DA88,
    0x1DA89,
    0x1DA8A,
    0x1DA8B,
    0x1E95E,
    0x1E95F
  ]

  # Unicode Category: Ps
  @open_punctuation [
    0x0028,
    0x005B,
    0x007B,
    0x0F3A,
    0x0F3C,
    0x169B,
    0x201A,
    0x201E,
    0x2045,
    0x207D,
    0x208D,
    0x2308,
    0x230A,
    0x2329,
    0x2768,
    0x276A,
    0x276C,
    0x276E,
    0x2770,
    0x2772,
    0x2774,
    0x27C5,
    0x27E6,
    0x27E8,
    0x27EA,
    0x27EC,
    0x27EE,
    0x2983,
    0x2985,
    0x2987,
    0x2989,
    0x298B,
    0x298D,
    0x298F,
    0x2991,
    0x2993,
    0x2995,
    0x2997,
    0x29D8,
    0x29DA,
    0x29FC,
    0x2E22,
    0x2E24,
    0x2E26,
    0x2E28,
    0x2E42,
    0x3008,
    0x300A,
    0x300C,
    0x300E,
    0x3010,
    0x3014,
    0x3016,
    0x3018,
    0x301A,
    0x301D,
    0xFD3F,
    0xFE17,
    0xFE35,
    0xFE37,
    0xFE39,
    0xFE3B,
    0xFE3D,
    0xFE3F,
    0xFE41,
    0xFE43,
    0xFE47,
    0xFE59,
    0xFE5B,
    0xFE5D,
    0xFF08,
    0xFF3B,
    0xFF5B,
    0xFF5F,
    0xFF62
  ]

  # Unicode Category: CC (partially), Zl, Zp
  @line_separator [
    0x000A..0x000D,
    0x0085,
    0x2028,
    0x2029
  ]

  @doc false
  def punctuation(),
    do:
      @close_punctuation ++
        @connector_punctuation ++
        @dash_punctuation ++
        @final_punctuation ++
        @initial_punctuation ++
        @open_punctuation ++
        @other_punctuation

  @doc false
  def whitespace(), do: @space_separator

  @doc false
  def newline(), do: @line_separator
end
