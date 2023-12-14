#Requires AutoHotkey v2.0


Items := 
{
    SuspiciousInvite: 
    {
        name: "Suspicious Invite",
        coolDownMs: 3500, ; placeholder
        hasFunc: false
    },
    MysteriousArtifact: 
    {
        name: "Mysterious Artifact",
        coolDownMs: 3500, ; placeholder
        hasFunc: false
    },
    AncientTotem: 
    {
        name: "Ancient Totem",
        coolDownMs: 5000, ; 15000
        durationMs: 21474836471,
        m1cancels: true,
        hasFunc: false
    },
    UnknownSignalEmitter: 
    {
        name: "Unknown Signal Emitter",
        coolDownMs: 5000, ; 30000
        durationMs: 21474836471,
        m1cancels: false,
        hasFunc: false
    },
    UnluckyYarnball:
    {
        name: "Unlucky Yarnball",
        cooldownMs: 3500, ; placeholder
        hasFunc: false
    },
    SynodicTransfigurator: 
    {
        name: "Synodic Transfigurator",
        coolDownMs: 14000,
        durationMs: 22000,
        m1cancels: false,
        hasFunc: false
    },
    KnightSword: 
    {
        name: "Knight Sword",
        coolDownMs: 1000,
        coolDown2Ms: 7000,
        m1cancels: false,
        hasFunc: false
    },
    SeraphimRing:
    {
        name: "Seraphim Ring",
        coolDownMs: 5000, ; 30000
        hasFunc: false
    },
    HolyEruption: 
    {
        name: "Knight Sword",
        coolDownMs: 1000,
        coolDown2Ms: 7000,
        m1cancels: false,
        hasFunc: false
    },
    SlimeStaff: 
    {
        name: "Slime Staff",
        coolDownMs: 1000,
        durationMs: 25000,
        m1cancels: false,
        hasFunc: false
    },
    StarfallBlade: 
    {
        name: "Starfall Blade",
        coolDownMs: 1000,
        durationMs: 25000,
        m1cancels: false,
        hasFunc: false
    },
    AngelicCross: 
    {
        name: "Angelic Cross",
        coolDownMs: 3500,
        durationMs: 30000,
        m1cancels: false,
        hasFunc: false
        
    },
    DuraniteTurretMK2: 
    {
        name:"Duranite Turret MK2",
        coolDownMs: 3000,
        durationMs: 12000,
        m1cancels: false,
        hasFunc: false
    },
    PocketSun: 
    {
        name: "Pocket Sun",
        coolDownMs: 2000,
        durationMs: 21474836471,
        m1cancels: false,
        hasFunc: false
    },
    PureCross: 
    {
        name: "Pure Cross",
        coolDownMs: 3500,
        durationMs: 30000,
        m1cancels: false,
        hasFunc: false
    },
    CivilWar:
    {
        name: "Civil War",
        coolDownMs: 3500, ; placeholder
        hasFunc: false
    },
    MagiaWand:
    {
        name: "Magia Wand",
        coolDownMs: 3500, ; placeholder
        hasFunc: false
    },
    ThePitch:
    {
        name: "The Pitch",
        coolDownMs: 3500, ; placeholder
        hasFunc: false
    },
    PhantomReminder:
    {
        name: "Phantom Reminder",
        coolDownMs: 3500, ; placeholder
        hasFunc: false
    },
    PickaxeOfBalance: {
        name: "Pickaxe of Balance",
        coolDownMs: 300,
        durationMs: 21474836471,
        m1cancels: false,
        hasFunc: false
    },
    EquinoxBallista: {
        name: "Equinox Ballista",
        coolDownMs: 2000,
        expires: false,
        durationMs: 21474836471,
        m1cancels: true,
        hasFunc: true
    }
}

Funcs := {}

