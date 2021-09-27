#!/usr/bin/python3
"""
100-count: Counts the number off occurrences of words from a given subreddit.
"""
from requests import get


def count_words(subreddit, word_list, payload={}, hot_list=[]):
    """Counts the number of occurrences of words given as list in
    the titles of all hot topics from a given subreddit"""
    if payload == {}:
        payload = {'limit': 100}

    url = 'https://www.reddit.com/r/{}/hot.json'.format(subreddit)
    user_agent_str = ('Mozilla/5.0 (Windows NT 6.1; WOW64; rv:77.0)'
                      'Gecko/20190101 Firefox/77.0')
    user_ag = {'User-Agent': user_agent_str}

    request = get(url, headers=user_ag)
    if (request.status_code == 404):
        return

    request = get(url, headers=user_ag, params=payload)
    request_data = request.json().get('data')

    post_page = request_data.get('children')
    hot_list.extend([post.get('data').get('title') for post in post_page])

    if (request_data.get('after') is not None):
        payload = {
            'after': request_data.get('after'),
            'limit': 100
        }
        return count_words(subreddit, word_list, payload, hot_list)

    word_list = [word.lower() for word in word_list]
    freq_dict = {word: 0 for word in word_list}
    for title in hot_list:
        title_words = title.lower().split(' ')
        for word in word_list:
            freq_dict[word] += title_words.count(word)

    for key in sorted(freq_dict):
        if (freq_dict[key] != 0):
            print("{}: {}".format(key, freq_dict[key]))
