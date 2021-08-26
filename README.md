# 程式基本流程
1. [x] 給定Header 的文字，因為有的人會讓他們不在同一 Row 上
2. [x] 由Excel抓取資料，與轉為我們定義的格式
   1. [x] 由各個row 自行決定**平均**、**總分**
   2. [x] 由一個 exam 決定 **名次**、**最高分**、**最低分**、與**各科總平均**
3. [x] 工作中的ProgressRing顯示
4. [ ] 分析與畫出來
   1. [ ] 先抓取資料的主頁面
   2. [ ] 以考試為主
   3. [ ] 以學生為主
   4. [ ] 以課目為主

# 思考
1. [x] 原則上，這是一個3D問題。有 **exam**, **student** 與 **course** 三個維度。
2. [x] 而它的值可以是文字，如 **A++**，可以是 **數字** ，也可以是 **rank**
3. [ ] 可能還得考慮 **名次或成績進步速度** 與 **名次或成績進步加速度** 等，也就是關乎每個學生在意的特徵。
4. 此外，可以由三個方向投影，投影的法線我稱之為 virtual
   1. [x] 目前已經投影 **course** 為sum & average
   2. [ ] 若投影 **student** 則可以為 average 與 SD (Standard Deviation)標準差
5. [ ] 使用 **TabBar** 來顯示這三種類型，由 **Drawer** 來操控個別類型

# 進度
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
