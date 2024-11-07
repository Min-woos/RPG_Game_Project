import 'dart:io';
import 'dart:math';

class Character {
  String name;
  int hp;
  int attack;
  int defense;
  List<String> defeatedMonsters = [];

  Character(this.name, this.hp, this.attack, this.defense);

  void showStatus() {
    print('[$name] 체력: $hp, 공격력: $attack, 방어력: $defense');
  }

  void attackMonster(Monster monster) {
    int damage = (attack - monster.defense).clamp(0, attack);
    monster.hp -= damage;
    print('$name이(가) ${monster.name}에게 $damage 데미지를 입혔습니다!');
    if (monster.hp <= 0) {
      defeatedMonsters.add(monster.name);
    }
  }

  void defend() {
    print('$name이(가) 방어테세 기동!');
  }

  void recoverHealth(int damage) {
    hp += damage;
    print('$name이(가) $damage 만큼 체력을 회복했다!');
  }
}

class Monster {
  String name;
  int hp;
  int attack;
  int defense;

  Monster(this.name, this.hp, this.attack, this.defense);

  void showStatus() {
    print('[$name] 체력: $hp, 공격력: $attack');
  }


  int attackCharacter(Character character, bool isDefending) {
    int damage = (attack - character.defense).clamp(0, attack);
    character.hp -= damage;
    print('$name이(가) ${character.name}에게 $damage 피해를 줬다!');
    return damage;
  }
}

Future<List<Character>> loadCharacters() async {
  List<Character> characters = [];
  final file = File('class/characters.csv');
  List<String> lines = await file.readAsLines();

  for (var i = 1; i < lines.length; i++) {
    List<String> values = lines[i].split(',');
    characters.add(Character(
      values[0],
      int.parse(values[1]),
      int.parse(values[2]),
      int.parse(values[3]),
    ));
  }
  return characters;
}

Future<List<Monster>> loadMonsters() async {
  List<Monster> monsters = [];
  final file = File('class/monsters.csv');
  List<String> lines = await file.readAsLines();

  for (var i = 1; i < lines.length; i++) {
    List<String> values = lines[i].split(',');
    monsters.add(Monster(
      values[0],
      int.parse(values[1]),
      int.parse(values[2]),
      int.parse(values[3]),
    ));
  }
  return monsters;
}

void saveGameResult(Character character, String result) {
  final file = File('bin/game_save.txt');
  file.writeAsStringSync(
    '캐릭터: ${character.name}\n남은 체력: ${character.hp}\n게임 결과: $result\n',
    mode: FileMode.append,
  );
  print('게임 결과가 game_save.txt에 저장되었습니다.');
}

void main() async {
  List<Character> characters = await loadCharacters();
  List<Monster> monsters = await loadMonsters();
  Random random = Random();

  print('캐릭터를 선택하세요:');
  for (var i = 0; i < characters.length; i++) {
    print('${i + 1}. ${characters[i].name}');
  }
  int choice = int.parse(stdin.readLineSync()!) - 1;
  Character player = characters[choice];

  while (player.hp > 0 && monsters.isNotEmpty) {
    Monster monster = monsters[random.nextInt(monsters.length)];

    monster.attack = max(monster.attack, player.defense + random.nextInt(10));
    // 몬스터 공격력을 캐릭터의 방어력 이상으로 설정 코드

    print('\n${monster.name}이(가) 나타났습니다!');

    while (player.hp > 0 && monster.hp > 0) {
      print('\n${player.name}의 현재상태:');
      player.showStatus();
      print('${monster.name}의 현재 상태:');
      monster.showStatus();
      
      print('\n행동을 선택하세요:');
      print('1. 공격');
      print('2. 방어');
      int action = int.parse(stdin.readLineSync()!);

      if (action == 1) {
        player.attackMonster(monster);
        if (monster.hp <= 0) {
          print('${monster.name}을(를) 처치했습니다!');
          monsters.remove(monster); //처치된 몬스터 제거
          break;
        }
      } else if (action == 2) {
        player.defend();
      } else {
        print('잘못된 선택입니다. 다시 입력하세요.');
        continue;
      }

      print('${monster.name}의 턴!');
      int damage = monster.attackCharacter(player, action == 2);
      if (action == 2) {
        player.recoverHealth(damage);
      }

      if (player.hp <= 0) {
        print('${player.name}이(가) 쓰러졌습니다. 게임 끝남!');
        saveGameResult(player,"패배");
        return;
      }
    }

    if (monster.hp <= 0 && monsters.isNotEmpty) {
      print('\n다음 몬스터와 승부를 보시겠습니까?');
      print('1. 다음 나와라');
      print('2. 두고보자..');
      int continueChoice = int.parse(stdin.readLineSync()!);
      if (continueChoice != 1) {
        print('게임을 종료합니다.');
        saveGameResult(player,"승리");
        return;
      }
    }
  }

  print('모든 몬스터를 처치했습니다! 승리!');
  saveGameResult(player,"승리");
}