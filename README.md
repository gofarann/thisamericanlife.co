## thisamericanlife.co

I really enjoy **This American Life**, but I absolutely hate the podcast subscription service through iTunes. Thankfully, the current TAL podcast can be downloaded from their website for free, but I never remember in time, and then I'm forced to listen through their weird flash player on their non-mobile-friendly website. Ruby to the rescue! I wrote a couple Nokogiri scripts, wired up an S3 bucket, snagged this sick domain, and now I'm good to go whenever I want.

#### [thisamericanlife.co](http://thisamericanlife.co)

## api.thisamericanlife.co

Just for funzies I also decided to create a **This American Life** public API. It's very simple. At the root it will return the 10 most recent episodes. Given a page number it will return the 10 episodes on that page. Given a specific episode number and it will return just that episode. It can also return a random episode for your listening pleasure.

#### [api.thisamericanlife.co](http://api.thisamericanlife.co)
#### [api.thisamericanlife.co?page=21](http://api.thisamericanlife.co?page=21)
#### [api.thisamericanlife.co/q?q=money](http://api.thisamericanlife.co/q?q=money)

```json
{
  "episodes": [
    {
      "number": 366,
      "title": "A Better Mousetrap 2008",
      "description": "Stories about people trying to find new solutions to age-old...",
      "date": "2008-10-10",
      "image_url": "http://assets.thisamericanlife.co/images/366.jpg",
      "podcast_url": "http://assets.thisamericanlife.co/podcasts/366.mp3"
    },
    {
      "number": 365,
      "title": "Another Frightening Show About the Economy",
      "description": "Alex Blumberg and NPR's Adam Davidson—the two guys who reported...",
      "date": "2008-10-03",
      "image_url": "http://assets.thisamericanlife.co/images/365.jpg",
      "podcast_url": "http://assets.thisamericanlife.co/podcasts/365.mp3"
    },
    {
      "number": 435,
      "title": "How To Create a Job",
      "description": "It seems like every politician has a plan for putting people...",
      "date": "2011-05-13",
      "image_url": "http://assets.thisamericanlife.co/images/435.jpg",
      "podcast_url": "http://assets.thisamericanlife.co/podcasts/435.mp3"
    }
    ...
```

#### [api.thisamericanlife.co/547](http://api.thisamericanlife.co/547)
#### [api.thisamericanlife.co/random](http://api.thisamericanlife.co/random)

```json
{
  "episode": {
    "number": 135,
    "title": "Allure of Crime",
    "description": "We think of crime as a kind of monolithic, menacing presence...",
    "date": "1999-07-23",
    "image_url": "http://assets.thisamericanlife.co/images/135.jpg",
    "podcast_url": "http://assets.thisamericanlife.co/podcasts/135.mp3"
  }
}
```

You get the idea. If you do end up using this API for any reason at all, please let me know.

## Up and Coming

I have future plans to implement the following, in no particular order:

* Full coverage RSpec
* ~~Elasticsearch (Front End)~~ (2015-04-01)
* Better audio player
* ~~Slugginate URLS~~ (2015-04-01)
* Bulk Download Interface
* ~~GitHub README.md (remote) as About Page~~ (2015-04-02)
* ~~Elasticsearch (API)~~ (2015-04-02)
