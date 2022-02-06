# sync rom
repo init -u https://github.com/ProjectRadiant/manifest -b eleven -g default,-mips,-darwin,-notdefault
git clone https://github.com/Neutralxs/local_manifest --depth 1 .repo/local_manifests
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags -j8

# build rom [7]
$ . build/envsetup.sh
$ lunch radiant_RMX2185-userdebug
$ mka bacon -jX

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
