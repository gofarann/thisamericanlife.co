Well, hello there! Thanks for stopping by. :)

I really enjoy **This American Life**, but I absolutely hate the podcast subscription service through iTunes. Thankfully, the current TAL podcast can be downloaded from their website for free, but I never remember in time, and then I'm forced to listen through their weird flash player on their non-mobile-friendly website. Ruby to the rescue! I wrote a couple Nokogiri scripts, wired up an S3 bucket, snagged this sick domain, and now I'm good to go whenever I want.

### http://thisamericanlife.co

Just for funzies I decided to create a **This American Life** public API. It's very simple. At the root it will return the 10 most recent episodes. Given a page number it will return the 10 episodes on that page. Given a specific episode number and it will return just that episode. It can also return a random episode for your listening pleasure.

### http://api.thisamericanlife.co
#### http://api.thisamericanlife.co?page=21

```json
{
  "podcasts": [
    {
      "number": 351,
      "title": "Return to Childhood 2008",
      "description": "Seventh-grader Kayla Hernandez likes to reminisce about when she was a child, back in fifth grade. She visits her school, where her fifth grade class met, and looks at her old books, thinks about what happened there.",
      "date": "2008-03-07",
      "image_url": "http://assets.thisamericanlife.co/images/351.jpg",
      "podcast_url": "http://assets.thisamericanlife.co/podcasts/351.mp3"
    },
    {
      "number": 350,
      "title": "Human Resources",
      "description": "The true story of little-known rooms in the New York City Board of Education building. Teachers are told to report there instead of their classrooms. No reason is usually given.",
      "date": "2008-02-29",
      "image_url": "http://assets.thisamericanlife.co/images/350.jpg",
      "podcast_url": "http://assets.thisamericanlife.co/podcasts/350.mp3"
    },
    {
      "number": 349,
      "title": "Valentine's Day 2008",
      "description": "Veronica Chater's mother wants to go to a resort in Mexico with a friend. Her father, a former cop with an extravagant sense of security, prepares as if she's headed for a war zone. This, and other stories about couples, that happen decades after the moment their eyes meet.",
      "date": "2008-02-15",
      "image_url": "http://assets.thisamericanlife.co/images/349.jpg",
      "podcast_url": "http://assets.thisamericanlife.co/podcasts/349.mp3"
    }
```

&hellip; you get the idea.

#### http://api.thisamericanlife.co/547
#### http://api.thisamericanlife.co/random

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

Enjoy! And, if you do end up using this API for any reason at all, please let me know.

### Up and Coming

I have future plans to implement the following, in no particular order:

* Full coverage RSpec
* ~~Elasticsearch~~ (2015-04-01)
* Better audio player
* ~~Slugginate URLS~~ (2015-04-01)
* Bulk Download Interface