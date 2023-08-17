package game;

import java.util.Scanner;

public class MainGame {

	public static void main(String[] args) {

		Scanner sc = new Scanner(System.in);
		Status stat = new Status("못써먹겠다 싶을정도로 낡은 곡괭이", 100, 1, false, true , 0, 100, 15 ,0 ,10, 1000 ,1 , 10, 00, 0, 0, 9, 10, 50, 1, 1);
		System.out.println("게임을 시작합니다.");
		
		while(stat.game) {
			if (stat.coupon3 == 0 && stat.expense2*stat.att2 > stat.money) {
				System.out.println("소유중인 무료 곡괭이 사용권이 없고 수리비용이 부족하여 게임이 종료됩니다.");
				stat.game = false;
			}
			System.out.println();
			System.out.println("=========================================================================================");
			System.out.println("1 : 내 정보, 2 : 광물 캐기, 3 : 장비 강화하기, 4 : 상점, 5 : 방사능 물질 제거, 9 : 게임 안내, 0 : 종료하기");
			System.out.println("=========================================================================================");
			System.out.println();
			int val = Integer.parseInt(sc.nextLine());
			switch (val) {
				case 1 :
					stat.stat();
					break;
				case 2 :
					stat.mine();
					break;
				case 3 :
					stat.enforce();
					break;
				case 9 :
					System.out.println();
					System.out.println("광물캐서 곡괭이 강화하기");
					System.out.println("광물을 캐서 곡괭이를 강화하는 게임입니다.");
					System.out.println("곡괭이 레벨이 100에 도달하면 게임이 클리어됩니다.");
					System.out.println("상점에서 아이템 구매와 곡괭이 수리를 할 수 있습니다.");
					System.out.println("☆★☆★곡괭이 강화 시 수리비용을 감안하여 돈을 남겨주세요. 게임 진행이 불가능하다면 게임이 종료됩니다.★☆★☆");
					System.out.println("내 정보창에서 강화 비용, 수리 비용 등을 확인할 수 있습니다.");
					System.out.println();
					System.out.println("다음 : 0");
					System.out.println();
					int val1 = Integer.parseInt(sc.nextLine());
					if (val1 == 0) {
						System.out.println();
						System.out.println("=================방사능(보스) 컨텐츠=================");
						System.out.println("광물을 10회 캘때마다 1일이 지납니다.");
						System.out.println("정해진 기간 내에 레벨과 내구도를 강화하여 방사능 물질을 제거하지 않으면 클리어 실패가 됩니다.");
						System.out.println("방사능 컨텐츠에서는 내구도가 공격력, 운빨이 치명타 확률이 됩니다.");
						System.out.println("방사능 공격 시 데미지는 +-20%입니다.");
						System.out.println("4턴의 기회가 주어지며 해당 턴 내에 제거하지 못하면 실패하게 됩니다.");
						System.out.println("방사능제거 시 50%의 확률로 무료 곡괭이 수리권(목숨과 비슷한 역할)을 획득할 수 있습니다.");
						System.out.println();
						System.out.println("다음 : 0");
						System.out.println();
					}
					int val2 = Integer.parseInt(sc.nextLine());
						if (val2 == 0) {
					System.out.println();
					System.out.println();
					System.out.println();
					System.out.println();
					System.out.println("=================아이템 설명=================");
					System.out.println("네잎클로버는 운빨을 높여줍니다.(운빨은 광물 채굴 시 돈을 2배로 획득 할 확률입니다.)");
					System.out.println("무료 강화권은 강화 시 비용을 대체하여 사용할 수 있습니다.");
					System.out.println("강화 확정권은 강화 시 무조건 성공하게 해주는 아이템입니다.");
					System.out.println("도박은 45%의 확률로 배팅한 금액의 2배를 획득하게 되는 컨텐츠 입니다.");
					System.out.println("자동 곡괭이 수리권은 곡괭이 내구도가 전부 닳게 되면 자동으로 비용을 지불하여 수리를 하게 해줍니다.");
					System.out.println();
					System.out.println("다음 : 0");
					System.out.println();
					}
					int val3 = Integer.parseInt(sc.nextLine());
					if (val3 == 0) {
					System.out.println();
					System.out.println();
					System.out.println();
					System.out.println();
					System.out.println();
					System.out.println();
					System.out.println("=============레벨 별 곡괭이 강화 확률============");
					System.out.println("1~9 = 90%");
					System.out.println("10~19 = 80%");
					System.out.println("20~29 = 70%");
					System.out.println("30~39 = 60%");
					System.out.println("40~59 = 50%");
					System.out.println("60~79 = 40%, 실패시 하락 확률 1%");
					System.out.println("80~100 = 40%, 실패시 하락 확률 5%");
					System.out.println();
					System.out.println("다음 : 0");
					System.out.println();
					}
					int val4 = Integer.parseInt(sc.nextLine());
					if (val4 == 0) {
					System.out.println();
					System.out.println();
					System.out.println();
					System.out.println();
					System.out.println();
					System.out.println();
					System.out.println("==============레벨 별 곡괭이 등급==============");
					System.out.println("0~9 : 못써먹겠다 싶을정도로 낡은 곡괭이");
					System.out.println("10~19 : 그나마 써볼만 할 것 같은 곡괭이");
					System.out.println("20~29 : 이제 좀 봐줄만한 곡괭이");
					System.out.println("30~39 : 어디가서 욕은 안 먹을만한 곡괭이");
					System.out.println("40~59 : 꽤 고급스러운 곡괭이");
					System.out.println("60~79 : 엄청난 퀄리티의 곡괭이");
					System.out.println("80~99 : 신조차도 만져보지 못한 곡괭이");
					System.out.println("100~ : 이세카이 곡괭이");
					System.out.println();
					System.out.println("설명 종료 : 0");
					System.out.println();
					}
					int val5 = Integer.parseInt(sc.nextLine());
					if (val5 == 0) {
					break;
					}
				case 4 :
					stat.store();
					break;
				case 5 :
					stat.radiation();
					break;
				case 0 :
					System.out.println("정말로 종료하시겠습니까? 1 : 종료, 0 : 취소");
					int val6 = Integer.parseInt(sc.nextLine());
					if (val6 == 0) {
						break;
					} else if(val6 == 1) {
						System.out.println("게임이 종료됩니다.");
						stat.game = false;
						break;
					}
				default :
					System.out.println("숫자를 제대로 입력해주세요.,");
					break;
			}
			
		}
		
	}

}
