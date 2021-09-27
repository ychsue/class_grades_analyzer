# 程式基本流程
1. [x] 給定Header 的文字，因為有的人會讓他們不在同一 Row 上
2. [x] 由Excel抓取資料，與轉為我們定義的格式
   1. [x] 由各個row 自行決定**平均**、**總分**
   2. [x] 由一個 exam 決定 **名次**、**最高分**、**最低分**、與**各科總平均**
3. [x] 工作中的ProgressRing顯示
4. [ ] 分析與畫出來
   1. [x] 先抓取資料的主頁面
   2. [x] 以考試為主
   3. [x] 以學生為主
   4. [x] 以課目為主

# 思考
1. [x] 原則上，這是一個3D問題。有 **exam**, **student** 與 **course** 三個維度。
2. [x] 而它的值可以是文字，如 **A++**，可以是 **數字** ，也可以是 **rank**
3. [ ] 可能還得考慮 **名次或成績進步速度** 與 **名次或成績進步加速度** 等，也就是關乎每個學生在意的特徵。
4. 此外，可以由三個方向投影，投影的法線我稱之為 virtual
   1. [x] 目前已經投影 **course** 為sum & average
   2. [ ] 若投影 **student** 則可以為 average 與 SD (Standard Deviation)標準差
5. [x] 使用 **TabBar** 來顯示這三種類型，由 **Drawer** 來操控個別類型

# 進度
## [2021-09-27] 初步印出頁面的標頭了
## [2021-09-24] packages 的問題
1. 首先， `printing` 與 `excel` 都用到了 `xml`, `archive` 等 packages，然而，由於 `excel` 的新版有問題，所以我用的是舊版，結果就有了 `xml`與`archive` 相衝的問題。
   1. 解決法是在 pubspec.yaml 的 `dependency-overrides` 裡將上述兩個的較新版本宣告進來，還在測試中，不知會否出問題。
   2. 目前能動。
2. 其次，`pdf` 這個package 的 3.6.0 版有問題，無法正確使用 `wt001.ttf` 的字形，只好，硬是將其版本宣告成 3.5.0，目前這樣能動。
3. 中文 `ttf` 檔一堆版權問題，而網路上的 `otf` 又不能直接在 `pdf` 裡使用，真傷腦筋。難道選擇使用 `pdf` 是錯誤的決定？
## [2021-09-11] 可以選擇要顯示 grade 或者 rank 了
以後可以顯示標準差嗎？

## [2021-09-10] 加上VirtualCourse的部分、修正大小等問題，但似乎變得很卡，到底哪裡在卡？
還有，`SingleChildScrollView` 需要用到 `LimitedBox`，這很傷腦筋，因為其大小很難限定。
不要使用它會否比較不卡一點？
## [2021-09-04] 已經能夠列出 Table 了，而且也可以連動了。
可是，關於UI物件大小控制還不大會。

## [2021-09-02] 試著抓取所需的資料，暫不考慮效能，僅考慮方便性。(也尚未寫好View 的部分)
## [2021-08-28] 能夠重排，也知道如何運用 `Theme` 了
用 `Theme` 會比較好，這樣，可以一次整個改變主題。
## [2021-08-27] 考量到未來可能會希望不同case 下順序不同，所以，創造一個 `PairModel` 來同時存 indices 與 是否被選取。
目前只差 reorder的部分，可能要由 `SimpleDialog` 換到 `Dialog` 了。
## [2021-08-26] 將 `exam`, `student` 與 `course` 看成是 `x`, `y`, `z` 三個軸(Axes)
1. 既然這些叫軸，那麼它其上的 `indices` 就不是連續實數，而是各考試、各學生與各科了。
2. 而slice它時，主要有沿三個軸切的，所以有三種cases，它們以 `TabsEnum` 來區隔是哪個當法線。
3. 因為這三個 cases 要顯示的 `indices` 可改變，所以，需要紀錄起來。記在 global的 `caseShows` 裡。
   
## [2021-08-21] 想讓不同狀態下 Drawer 的 `onTap` 有不停功能
1. 要做到這點，我可能得有一個 `StateController` 當作大家的頭，不然，這些 `Controller` 互相關聯，也會使得除錯變得困難。
2. 星狀的話，就可以用假的來做測試了。 
## [2021-08-20] 為了能夠加速開發，因此，將整筆Data變成 JSON 檔
1. 結果 `JsonDecoder().convert(...)` 所得到的結果還需要修改才能由 `fromJson` 灌入 Model 裡
2. 參考 [此篇 StackOverflow](https://stackoverflow.com/questions/53376518/dart-json-string-convert-to-list-string) 可以解決。
   1. `String`, `num` 等不用轉換即可使用。
   2. 透過 `List<String>.from(JSONVALUE)` 或 `Map<String,int>.from(JSONVALUE)` 來轉換 `List` 與 `Map`
   3. 自訂 `class` 則要用 `(JSONVALUE as List<dynamic>).map((e)=>CLASS.fromJson(e)).toList()` 來達成
## [2021-08-20] 已經加入 `TabBar` 與 `TabBarView` 了。
1. 先將excel檔案讀入後變成 JSON 檔，再將人名前兩個變成 ~XX~ ，這樣避免個資外流
``` regexp
   尋找：  ("姓名":\s{1}")(.{2})(.{1})
   替換：  $1XX$3
```
