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

# 進度
1. [2021-08-20] 已經加入 `TabBar` 與 `TabBarView` 了。
2. 先將excel檔案讀入後變成 JSON 檔，再將人名前兩個變成 ~XX~ ，這樣避免個資外流
``` regexp
   尋找：  ("姓名":\s{1}")(.{2})(.{1})
   替換：  $1XX$3
```