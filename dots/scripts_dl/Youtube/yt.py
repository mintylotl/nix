import yt_dlp
import sys
import json
from time import sleep
import os

os.chdir(f"/home/jwm/Downloads/Youtube")
root = os.getcwd()
os.chdir(f"Downloads")


def youtube(link):
    params = {
        "break_on_existing": False,
        "break_per_url": False,
        #'format': 'best[protocol=https]',
        "format": "bestvideo[protocol=https]+bestaudio",
        "keep_fragments": False,
        "concurrent_fragment_downloads": 1,
        "writesubtitles": True,
        "subtitleslangs": ["en"],
        "download_archive": f"{root}/archive.txt",
        "embed_thumbnail": True,
        "add_metadata": True,
        "skip_unavailable_fragments": False,
        "external_downloader": "aria2c",
        "abort_on_unavailable_fragment": True,
        "abort_on_error": True,
        "fragment_retries": 9999,
        "merge_output_format": "mkv",
        # "outtmpl": "%(playlist_index)s_%(title)s.%(ext)s",
    }

    if "!" in link:
        params["format"] = "bestaudio"
        params["outtmpl"] = ""

        i = 0
        for l in link:
            if (l == "!") and (i == link.__len__()):
                link = link.replace("!", "")
            i = i + 1
    try:
        yt = yt_dlp.YoutubeDL(params)
        yt.download(link)
    except:
        pass


fileL = open(f"{root}/links.txt", "r")
urls = fileL.read().split("\n")

for url in urls:
    print(f"Link: {url}")
    print(url.__len__())
    youtube(url)