EquinoxBallista(key, clickPosArray) { ; What the hell am I doing?
    static coolDown := False
    static counter := 0
    if coolDown = False and toggle = true {
        Loop 6 {
            if toggle = true {
                SafeSend(key, WINDOW_CLASS)
                SafeClick(Random(clickPosArray[1] + 10, clickPosArray[1] - 10), Random(clickPosArray[2] + 10, clickPosArray[2] - 10), WINDOW_CLASS)
                SafeSend(key, WINDOW_CLASS)
                SafeClick(Random(clickPosArray[1] + 10, clickPosArray[1] - 10), Random(clickPosArray[2] + 10, clickPosArray[2] - 10), WINDOW_CLASS)
                Delay(Items.EquinoxBallista.coolDownMs)
            }
        }
        coolDown := true
        SetTimer CooldownFalse, 30000
        CooldownFalse() {
            coolDown := false
        }
    } else {
        return 0
    }
} 


/*
 * Luckily, the OCR CONSISTENTLY (somewhat) reads out the WRONG ANSWER!, so I only need to input one.
 * That's hot.
 * I could probably do something with Levenstein Distance or Dice Coefficient but I'm uncertain about
 * the effectiveness and false positives, I might make it an option in the future, once I have 100
 * different variants of Popsicle in the code.
 */
