package game;

import java.util.Scanner;

public class Status {

	int level;		//곡괭이 레벨
	int money;		//돈
	int coupon1;	//무료 강화권
	int coupon2;	//강화 확정권
	int coupon3;	//무료 곡괭이 수리권
	int value;		//강화 금액
	int levelRange; //레벨범위
	int percentage;	//강화확률
	int expense;	//강화비용
	int luck;		//운빨
	int clober = 30000;	//클로버 비용
	int att;		//곡괭이 남은 내구도
	int att2 = 0;	//사용 내구도
	int att3;		//최대 내구도
	int expense2;	//곡괭이 내구도 수리 비용
	int expense3;	//내구도 강화 비용
	int day;		//현재 날짜
	int day2 = 10;	//방사능 남은 날짜
	int day3;		//10day3 == 1day
	int radiationLevel;//방사능 제거 필요 레벨
	int radiationAtt;//방사능 HP
	int radiationAtt2;//방사능 최대 HP
	boolean game;	//게임 시작, 종료
	String name;	//곡괭이 이름
	boolean auto;	//곡괭이 자동 강화기
	int[] ex = {50, 1000, 10000, 50000, 100000, 150000, 250000};//강화 비용 배열
	int[] ex2 = {1, 10, 100, 500, 1000, 1500, 2500}; 		//수리 비용 배열
	
	Status(String name,int radiationAtt2, int coupon3, boolean auto, boolean game, int day3, int radiationAtt, int radiationLevel,int day, int att3, int expense3, int level, int att, int money, int coupon1, int coupon2, int levelRange, int percentage, int expense, int luck, int expense2){
		this.name = name;
		this.game = game;
		this.radiationAtt2 = radiationAtt2;
		this.coupon3 = coupon3;
		this.day3 = day3;
		this.radiationLevel = radiationLevel;
		this.radiationAtt = radiationAtt;
		this.day = day;
		this.level = level;
		this.money = money;
		this.att = att;
		this.coupon1 = coupon1;
		this.coupon2 = coupon2;
		this.levelRange = levelRange;
		this.percentage = percentage;
		this.expense = expense;
		this.luck = luck;
		this.expense2 = expense2;
		this.expense3 = expense3;
		this.att3 = att3;
		this.auto = auto;
	}
	
