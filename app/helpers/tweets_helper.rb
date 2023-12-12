# frozen_string_literal: true

module TweetsHelper
  def like_button(tweet)
    if current_user
      if tweet.liked?
        link_to like_tweet_path(tweet), class: 'nav-tweet-link hover:bg-red-500/20', data: { turbo_method: :post } do
          image_tag 'liked_icon', class: 'nav-tweet-icon'
          tweet.likes.size
        end
      else
        link_to like_tweet_path(tweet), class: 'nav-tweet-link hover:bg-red-500/20', data: { turbo_method: :post } do
          image_tag 'like_icon', class: 'nav-tweet-icon'
          tweet.likes.size
        end
      end
    else
      link_to new_user_session_path, class: 'nav-tweet-link hover:bg-red-500/20', data: { turbo_method: :post } do
        image_tag 'like_icon', class: 'nav-tweet-icon'
        tweet.likes.size
      end
    end
  end
end
