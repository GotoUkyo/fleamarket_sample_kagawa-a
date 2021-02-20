jQuery(function(){
  function appendOption(category){ // optionの作成
    var html = `<option value="${category.id}">${category.name}</option>`;
    return html;
  }
  function appendChildrenBox(insertHTML){ // 子セレクトボックスのhtml作成
    var childSelectHtml = '';
      childSelectHtml = `<select class="category-select" id="child_category" name="item[category_id]">
                        <option value="---">選択してください</option>
                        ${insertHTML}
                        </select>`;
    $('.Detail__select-children').append(childSelectHtml);
  }
  function appendGrandchildrenBox(insertHTML){ // 孫セレクトボックスのhtml作成
    var grandchildrenSelectHtml = '';
    grandchildrenSelectHtml = `<select class="category-select" id="grandchild_category" name="item[category_id]">
                              <option value="---">選択してください</option>
                              ${insertHTML} 
                              </select>`;
    $('.Detail__select-grandchildren').append(grandchildrenSelectHtml);
  }

  $(document).on('change', '#select_category', function(){  // 親セレクトボックスの選択肢を変えたらイベント発火
    var parent_Id = document.getElementById('select_category').value; 
    // ↑ category_idに選択した親のvalueを代入
    if (parent_Id != ''){
    // ↑ category_idが空ではない場合のみAjax通信を行う｡選択肢を初期選択肢に変えると､通信失敗となってしまうため｡
      $.ajax({
        url: '/items/category_children',
        type: 'GET',
        data: { parent_id: parent_Id },
        dataType: 'json'
      })
      .done(function(children){
        // 下記2行：商品情報編集機能実装時に追加（親カテゴリに変化があった場合、子カテゴリ、孫カテゴリのセレクトボックスを一旦削除する）
        $('#child_category').remove(); 
        $('#grandchild_category').remove();
        // 送られてきたデータをchildrenに代入
        var insertHTML = '';
        children.forEach(function(child){  
        // forEachでchildに一つずつデータを代入｡子のoptionが一つずつ作成される｡
          insertHTML += appendOption(child); 
        });
        appendChildrenBox(insertHTML); 
        $(document).on('change', '#select_category', function(){
        // 通信成功時に親の選択肢を変えたらイベント発火｡子と孫を削除｡selectのidにかけるのではなく､親要素にかけないと残ってしまう
          $('#child_category').remove(); 
          $('#grandchild_category').remove();
        })
      })
      .fail(function(){
        alert('親カテゴリー取得に失敗しました');
      })
    }
  });

  // document､もしくは親を指定しないと発火しない
  $(document).on('change', '#child_category', function(){
    var child_Id = document.getElementById('child_category').value;
    if (child_Id != '---'){
      $.ajax ({
        url: '/items/category_grandchildren',
        type: 'GET',
        data: { child_id: child_Id },
        dataType: 'json'
      })
      .done(function(grandchildren){
        var insertHTML = '';
        grandchildren.forEach(function(grandchild){
          insertHTML += appendOption(grandchild);
        });
        appendGrandchildrenBox(insertHTML);  
        $(document).on('change', '#child_category',function(){
          $('#grandchild_category').remove();
        })
      })  
      .fail(function(){
        alert('子カテゴリー取得に失敗しました');
      })
    }
  });
});