# 使用方式
它由
1. Widget [PdfItemDeclarerCard](pdf_item_declare_card.dart)
   - 用來產生輸入的簡述 `Card` ，方便使用者知道想修改誰。 
2. function [showDeclarerDialog](show_declarer_dialog.dart)
   - 用來跳出 `Dialog` ，好讓使用者可以修改輸入的資料。
這兩個為 `IO` 窗口，而且，使用了該 (1) Widget，按其 `編輯` 鈕會自動調用該 (2) function。所以，可以完全不用管 (2) 的部分。

## 輸入：
藉由 `itemData` 來輸入資料，

## 輸出：
這次，改藉由 `itemData.callback` 所輸入的function 來傳回修改後的新的 `PIDData`，
所以，如何處理傳回來的 data，改成在 `callback`裏頭寫。

# 範例：
請見 [ExampleWidget](example_widget.dart)
，其中可以看見我讓它的 `callback` 為將新的 data 取代舊的 data，寫在第一個 `for`迴圈裡。
當然，這取決於您。