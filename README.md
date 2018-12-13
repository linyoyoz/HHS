# 高雄房價查詢系統
系統主要以ruby on rails建構  
主要功能:登入、註冊、查詢、更動與刪除帳號資訊並查看高雄房價資料 

位於heroku之雲端網站連接  
https://ancient-falls-75723.herokuapp.com  

 
#程式邏輯與資料庫架構  

*系統架構  
本系統架構如圖下所示
![image](https://github.com/linyoyoz/HHS/blob/master/image/system.png)
主要執行後端位於資料夾app/controller內
前端顯示則於資料夾app/view內

本系統包含三個資料表:  

* Users:
紀錄帳號設定
* Permission:
紀錄身分權限  
* House:
紀錄每區房價的資訊  
* 資料關聯圖
![image](https://github.com/linyoyoz/HHS/blob/master/image/table.png)  
# 環境配置  

建議環境:Ubuntu 16.04
(必備)
Ruby 版本 2.5.3  
Rail 版本 5.2.2  
mysql 版本 5.7.24(資料庫主要資料)  

# 房價資料來源  
https://price.housefun.com.tw  
由此網站查詢高雄各地區之每一坪的平均房價，並整合成共15區的房價資料  

# 資料匯入

以下以ubuntu 16.04 之terminal進行mysql資料庫的匯入  

1. cd Map7  
進入專案配置之資料夾內  

2.bundle install  
將相關套件配置完成  

3.rake create:db  
將專案之資料庫建置出來  

4.mysql -u帳號 -p密碼 Map7_develop < database/database.sql  
根據mysql系統 將專案內database資料夾內的sql資料匯入   

5.打開config/database.yml這個檔案，根據mysql帳號密碼修改16,17行

6.rails server
運行 在local端 輸入http://127.0.0.1:3000  \
進入網頁  
<br>


# 執行方式
* 登入與註冊
可以使用預設 Username: root Password: 12345 進行登入測試  
或點擊註冊新建一個 User  
<br>
在登入(session/new)與註冊(users/new)頁面上皆設有google之我不是機器人認證系統  
每一次的登入或是註冊皆須進行驗證!!   
(如果頁面沒有顯示請按F5重新載入)  
<br>
![image](https://github.com/linyoyoz/HHS/blob/master/image/login.png)  
<br>


* 帳號管理
登入後進入帳號顯示頁面(users/show)  
根據登入的身分為root、users或是guest能夠進行不同權限的帳號管理  
<br>
![image](https://github.com/linyoyoz/HHS/blob/master/image/show.png)  
<br>
帳號編輯頁面 
<br>
* 房價查詢  
在登入後可以進入房價查詢頁面(users/price)  
勾選(複選)要查詢的地區，並按創建
<br>  
![image](https://github.com/linyoyoz/HHS/blob/master/image/choose.png)  
<br>
在圖表頁面(users/draw)顯示地區之折線圖表內容  
<br>
![image](https://github.com/linyoyoz/HHS/blob/master/image/draw.png)  
<br>
# 結論
<br>
本系統開發一房價查詢之網站 使用ruby on rails 結合mySQL或是Heroku之PostgreSQL達成資料傳輸，並用  
recaptcha與chartjs-ror等相關套件提供驗證和資料顯示等等功能，並上傳至Heroku來進行雲端的建制。  
 