Biomes := 
{
    Grasslands: { ; This should not be merged.
        tips: "The world has returned to normal.",
        tips2: "The world has returned to normal?",
        items: [
            "The Ripper",
                "Shadow Fragment",
                "Ripper Claws",
                "Ripper",
            "The Paladin",
                "Your actions created chaos and destruction!",
                "chaos and destruction"
                "You are under arrest! Do not resist!",
                "under arrest",
                "Do not resist",
                "I will not fall just yet.",
                "I will not fall just yet",
                "The light will stop you...",
                "The light will stop you",
            "The Controller",
                "Controller",
                "Controlier",
                "Controiler",
                "Synodic Alloy",
                "Synodic Energy Core",
                "Synodic Transfigurator"
        ]
    },
    Night: {
        tips: "The moon is rising!",
        items: [
            "The moon is rising!",
                "The moon is",
            "Moonlight Medallion",
            "Ectoplasm",
                "Ect0Dlasm",
                "Ect0Diasm",
            "Nightseer Scepter",
                "Nightseer",
            "Boombox",
            "Archmage",
                "Glimmer Energy",
                    "Glimmer Energv",
                "Archmage Cloak",
                    "Archmage Cioak",
                "Lumen",
            "The Fallen",
                "Shadow Spellbook",
                    "Shadow Snellbook",
                    "Shadow Sneiibook",
                "Fallen Excalibur",
                "Faiien Excaiibur",
                "Fallen's Bindings",
            "Unknown Machine",
            "Corroded Energy Core",
            "Old Construct Rifle",
            "Corroded Energy Reactor",
            "Steve",
            "Titan Shield",
            "Special Herb Bag",
            "Wind Horn",
            "Scroll of Sevenless",
            ; Misc, since this stuff wasn't on the wiki.
            "Spider Fang",
                "Snider Fang",
            "Strings", ; This sounds just way too general to not be in a characters dialogue or something. 
                "String"
        ]
    },
    Blizzard: {
        tips: "An incredibly strong blizzard is freezing the island!",
        items: [
            "An incredibly strong blizzard is freezing the island!",
                ; You can't use "An incredible", because Benedictus says that.
                "blizzard",
                "bli77arri",
                "bli77arrl",
                "frpp7in",
            "Ice Essence",
            "Popsicle",
                "Poosicle", ; Yes, this is real.
                "Poosicie",
                "Pnnsiclps",
                "Ponsicles",
                "Popsicl",
            "The White Death",
                "White Death",
                "White Dpath",
            "Winter Rose",
            "Inglaciator",
            "Frigid Sickle",
            "Frost Sprite",
                "Frost Sorite",
            ; TODO: WD's dialogue goes here.
            "Your time has come",
            ; TODO: WD's dialogue goes here.
            "Glacies",
            "Mask of Frost",
            "Frost Fury",
            "Blizzard Striker",
            "Swallow Feather"
        ]
    },
    FlareBiome: {
        tips: "Magical flames have warped the island!",
        items: [
            "Magical flames have warped the island!",
                "flames",
                "fiames",
            "Burning Embrace",
                "Burning-Embrace"
            "Fire Staff",
            "Firebrand",
            "Stave of Flames",
            "Flare Sprite",
                "Flare",
                "Fla re",
            "Burning Heart",
            "Magma Lord",
            "Fire Crown",
            "Flaming Halberd",
            "Lava Launcher",
            "Flame Essence",
                "Fiame Essence"
        ]
    },
    Nature: {
        tips: "The wind is sweeping life energy...",
        items: [
            "The wind is sweeping life energy...",
                "weeping",
                "sweeding",
                "life energv",
                "The wind",
            "Nature Essence",
                "Nature",
            "Woodland Horns",
                "Woodland",
                "Woodiand",
            "Woodland's Mask",
            "Tree",
            "Nympha",
                "NvmDha",
                "Nvmpha",
            "Wind Essence",
            "Nature's Staff",
            "Venomshank",
            "Sky Burst",
            "Windforce",
            "Gale Sprite",
            "Nature Sprite",
                "Nature Sorite",
            "Tornado Force",
            "Nature's Garland",
            "Jade Band",
                "Jade"
            ; "Five Leaf Clover" causes a global message.
        ]
    },
    Stormsurge: {
        tips: "A powerful stormsurge has engulfed the island!",
        items: [
            "A powerful stormsurge has engulfed the island!",
                "stormsurge",
                "stormsnrve",
                "engulfed the island",
                "enguifed the island"
            "Water Essence",
                "Water",
            "Thunder Essence",
            "Strider Scale Cloak",
                "Strider",
                "Strider Scalp",
            "Crab Staff",
            "Naga Trident",
                "Nava Trident",
            "Ocean Spellbook",
            "Thunder Spear",
            "Sea's Revenge",
            "Lightning Staff",
            "Aqua Sprite",
            "Thunder Sprite",
            "Devorator's Eye"
        ]
    },
    StarryNight: {
        tips: "A bright blue moon illuminates the sky along with countless shooting stars...",
        items: [
            "A bright blue moon illuminates the sky along with countless shooting stars...",
                "the night",
                "stars",
            "Stardust",
            "Starfarer",
                "Starfarpr",
            "Star Fragment",
            "Starfall Blade",
                "Starfaii Blade",
                "Starfail Blade",
                "Starfali Blade",
            "Starfarer's Experience",
            "Starblazer"
        ]
    },
    Irradiated: {
        tips: "placeholder",
        items: [
            "The island has been irradiated by an unknown wave of energy...",
            "Irradiated Essence",
                "Irradiated",
            "The Petridish",
                "Petridish",
            "Uranium Ore",
                "Uranium",
            "Plutonium Ore",
                "Piutonium Ore",
                "Piutonium",
                "Piuton",
                "pluton",
            "Basilisk",
            "Basilisk Scale",
            "Basilisk Eye",
            "Chemical Thrower",
            "The Bioweapon",
        ]
    },
    PurevsCorruptWar: {
        tips: "The war between pure and corrupt has started!",
        items: [
            ; Can't use corrupt or pure orb because it is dropped by Grasslands enemies.
            "The war between pure and corrupt has started!",
            "Essence of Hatred",
                "Hatred",
            "Essence of Purity",
                "Purity",
                "Puritv"
            "Katharos, the Pure",
                "Katharos",
            "Blessed Essence",
            "Purifying Cross",
            "Atrocitus, the Corrupted",
                "Atrocitus",
            "Corrupted Essence",
                "Corrudted",
            "Atrocitus' Rage"
        ]
    },
    HolyvsUnholyWar: {
        tips: "The war between holy and unholy has started!",
        items: [
            ; Kiln of the holy flame causes a global message.}
            ; Holy eruption is an Angelic item.
            "The war between holy and unholy has started!",
            "Unholy Orb",
                "unhoiv orb",
                "unholv orb",
            "Unholy Core",
            "Holy Orb",
            "Holy Core",
                "Hotv core",
                "Hoty core",
            "Virtue, Disciple of Heaven",
                "Virtue",
                "of Heaven",
            "Passion for War",
            "Essence of Divinity",
            "Belial, Envoy of Hell",
                "Beiiai, Envoy of Heii",
                "Envoy of Hell",
                "Envoy of Heii",
                "Envoy of Heil",
                "Envoy of Heli",
                "Envov of Hell",
                "Envov of Heii",
                "Envov of Heil",
                "Envov of Heli",
                "Beiiai"
                "Belial",
            "Evil Essence",
                "Evii Essence",
            "Abode of the Damned"
        ]
    },
    AngelsDescent: {
        tips: "The angels of the sky are descending!",
        items: [
            "The angels of the sky are descending!",
                "angels",
                "angeis",
                "of the sky",
                "of the skv",
                "descending",
                "descend",
            "Uriel, Gatekeeper of Heaven",
                "Archangel Uriel", 
                "Archangel",       
                "Archangei",               
                "Uriel",
                "Uriei",
            "Angelic Orb",
                "Angeiic Orb",
            "Angelic Cross",
                "Angeiic Cross",
            "Heavenly Essence",
                "Heaveniy Essence",
            "Holy Eruption",
                "Hoiy Eruption",
            ; TODO: Uriel's dialogue goes here.
            "Angeiic"
        ]
    },
    VoidInfiltration: {
        tips: "The void has infiltrated reality!",
        items: [
            "The void is infiltrating reality!",
                "void",
                "The void",
                "is infiltrating",
                "is infiitrating"
                "ting reality",
                "ting realitv",
                "ting reaiity",
                "ting reaiitv",
            "Void Orb",
            "Void Watcher's Relic",
            "Voidmite Fang",
            "Beelzebub, Beast of Gluttony",            
                "Beelzebub",
                "Beeizebub",
            "Essence of the Void",
            "Shard of the Void",
            "Void Star",
            "Maw of the Void",
            ; TODO: Beelzebub's dialogue goes here.
            "I don't have enough spare time to deal with waste like you. Let us end this quickly.",  
                "I don't have enough",
                "soare time to deal",
                "let us end this",
            "Beelzebub has distorted gravity. It is advised to stay on the ground."
                "has distorted gravity",
                "has distorted gravitv"
        ]
    },
    CultistLegion: {
        tips: "Your actions created an imbalance in reality.",
        items: [
            "Your actions created an imbalance in reality.",
                "created an",
                "imbalance",
                "imbaiance",
                ; You can't use your actions because The Paladin says that.
            "Essence of Conflict",
                "Conflict",
                "Confiict",
            "Moonstone",
            "Forbidden Crystal",
                "Forbidden",
                "Crystal",
                "Crystai",
                "Crvstal",
                "Crvstai"
            "Equinox Praetor",
                "Equinox",
                "Praetor",
            "Mysterious Artifact",
                "Mysterious",
                "Artifact",
            "Praetor's Cape",
            "Parry Manual",
                "Parry Manuai",
                "Parry"
            ; TODO: Preator's dialogue goes here.
        ]
    },
    Darkness: {
        tips: "The world is being shrouded in darkness!",
        items: [
            "The world is being shrouded in darkness!", ; This is barely readable.
            "Astaroth",
            "Astaroth, the Monarch of Darkness",
            "Astaroth's Aura of Death",
            "The Shadowdancer",
            "Null Fabric"
            ; TODO: Astaroth's dialogue goes here.
        ]
    },
    BlindingLight: {
        tips: "A bright light is blinding the world!",
        items: [
            "A bright light is blinding the world!", ; This one is very readable.
                "bright light",
                "blinding the world",
                "blinding",
            "Benedictus",
                "gpnpdirtnsi",
                "gpnpdirtnsl", ; Yes, these are supposed to say Benedictus.
            "Benedictus, the Avatar of Luminosity",
                "Benedictus. the Avatar of Luminosity",
                "Avatar",
                "Lnminnsitv",
            "Blinding Light Orb",
                "Blinding Light",
            "Aura of Life",
            "The Empyrean",
            "Illuminating Prism",
                "Iiiuminating Prism" ;
            ; TODO: Benedictus, the Avatar of Luminosity's dialogue goes here.
        ]
    },
    Rain: {
        items: [
            "Interdimensional Travelling Merchant Rain has arrived!",
                "Interdimensional",
                "Travelling",
                "Traveiiing",
                "Travel",
                "Travei"
                "Rain"
        ]
    }
}

