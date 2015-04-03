## thisamericanlife.co

I really enjoy **This American Life**, but I absolutely hate the podcast subscription service through iTunes. Thankfully, the current TAL podcast can be downloaded from their website for free, but I never remember in time, and then I'm forced to listen through their weird flash player on their non-mobile-friendly website. Ruby to the rescue! I wrote a couple Nokogiri scripts, wired up an S3 bucket, snagged this sick domain, and now I'm good to go whenever I want.

#### [thisamericanlife.co](http://thisamericanlife.co)

## api.thisamericanlife.co

Just for funzies I also decided to create a **This American Life** public API. It's very simple. At the root it will return the 10 most recent episodes. Given a page number it will return the 10 episodes on that page. Given a specific episode number and it will return just that episode. It can also return a random episode for your listening pleasure.

#### [api.thisamericanlife.co](http://api.thisamericanlife.co)
#### [api.thisamericanlife.co?page=21](http://api.thisamericanlife.co?page=21)

```json
{
  "podcasts": [
    {
      "number": 351,
      "title": "Return to Childhood 2008",
      "description": "Seventh-grader Kayla Hernandez likes to reminisce&hellip;",
      "date": "2008-03-07",
      "image_url": "http://assets.thisamericanlife.co/images/351.jpg",
      "podcast_url": "http://assets.thisamericanlife.co/podcasts/351.mp3"
    },
    {
      "number": 350,
      "title": "Human Resources",
      "description": "The true story of little-known rooms in the New York City&hellip;",
      "date": "2008-02-29",
      "image_url": "http://assets.thisamericanlife.co/images/350.jpg",
      "podcast_url": "http://assets.thisamericanlife.co/podcasts/350.mp3"
    },
    {
      "number": 349,
      "title": "Valentine's Day 2008",
      "description": "Veronica Chater's mother wants to go to a resort in Mexico&hellip;",
      "date": "2008-02-15",
      "image_url": "http://assets.thisamericanlife.co/images/349.jpg",
      "podcast_url": "http://assets.thisamericanlife.co/podcasts/349.mp3"
    }
```

#### [api.thisamericanlife.co/547](http://api.thisamericanlife.co/547)
#### [api.thisamericanlife.co/random](http://api.thisamericanlife.co/random)

```json
{
  "podcast": {
    "number": 135,
    "title": "Allure of Crime",
    "description": "We think of crime as a kind of monolithic, menacing presence&hellip;",
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
* ~~Elasticsearch~~ (2015-04-01)
* Better audio player
* ~~Slugginate URLS~~ (2015-04-01)
* Bulk Download Interface
* ~~GitHub README.md as About Page~~ (2015-04-02)