//
//  NationalGalarPokedexUITests.swift
//  NationalGalarPokedexUITests
//
//  Created by Hector Villasano on 7/21/20.
//  Copyright © 2020 s. All rights reserved.
//

import XCTest

class NationalGalarPokedexUITests: XCTestCase {
    var app: XCUIApplication! = nil
    
    var nationalPokemonNames: [String] = fetchNationalPokemonNames.split(separator: ",").map {
        let name = String($0)
        return name.first! == "\n" ? String(name.dropFirst()) : name
    }
    
    var galarPokemonNames: [String] = fetchGalarPokemonNames.split(separator: ",").map {
        let name = String($0)
        return name.first! == "\n" ? String(name.dropFirst()) : name
    }
    
    var searchNavigationBar: XCUIElement {
        app.navigationBars["PokedexSearchNavigationBar"]
    }
    
    var searchListTableView: XCUIElement {
        app.tables["PokedexListTableView"]
    }
    
    var rightBarButtonItemMagnifyingglass: XCUIElement {
        searchNavigationBar.buttons["rightBarButtonItemMagnifyingglass"]
    }
    
    var leftBarButtonItemGear: XCUIElement {
        searchNavigationBar.buttons["leftBarButtonItemGear"]
    }
    
    var searchTabBarButton: XCUIElement {
        app.tabBars.buttons["Search"]
    }
    
    var favoritesTabBarButton: XCUIElement {
        app.tabBars.buttons["Favorites"]
    }
    
    var leagueCardTabBarButton: XCUIElement {
        app.tabBars.buttons["League Cards"]
    }
    
    var pokedexNOSheet: XCUIElement {
        app.sheets["Pokedex NO."]
    }
    
    ///buttons["National Pokedex"], buttons["Galar Pokedex"], buttons["Favorite"]
    var pokedexNOSheetButtons: [XCUIElement] {
        [pokedexNOSheet.buttons["National Pokedex"], pokedexNOSheet.buttons["Galar Pokedex"], pokedexNOSheet.buttons["Favorite"]]
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        sleep(1)
        app.terminate()
    }
    
    private func pokemonDetailViewFlow(name: String, enableDetailViewSections: Bool = true) {
        let detailViewSections = ["Description", "NO.", "Type", "Height & Weight", "Base Stats", "Hatch Cycles", "Exp Group", "Egg groups", "Egg Moves", "Abilities", "Level Up Moves"]
        
        let pokemonDetailViewNaviationBar = app.navigationBars["\(name)DetailView"]
        XCTAssert(pokemonDetailViewNaviationBar.isHittable)
        
        let playPauseButton = app.buttons["playpause"]
        XCTAssert(playPauseButton.isHittable)
        playPauseButton.tap()
        
        let tablesQuery = app.tables
        
        if enableDetailViewSections {
            for section in detailViewSections {
                let button = tablesQuery.buttons[section]
                XCTAssert(button.isHittable)
                button.tap()
            }
        }
        
        let serebiiButton = pokemonDetailViewNaviationBar.buttons["serebii.net"]
        XCTAssert(serebiiButton.isHittable)
        serebiiButton.tap()
        
        pokemonDetailViewNaviationBar.buttons["\(name)"].tap()
    }
    
    private func navigateToNationalPokemonTableViewList() {
        searchTabBarButton.tap()
        leftBarButtonItemGear.tap()
        XCTAssert(pokedexNOSheet.isHittable)
        pokedexNOSheetButtons[0].tap()
        sleep(1)
        XCTAssert(searchListTableView.cells["\(nationalPokemonNames[0])Cell"].isHittable)
    }
    
    private func navigateToGalarPokemonTableViewList() {
        searchTabBarButton.tap()
        leftBarButtonItemGear.tap()
        XCTAssert(pokedexNOSheet.isHittable)
        pokedexNOSheetButtons[1].tap()
        sleep(1)
        XCTAssert(searchListTableView.cells["\(galarPokemonNames[0])Cell"].isHittable)
    }
    
