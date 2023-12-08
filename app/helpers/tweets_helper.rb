# frozen_string_literal: true

module TweetsHelper
  def like_button(liked, user, tweet)
    if current_user
      if current_user.likes && current_user.likes.include?(liked)
        link_to user_tweet_like_path(user, tweet, liked), class: 'nav-tweet-link hover:bg-red-500/20', data: { turbo_method: :delete } do
          image_tag 'liked_icon', class: 'nav-tweet-icon'
          tweet.likes.size
        end
      else
        link_to user_tweet_likes_path(user, tweet), class: 'nav-tweet-link hover:bg-red-500/20', data: { turbo_method: :post } do
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