	// ============================ 정 보 =================================
	public void stat() {
		System.out.println();
		System.out.println();
		System.out.println("======================================================================");
		System.out.println("곡괭이 등급 : " + name);
		System.out.println("곡괭이 레벨 : " + level);
		System.out.println("현재 곡괭이 내구도 : " + att);
		System.out.println("현재 자산 : " + money + "원");
		System.out.println("무료 강화권 : " + coupon1 + "장");
		System.out.println("강화 확정권 : " + coupon2 + "장");
		System.out.println("무료 수리권 : " + coupon3 + "장");
		System.out.println("장비 강화 금액 : " + expense + "원");
		System.out.println("운빨(획득 금액 2배 확률) : " + luck + "%");
		if (auto == true) {
			System.out.println("☆★☆★자동수리기 소지 중★☆★☆");
		}

		System.out.println("수리 금액 : 1당 " + expense2 + "원");
		System.out.println("현재 지난 날짜 : " + day + "일");
		System.out.println("방사능 물질 파괴까지 남은 날짜 : " + day2 + "일");
		System.out.println("======================================================================");
		System.out.println();
	}
	// ============================ 강 화 =================================
	public void enforce() {
		Scanner sc = new Scanner(System.in);
		System.out.println();
		System.out.println("======================================================================");
		System.out.println("장비를 강화합니다.");
		System.out.println("현재 장비 레벨 : " + level);
		System.out.println("현재 자산 : " + money);
		System.out.println("장비 강화 금액 : " + expense);
		System.out.println("======================================================================");
		System.out.println();
		if (money < expense) {
			System.out.println();
			System.out.println("======================================================================");
			System.out.println("강화 금액이 부족합니다. 이전으로 돌아갑니다.");
			System.out.println("현재 소지금 : " + money + ", 강화 비용 : " + expense);
			System.out.println("======================================================================");
			System.out.println();
		} else if (money < expense2 * att2) {
			System.out.println();
			System.out.println("======================================================================");
			System.out.println("곡괭이 수리를 먼저 해주세요!!");
			System.out.println("======================================================================");
			System.out.println();
		} else if(money >= expense) {
			while(true) {
				if (money < expense) {
					System.out.println();
					System.out.println("======================================================================");
					System.out.println("강화 금액이 부족합니다. 이전으로 돌아갑니다.");
					System.out.println("현재 소지금 : " + money + "강화 비용 : " + expense);
					System.out.println("======================================================================");
					System.out.println();
					break;
				}
				System.out.println();
				System.out.println();
				System.out.println("======================================================================");
				System.out.println("강화를 진행하시겠습니까?");
				System.out.println("1 : 진행, 2 : 연속 강화, 3 : 무료 강화권 사용, 4 : 강화 확정권 사용 0 : 취소");
				System.out.println("======================================================================");
				int val = Integer.parseInt(sc.nextLine());
				if (val == 1) {
					if (money < expense) {
						System.out.println();
						System.out.println("======================================================================");
						System.out.println("강화 금액이 부족합니다. 이전으로 돌아갑니다.");
						System.out.println("현재 소지금 : " + money + "강화 비용 : " + expense);
						System.out.println("======================================================================");
						System.out.println();
						break;
					} else if (money < expense2 * att2) {
						System.out.println();
						System.out.println("======================================================================");
						System.out.println("곡괭이 수리를 먼저 해주세요!!");
						System.out.println("======================================================================");
						System.out.println();
					} 
					int random = (int)(Math.random()*10 + 1)*10;
					int random2 = (int)(Math.random()*10 + 1)*10;
					if (level <= levelRange && random > percentage) {
						System.out.println();
						System.out.println("======================================================================");
						System.out.println("강화에 성공하셨습니다!!");
						level++;
						System.out.println("현재 level : " + level);
						money = money - expense;
						System.out.println( "현재 남은 금액 : " + money);
						System.out.println("======================================================================");
							if (level == 10) {
								levelRange = levelRange + 10;
								percentage = percentage + 10;
								expense = ex[1];
								expense2 = ex2[1];
								name = "그나마 써볼만 할 것 같은 곡괭이";
								System.out.println();
								System.out.println("☆★☆★곡괭이 등급이 " + name + "로 강화되었습니다.★☆★☆");
								System.out.println();
							} else if (level == 20) {
								levelRange = levelRange + 10;
								percentage = percentage + 10;
								expense = ex[2];
								expense2 = ex2[2];
								name = "이제 좀 봐줄만한 곡괭이";
								System.out.println();
								System.out.println("☆★☆★곡괭이 등급이 " + name + "로 강화되었습니다.★☆★☆");
								System.out.println();
							} else if (level == 30) {
								levelRange = levelRange + 10;
								percentage = percentage + 10;
								expense = ex[3];
								expense2 = ex2[3];
								name = "어디가서 욕은 안 먹을만한 곡괭이";
								System.out.println();
								System.out.println("☆★☆★곡괭이 등급이 " + name + "로 강화되었습니다.★☆★☆");
								System.out.println();
							} else if(level == 40) {
								levelRange = levelRange + 20;
								percentage = percentage + 10;
								expense = ex[4];
								expense2 = ex2[4];;
								name = "꽤 고급스러운 곡괭이";
								System.out.println();
								System.out.println("☆★☆★곡괭이 등급이 " + name + "로 강화되었습니다.★☆★☆");
								System.out.println();
							} else if(level == 60) {
								levelRange = levelRange + 20;
								percentage = percentage + 10;
								expense = ex[5];
								expense2 = ex2[5];
								name = "엄청난 퀄리티의 곡괭이";
								System.out.println();
								System.out.println("☆★☆★곡괭이 등급이 " + name + "로 강화되었습니다.★☆★☆");
								System.out.println();
							} else if(level == 80) {
								levelRange = levelRange + 20;
								expense = ex[6];
								expense2 = ex2[6];
								name = "신조차도 만져보지 못한 곡괭이";
								System.out.println();
								System.out.println("☆★☆★곡괭이 등급이 " + name + "로 강화되었습니다.★☆★☆");
								System.out.println();
							} else if(level == 100) {
								System.out.println("======================================================================");
								System.out.println("======================================================================");
								System.out.println("======================================================================");
								System.out.println("======================================================================");
								System.out.println("축하드립니다! 게임을 클리어하셨습니다!!");
								name = "이세카이 곡괭이";
								System.out.println();
								System.out.println("☆★☆★곡괭이 등급이 " + name + "로 강화되었습니다.★☆★☆");
								System.out.println();
								System.out.println("======================================================================");
								System.out.println("======================================================================");
								System.out.println("======================================================================");
								System.out.println("======================================================================");
								System.out.println("게임을 계속 진행하시겠습니까?   1 : 예, 2 : 종료");
								int val7 = Integer.parseInt(sc.nextLine());
								if (val7 == 1) {
								break;
								} else if (val7 == 2) {
									System.out.println("축하드립니다. 게임을 클리어하셨습니다!!");
									game = false;
									break;
								}
							}
					} else if (level <= levelRange && random <= percentage) {
						System.out.println();
						System.out.println("======================================================================");
						System.out.println("강화에 실패하셨습니다.. ㅠㅠ");
						if ((level > 60 && random2 > 99) || (level > 80 && random2 > 95)) {
							System.out.println("심지어 하락했네요...");
							level = level - 1;
							if (level == 59) {
								levelRange = - 20;
								percentage = - 10;
								expense = 25000;
							} if (level == 79) {
								levelRange = - 20;
								expense = 50000;
							}
						System.out.println( "현재 level : " + level);
						money = money - expense;
						System.out.println( "현재 남은 금액 : " + money);
						System.out.println("======================================================================");
					}
					}
				} else if (val == 0) {
					System.out.println();
					System.out.println("이전으로 돌아갑니다.");
					break;
				} else if (val == 4) {
					if (coupon2 == 0) {
						System.out.println();
						System.out.println("쿠폰이 부족합니다..");
						break;
					} else if (coupon2 != 0) {
						System.out.println();
						System.out.println("강화 확정권을 사용하시겠습니까?");
						System.out.println("사용 : 1, 취소 : 0");
						int val3 = Integer.parseInt(sc.nextLine());
						switch (val3) {
						case 1 :
							coupon2 = coupon2 - 1;
							level = level++;
							if (level == 10) {
								levelRange = levelRange + 10;
								percentage = percentage + 10;
								expense = ex[1];
								expense2 = ex2[1];
								name = "그나마 써볼만 할 것 같은 곡괭이";
								System.out.println();
								System.out.println("☆★☆★곡괭이 등급이 " + name + "로 강화되었습니다.★☆★☆");
								System.out.println();
							} else if (level == 20) {
								levelRange = levelRange + 10;
								percentage = percentage + 10;
								expense = ex[2];
								expense2 = ex2[2];
								name = "이제 좀 봐줄만한 곡괭이";
								System.out.println();
								System.out.println("☆★☆★곡괭이 등급이 " + name + "로 강화되었습니다.★☆★☆");
								System.out.println();
							} else if (level == 30) {
								levelRange = levelRange + 10;
								percentage = percentage + 10;
								expense = ex[3];
								expense2 = ex2[3];
								name = "어디가서 욕은 안 먹을만한 곡괭이";
								System.out.println();
								System.out.println("☆★☆★곡괭이 등급이 " + name + "로 강화되었습니다.★☆★☆");
								System.out.println();
							} else if(level == 40) {
								levelRange = levelRange + 20;
								percentage = percentage + 10;
								expense = ex[4];
								expense2 = ex2[4];;
								name = "꽤 고급스러운 곡괭이";
								System.out.println();
								System.out.println("☆★☆★곡괭이 등급이 " + name + "로 강화되었습니다.★☆★☆");
								System.out.println();
							} else if(level == 60) {
								levelRange = levelRange + 20;
								percentage = percentage + 10;
								expense = ex[5];
								expense2 = ex2[5];
								name = "엄청난 퀄리티의 곡괭이";
								System.out.println();
								System.out.println("☆★☆★곡괭이 등급이 " + name + "로 강화되었습니다.★☆★☆");
								System.out.println();
							} else if(level == 80) {
								levelRange = levelRange + 20;
								expense = ex[6];
								expense2 = ex2[6];
								name = "신조차도 만져보지 못한 곡괭이";
								System.out.println();
								System.out.println("☆★☆★곡괭이 등급이 " + name + "로 강화되었습니다.★☆★☆");
								System.out.println();
							} else if(level == 100) {
								System.out.println("======================================================================");
								System.out.println("======================================================================");
								System.out.println("======================================================================");
								System.out.println("======================================================================");
								System.out.println("축하드립니다! 게임을 클리어하셨습니다!!");
								name = "이세카이 곡괭이";
								System.out.println();
								System.out.println("☆★☆★곡괭이 등급이 " + name + "로 강화되었습니다.★☆★☆");
								System.out.println();
								System.out.println("======================================================================");
								System.out.println("======================================================================");
								System.out.println("======================================================================");
								System.out.println("======================================================================");
								System.out.println("게임을 계속 진행하시겠습니까?   1 : 예, 2 : 종료");
								int val7 = Integer.parseInt(sc.nextLine());
								if (val7 == 1) {
								break;
								} else if (val7 == 2) {
									System.out.println("축하드립니다. 게임을 클리어하셨습니다!!");
									game = false;
									break;
								}
							}
							System.out.println();
							System.out.println("======================================================================");
							System.out.println("강화 확정권을 사용하여 level " + level + "이 되었습니다.");
							System.out.println("현재 남은 강화 확정권 : " + coupon2 + "장");
							System.out.println("======================================================================");
							break;
						}
					}
				}
				else if (val == 3) {
					if (coupon1 == 0) {
						System.out.println();
						System.out.println("쿠폰이 부족합니다..");
						break;
					} else if (coupon1 != 0) {
						System.out.println();
					System.out.println("무료 강화권을 사용하시겠습니까?");
					System.out.println("사용 : 1, 취소 : 0");
					int val2 = Integer.parseInt(sc.nextLine());
					if (coupon1 >= 1) {
						if (val2 == 1) {
							int random1 = (int)(Math.random()*10 + 1)*10;
							int random21 = (int)(Math.random()*10 + 1)*10;
							if (level <= levelRange && random1 > percentage) {
								System.out.println();
								System.out.println("======================================================================");
								System.out.println("강화에 성공하셨습니다!!");
								level++;
								System.out.println("현재 level : " + level);
								coupon1 = coupon1 - 1;
								System.out.println( "현재 남은 강화권 : " + coupon1 + "장");
								System.out.println("======================================================================");
								if (level == 10) {
									levelRange = levelRange + 10;
									percentage = percentage + 10;
									expense = ex[1];
									expense2 = ex2[1];
									name = "그나마 써볼만 할 것 같은 곡괭이";
									System.out.println();
									System.out.println("☆★☆★곡괭이 등급이 " + name + "로 강화되었습니다.★☆★☆");
									System.out.println();
								} else if (level == 20) {
									levelRange = levelRange + 10;
									percentage = percentage + 10;
									expense = ex[2];
									expense2 = ex2[2];
									name = "이제 좀 봐줄만한 곡괭이";
									System.out.println();
									System.out.println("☆★☆★곡괭이 등급이 " + name + "로 강화되었습니다.★☆★☆");
									System.out.println();
								} else if (level == 30) {
									levelRange = levelRange + 10;
									percentage = percentage + 10;
									expense = ex[3];
									expense2 = ex2[3];
									name = "어디가서 욕은 안 먹을만한 곡괭이";
									System.out.println();
									System.out.println("☆★☆★곡괭이 등급이 " + name + "로 강화되었습니다.★☆★☆");
									System.out.println();
								} else if(level == 40) {
									levelRange = levelRange + 20;
									percentage = percentage + 10;
									expense = ex[4];
									expense2 = ex2[4];;
									name = "꽤 고급스러운 곡괭이";
									System.out.println();
									System.out.println("☆★☆★곡괭이 등급이 " + name + "로 강화되었습니다.★☆★☆");
									System.out.println();
								} else if(level == 60) {
									levelRange = levelRange + 20;
									percentage = percentage + 10;
									expense = ex[5];
									expense2 = ex2[5];
									name = "엄청난 퀄리티의 곡괭이";
									System.out.println();
									System.out.println("☆★☆★곡괭이 등급이 " + name + "로 강화되었습니다.★☆★☆");
									System.out.println();
								} else if(level == 80) {
									levelRange = levelRange + 20;
									expense = ex[6];
									expense2 = ex2[6];
									name = "신조차도 만져보지 못한 곡괭이";
									System.out.println();
									System.out.println("☆★☆★곡괭이 등급이 " + name + "로 강화되었습니다.★☆★☆");
									System.out.println();
								} else if(level == 100) {
									System.out.println("======================================================================");
									System.out.println("======================================================================");
									System.out.println("======================================================================");
									System.out.println("======================================================================");
									System.out.println("축하드립니다! 게임을 클리어하셨습니다!!");
									name = "이세카이 곡괭이";
									System.out.println();
									System.out.println("☆★☆★곡괭이 등급이 " + name + "로 강화되었습니다.★☆★☆");
									System.out.println();
									System.out.println("======================================================================");
									System.out.println("======================================================================");
									System.out.println("======================================================================");
									System.out.println("======================================================================");
									System.out.println("게임을 계속 진행하시겠습니까?   1 : 예, 2 : 종료");
									int val7 = Integer.parseInt(sc.nextLine());
									if (val7 == 1) {
									break;
									} else if (val7 == 2) {
										System.out.println("축하드립니다. 게임을 클리어하셨습니다!!");
										game = false;
										break;
									}
								}
							} else if (level <= levelRange && random1 <= percentage) {
								System.out.println();
								System.out.println("======================================================================");
								System.out.println("강화에 실패하셨습니다.. ㅠㅠ");
								if (level > 60 && random21 > 99 || level < 80 && random21 > 99) {
									System.out.println("심지어 하락했네요...");
									level = level - 1;
								} else if (level > 80 && random21 > 95) {
									level = level - 1;
								}
								System.out.println( "현재 level : " + level);
								coupon1 = coupon1 - 1;
								System.out.println( "현재 남은 강화권 : " + coupon1 + "장");
								System.out.println("======================================================================");
								System.out.println();
							} 

						} else if (val == 0) {
							System.out.println();
							System.out.println("이전으로 돌아갑니다.");
							System.out.println();
							break;
						} else {
							System.out.println();
							System.out.println("숫자를 제대로 입력해주세요.");
							System.out.println();
						}
					}
				}
				}
				else if (val == 2) {
					System.out.println();
					System.out.println("연속강화를 몇회 진행하시겠습니까?  0 : 취소");
					int nu = Integer.parseInt(sc.nextLine());
					if(nu == 0) {
						System.out.println();
						System.out.println("======================================================================");
						System.out.println("뒤로 돌아갑니다.");
						System.out.println("======================================================================");
						System.out.println();
					} else if (nu > 0) {
						int j = 0;
						for (int i = 1; i <= nu; i++) {
							int random3 = (int)(Math.random()*10 + 1)*10;
							int random4 = (int)(Math.random()*10 + 1)*10;
							if (money < expense) {
								System.out.println();
								System.out.println("======================================================================");
								System.out.println("강화 금액이 부족합니다. 이전으로 돌아갑니다.");
								System.out.println("======================================================================");
								System.out.println();
								i = nu + 10;
							}  else if (money < expense2 * att2) {
								System.out.println();
								System.out.println("======================================================================");
								System.out.println("곡괭이 수리를 먼저 해주세요!!");
								System.out.println("======================================================================");
								System.out.println();
							} else if (money * val > expense) {
								money = money - expense;
								if (level <= levelRange && random3 > percentage) {
									System.out.println("======================================================================");
									System.out.println("강화에 성공하셨습니다!!");
									level++;
									System.out.println("현재 level : " + level);
									System.out.println("======================================================================");
									if (level == 10) {
										levelRange = levelRange + 10;
										percentage = percentage + 10;
										expense = ex[1];
										expense2 = ex2[1];
										name = "그나마 써볼만 할 것 같은 곡괭이";
										System.out.println();
										System.out.println("☆★☆★곡괭이 등급이 " + name + "로 강화되었습니다.★☆★☆");
										System.out.println();
									} else if (level == 20) {
										levelRange = levelRange + 10;
										percentage = percentage + 10;
										expense = ex[2];
										expense2 = ex2[2];
										name = "이제 좀 봐줄만한 곡괭이";
										System.out.println();
										System.out.println("☆★☆★곡괭이 등급이 " + name + "로 강화되었습니다.★☆★☆");
										System.out.println();
									} else if (level == 30) {
										levelRange = levelRange + 10;
										percentage = percentage + 10;
										expense = ex[3];
										expense2 = ex2[3];
										name = "어디가서 욕은 안 먹을만한 곡괭이";
										System.out.println();
										System.out.println("☆★☆★곡괭이 등급이 " + name + "로 강화되었습니다.★☆★☆");
										System.out.println();
									} else if(level == 40) {
										levelRange = levelRange + 20;
										percentage = percentage + 10;
										expense = ex[4];
										expense2 = ex2[4];;
										name = "꽤 고급스러운 곡괭이";
										System.out.println();
										System.out.println("☆★☆★곡괭이 등급이 " + name + "로 강화되었습니다.★☆★☆");
										System.out.println();
									} else if(level == 60) {
										levelRange = levelRange + 20;
										percentage = percentage + 10;
										expense = ex[5];
										expense2 = ex2[5];
										name = "엄청난 퀄리티의 곡괭이";
										System.out.println();
										System.out.println("☆★☆★곡괭이 등급이 " + name + "로 강화되었습니다.★☆★☆");
										System.out.println();
									} else if(level == 80) {
										levelRange = levelRange + 20;
										expense = ex[6];
										expense2 = ex2[6];
										name = "신조차도 만져보지 못한 곡괭이";
										System.out.println();
										System.out.println("☆★☆★곡괭이 등급이 " + name + "로 강화되었습니다.★☆★☆");
										System.out.println();
									} else if(level == 100) {
										System.out.println("======================================================================");
										System.out.println("======================================================================");
										System.out.println("======================================================================");
										System.out.println("======================================================================");
										System.out.println("축하드립니다! 게임을 클리어하셨습니다!!");
										name = "이세카이 곡괭이";
										System.out.println();
										System.out.println("☆★☆★곡괭이 등급이 " + name + "로 강화되었습니다.★☆★☆");
										System.out.println();
										System.out.println("======================================================================");
										System.out.println("======================================================================");
										System.out.println("======================================================================");
										System.out.println("======================================================================");
										System.out.println("게임을 계속 진행하시겠습니까?   1 : 예, 2 : 종료");
										int val7 = Integer.parseInt(sc.nextLine());
										if (val7 == 1) {
										break;
										} else if (val7 == 2) {
											System.out.println("축하드립니다. 게임을 클리어하셨습니다!!");
											game = false;
											break;
										}
									}
								} else if (level <= levelRange && random3 <= percentage) {
									System.out.println("======================================================================");
									System.out.println("강화에 실패하셨습니다.. ㅠㅠ");
									if ((level > 60 && random4 > 99) || (level > 80 && random4 > 95)) {
										System.out.println("심지어 하락했네요...");
										level = level - 1;

										if (level == 59) {
											levelRange = - 20;
											percentage = - 10;
											expense = 25000;
										} if (level == 79) {
											levelRange = - 20;
											expense = 50000;
										}
									}
									System.out.println( "현재 level : " + level);
									System.out.println("======================================================================");
								}
							}
							System.out.println( "현재 남은 금액 : " + money);
							System.out.println("======================================================================");
						}
						break;
					}
				} else {
					System.out.println();
					System.out.println();
					System.out.println();
					System.out.println();
					System.out.println();
					System.out.println("숫자를 다시 입력해주세요.");
				}
				
			
			}
			}
		
	} // 강화 메소드 끝
	// =========================== 방 사 능 ====================================
	public void radiation () {
		Scanner sc = new Scanner(System.in);
		System.out.println();
		System.out.println();
		System.out.println("방사능 물질을 제거합니다. 4턴 내에 제거해야 성공합니다.");
		System.out.println("곡괭이 내구도는 공격력이 되고 운빨은 1.5배 데미지 확률이 됩니다.");
		System.out.println("방사능 물질 제거까지 남은 기간 : " + day2);
		System.out.println("필요 레벨 : " + radiationLevel + ", 내 곡괭이 레벨 : " + level);
		System.out.println("방사능 HP : " + radiationAtt + ", 내 곡괭이 내구도 : " + att3);
		System.out.println("방사능 물질 제거를 시작하시겠습니까?  1 : 예, 2 : 아니오");
		int val = Integer.parseInt(sc.nextLine());
		int turn = 4;
		int percent = 0;
		if (val == 1) {
		battle : while(true) {
			if (level >= radiationLevel) {
				if (turn != 0 && radiationAtt > 0) {
				System.out.println();
				System.out.println("방사능 물질 제거를 시작합니다.  0 : 방사능 캐기");
				int val2 = Integer.parseInt(sc.nextLine());
				if (val2 == 0) {
					int random = (int)(Math.random()*100 + 1);
					int random2 = (int)(Math.random()*5 + 1);
					if (random2 == 1) {
						percent = (int)(0.8 * att3);
					} else if (random2 == 2) {
						percent = (int)(0.9 * att3);
					} else if (random2 == 3) {
						percent = (int)(1 * att3);
					} else if (random2 == 4) {
						percent = (int)(1.1 * att3);
					} else if (random2 == 5) {
						percent = (int)(1.2 * att3);
					} 
					if (random <= luck) {
						System.out.println();
						System.out.println("치명타가 발생해 1.5배를 "+ (int)(percent*1.5) +" 데미지를 입혔습니다!!");
						radiationAtt = radiationAtt - (int)(percent*1.5);
						if (radiationAtt < 0) {
							radiationAtt = 0;
						}
						System.out.println();
						turn = turn - 1;
						System.out.println("현재 방사능 HP : " + radiationAtt + ", 남은 턴 : " + turn);
					} else {
						System.out.println();
						System.out.println(percent +"의 데미지를 입혔습니다.");
						radiationAtt = radiationAtt - percent;
						if (radiationAtt < 0) {
							radiationAtt = 0;
						}
						System.out.println();
						turn = turn - 1;
						System.out.println("현재 방사능 HP : " + radiationAtt + ", 남은 턴 : " + turn);
					}
				}
				} else if (turn == 0 && radiationAtt > 0) {
					System.out.println();
					System.out.println("방사능 제거를 실패하였습니다..");
					System.out.println();
					radiationAtt = radiationAtt2;
					break battle;
				} else if (turn != 0 && radiationAtt <= 0 || turn == 0 && radiationAtt <= 0) {
					System.out.println();
					System.out.println();
					System.out.println("방사능 물질 제거에 성공하였습니다!!");
					radiationLevel = radiationLevel + 10;
					radiationAtt2 = (int)(radiationAtt2 * 1.5);
					radiationAtt = radiationAtt2;
					int random = (int)(Math.random()*2+1);
					if (random == 1) {
					System.out.println("50% 확률로 곡괭이 무료 수리권을 획득하셨습니다!!");
					coupon3 = coupon3 + 1;
					}
					day2 = day2 + 10;
					System.out.println();
					System.out.println("다음 방사능 물질 제거까지 남은 기간 : " + day2);
					break battle;
				}
			} else if (level < radiationLevel) {
				System.out.println();
				System.out.println();
				System.out.println("곡괭이 레벨이 부족합니다.");
				break battle;
			}
			}
			}else if (val == 2) {
			System.out.println();
			System.out.println();
			System.out.println("이전으로 돌아갑니다.");
		}
		}
		
