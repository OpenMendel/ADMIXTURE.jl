using Pkg.Artifacts, Pkg.PlatformEngines

# This is the path to the Artifacts.toml we will manipulate
artifact_toml = joinpath(@__DIR__, "../Artifacts.toml")

# Query the `Artifacts.toml` file for the hash bound to the name "iris"
# (returns `nothing` if no such binding exists)
admixture_hash = artifact_hash("ADMIXTURE", artifact_toml)

# If the name was not bound, or the hash it was bound to does not exist, create it!
if admixture_hash === nothing || !artifact_exists(admixture_hash)
    # create_artifact() returns the content-hash of the artifact directory once we're finished creating it
    admixture_hash = create_artifact() do artifact_dir
        # We create the artifact by simply downloading and unpack tar ball into the new artifact directory
        tarball = download("http://dalexander.github.io/admixture/binaries/admixture_linux-1.3.0.tar.gz")
        try
            global tarball_hash = bytes2hex(GitTools.blob_hash(tarball))
            unpack(tarball, artifact_dir)
        finally
            rm(tarball)
        end
    end

    # Now bind that hash within our `Artifacts.toml`.  `force = true` means that if it already exists,
    # just overwrite with the new content-hash.  Unless the source files change, we do not expect
    # the content hash to change, so this should not cause unnecessary version control churn.
    bind_artifact!(artifact_toml, "ADMIXTURE", admixture_hash; 
    platform = Linux(:x86_64, libc=:glibc), 
    download_info = ["http://dalexander.github.io/admixture/binaries/admixture_linux-1.3.0.tar.gz", "353e8b170c81f8d95946bf18bc78afda5d6bd32645b2a68658bd6781ff35703c"],
    force = true)
end
