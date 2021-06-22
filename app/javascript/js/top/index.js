window.onload = function () {
  //html読み込み後にjs読み込みした時に有効

  // 利用規約に同意チェックボックスにチェックを入れたらボタンが出現
  const $checkBox = document.forms[0].check;
  const $submitButton = document.forms[0].submit;

  $checkBox.addEventListener("change", () => {
    let checkBoxVal = $checkBox.value;
    if (checkBoxVal == 1) {
      $submitButton.style.display = "";
      $checkBox.value = 0;
    } else {
      $submitButton.style.display = "none";
      $checkBox.value = 1;
    }
  });
};

