# thisamericanlife.co

I really enjoy *This American Life*, but I absolutely hate the podcast subscription service through iTunes. Thankfully, the current TAL podcast can be downloaded from their website for free, but I never remember in time, and then I'm forced to listen through their weird flash player on their non-mobile-friendly website. Ruby to the rescue! I wrote a couple Nokogiri scripts, wired up an S3 bucket, snagged this sick domain, and now I'm good to go whenever I want.

http://thisamericanlife.co

# api.thisamericanlife.co

Just for funzies, I decided to create a *This American Life* public API. It's very simple. At the root it will return the 10 most recently episodes. Given a page number it will return the 10 episodes on that page. Given a specific episode number and it will return just that episode. It can also return a random episode for your listening pleasure.

http://api.thisamericanlife.co
http://api.thisamericanlife.co?page=32
http://api.thisamericanlife.co/547
http://api.thisamericanlife.co/random

```json
{
  "podcast": {
    "number": 135,
    "title": "Allure of Crime",
    "description": "We think of crime as a kind of monolithic, menacing presence. But there are many kinds of crimes and many kinds of criminals. Through our crimes, we express who we are. Today we hear of three different criminals and three different kinds of crimes.",
    "date": "1999-07-23",
    "image_url": "http://assets.thisamericanlife.co/images/135.jpg",
    "podcast_url": "http://assets.thisamericanlife.co/podcasts/135.mp3"
  }
}
```

Enjoy!