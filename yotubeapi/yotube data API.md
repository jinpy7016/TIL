## yotube data API

- 동영상 정보 가져오기

  https://www.googleapis.com/youtube/v3/videos?id=[영상 id]&key=[내 api key]&part=snippet

  ex) https://www.googleapis.com/youtube/v3/videos?id=0GzySut7yTE&key=[내 api key]&part=snippet



- 채널 정보 가져오기(위의 결과에서 채널 id 가져와서)

  https://www.googleapis.com/youtube/v3/channels?part=statistics&id=[채널 id]&key=[내 api key]

  ex) https://www.googleapis.com/youtube/v3/channels?part=statistics&id=UCDzpa0rTkUzxhE6h6fMKOQA&key=[내 api key]



- 댓글 정보 가져오기 (100개 제한)
  https://www.googleapis.com/youtube/v3/commentThreads?part=snippet&maxResults=100&order=relevance&videoId=[영상id]]&key=[api key]

  ex) https://www.googleapis.com/youtube/v3/commentThreads?part=snippet&maxResults=100&order=relevance&videoId=0GzySut7yTE&key=[내 api key]



- 채널 재생목록 가져오기 (재생목록 50개 제한)
  https://www.googleapis.com/youtube/v3/playlists?part=snippet&maxResults=50&channelId=UCDzpa0rTkUzxhE6h6fMKOQA&key=[내 api key]



- 영상 목록 가져오기(재생 목록별로 50개 제한)
  (채널 id로 채널 재생목록 가져오기 > 재생목록의 영상 list 가져오기)
  https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=[재생목록 id]&maxResults=50&key=[api key]

  ex) https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=PLW6uMrP8oiHVTV7T9m2EDhq9bBftTMRwn&maxResults=50&key=[내 api key]