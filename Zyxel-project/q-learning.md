# Q-LEARNING

> https://medium.com/%E9%9B%9E%E9%9B%9E%E8%88%87%E5%85%94%E5%85%94%E7%9A%84%E5%B7%A5%E7%A8%8B%E4%B8%96%E7%95%8C/%E6%A9%9F%E5%99%A8%E5%AD%B8%E7%BF%92-ml-note-reinforcement-learning-%E5%BC%B7%E5%8C%96%E5%AD%B8%E7%BF%92-dqn-%E5%AF%A6%E4%BD%9Catari-game-7f9185f833b0

## 題目
![](https://i.imgur.com/lcxmb7p.png)




---


![](https://i.imgur.com/qAW9hLK.jpg)




---


比方說調整action，現在是1-5，你可以調成2-6 /3-7之類的測試

現在5個action，你也可以多一些action，6789...個跑看看

呈現結果x-axis會是iteration(n-th beacon)，y-axis會是 1. action 2. total SINR 3. Throughput (i.e., reward)

另外bar圖x-axis是action，y-axis就是選擇到的次數，就是你現在貼的這些


---

## Q-learning



![](https://i.imgur.com/Yzu4gus.png)



![](https://i.imgur.com/LoezYOd.png)


中間的bellman function，也就是target ，我們可以想像，一開始的值可能是錯的，但經過一次又一次的疊代，target Q也會越來越精準，所以可以想像，如果夠長的時間，value-function就可以優化為最優的價值函數，這就是Q-learning

## Exploration and Exploitation
1. Exploration(探索)：隨機生成一個動作
2. Exploitation(利用)：我們利用目前的所有的Q值來找出一個最好的動作，這個policy稱為greedy policy，舉例來說，就是假設現在我要選擇我要走的方向(上下左右)，向上的Q值5，向下的Q值2，向左的Q值4，向右的Q值10，因此我們取最大的Q值，所以就向右走。

![](https://i.imgur.com/2jfGOoa.png)

![](https://i.imgur.com/HbPyFSv.png)

原本2013的DQN是只有一個network，然後同時計算Target Q跟預測的Q，如果是這種情況的話，同一個network都在更新，Target Q同樣在更新，那這樣是不是會有一種自己在跟自己的Target Q去做比較的呢？所以就出現了2015的DQN，很直觀的，2015DQN就是把計算Target Q的神經網路跟訓練用的神經網路分開，那要怎麼分開呢，從上面的演算法看來，就是經過一些時間後，把訓練用的參數給復製到計算Target Q的網路，這樣就會分開了

或許你現在還會覺得很復雜，我自己畫了一張圖來表達整個DQN演算法的架構(有錯的話幫忙在下面留言指正)，或許這可能會比較直觀也比較好了解，看這張圖對於DQN演算法的Implement也許會比較容易。左邊紅色線為初始狀態的第一步，如果不做這一步的話會沒辦法把 St, at, rt, S(t+1)給算出來並存放至記憶體裡面，第一步初始化做完之後，後面就是藍色線的flow，通過環境來儲存St, at, rt, S(t+1)，並將參數丟給對應的網路來計算LOSS Function，最後再更新網路的參數，一直不斷的重覆更新就可以找出最好的Q Function了。

![](https://i.imgur.com/SifKXlJ.png)