    private func viewAllPokemonFlow(with list: [String]) {
        searchTabBarButton.tap()
        XCTAssert(searchTabBarButton.isSelected)
        for name in list {
            let pokemonCellID = "\(name)Cell"
            
            searchListTableView.cells[pokemonCellID].tap()
            
            pokemonDetailViewFlow(name: name)
            
            searchTabBarButton.tap()
            XCTAssert(searchNavigationBar.isHittable)
            break
        }
    }
    
    private func favoriteAllPokemonFlow(with list: [String]) {
        searchTabBarButton.tap()
        XCTAssert(searchTabBarButton.isSelected)
        for name in list {
            let cell = searchListTableView.cells["\(name)Cell"]
            
            let cellHeartButton = cell.buttons["heart"]
            
            if !cellHeartButton.isHittable {
                app.swipeUp()
            }
            
            cellHeartButton.tap()
            
            XCTAssert(favoritesTabBarButton.isHittable)
            favoritesTabBarButton.tap()
            XCTAssert(favoritesTabBarButton.isSelected)
            
            app.collectionViews.cells["\(name)Cell"].tap()
            
            pokemonDetailViewFlow(name: name)
            
            favoritesTabBarButton.tap()
            XCTAssert(favoritesTabBarButton.isSelected)
            
            XCTAssert(searchTabBarButton.isHittable)
            searchTabBarButton.tap()
            XCTAssert(searchTabBarButton.isSelected)
            
            let cellHeartFillButton = cell.buttons["heart.fill"]
            XCTAssert(cellHeartFillButton.isHittable)
            cellHeartFillButton.tap()
            break
        }
    }
}

extension NationalGalarPokedexUITests {
    func testrightBarButtonItemMagnifyingglass() {
        XCTAssert(rightBarButtonItemMagnifyingglass.isHittable)
        rightBarButtonItemMagnifyingglass.tap()
    }
    
    func testPokedexSearchNavigationBarIsHittable() throws {
        XCTAssert(searchNavigationBar.isHittable)
    }
    
    func testpokedexListTableViewIsHittable() throws {
        XCTAssert(searchListTableView.isHittable)
    }
    
    func testTabBarButtonsIsHittable() {
        XCTAssert(favoritesTabBarButton.isHittable)
        favoritesTabBarButton.tap()
        XCTAssert(leagueCardTabBarButton.isHittable)
        leagueCardTabBarButton.tap()
        XCTAssert(searchTabBarButton.isHittable)
        searchTabBarButton.tap()
    }
    
    func testSearchViewFavorites() {
        searchTabBarButton.tap()
        XCTAssert(searchTabBarButton.isSelected)

        let cell = searchListTableView.cells["\(nationalPokemonNames[0])Cell"]
        XCTAssert(cell.isHittable)
        
        let cellHeartButton = cell.buttons["heart"]
        XCTAssert(cellHeartButton.isHittable)
        cellHeartButton.tap()

        leftBarButtonItemGear.tap()
        XCTAssert(pokedexNOSheet.isHittable)
        
        let favoriteButton = pokedexNOSheetButtons[2]
        favoriteButton.tap()
        
        XCTAssert(cell.isHittable)
        
        let cellHeartFillButton = cell.buttons["heart.fill"]
        XCTAssertTrue(cellHeartFillButton.isHittable)
        cellHeartFillButton.tap()
        
        let cellExist = cell.waitForExistence(timeout: 1)
        XCTAssertFalse(cellExist)
        
        leftBarButtonItemGear.tap()
        XCTAssert(pokedexNOSheet.isHittable)
        pokedexNOSheetButtons[0].tap()
        XCTAssert(cellHeartButton.isHittable)
    }
    
    func testPokemonNameListNotNil() {
        XCTAssertNotNil(nationalPokemonNames)
        XCTAssertNotNil(galarPokemonNames)
    }
    
    func testPokedexNOSheetButtonsIsHittable() {
        for button in pokedexNOSheetButtons {
            leftBarButtonItemGear.tap()
            XCTAssert(button.isHittable)
            button.tap()
        }
    }
    
