#!/usr/bin/python3
"""
1-top_ten: Gets the top ten hot posts from a given subreddit.
"""
import requests


def top_ten(subreddit):
    """Gets the top ten hot posts from a given subreddit"""
    user_agent_str = ('Mozilla/5.0 (Windows NT 6.1; WOW64; rv:77.0)'
                      'Gecko/20190101 Firefox/77.0')
    user_ag = {'User-Agent': user_agent_str}
    session = requests.Session()
    session.headers.update(user_ag)

    url = 'https://www.reddit.com/r/{}/hot.json'.format(subreddit)
    request = session.get(url, headers=user_ag)
    if (request.status_code == 404):
        print(None)
        return
    posts = request.json().get('data').get('children')
    for post in posts[:10]:
        print(post.get('data').get('title'))
