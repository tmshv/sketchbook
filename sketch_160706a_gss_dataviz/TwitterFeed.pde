class TwitterFeed {

    Twitter twitter;
    List<Status> tweets;

    boolean started = false;

    ArrayList allTweets;

    TwitterFeed(){
        ConfigurationBuilder cb = new ConfigurationBuilder();

        cb.setOAuthConsumerKey("CwjLjhWnNG6r3VkSfCP1ow");
        cb.setOAuthConsumerSecret("XMCxCqvBKmC4tCWGjNVBT4NxPDSLdMdmPQCsgomW4g");
        cb.setOAuthAccessToken("218009356-Y4Loqt1gP8Y7oLRalZY1AaT1B7SIF7GkMiTaaMrK");
        cb.setOAuthAccessTokenSecret("rfIAZR2iK33whhD9zqVTQgS0lEovpnqqsYQlmXVMTbbd1");

        TwitterFactory tf = new TwitterFactory(cb.build());
        twitter = tf.getInstance();
    }

    void update(){
        allTweets = getList();

        for(int i=0; i<allTweets.size(); i++){
            ArrayList t = (ArrayList) allTweets.get(i);

            PVector loc = new PVector(
                (float) t.get(5),
                (float) t.get(4)
            );

            PVector m = geoToPixel(loc);

            float followers = (int) t.get(1);
            float h = map(followers, 0, 1000, 50, 100);

            stroke(255);
            strokeWeight(1);
            line(m.x, m.y, 0, m.x, m.y, h);

            String text = (String) t.get(3);
            fill(255);
            textSize(24);
            text(text, m.x, m.y, h);

            // println("text: "+text);
        }
    }

    void getNewTweets(float lat, float lon, float res, String resUnit){
        try{
            Query q = new Query().geoCode(new GeoLocation(lat, lon), (int) res, resUnit);
            q.count(100);
            QueryResult result = twitter.search(q);

            tweets = result.getTweets();
            
            ArrayList allTweets = new ArrayList();
            started = true;

            println(tweets.size());

            getList();
        }catch(TwitterException error){
            println("TWITTER FAIL");
            println(error.getMessage());
        }
    }

    ArrayList getList(){
        ArrayList<ArrayList<String>> al = new ArrayList();

        if(started == true){
            for(int i=0; i<tweets.size(); i++){
                Status status = tweets.get(i);

                if(status.getGeoLocation() == null) continue;

                User user = status.getUser();

                // al.add(new ArrayList());

                ArrayList t = new ArrayList();//al.get(cnt);
                al.add(t);

                t.add(status.getCreatedAt()); //0
                t.add(user.getFollowersCount()); //1
                t.add(user.getName()); //2
                t.add(status.getText()); //3
                
                GeoLocation location = status.getGeoLocation();
                float lat = (float) location.getLatitude();
                float lon = (float) location.getLongitude();

                t.add(lat); //4
                t.add(lon); //5

                // println(status);
            }
        }

        return al;
    }

    void showTweets(){
        if(started){
            ArrayList t = (ArrayList) allTweets.get(0);
            String text = t.get(0) + "-" + t.get(2) + "-" + t.get(3);
        }
    }
}