/*
This is Wole's script to kill GmoB. Am I lazy? Yes I am. 
*/
script "getgmob.ash";
notify "Wole"; 
import <zlib.ash>; 
string getgmobVersion = "0.1"; 

//int getgmob_PAGE = 9999; 
//check_version("getgmtob", "getgmob", getgmobVersion, getgmob_PAGE); 

setvar("woleUseMall", true); 

boolean useMall = vars["woleUseMall"].to_boolean();
boolean hasMusk = have_skill($skill[musk]);
boolean hasCantata = have_skill($skill[cantata]);
boolean hasSmooth = have_skill($skill[smooth]);
boolean hasSonata = have_skill($skill[sonata]);

//This checks for Combat modifier skills and casts/shrugs them
void combatModBuff(string rate){
	if (rate == "plus") {
		if (have_effect($effect[smooth movements]) > 0) {
			cli_execute("shrug smooth movements");
		}
		if (have_effect($effect[Sonata of Sneakiness]) > 0) {
			cli_execute("shrug Sonata of Sneakiness");
		}
		if (hasMusk && have_effect($effect[musk]) == 0){
			use_skill($skill[musk]);
		}
		if (hasCantata && have_effect($effect[cantata]) == 0){
			use_skill($skill[cantata]);
		}
	}
	if (rate == "minus") {
		if (have_effect($effect[musk]) > 0) {
			cli_execute("shrug musk");
		}
		if (have_effect($effect[cantata]) > 0) {
			cli_execute("shrug cantata");
		}
		if (hasSmooth && have_effect($effect[smooth movements]) == 0){
			use_skill($skill[smooth movement]);
		}
		if (hasSonata && have_effect($effect[sonata of sneakiness]) == 0){
			use_skill($skill[sonata of sneakiness]);
		}
	}
}

void runAdv(location place) {
	if (my_adventures() >= 1) {
		adventure(1, place);
	}
	else {
		print("You are out of adventures", "red");
		abort();
	}
}		

void getMirror() {
	if (item_amount($item[antique hand mirror]) == 0) { 
		if (useMall) {
			buy(1, $item[antique hand mirror]);
		}
		else {
			print("Do you really want to farm for a mirror? Silly you!", "red");
		}	
	}
}

void main() {
	getMirror();
	maximize("-combat -tie", false);
	set_property("choiceAdventure105", 3);
	while(last_monster()!=$monster[guy made of bees]) {
		combatModBuff("minus");
		runAdv($location[haunted bathroom]);
	}
}		
 
