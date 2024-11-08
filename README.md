# Dart RPG_Game
### 필수기능
1. 파일로부터 데이터 읽어오기
2. 캐릭터 이름 입력받기
3. 게임 종료 후 결과를 파일에 저장

### 도전기능
* 하지 못했습니다!

---
### 파일관리


<img width="241" alt="스크린샷 2024-11-08 오전 9 03 36" src="https://github.com/user-attachments/assets/e85f41a1-3d9d-4d22-af69-f9379b736fbc">

* bin/dart_rpg_game.dart - main함수와 메서드가 있는 곳.
* bin/game_save.txt - 게임 종료 후 캐릭터,남은 체력,게임결과가 나오는 곳.
* class - characters,monsters 로 구분해 캐릭터의 공격력,체력,방어력 몬스터의 체력,공격력,방어력이 정리되어있다.
* lib - 잘 몰라서 가만히 놔뒀다.
* test - 건드리면 안될것 같아서 놔뒀다.
---
### 게임작동 확인

<img width="322" alt="스크린샷 2024-11-08 오전 9 28 39" src="https://github.com/user-attachments/assets/1c888355-d81e-4ea3-888f-b4ea3555d1a3">
<img width="313" alt="스크린샷 2024-11-08 오전 9 30 01" src="https://github.com/user-attachments/assets/8ab4b5c7-029c-4102-914a-c3384534dae7">
<img width="313" alt="스크린샷 2024-11-08 오전 9 30 26" src="https://github.com/user-attachments/assets/2d26c733-854d-42e4-94fd-8978bc0a971b">

#

* 캐릭터를 선택할수 있습니다. 캐릭터마다 체력,공격력,방어력이 다르니 골라보세요!
* 행동을 선택하는 창이 나올건데 ``1``, ``2`` 중에 골라서 쓸수있어요!
* ``2``방어를 누르게 되면 공격당한 데미지 만큼 체력을 회복할수있어요(순간적으로 흡혈하나봐요).
* 몬스터를 처치하게 되면 다음 몬스터를 상대하거나 한발 물러설수있어요.
* ``1``다음 나와라 를 선택하면 랜덤으로 몬스터가 나타나요 여러번 스트레스를 풀수 있겠군요 ㅎㅎ
* ``2``두고보자.. 를 선택하면 즉시 게임이 종료 되며 게임결과가 bin/game_save.txt 파일에 저장됩니다.