    func testLeagueCardView() {
        XCTAssert(leagueCardTabBarButton.isHittable)
        leagueCardTabBarButton.tap()
        
        XCTAssert(leagueCardTabBarButton.isSelected)
        
        let leagueCardNavigationBar = app.navigationBars["League Cards"]
        XCTAssert(leagueCardNavigationBar.isHittable)
        
        let plussButton = leagueCardNavigationBar.buttons["plus"]
        XCTAssert(plussButton.isHittable)
        plussButton.tap()
                
        app.alerts["iCloud Error"].buttons["OK"].tap()
        
        app.tables.staticTexts["0000 0000 0000 00"].tap()
        app.navigationBars["My Card Code"].buttons["League Cards"].tap()
    }
    
    func testNavigateTonationalPokemonTableViewList() {
        navigateToNationalPokemonTableViewList()
    }
    
    func testNavigateToGalarPokemonTableViewList() {
        navigateToGalarPokemonTableViewList()
    }
    
    func testAllNationalPokemonInTableViewIsHittable() {
        navigateToNationalPokemonTableViewList()
        viewAllPokemonFlow(with: nationalPokemonNames)
    }
    
    func testAllGalarPokemonInTableViewIsHittable() {
        navigateToGalarPokemonTableViewList()
        viewAllPokemonFlow(with: galarPokemonNames)
    }
    
    func testNationalPokokemonIsFavorite() {
        navigateToNationalPokemonTableViewList()
        favoriteAllPokemonFlow(with: nationalPokemonNames)
    }
    
    func testGalarPokokemonIsFavorite() {
        navigateToGalarPokemonTableViewList()
        favoriteAllPokemonFlow(with: galarPokemonNames)
    }
}

// MARK: METRICS
extension NationalGalarPokedexUITests {
    func _testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}

