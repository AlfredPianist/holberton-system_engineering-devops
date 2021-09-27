#!/usr/bin/python3
"""
0-subs: Gets the number of subscribers from a given subreddit.
"""
import requests


def number_of_subscribers(subreddit):
    """Gets the number of subscribers from a given subreddit"""
    user_agent_str = ('Mozilla/5.0 (Windows NT 6.1; WOW64; rv:77.0)'
                      'Gecko/20190101 Firefox/77.0')
    user_ag = {'User-Agent': user_agent_str}
    session = requests.Session()
    session.headers.update(user_ag)

    url = 'https://www.reddit.com/r/{}/about.json'.format(subreddit)
    request = session.get(url, headers=user_ag)
    if (request.status_code == 404):
        return 0

    return request.json().get('data').get('subscribers')
