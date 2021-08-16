<<<<<<< HEAD
=======
window.onload = function () {
  //html読み込み後にjs読み込みした時に有効
  // 利用規約に同意チェックボックスにチェックを入れたらボタンが出現
  const $checkBox = document.forms[0].check;
  const $submitButton = document.forms[0].submit;

  $checkBox.addEventListener("change", () => {
    let checkBoxCheck = $checkBox.checked;

    if (checkBoxCheck == false) {
      $submitButton.disabled = "false";
      $submitButton.classList.value = "button_disabled";
      // $checkBox.checked = false;
      $checkBox.removeAttribute("checked");
    } else if (checkBoxCheck == true) {
      $submitButton.removeAttribute("disabled");
      $submitButton.classList.value = "button";
      // $checkBox.checked = "checked";
      $checkBox.setAttribute("checked", "checked");
    }
  });
  // let checkBoxVal = $checkBox.value;
  // if (checkBoxVal == 1) {
  //   $submitButton.removeAttribute("disabled");
  //   $submitButton.classList.value="button"
  //   $checkBox.value = 0;
  // } else {
  //   $submitButton.disabled = "false";
  //   $submitButton.classList.value="button_disabled"
  //   $checkBox.value = 1;
  // }

  // イベントリスナの処理の外にfalseを定義してcheckedを初期のfalseに戻す
  $checkBox.checked = false;
};

const arr = document.getElementsByClassName("kinoko");

for (let i = 0; i < 5; i++) {
  arr[i].addEventListener("click", () => {
    fadeOut(arr[i], 300);
    setTimeout(function () {
      arr[i].style.display = "";
    }, 5000);
  });
}

function fadeOut(node, duration) {
  node.style.opacity = 1;

  const start = performance.now();

  requestAnimationFrame(function tick(timestamp) {
    // イージング計算式（linear）
    const easing = (timestamp - start) / duration;

    // opacityが0より小さくならないように
    node.style.opacity = Math.max(1 - easing, 0);

    // イージング計算式の値が1より小さいとき
    if (easing < 1) {
      requestAnimationFrame(tick);
    } else {
      node.style.opacity = "";
      node.style.display = "none";
    }
  });
}
>>>>>>> bb9921b13872abbfa2406a6f7e8f080ff0e80b10
