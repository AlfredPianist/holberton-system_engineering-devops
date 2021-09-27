#!/usr/bin/python3
"""
2-recurse: Gets the top ten hot posts from a given subreddit.
"""
import requests


def recurse(subreddit, hot_list=[]):
    """Gets the top ten hot posts from a given subreddit"""
    user_agent_str = ('Mozilla/5.0 (Windows NT 6.1; WOW64; rv:77.0)'
                      'Gecko/20190101 Firefox/77.0')
    user_ag = {'User-Agent': user_agent_str}
    session = requests.Session()
    session.headers.update(user_ag)

    url = 'https://www.reddit.com/r/{}/hot.json'.format(subreddit)
    request = session.get(url)
    if (request.status_code == 404):
        return None

    payload = {'limit': 100}
    return recurse_helper(session, url, payload, hot_list)


def recurse_helper(session, url, payload, hot_list):
    """Actual recursive function that stores the titles of all
    hot topics in the actual subreddit"""
    request = session.get(url, params=payload, allow_redirects=False)
    request_data = request.json().get('data')

    post_page = request_data.get('children')
    hot_list.extend([post.get('data').get('title') for post in post_page])

    if (request_data.get('after') is None):
        return hot_list
    payload = {
        'after': request_data.get('after'),
        'limit': 100
    }
    return recurse_helper(session, url, payload, hot_list)