private let fetchNationalPokemonNames = """
Bulbasaur,
Ivysaur,
Venusaur,
Charmander,
Charmeleon,
Charizard,
Squirtle,
Wartortle,
Blastoise,
Caterpie,
Metapod,
Butterfree,
Pikachu,
Raichu,
Clefairy,
Clefable,
Vulpix,
Ninetales,
Oddish,
Gloom,
Vileplume,
Diglett,
Dugtrio,
Meowth,
Persian,
Growlithe,
Arcanine,
Machop,
Machoke,
Machamp,
Ponyta,
Rapidash,
Farfetch’d,
Shellder,
Cloyster,
Gastly,
Haunter,
Gengar,
Onix,
Krabby,
Kingler,
Hitmonlee,
Hitmonchan,
Koffing,
Weezing,
Rhyhorn,
Rhydon,
Goldeen,
Seaking,
Mr. Mime,
Magikarp,
Gyarados,
Lapras,
Ditto,
Eevee,
Vaporeon,
Jolteon,
Flareon,
Snorlax,
Mewtwo,
Mew,
Hoothoot,
Noctowl,
Chinchou,
Lanturn,
Pichu,
Cleffa,
Togepi,
Togetic,
Natu,
Xatu,
Bellossom,
Sudowoodo,
Wooper,
Quagsire,
Espeon,
Umbreon,
Wobbuffet,
Steelix,
Qwilfish,
Shuckle,
Sneasel,
Swinub,
Piloswine,
Corsola,
Remoraid,
Octillery,
Delibird,
Mantine,
Tyrogue,
Hitmontop,
Larvitar,
Pupitar,
Tyranitar,
Celebi,
Zigzagoon,
Linoone,
Lotad,
Lombre,
Ludicolo,
Seedot,
Nuzleaf,
Shiftry,
Wingull,
Pelipper,
Ralts,
Kirlia,
Gardevoir,
Nincada,
Ninjask,
Shedinja,
Sableye,
Mawile,
Electrike,
Manectric,
Roselia,
Wailmer,
Wailord,
Torkoal,
Trapinch,
Vibrava,
Flygon,
Lunatone,
Solrock,
Barboach,
Whiscash,
Corphish,
Crawdaunt,
Baltoy,
Claydol,
Feebas,
Milotic,
Duskull,
Dusclops,
Wynaut,
Snorunt,
Glalie,
Jirachi,
Budew,
Roserade,
Combee,
Vespiquen,
Cherubi,
Cherrim,
Shellos,
Gastrodon,
Drifloon,
Drifblim,
Stunky,
Skuntank,
Bronzor,
Bronzong,
Bonsly,
Mime Jr.,
Munchlax,
Riolu,
Lucario,
Hippopotas,
Hippowdon,
Skorupi,
Drapion,
Croagunk,
Toxicroak,
Mantyke,
Snover,
Abomasnow,
Weavile,
Rhyperior,
Togekiss,
Leafeon,
Glaceon,
Mamoswine,
Gallade,
Dusknoir,
Froslass,
Rotom,
Purrloin,
Liepard,
Munna,
Musharna,
Pidove,
Tranquill,
Unfezant,
Roggenrola,
Boldore,
Gigalith,
Woobat,
Swoobat,
Drilbur,
Excadrill,
Timburr,
Gurdurr,
Conkeldurr,
Tympole,
Palpitoad,
Seismitoad,
Throh,
Sawk,
Cottonee,
Whimsicott,
Basculin,
Darumaka,
Darmanitan,
Maractus,
Dwebble,
Crustle,
Scraggy,
Scrafty,
Sigilyph,
Yamask,
Cofagrigus,
Trubbish,
Garbodor,
Minccino,
Cinccino,
Gothita,
Gothorita,
Gothitelle,
Solosis,
Duosion,
Reuniclus,
Vanillite,
Vanillish,
Vanilluxe,
Karrablast,
Escavalier,
Frillish,
Jellicent,
Joltik,
Galvantula,
Ferroseed,
Ferrothorn,
Klink,
Klang,
Klinklang,
Elgyem,
Beheeyem,
Litwick,
Lampent,
Chandelure,
Axew,
Fraxure,
Haxorus,
Cubchoo,
Beartic,
Shelmet,
Accelgor,
Stunfisk,
Golett,
Golurk,
Pawniard,
Bisharp,
Rufflet,
Braviary,
Vullaby,
Mandibuzz,
Heatmor,
Durant,
Deino,
Zweilous,
Hydreigon,
Cobalion,
Terrakion,
Virizion,
Reshiram,
Zekrom,
Kyurem,
Keldeo,
Bunnelby,
Diggersby,
Pancham,
Pangoro,
Espurr,
Meowstic,
Honedge,
Doublade,
Aegislash,
Spritzee,
Aromatisse,
Swirlix,
Slurpuff,
Inkay,
Malamar,
Binacle,
Barbaracle,
Helioptile,
Heliolisk,
Sylveon,
Hawlucha,
Goomy,
Sliggoo,
Goodra,
Phantump,
Trevenant,
Pumpkaboo,
Gourgeist,
Bergmite,
Avalugg,
Noibat,
Noivern,
Rowlet,
Dartrix,
Decidueye,
Litten,
Torracat,
Incineroar,
Popplio,
Brionne,
Primarina,
Grubbin,
Charjabug,
Vikavolt,
Cutiefly,
Ribombee,
Wishiwashi,
Mareanie,
Toxapex,
Mudbray,
Mudsdale,
Dewpider,
Araquanid,
Morelull,
Shiinotic,
Salandit,
Salazzle,
Stufful,
Bewear,
Bounsweet,
Steenee,
Tsareena,
Oranguru,
Passimian,
Wimpod,
Golisopod,
Pyukumuku,
Type: Null,
Silvally,
Turtonator,
Togedemaru,
Mimikyu,
Drampa,
Dhelmise,
Jangmo-o,
Hakamo-o,
Kommo-o,
Cosmog,
Cosmoem,
Solgaleo,
Lunala,
Necrozma,
Marshadow,
Zeraora,
Meltan,
Melmetal,
Grookey,
Thwackey,
Rillaboom,
Scorbunny,
Raboot,
Cinderace,
Sobble,
Drizzile,
Inteleon,
Skwovet,
Greedent,
Rookidee,
Corvisquire,
Corviknight,
Blipbug,
Dottler,
Orbeetle,
Nickit,
Thievul,
Gossifleur,
Eldegoss,
Wooloo,
Dubwool,
Chewtle,
Drednaw,
Yamper,
Boltund,
Rolycoly,
Carkol,
Coalossal,
Applin,
Flapple,
Appletun,
Silicobra,
Sandaconda,
Cramorant,
Arrokuda,
Barraskewda,
Toxel,
Toxtricity,
Sizzlipede,
Centiskorch,
Clobbopus,
Grapploct,
Sinistea,
Polteageist,
Hatenna,
Hattrem,
Hatterene,
Impidimp,
Morgrem,
Grimmsnarl,
Obstagoon,
Perrserker,
Cursola,
Sirfetch’d,
Mr. Rime,
Runerigus,
Milcery,
Alcremie,
Falinks,
Pincurchin,
Snom,
Frosmoth,
Stonjourner,
Eiscue,
Indeedee,
Morpeko,
Cufant,
Copperajah,
Dracozolt,
Arctozolt,
Dracovish,
Arctovish,
Duraludon,
Dreepy,
Drakloak,
Dragapult,
Zacian,
Zamazenta,
Eternatus,
"""

