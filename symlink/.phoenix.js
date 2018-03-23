Phoenix.set({
  openAtLogin: true
});

var window = Window;
var key = Key;

var PADDING = 20;
var HOTKEY = ["alt", "cmd"];

var C = "center";
var F  = "fill";
var N  = "north";
var S  = "south";
var W  = "west";
var E  = "east";
var NW = "nw";
var NE = "ne";
var SW = "sw";
var SE = "se";

var directions = {
  "f":      F,
  "c":      C,
  "up":     N,
  "left":   W,
  "right":  E,
  "down":   S,
  "a":      NW,
  "s":      NE,
  "z":      SW,
  "x":      SE
};

Screen.prototype.width = function () {
  return this.flippedVisibleFrame().width - PADDING * 2;
};

Screen.prototype.height = function () {
  return this.flippedVisibleFrame().height - PADDING * 2;
};

Screen.prototype.origin = function () {
  return {
    x: this.flippedVisibleFrame().x + PADDING,
    y: this.flippedVisibleFrame().y + PADDING
  };
};

window.prototype.move = function (direction) {
  var screen = this.screen();
  var frame = this.frame();
  frame.x = screen.origin().x;
  frame.y = screen.origin().y;

  switch (direction) {
    case C:
      frame.x += screen.width() / 2 - frame.width / 2;
      frame.y += screen.height() / 2 - frame.height / 2;
      break;
    case F:
      frame.width = screen.width();
      frame.height = screen.height();
      break;
    case N:
      frame.width = screen.width();
      frame.height = (screen.height() - PADDING) / 2;
      break;
    case S:
      frame.width = screen.width();
      frame.height = (screen.height() - PADDING) / 2;
      frame.y += screen.height() - frame.height;
      break;
    case E:
      frame.width = (screen.width() - PADDING) / 2;
      frame.height = screen.height();
      frame.x += screen.width() - frame.width;
      break;
    case W:
      frame.width = (screen.width() - PADDING) / 2;
      frame.height = screen.height();
      break;
    case NW:
      frame.width = (screen.width() - PADDING) / 2;
      frame.height = (screen.height() - PADDING) / 2;
      break;
    case NE:
      frame.width = (screen.width() - PADDING) / 2;
      frame.height = (screen.height() - PADDING) / 2;
      frame.x += screen.width() - frame.width;
      break;
    case SW:
      frame.width = (screen.width() - PADDING) / 2;
      frame.height = (screen.height() - PADDING) / 2;
      frame.y += screen.height() - frame.height;
      break;
    case SE:
      frame.width = (screen.width() - PADDING) / 2;
      frame.height = (screen.height() - PADDING) / 2;
      frame.y += screen.height() - frame.height;
      frame.x += screen.width() - frame.width;
      break;
  }
  this.setFrame(frame);
};

for (var direction in directions) {
  key.on(direction, HOTKEY, function(dir) {
    if (window.focused()) {
      window.focused().move(dir);
    } else return;
  }.bind(null, directions[direction]));
}
