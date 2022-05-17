import UIKit

class ViewController: UIViewController {
//storyboard'da gerekli label ve imageview'ları ekledik.
    
    @IBOutlet weak var highscorelabel: UILabel!
    @IBOutlet weak var i9: UIImageView!
    @IBOutlet weak var i8: UIImageView!
    @IBOutlet weak var i7: UIImageView!
    @IBOutlet weak var i6: UIImageView!
    @IBOutlet weak var i5: UIImageView!
    @IBOutlet weak var i4: UIImageView!
    @IBOutlet weak var i3: UIImageView!
    @IBOutlet weak var i2: UIImageView!
    @IBOutlet weak var i1: UIImageView!
    @IBOutlet weak var scorelabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var score = 0  //score'u tutacak değişken
    var counter = 0  //sayaç değişkeni
    var timer = Timer() //Timer class'ından bir nesne türetildi.
    var molearray=[UIImageView]() //image'leri tutacak bir mole dizisi oluşturuldu
    var hideTimer = Timer() //??
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //küçük bir veri tabannı oluşturmak için user.defaults kullanılır
        let highScore = UserDefaults.standard.object(forKey: "highscore")
        
        if highScore==nil{
            highscorelabel.text = "0"
        }
        
        if let newscore = highScore as? Int{
            highscorelabel.text = String(newscore)
        }
        
        scorelabel.text="Score: \(score)" //score scorelabel'a yazılır
        
        
        //recognizer'lara dokunma özelliği ve fonksiyon eklendi
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScores))
                
        
        // dokunma hassasiyetini mole'lere ekledik.
        i1.addGestureRecognizer(recognizer1)
        i2.addGestureRecognizer(recognizer2)
        i3.addGestureRecognizer(recognizer3)
        i4.addGestureRecognizer(recognizer4)
        i5.addGestureRecognizer(recognizer5)
        i6.addGestureRecognizer(recognizer6)
        i7.addGestureRecognizer(recognizer7)
        i8.addGestureRecognizer(recognizer8)
        i9.addGestureRecognizer(recognizer9)
        
        
       //dokunma için kullanıcıya izin verildi.
        i1.isUserInteractionEnabled = true
        i2.isUserInteractionEnabled = true
        i3.isUserInteractionEnabled = true
        i4.isUserInteractionEnabled = true
        i5.isUserInteractionEnabled = true
        i6.isUserInteractionEnabled = true
        i7.isUserInteractionEnabled = true
        i8.isUserInteractionEnabled = true
        i9.isUserInteractionEnabled = true

        
        //timer oluşturma:
        counter = 30 // geri sayım sayacı için değişken
        timeLabel.text="\(counter)" //label da sayacı gösterdik (time için oluşturduğumuz label'a değer atandı)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true) //geri sayım sayacı oluşturuldu
        hideTimer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(ViewController.hideMole), userInfo: nil, repeats: true) //yakalama sayacı oluşturuldu
        
        //molearray'e mole image'ler eklendi
        
        molearray.append(i1)
        molearray.append(i2)
        molearray.append(i3)
        molearray.append(i4)
        molearray.append(i5)
        molearray.append(i6)
        molearray.append(i7)
        molearray.append(i8)
        molearray.append(i9)
        
        hideMole() //hidemole fonksiyonu çağrılır
}
    
    
    //score arttıracak fonksiyon yazıldı
    @objc func increaseScores() {
          score += 1
          scorelabel.text = "Score: \(score)"
      }
    
    
    @objc func hideMole() {
        if(counter>0){
            //sayaç sıfırdan büyük olduğu süreçte hareket devam eder.
        for mole in molearray {
            mole.isHidden = true
        }
        
        let randomNumber = Int(arc4random_uniform(UInt32(molearray.count - 1)))
        molearray[randomNumber].isHidden = false
            //sayaç sıfırdan küçükse hareket durdurulur.
        }}
    
    @objc func countDown() {
        if counter>0{
            counter = counter - 1
            timeLabel.text = "\(counter)"
        //sayacdaki değer azaltılıyor
        }
            
        //sayaç sıfıra eşitse durumu
            if counter == 0 {
                hideMole()
                timer.invalidate()
                hideTimer.invalidate()
                
                //yeni skor önceki skorlardan daha büyük mü diye kontrol edilir
                if self.score > Int(highscorelabel.text!)! {
                    UserDefaults.standard.set(self.score, forKey: "highscore")
                    highscorelabel.text = String(self.score) //yeni skor high score a atanır
                }
                
                //zaman bitiğinde verilecek uyarılar oluşturulur
                let alert = UIAlertController(title: "Time", message: "Your Time Is Up", preferredStyle: UIAlertController.Style.alert) //kullanıcıya uyarı mesajı verildi
               
                let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: {(UIAlertAction) in
                    
                })
                alert.addAction(ok)
               
                let replay = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
                    //tekrar oynama seçilirse sayaç ve score sıfırlanır.
                    
                    self.score = 0
                    self.scorelabel.text = "Score: \(self.score)"
                    self.counter = 30 //sayaç başa alındı.
                    
                    
                
                self.timeLabel.text = "\(self.counter)"
                    
                        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
                        self.hideTimer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(ViewController.hideMole), userInfo: nil, repeats: true)
                                   
                               })
               
                alert.addAction(replay)
                self.present(alert, animated: true, completion: nil)
                        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
                        self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideMole), userInfo: nil, repeats: true)
    }
    }
}
