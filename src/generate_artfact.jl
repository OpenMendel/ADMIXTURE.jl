using Tar, Inflate, SHA

download_urls = [
    "http://dalexander.github.io/admixture/binaries/admixture_linux-1.3.0.tar.gz",
    "http://dalexander.github.io/admixture/binaries/admixture_macosx-1.3.0.tar.gz"
    ]

for download_url in download_urls
    filename = download(download_url)
    println("sha256: ", bytes2hex(open(sha256, filename)))
    println("git-tree-sha1: ", Tar.tree_hash(IOBuffer(inflate_gzip(filename))))
end
