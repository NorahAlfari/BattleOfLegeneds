// 1. Define the `Item` protocol with the following requirements:
// - `name` property of type `String`
// - `description` property of type `String`

protocol Item {
  var name: String { get }
  var description: String { get }
}

// 2. Define the `Chest` struct with the following requirements:
// - `items` property of type `Array<Item>`

struct Chest {
  var items: Array<Item> = []
}

// 3. Define the `Player` protocol which confirm to `AnyObject` protocol and with the following requirements:
// - `name` property of type `String`
// - `health` property of type `Int`
// - `attack<P: Player>(_ player: P)` function
// - `splash<P: Player>(_ player: P)` function
// - `heal()` function

protocol Player: AnyObject {
  var name: String { get }
  var health: Int { get set }
  var chest: Chest { get set }
  
  func attack<P: Player>(_ player: P)
  func splash<P: Player>(_ player: P)
  func heal()
}

// 4. Define the `Weapon` protocol which confirm to `Item` protocol and with the following requirements:
// - `effectPoints` property of type `Int`
// - `attack<P: Player>(_ player: P)` function

protocol Weapon: Item{
    var effectPoints: Int { get }
    
    func attack<P: Player>(_ player: P)
}


// 5. Define the `Potion` protocol which confirm to `Item` protocol and with the following requirements:
// - `effectPoints` property of type `Int`
// - `splash<P: Player>(_ player: P)` function


protocol Potion: Item{
    var effectPoints: Int { get }
    
    func splash<P: Player>(_ player: P)
}


// 6. Define the `Sword` struct which confirm to `Weapon` protocol
// - the `effectPoints` should be 10

struct Sword: Weapon{
    var effectPoints: Int = 10
    
    func attack<P>(_ player: P) where P : Player {
        if player.health > effectPoints{
            player.health -= effectPoints
        }
    }
    
    var name: String
    
    var description: String
    
    
}



// 7. Define the `Axe` struct which confirm to `Weapon` protocol
// - the `effectPoints` should be 20

struct Axe: Weapon{
    var effectPoints: Int = 20
    
    func attack<P>(_ player: P) where P : Player {
        if player.health > effectPoints {
            player.health -= effectPoints
        }
    }
    
    var name: String
    
    var description: String
    
    
}


// 8. Define the `Knife` struct which confirm to `Weapon` protocol
// - the `effectPoints` should be 5

struct Knife: Weapon{
    var effectPoints: Int = 5
    
    func attack<P>(_ player: P) where P : Player {
        if player.health > effectPoints {
            player.health -= effectPoints
        }
    }
    
    var name: String
    
    var description: String
    
    
}


// 9. Define the `Wand` struct which confirm to `Weapon` protocol
// - the `effectPoints` should be 30
struct Wand: Weapon{
    var effectPoints: Int = 30
    
    func attack<P>(_ player: P) where P : Player {
        if player.health > effectPoints {
            player.health -= effectPoints
        }
    }
    
    var name: String
    
    var description: String
    
    
}



// 10. Define the `HealthPotion` struct which confirm to `Potion` protocol
// - the `effectPoints` should be 20

struct HealthPotion: Potion{
    var effectPoints: Int = 20
    
    func splash<P>(_ player: P) where P : Player {
        player.health += effectPoints
    }
    
    var name: String
    
    var description: String
    
    
}


// 11. Define the `PoisonPotion` struct which confirm to `Potion` protocol
// - the `effectPoints` should be 20
struct PoisonPotion: Potion{
    var effectPoints: Int = 20
    
    func splash<P>(_ player: P) where P : Player {
        player.health += effectPoints
    }
    
    var name: String
    
    var description: String
    
    
}




// 12. Define the `Warrior` class which confirm to `Player` protocol
// - the `health` should be 100

class Warrior: Player{
    var name: String = "Gandalf"
    
    var health: Int = 100
    
    var chest: Chest =  Chest()
    
    func attack<P>(_ player: P) where P : Player {
        if let weapon = chest.items.randomElement() as? Weapon {
                    weapon.attack(player)
                }
    }
    
    func splash<P>(_ player: P) where P : Player {
        if let potion = chest.items.randomElement() as? Potion {
                   potion.splash(player)
               }
    }
    
    func heal() {
        if let potion = chest.items.randomElement() as? HealthPotion {
                   potion.splash(self)
               }
    }
    
    
}


// 13. Define the `Wizard` class which confirm to `Player` protocol
// - the `health` should be 100
class Wizard: Player{
    var name: String = "Aragon"
    
    var health: Int = 100
    
    var chest: Chest =  Chest()
    
    func attack<P>(_ player: P) where P : Player {
        if let weapon = chest.items.randomElement() as? Weapon {
                    weapon.attack(player)
                }
    }
    
    // for item in chest.items is Weapon
    func splash<P>(_ player: P) where P : Player {
        if let potion = chest.items.randomElement() as? Potion {
                    potion.splash(player)
                }
    }
    
    func heal() {
        if let potion = chest.items.randomElement() as? HealthPotion {
                    potion.splash(self)
                }
    }
    
    
}



let warrior = Warrior()
let wizard = Wizard()

// Add items to Warrior's chest
warrior.chest.items.append(Sword(name: "Excalibur", description: "Legendary sword"))
warrior.chest.items.append(HealthPotion(name: "Healing Elixir", description: "Restores health"))
warrior.chest.items.append(PoisonPotion(name: "Toxic Brew", description: "Inflicts poison"))

// Add items to Wizard's chest
wizard.chest.items.append(Wand(name: "Magic Wand", description: "Harnesses arcane power"))
wizard.chest.items.append(HealthPotion(name: "Mystical Potion", description: "Magical healing elixir"))
wizard.chest.items.append(PoisonPotion(name: "Venomous Concoction", description: "Deadly poison"))

//Simulating a battle
print("Initial Health - Warrior: \(warrior.health), Wizard: \(wizard.health)")
wizard.attack(warrior)
warrior.splash(wizard)
//warrior.heal()
print("After Battle - Warrior: \(warrior.health), Wizard: \(wizard.health)")
