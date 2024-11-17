import yt_dlp
import sys
import json
import pyclip
from time import sleep
import os

os.chdir(f"/home/jwm/Downloads/Youtube")
root = os.getcwd()
os.chdir(f"Downloads")


def youtube(urlList):
    params = {
        "break_on_existing": False,
        "break_per_url": False,
        #'format': 'best[protocol=https]',
        "format": "bestvideo[ext=webm][protocol=https]+bestaudio",
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
    }

    try:
        yt = yt_dlp.YoutubeDL(params)
        yt.download(urlList)
    except:
        pass


urls = [pyclip.paste(text=True)]

for url in urls:
    youtube(url)
