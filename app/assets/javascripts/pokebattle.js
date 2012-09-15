function parsePx(string) {
	return parseInt(string.replace("px",""));
}

/**
* Player 1 has top and left 
**/
function movep1(down, right) {
	oldTop = $("#player1-img").css("top");
	oldLeft = $("#player1-img").css("left");
	currTop = parsePx(oldTop);
	currLeft = parsePx(oldLeft);
	newTop = (currTop+down) + "px";
	newLeft = (currLeft+right) + "px";
	//Move there
	$("#player1-img").animate({
		top : newTop,
		left : newLeft
	}, 500);
	//Move back
	$("#player1-img").animate({
		top : oldTop,
		left : oldLeft
	}, 500);
}

/**
* Player 2 has top and right
**/
function movep2(up, left) {
	oldTop = $("#player2-img").css("top");
	oldRight = $("#player2-img").css("right");
	currTop = parsePx(oldTop);
	currRight = parsePx(oldRight);
	newTop = (currTop-up) + "px";
	newRight = (currRight+left) + "px";
	//Move there
	$("#player2-img").animate({
		top : newTop,
		right : newRight
	}, 500);
	//Move back
	$("#player2-img").animate({
		top : oldTop,
		right : oldRight
	}, 500);
}

function gethp1() {
	return Math.floor($("#p1-bar").width() * (100/120));
}

function sethp1(hp) {
	$("#p1-bar").animate({
		width: (hp + "%")
	},1000);
	$("#p1-bar").css("background-color", rgbForHp(hp));
}

function gethp2() {
	return Math.floor($("#p2-bar").width() * (100/120))
}

function sethp2(hp) {
	$("#p2-bar").animate({
		width: (hp + "%")
	},1000);
	$("#p2-bar").css("background-color", rgbForHp(hp));
}

/**
* Use p1 to deal "damage" to p2
*/
function p1attack(damage) {
	p2newhp = Math.max(gethp2() - damage, 0);
	showRocks = (Math.random() > 0.65);
	attack = "ROCK SLIDE";
	if (showRocks) {
		flashRocks("#player2-img");
	} else {
		movep1(60,80);
		attack = "TACKLE";
	}
	setTimeout(function(){
		sethp2(p2newhp)
	}, 1000);
	setTimeout(function() {
		setMainText("CHARIZARD", attack, damage)
	}, 1500);
}

/**
* Use p2 to deal "damage" to p1
*/
function p2attack(damage) {
	p1newhp = Math.max(gethp1() - damage, 0);
	showRocks = (Math.random() > 0.65);
	attack = "ROCK SLIDE";
	if (showRocks) {
		flashRocks("#player1-img");
	} else {
		movep2(60,80);
		attack = "TACKLE";
	}
	setTimeout(function(){
		sethp1(p1newhp)
	}, 1000);
	setTimeout(function() {
		setMainText("PIKACHU", attack, damage)
	}, 1000);
}

function setMainText(charname, attack, damage) {
	mainText = charname + " used " + attack + ".  " + effectiveString(damage);
	$("#maintext").css("background-color","black");
	setTimeout(function() {
		$("#maintext").text(mainText);
	}, 100);
	setTimeout(function() {
		$("#maintext").css("background-color","white");
	}, 100);

}

function flashRocks(playerdiv) {
	selector = playerdiv + " " + ".rocks";
	$(selector).css("visibility","visible");
	$(selector).animate({
		"top" : "0px"
	}, 500);	
	setTimeout(function() {
		$(selector).css("visibility","hidden");	
	}, 600);
	setTimeout(function() {
		$(selector).css("visibility","visible");	
	}, 800);	
	setTimeout(function() {
		$(selector).css("visibility","hidden");	
	}, 1000);
	setTimeout(function() {
		$(selector).css("visibility","visible");	
	}, 1200);	
	setTimeout(function() {
		$(selector).css("visibility","hidden");	
	}, 1400);
	setTimeout(function() {
		$(selector).css("top","-50px")
	},1500);

}

/**
* Gives a string description of how effective an attack was
*/
function effectiveString(damage) {
	if (damage > 30) {
		return "It's super effective!";
	} else {
		return "It's not very effective..."
	}
}

function rgbForHp(hp) {
	greenR = 33;
	greenG = 71;
	greenB = 36;

	redR = 100;
	redG = 13;
	redB = 9;

	newR = Math.floor(redR - ((redR - greenR) * (hp/100)));
	newG = Math.floor(redG + ((greenG - redG) * (hp/100)));
	newB = Math.floor(redB + ((greenB - redB) * (hp/100)));

	newRGB = 'rgb(' + newR + ',' + newG + ',' + newB + ')';
	return newRGB;
}

/**
* Get the color for the hp bar at any hp
**/
function colorForHp(hp) {
	return interpolateColor("FF2117","2E2E2E",99,(hp-1));
}

$(document).ready(function() {
	//Set initial HP
	sethp1(100);
	sethp2(100);
	//Slide in characters
	//P1 - top100, left160
	$("#player1-img").animate({
		"left" : "160px"
	}, 1000);
	//P2 - top260, right280
	$("#player2-img").animate({
		"right" : "280px"
	}, 1000);
});