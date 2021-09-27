#!/usr/bin/python3
"""
100-count: Counts the number off occurrences of words from a given subreddit.
"""
import requests


def count_words(subreddit, word_list):
    """Counts the number of occurrences of words given as list in
    the titles of all hot topics from a given subreddit"""
    user_agent_str = ('Mozilla/5.0 (Windows NT 6.1; WOW64; rv:77.0)'
                      'Gecko/20190101 Firefox/77.0')
    user_ag = {'User-Agent': user_agent_str}
    session = requests.Session()
    session.headers.update(user_ag)

    url = 'https://www.reddit.com/r/{}/hot.json'.format(subreddit)
    request = session.get(url)
    if (request.status_code == 404):
        return

    payload = {'limit': 100}
    titles = recurse(session, url, payload, [])

    low_list = []
    multiply = []
    uniq_list = []
    for word in word_list:
        low_list.append(word.lower())
    for word in low_list:
        if word not in uniq_list:
            uniq_list.append(word)
            multiply.append(low_list.count(word))

    n = len(uniq_list)
    quantity = [None] * n

    for i in range(n):
        number = 0
        for title in titles:
            number += title.lower().split().count(uniq_list[i])
        quantity[i] = number * multiply[i]

    ans = list(zip(uniq_list, quantity))
    ans_ordened = sorted(ans, key=lambda x: x[1], reverse=True)
    for name, quantity in ans_ordened:
        if quantity:
            print("{}: {}".format(name, quantity))
    return titles


def recurse(session, url, payload, hot_list):
    """Stores the titles of all hot topics in the actual subreddit"""
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
    return recurse(session, url, payload, hot_list)
