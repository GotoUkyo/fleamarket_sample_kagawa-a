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
    var category_id = document.getElementById('select_category').value; 
  // ↑ category_idに選択した親のvalueを代入
    if (category_id != ''){
  // ↑ category_idが空ではない場合のみAjax通信を行う｡選択肢を初期選択肢に変えると､通信失敗となってしまうため｡
      $.ajax({
        url: '/items/category_children',
        type: 'GET',
        data: { category_id: category_id },
        dataType: 'json'
      })
      .done(function(children){
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
        alert('カテゴリー取得に失敗しました');
      })
    }
  });


  // document､もしくは親を指定しないと発火しない
  $(document).on('change', '#child_category', function(){
    var category_id = document.getElementById('child_category').value;
    if (category_id != '---'){
    $.ajax ({
      url: '/items/category_grandchildren',
      type: 'GET',
      data: { category_id: category_id },
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
          alert('カテゴリー取得に失敗しました');
        })
    }
  });
});