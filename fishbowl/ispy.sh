#
if [ $# = 0 ]; then
    echo Usage: $0 img-folder out-folder
    exit 1
fi

img_f="$1"
out_f="$2"
html_f=ispy.html

mkdir -p $out_f
#cp ../images/* "$out_f/"
cp images/{rusty.jpg,single-dice-rolling.gif,giphy.gif,wheel.gif,bird.gif,clock-animated-gif-9.gif,clock-fast-white.gif,dice-rolling-gif-8.gif} "$out_f/"

cp "$img_f"/* "$out_f/"

cat <<! > $out_f/$html_f
<!DOCTYPE html>
<html>

  <head>
    <meta charset="UTF-8">
    <style>
      #word1 {
       font-size:120px;
      }
      header {
       padding: 10px;
       margin-bottom: 10px;

       font-size: 20px;
       color: white;
       background: black;
      }
      .button {
       width:400px;
       height:70px;
       font-size: 40px;
       color: white;
       background: blue;
       border-radius: 12px;
      }
      .button:hover {
        cursor: progress;
        background: red;
      }
      td {
        background: black;
        color: white;
      }
    #answers {
      font-size: 50px;
      background: lightGray;
      color: blue;
    }

    </style>

  </head>

  <body onload="focus()" >
  <center>
    <header>I Spy</header>
    <table>
      <tr>
        <td width=1024 id=dice1 align=center><img width=100% height=666 src=rusty.jpg /></td>
      </tr>
    </table>
    <button onclick="rollDice()" id=roll class=button type="button">Roll</button> 
    <hr>
    <div id=answers> </div>

  <script>
    var words = ['',
!

#for i in $img_f/*
for i in `ls -1 $img_f/* | grep -v '.txt$'`
do
  # skip .txt file
  echo "'`basename $i`',"
done >> $out_f/$html_f

cat <<! >> $out_f/$html_f
  ];
  function showAnswer(ans) {
    ans = ans.charAt(0).toUpperCase() + ans.slice(1)
    document.getElementById("answers").innerHTML = ans;
  }
  function getRandom(w) {
     var length = w.length - 1;
    
     var r1 = Math.floor(Math.random() * length) + 1;
     word = w[r1];
     w.splice(r1, 1);
     return word;
  }

  function focus() {
    document.getElementById("roll").focus(); 
  }

  function rollDice() {
    var btn = document.getElementById("roll");
    document.getElementById("dice1").innerHTML = "";
    btn.innerHTML = "Rolling...";
    btn.style.background = "yellow";
    btn.style.color = "black";
    spin();
    sleep(500).then(() => {
      stopSpin();
      var w = getRandom(words);
      img1 = '<img id=word1 width=1024 height=666 align=center src="' + w + '"</img>';
      document.getElementById("dice1").innerHTML = img1;
      var ans = w.split('.')[0];
      showAnswer(ans)
      btn.innerHTML = "Roll";
      btn.style.background = "blue";
      btn.style.color = "white";
      if(words.length <= 1) {
          btn.innerHTML = "That's all folks!";
          btn.style.background = "black";
          btn.disabled = true;
      }
    });
  }
  var spinners = [ '',
     'single-dice-rolling.gif', 'giphy.gif', 'wheel.gif',
     'bird.gif', 'clock-animated-gif-9.gif',
     'clock-fast-white.gif', 'dice-rolling-gif-8.gif'
  ];

  function spin() {
    var length = spinners.length - 1;
    var r1 = Math.floor(Math.random() * length) + 1;
    var gif = spinners[r1];
    spinner = "<center><img width=100% height=666 src=" + gif + " />";
    document.getElementById("dice1").innerHTML = spinner;
  }

  function stopSpin() {
    document.getElementById("dice1").innerHTML = "";
  }

  function sleep (time) {
    return new Promise((resolve) => setTimeout(resolve, time));
  }

</script>

</body>

</html>

!

