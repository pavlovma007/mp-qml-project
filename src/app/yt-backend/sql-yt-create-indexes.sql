CREATE INDEX "yt-link-playlist-video-BY-playlistId" ON "yt-link-playlist-video" (
	"playlistId"
); 

CREATE INDEX "yt-link-playlist-video-BY-videoId" ON "yt-link-playlist-video" (
	"videoId"
); 


CREATE INDEX "yt-playlists-BY-uploader" ON "yt-playlists" (
	"uploader"
);

CREATE INDEX "yt-subtitlesFiles-BY-video" ON "yt-subtitlesFiles" (
	"video"
); 

CREATE INDEX "yt-videoFiles-BY-video" ON "yt-videoFiles" (
	"video"
); 

CREATE INDEX "yt-comments-BY-parent" ON "yt-comments" (
	"parent"
); 
