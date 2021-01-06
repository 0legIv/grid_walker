import "../css/app.scss"

import "phoenix_html"

$(document).ready(function(){
  drawGrid()
  drawWalls()
});

function drawGrid() {
  var ctx = document.getElementById('grid').getContext('2d');
  ctx.beginPath();    
  for (var x = 0, i = 0; i < 8; x+=100, i++) {
      for (var y = 0, j=0; j < 8; y+=100, j++) {     
          drawBorder(ctx, x, y, 100, 100)
          ctx.fillStyle='#FFF';
          ctx.fillRect(x, y, 100, 100);
      }
  }
  ctx.closePath();
}

function drawWalls() {
  var ctx = document.getElementById('grid').getContext('2d');
  ctx.beginPath();
  ctx.fillStyle='#000';
  ctx.fillRect(100, 400, 100, 100);
  ctx.fillRect(200, 400, 100, 100);
  ctx.fillRect(300, 400, 100, 100);
  ctx.fillRect(400, 400, 100, 100);
  ctx.fillRect(400, 500, 100, 100);
  ctx.fillRect(500, 500, 100, 100);
  ctx.closePath();
}

function drawBorder(ctx, xPos, yPos, width, height, thickness = 1)
{
  ctx.fillStyle='#000';
  ctx.fillRect(xPos - (thickness), yPos - (thickness), width + (thickness * 2), height + (thickness * 2));
}