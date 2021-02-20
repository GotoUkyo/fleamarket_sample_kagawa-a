document.addEventListener(
  "DOMContentLoaded", e => {
    // info_submitというidが付与されたビューがnullでない場合（つまり存在する場合）にif文で内包された処理を実行
    if (document.getElementById("info_submit") != null) {
      
      // 公開鍵をセット
      Payjp.setPublicKey("pk_test_cf1e9fe1e6278b6f6ef03853");

      // idがinfo_submitであるビュー中の要素を取得
      let btn = document.getElementById("info_submit");
      // id名がinfo_submitであるビュー中の要素がクリックされたときにイベント発火
      btn.addEventListener("click", e => {
        e.preventDefault();                                                   // ボタンを一旦無効化
        let card = {
          number: document.getElementById("card_number").value,               // カード番号を取得
          exp_month: document.getElementById("exp_month").value,              // 有効月を取得
          exp_year: document.getElementById("exp_year").value,                // 有効年を取得
          cvc: document.getElementById("cvc").value                           // cvcを取得
        };

        // 取得したクレジットカード情報をもとにトークンを生成
        Payjp.createToken(card, (status, response) => {
          // トークンの生成に成功した場合、if文に内包された処理を実行
          if (status == 200) {
            // .removeAttrを使うことでサーバーにデータが残るのを防止
            $("#card_number").removeAttr("name");
            $("#exp_month").removeAttr("name");
            $("#exp_year").removeAttr("name");
            $("#cvc").removeAttr("name");

            // $(‘セレクタ’).append(‘追加するもの’);
            // .val()系の使い方 参考URL：http://js.studio-kingdom.com/jquery/attributes/val#1
            // id #card_tokenを仕込んだビューの部分にname属性がpayjp_tokenでresponse.idの値が入力されたinput（入力フォーム）要素を追加
            // ※responseの中身をconsole.log()で覗いた結果は下記のとおり
            // {card: {…}, created: 1613828847, id: "tok_a36b・・・", livemode: false, object: "token", …}
            // ※上記より、console.log(response.id)とすると、上記のid:"〜"の〜の部分（実質、これがトークンのようだ）がデータとして表示される
            $("#card_token").append(
              $('<input type="hidden" name="payjp_token">').val(response.id)
            );

            // 指定したフォーム（ここでは、inputForm）の情報（実際には指定したフォームに内包されるフォームの情報も含むなのだろう）を送信
            // 参考URL：http://www.htmq.com/js/form_submit.shtml
            // ビュー中の#card_tokenに追加されたname属性がpayjp_tokenのinput（入力フォーム）要素に記入されたresponse.idの値もsubmitされることになる
            document.inputForm.submit();
            alert("登録が完了しました");                                       // クレジットカードが登録できた旨を画面上に表示
          }
          // トークンの生成に失敗した場合、else文に内包された処理を実行
          else {
            alert("カード情報が正しくありません。");                            // クレジットカードの登録に失敗した旨を画面上に表示
          }
        });
      });
    }
  },
  false
);