	// ============================= 광 산 ==================================
	public void mine () {
		Scanner sc = new Scanner(System.in);
		if (att2 == att3 || att == 0) {
			System.out.println();
			System.out.println();
			System.out.println("======================================================================");
			System.out.println("☆★☆★☆★상점에서 곡괭이를 수리해주세요.☆★☆★☆★");
			System.out.println();
			System.out.println("확인 : 아무 숫자나 입력해주세요.");
			System.out.println("======================================================================");
			int b = Integer.parseInt(sc.nextLine());
		}
		else if (att2 < att3) {
		boolean a = true;

		while (a) {
			if (auto == false) {
				if (att == 0) {
					System.out.println();
					System.out.println();
					System.out.println("======================================================================");
					System.out.println("☆★☆★☆★상점에서 곡괭이를 수리해주세요.☆★☆★☆★");
					System.out.println();
					System.out.println("확인 : 아무 숫자나 입력해주세요.");
					System.out.println("======================================================================");
					int b = Integer.parseInt(sc.nextLine());
					a = false;
					break;
				}
			} else if (auto == true && att == 0) {
				System.out.println();
				System.out.println();
				System.out.println();
				System.out.println("곡괭이를 자동 수리하여 " + (expense2 * att2) + "원의 비용이 들었습니다.");
				System.out.println("남은 돈 : " + money + "원");
				System.out.println();
				System.out.println();
				att2 = 0;
				att = att3;
				System.out.println("확인 : 아무 숫자나 입력해주세요.");
				int b = Integer.parseInt(sc.nextLine());
			}
			if (day2 == 0) {
				System.out.println("방사능 물질에 오염되어 죽었습니다...");
				game = false;
			} else if (day2 == 5) {
				System.out.println();
				System.out.println("방사능 물질 제거까지 5일 남았습니다!!");
			} else if (day2 == 1) {
				System.out.println("방사능 물질을 1일 내에 제거해주세요!!");
			}
			System.out.println("채굴 할 광물을 선택해주세요. 현재 소지 금액 : " + money + "원, 내 곡괭이 레벨 : " + level);
			System.out.println("☆★현재 날짜" + day + "일★☆");
			System.out.println("★☆방사능물질 채굴까지 남은 날짜" + day2 + "일☆★");
			System.out.println("1 : 돌덩이 캐기(50원) / level 1 ~");
			System.out.println("2 : 짱돌 캐기(500원) / level 10 ~");
			System.out.println("3 : 철광석 캐기(8000원) / level 20 ~");
			System.out.println("4 : 금 캐기(20000원) / level 30 ~ / 무료강화권 0.1%");
			System.out.println("5 : 다이아몬드 캐기(50000원) / level 40 ~ / 무료강화권 0.1%");
			System.out.println("6 : 캘리포늄 캐기 (150000원) / level 60 ~ / 무료강화권 1%, 강화확정권 0.1%");
			System.out.println("7 : 티타늄 캐기(450000원) / level 80 ~ / 무료강화권 1%, 강화확정권 0.1%");
			System.out.println("0 : 나가기");
		int val = Integer.parseInt(sc.nextLine());
		int random = (int)(Math.random() * 100 + 1);
		int random2 = (int)(Math.random() * 1000 + 1);
		int random3 = (int)(Math.random() * 1000 + 1);
		switch (val) {
			case 1 :
				System.out.println("======================================================================");
				System.out.println("돌덩이를 캡니다.");
				if (random <= luck) {
					System.out.println();
					System.out.println("대박이 났습니다!!");
					System.out.println("100원을 획득했습니다.");
					money = money + 100;
					System.out.println("현재 소지금 : " + money + "원");
				} else if (random > luck) {
					System.out.println();
					System.out.println("50원을 획득했습니다.");
					money = money + 50;
					System.out.println("현재 소지금 : " + money + "원");
				}
				att2 = att2 + 1;
				att = att - 1;
				System.out.println("현재 곡괭이 내구도 : " + att);
				System.out.println("======================================================================");
				day3 = day3 + 1;
				if (day3 == 10) {
					day = day + 1;
					day3 = 0;
					day2 = day2 - 1;
					System.out.println("하루가 지났습니다.");
					System.out.println("현재 날짜 : " + day);
					System.out.println("방사능 제거까지 남은 날짜 : " + day2);
				}
				break;
			case 2 :
				if (level >= 10) {
					System.out.println("======================================================================");
					System.out.println("짱돌을 캡니다.");
					if (random <= luck) {
						System.out.println();
						System.out.println("대박이 났습니다!!");
						money = money + 1000;
						System.out.println("1000원을 획득했습니다.");
						System.out.println("현재 소지금 : " + money + "원");

					} else if (random > luck) {
						System.out.println();
						System.out.println("500원을 획득했습니다.");
						money = money + 500;
						System.out.println("현재 소지금 : " + money + "원");
					}
					att2 = att2 + 1;
					att = att - 1;
					System.out.println("현재 곡괭이 내구도 : " + att);
					System.out.println("======================================================================");
					day3 = day3 + 1;
					if (day3 == 10) {
						day = day + 1;
						day3 = 0;
						day2 = day2 - 1;
						System.out.println("하루가 지났습니다.");
						System.out.println("현재 날짜 : " + day);
						System.out.println("방사능 제거까지 남은 날짜 : " + day2);
					}
				} else if(level < 10) {
					System.out.println("======================================================================");
					System.out.println("레벨이 부족합니다..");
					System.out.println("======================================================================");
				}
				
				break;
			case 3 :
				if (level >= 20) {
					System.out.println("철광석을 캡니다.");
					if (random <= luck) {
						System.out.println();
						System.out.println("대박이 났습니다!!");
						System.out.println("16000원을 획득했습니다.");
						money = money + 16000;
						System.out.println("현재 소지금 : " + money + "원");
					} else if (random > luck) {
						System.out.println();
						System.out.println("8000원을 획득했습니다.");
						money = money + 8000;
						System.out.println("현재 소지금 : " + money + "원");
					}
					att2 = att2 + 1;
					att = att - 1;
					System.out.println("현재 곡괭이 내구도 : " + att);
					System.out.println("======================================================================");
				} else if(level < 20) {
					System.out.println();
					System.out.println("======================================================================");
					System.out.println("레벨이 부족합니다..");
					System.out.println("======================================================================");
				}
				day3 = day3 + 1;
				if (day3 == 10) {
					day = day + 1;
					day3 = 0;
					day2 = day2 - 1;
					System.out.println("하루가 지났습니다.");
					System.out.println("현재 날짜 : " + day);
					System.out.println("방사능 제거까지 남은 날짜 : " + day2);
				}
				break;
			case 4 :
				if (level >= 30) {
					System.out.println("금을 캡니다.");
					if (random <= luck) {
						System.out.println();
						System.out.println("대박이 났습니다!!");
						System.out.println("40000원을 획득했습니다.");
						money = money + 40000;
						System.out.println("현재 소지금 : " + money + "원");
					} else if (random > luck) {
						System.out.println();
						System.out.println("20000원을 획득했습니다.");
						money = money + 20000;
						System.out.println("현재 소지금 : " + money + "원");
					} if (random2 <= 1) {
						System.out.println("☆★☆★☆★무료 강화권을 획득하셨습니다☆★☆★☆★");
						System.out.println("현재 무료 강화권" + coupon1 + "장");
					}
					att2 = att2 + 1;
					att = att - 1;
					System.out.println("현재 곡괭이 내구도 : " + att);
					System.out.println("======================================================================");
				} else if(level < 30) {
					System.out.println();
					System.out.println("======================================================================");
					System.out.println("레벨이 부족합니다..");
					System.out.println("======================================================================");
				}
				day3 = day3 + 1;
				if (day3 == 10) {
					day = day + 1;
					day3 = 0;
					day2 = day2 - 1;
					System.out.println("하루가 지났습니다.");
					System.out.println("현재 날짜 : " + day);
					System.out.println("방사능 제거까지 남은 날짜 : " + day2);
				}
				break;
			case 5 :
				if (level >= 40) {
					System.out.println("다이아몬드를 캡니다.");
					if (random <= luck) {
						System.out.println();
						System.out.println("대박이 났습니다!!");
						System.out.println("100000원을 획득했습니다.");
						money = money + 100000;
						System.out.println("현재 소지금 : " + money + "원");
					} else if (random > luck) {
						System.out.println();
						System.out.println("50000원을 획득했습니다.");
						money = money + 50000;
						System.out.println("현재 소지금 : " + money + "원");
					} if (random2 <= 1) {
						System.out.println("☆★☆★☆★무료 강화권을 획득하셨습니다☆★☆★☆★");
						System.out.println("현재 무료 강화권" + coupon1 + "장");
					}
					att2 = att2 + 1;
					att = att - 1;
					System.out.println("현재 곡괭이 내구도 : " + att);
					System.out.println("======================================================================");
					day3 = day3 + 1;
					if (day3 == 10) {
						day = day + 1;
						day3 = 0;
						day2 = day2 - 1;
						System.out.println("하루가 지났습니다.");
						System.out.println("현재 날짜 : " + day);
						System.out.println("방사능 제거까지 남은 날짜 : " + day2);
					}
				} else if(level < 40) {
					System.out.println();
					System.out.println("======================================================================");
					System.out.println("레벨이 부족합니다..");
					System.out.println("======================================================================");
				}

				break;
			case 6 :
				if (level >= 60) {
					System.out.println("캘리포늄을 캡니다.");
					if (random <= luck) {
						System.out.println();
						System.out.println("대박이 났습니다!!");
						System.out.println("300000원을 획득했습니다.");
						money = money + 300000;
						System.out.println("현재 소지금 : " + money + "원");
					} else if (random > luck) {
						System.out.println();
						System.out.println("150000원을 획득했습니다.");
						money = money + 150000;
						System.out.println("현재 소지금 : " + money + "원");
					} if (random2 <= 10) {
						System.out.println("☆★☆★☆★무료 강화권을 획득하셨습니다☆★☆★☆★");
						System.out.println("현재 무료 강화권" + coupon1 + "장");
					} if (random3 <= 1) {
						System.out.println("☆★☆★☆★강화 확정권을 획득하셨습니다☆★☆★☆★");
						System.out.println("현재 강화 확정권" + coupon2 + "장");
					}
					att2 = att2 + 1;
					att = att - 1;
					System.out.println("현재 곡괭이 내구도 : " + att);
					day3 = day3 + 1;
					if (day3 == 10) {
						day = day + 1;
						day3 = 0;
						day2 = day2 - 1;
						System.out.println("하루가 지났습니다.");
						System.out.println("현재 날짜 : " + day);
						System.out.println("방사능 제거까지 남은 날짜 : " + day2);
					}
					break;
				} else if(level < 60) {
					System.out.println();
					System.out.println("======================================================================");
					System.out.println("레벨이 부족합니다..");
					System.out.println("======================================================================");
				}

			case 7 :
				if (level >= 80) {
					System.out.println("티타늄을 캡니다.");
					if (random <= luck) {
						System.out.println();
						System.out.println("대박이 났습니다!!");
						System.out.println("900000원을 획득했습니다.");
						money = money + 900000;
						System.out.println("현재 소지금 : " + money + "원");
					} else if (random > luck) {
						System.out.println();
						System.out.println("450000원을 획득했습니다.");
						money = money + 450000;
						System.out.println("현재 소지금 : " + money + "원");
					} if (random2 <= 10) {
						System.out.println("☆★☆★☆★무료 강화권을 획득하셨습니다☆★☆★☆★");
						System.out.println("현재 무료 강화권" + coupon1 + "장");
					} if (random3 <= 1) {
						System.out.println("☆★☆★☆★강화 확정권을 획득하셨습니다☆★☆★☆★");
						System.out.println("현재 강화 확정권" + coupon2 + "장");
					}
					att2 = att2 + 1;
					att = att - 1;
					System.out.println("현재 곡괭이 내구도 : " + att);
					day3 = day3 + 1;
					if (day3 == 10) {
						day = day + 1;
						day3 = 0;
						day2 = day2 - 1;
						System.out.println("하루가 지났습니다.");
						System.out.println("현재 날짜 : " + day + "일");
						System.out.println("방사능 제거까지 남은 날짜 : " + day2 + "일");
					}
				} else if(level < 80) {
					System.out.println();
					System.out.println("======================================================================");
					System.out.println("레벨이 부족합니다..");
					System.out.println("======================================================================");
				}
				break;
			case 0 :
				System.out.println();
				System.out.println("광산에서 나갑니다.");
				a = false;
				break;
			default :
				System.out.println();
				System.out.println();
				System.out.println();
					System.out.println("숫자를 다시 입력해주세요.");
				break;
			}
		} 
		} //switch
	} //mine 메소드 끝
	// ============================ 상점 ==================================
	public void store() {
		Scanner sc = new Scanner(System.in);
		System.out.println();
		System.out.println();
		System.out.println("상점입니다.");
		System.out.println();
		System.out.println("현재 소지금 : " + money + "원");
		System.out.println("1 : 장비 강화 확정권 구매 : 3000000원");
		if (luck < 20) {
		System.out.println("2 : 네잎클로버 구매(운빨 + 1%, 최대 운빨 20까지)" + clober + "원, 현재 운빨 : " + luck + "%");
		} else if (luck == 20) {
			System.out.println("2 : 네잎클로버 최대 수량 구매 완료");
		}
		System.out.println("3 : 도박");
		System.out.println("4 : 곡괭이 수리, 비용 : " + (expense2 * att2) + "원");
		System.out.println("5 : 곡괭이 내구도 +2 강화, 비용 : " + expense3 + "원");
		if (auto == false) {
		System.out.println("6 : 곡괭이 자동수리기, 비용 : 1000000원");
		} else if(auto == true) {
			System.out.println("6 : 곡괭이 자동수리기 < 구매 완료");
		}
		System.out.println("0 : 나가기");
		System.out.println();
		System.out.println();
		int val = Integer.parseInt(sc.nextLine());
		switch (val) {
		case 1 :
			if (money >= 3000000) {
				System.out.println();
				System.out.println();
				System.out.println("장비 강화 확정권을 구매합니다.");
				money = money - 3000000;
				coupon2 = + coupon2 + 1;
				System.out.println("현재 소지금 : " + money + "원");
				System.out.println("현재 소지중인 강화 확정권 : " + coupon2 + "장");
			} else if(money < 3000000) {
				System.out.println();
				System.out.println();
				System.out.println("돈이 부족합니다.");
			}
			break;
		case 2 :
			if (luck < 20) {
			if (money >= clober) {
				System.out.println();
				System.out.println();
				System.out.println("클로버를 구입합니다.");
				money = money - clober;
				luck = luck + 1;
				System.out.println("현재 소지금 : " + money + "원");
				System.out.println("현재 운빨 : " + luck + "%");
				clober = (int)(clober*1.3 / 100) * 100;
				if (luck == 20) {
					clober = 999999;
				}
			} else if(money < clober) {
				System.out.println();
				System.out.println();
				System.out.println("돈이 부족합니다.");
			}
			} else if (luck >= 20) {
				System.out.println();
				System.out.println();
				System.out.println("최대 수량만큼 구매하였습니다.");
			}
			break;
		case 3 :
			System.out.println();
			System.out.println();
			System.out.println("도박을 합니다.");
			System.out.println("45% 확률로 배팅한 금액의 2배를 얻습니다.");
			System.out.println("배팅할 금액을 입력해주세요. 0 : 나가기");
			int val2 = Integer.parseInt(sc.nextLine());
			if (val2 == 0) {
				System.out.println();
				System.out.println();
				System.out.println("도박을 취소합니다.");
			} else if(val2 > 0) {
				if (val2 > money) {
					System.out.println();
					System.out.println();
					System.out.println("소지중인 금액보다 적은 금액을 입력하세요.");
				} else if (val2 <= money) {
					int random = (int)(Math.random() * 100 + 1);
					if (random >= 55) {
						System.out.println();
						System.out.println();
						System.out.println("축하드립니다!" + (val2 * 2) + "원을 획득하셨습니다!");
						money = money + val2;
						System.out.println("현재 소지금 : " + money + "원");
					} else if(random < 55) {
						System.out.println();
						System.out.println();
						System.out.println("안타깝게도 도박에 실패하였습니다..");
						money = money - val2;
						System.out.println("현재 소지금 : " + money + "원");
					}
				}
			}
			break;
		case 4 :
			if ((expense2 * att2) > money) {
				System.out.println();
				System.out.println();
				System.out.println("돈이 부족합니다.");
				if (coupon3 > 0) {
					System.out.println();
					System.out.println("현재 곡괭이 무료 수리권 " + coupon3 + "장이 있어 1장을 사용합니다.");
					coupon3 = coupon3 - 1;
					att2 = 0;
					att = att3;
					System.out.println("곡괭이 강화 시 수리금액도 감안하여 강화해주세요!!");
					System.out.println("남은 곡괭이 무료 수리권 : " + coupon3 + "장");
				}
			} else if ((expense2 * att2) <= money) {
				System.out.println();
				System.out.println();
			System.out.println("곡괭이를 수리하였습니다.");
			money = money - (expense2 * att2);
			System.out.println("현재 소지금 : " + money + "원");
			att2 = 0;
			att = att3;
			}
			break;
		case 5 : 
			System.out.println();
				if (expense3 > money) {
					System.out.println();
					System.out.println("돈이 부족합니다..");
				} else if (expense3 <= money) {
					att3 = att3 + 2;
					att = att3;
					money = money - expense3;
					expense3 = (int)(expense3 * 1.5 / 100) * 100;
					System.out.println();
					System.out.println("강화를 진행하여 최대 내구도가 " + att3 + "로 상승하였습니다.");
					System.out.println();
				}
			break;
		case 6 :
			if (auto == false) {
			if (money >= 1000000) {
				System.out.println();
				System.out.println("곡괭이 자동수리기를 구매합니다.");
				System.out.println();
				money = money - 1000000;
				auto = true;
			} else if(money < 1000000) {
				System.out.println();
				System.out.println("돈이 부족합니다..");
				System.out.println();
			}} else if(auto == true) {
				System.out.println();
				System.out.println("이미 구매하였습니다.");
				System.out.println();
			}
			break;
			
		case 0 :
			System.out.println();
			System.out.println();
			System.out.println("상점에서 나갑니다.");
			System.out.println();
			System.out.println();
			System.out.println();
			break;
		default :
			System.out.println();
			System.out.println();
			System.out.println("숫자를 제대로 입력해주세요.");
			System.out.println();
			System.out.println();
			System.out.println();
			break;
		}
	}
}

