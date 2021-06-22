window.onload = function () {
  //html読み込み後にjs読み込みした時に有効
  // 利用規約に同意チェックボックスにチェックを入れたらボタンが出現
  const $checkBox = document.forms[0].check;
  const $submitButton = document.forms[0].submit;

  $checkBox.addEventListener("change", () => {
    let checkBoxCheck = $checkBox.checked
    
    if (checkBoxCheck == false) {
      $submitButton.disabled = "false";
      $submitButton.classList.value = "button_disabled";
      // $checkBox.checked = false;
      $checkBox.removeAttribute("checked");
    } else if (checkBoxCheck == true) {
      $submitButton.removeAttribute("disabled");
      $submitButton.classList.value = "button";
      // $checkBox.checked = "checked";
      $checkBox.setAttribute("checked", "checked")
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