private let fetchGalarPokemonNames = """
Grookey,
Thwackey,
Rillaboom,
Scorbunny,
Raboot,
Cinderace,
Sobble,
Drizzile,
Inteleon,
Blipbug,
Dottler,
Orbeetle,
Caterpie,
Metapod,
Butterfree,
Grubbin,
Charjabug,
Vikavolt,
Hoothoot,
Noctowl,
Rookidee,
Corvisquire,
Corviknight,
Skwovet,
Greedent,
Pidove,
Tranquill,
Unfezant,
Nickit,
Thievul,
Zigzagoon,
Linoone,
Obstagoon,
Wooloo,
Dubwool,
Lotad,
Lombre,
Ludicolo,
Seedot,
Nuzleaf,
Shiftry,
Chewtle,
Drednaw,
Purrloin,
Liepard,
Yamper,
Boltund,
Bunnelby,
Diggersby,
Minccino,
Cinccino,
Bounsweet,
Steenee,
Tsareena,
Oddish,
Gloom,
Vileplume,
Bellossom,
Budew,
Roselia,
Roserade,
Wingull,
Pelipper,
Joltik,
Galvantula,
Electrike,
Manectric,
Vulpix,
Ninetales,
Growlithe,
Arcanine,
Vanillite,
Vanillish,
Vanilluxe,
Swinub,
Piloswine,
Mamoswine,
Delibird,
Snorunt,
Glalie,
Froslass,
Baltoy,
Claydol,
Mudbray,
Mudsdale,
Dwebble,
Crustle,
Golett,
Golurk,
Munna,
Musharna,
Natu,
Xatu,
Stufful,
Bewear,
Snover,
Abomasnow,
Krabby,
Kingler,
Wooper,
Quagsire,
Corphish,
Crawdaunt,
Nincada,
Ninjask,
Shedinja,
Tyrogue,
Hitmonlee,
Hitmonchan,
Hitmontop,
Pancham,
Pangoro,
Klink,
Klang,
Klinklang,
Combee,
Vespiquen,
Bronzor,
Bronzong,
Ralts,
Kirlia,
Gardevoir,
Gallade,
Drifloon,
Drifblim,
Gossifleur,
Eldegoss,
Cherubi,
Cherrim,
Stunky,
Skuntank,
Tympole,
Palpitoad,
Seismitoad,
Duskull,
Dusclops,
Dusknoir,
Machop,
Machoke,
Machamp,
Gastly,
Haunter,
Gengar,
Magikarp,
Gyarados,
Goldeen,
Seaking,
Remoraid,
Octillery,
Shellder,
Cloyster,
Feebas,
Milotic,
Basculin,
Wishiwashi,
Pyukumuku,
Trubbish,
Garbodor,
Sizzlipede,
Centiskorch,
Rolycoly,
Carkol,
Coalossal,
Diglett,
Dugtrio,
Drilbur,
Excadrill,
Roggenrola,
Boldore,
Gigalith,
Timburr,
Gurdurr,
Conkeldurr,
Woobat,
Swoobat,
Noibat,
Noivern,
Onix,
Steelix,
Arrokuda,
Barraskewda,
Meowth,
Perrserker,
Persian,
Milcery,
Alcremie,
Cutiefly,
Ribombee,
Ferroseed,
Ferrothorn,
Pumpkaboo,
Gourgeist,
Pichu,
Pikachu,
Raichu,
Eevee,
Vaporeon,
Jolteon,
Flareon,
Espeon,
Umbreon,
Leafeon,
Glaceon,
Sylveon,
Applin,
Flapple,
Appletun,
Espurr,
Meowstic,
Swirlix,
Slurpuff,
Spritzee,
Aromatisse,
Dewpider,
Araquanid,
Wynaut,
Wobbuffet,
Farfetch’d,
Sirfetch’d,
Chinchou,
Lanturn,
Croagunk,
Toxicroak,
Scraggy,
Scrafty,
Stunfisk,
Shuckle,
Barboach,
Whiscash,
Shellos,
Gastrodon,
Wimpod,
Golisopod,
Binacle,
Barbaracle,
Corsola,
Cursola,
Impidimp,
Morgrem,
Grimmsnarl,
Hatenna,
Hattrem,
Hatterene,
Salandit,
Salazzle,
Pawniard,
Bisharp,
Throh,
Sawk,
Koffing,
Weezing,
Bonsly,
Sudowoodo,
Cleffa,
Clefairy,
Clefable,
Togepi,
Togetic,
Togekiss,
Munchlax,
Snorlax,
Cottonee,
Whimsicott,
Rhyhorn,
Rhydon,
Rhyperior,
Gothita,
Gothorita,
Gothitelle,
Solosis,
Duosion,
Reuniclus,
Karrablast,
Escavalier,
Shelmet,
Accelgor,
Elgyem,
Beheeyem,
Cubchoo,
Beartic,
Rufflet,
Braviary,
Vullaby,
Mandibuzz,
Skorupi,
Drapion,
Litwick,
Lampent,
Chandelure,
Inkay,
Malamar,
Sneasel,
Weavile,
Sableye,
Mawile,
Maractus,
Sigilyph,
Riolu,
Lucario,
Torkoal,
Mimikyu,
Cufant,
Copperajah,
Qwilfish,
Frillish,
Jellicent,
Mareanie,
Toxapex,
Cramorant,
Toxel,
Toxtricity,
Silicobra,
Sandaconda,
Hippopotas,
Hippowdon,
Durant,
Heatmor,
Helioptile,
Heliolisk,
Hawlucha,
Trapinch,
Vibrava,
Flygon,
Axew,
Fraxure,
Haxorus,
Yamask,
Runerigus,
Cofagrigus,
Honedge,
Doublade,
Aegislash,
Ponyta,
Rapidash,
Sinistea,
Polteageist,
Indeedee,
Phantump,
Trevenant,
Morelull,
Shiinotic,
Oranguru,
Passimian,
Morpeko,
Falinks,
Drampa,
Turtonator,
Togedemaru,
Snom,
Frosmoth,
Clobbopus,
Grapploct,
Pincurchin,
Mantyke,
Mantine,
Wailmer,
Wailord,
Bergmite,
Avalugg,
Dhelmise,
Lapras,
Lunatone,
Solrock,
Mime Jr.,
Mr. Mime,
Mr. Rime,
Darumaka,
Darmanitan,
Stonjourner,
Eiscue,
Duraludon,
Rotom,
Ditto,
Dracozolt,
Arctozolt,
Dracovish,
Arctovish,
Charmander,
Charmeleon,
Charizard,
Type: Null,
Silvally,
Larvitar,
Pupitar,
Tyranitar,
Deino,
Zweilous,
Hydreigon,
Goomy,
Sliggoo,
Goodra,
Jangmo-o,
Hakamo-o,
Kommo-o,
Dreepy,
Drakloak,
Dragapult,
Zacian,
Zamazenta,
Eternatus,
"""
