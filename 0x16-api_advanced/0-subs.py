#!/usr/bin/python3
"""
0-subs: Gets the number of subscribers from a given subreddit.
"""
import requests
import user_agent


def number_of_subscribers(subreddit):
    """Gets the number of subscribers from a given subreddit"""
    user_ag = {'User-Agent': user_agent.generate_user_agent()}
    session = requests.Session()
    session.headers.update(user_ag)

    url = 'https://www.reddit.com/r/{}/about.json'.format(subreddit)
    request = session.get(url, headers=user_ag)
    if (request.status_code == 404):
        return 0

    return request.json().get('data').get('subscribers')
