Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E313311BE9E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 21:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfLKUw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 15:52:57 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:36589 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfLKUw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 15:52:56 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M1YpJ-1ihckI0soN-0037Oo; Wed, 11 Dec 2019 21:52:45 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        Arnd Bergmann <arnd@arndb.de>, Jan Kara <jack@suse.cz>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Ajay Joshi <ajay.joshi@wdc.com>, linux-block@vger.kernel.org
Subject: [PATCH 23/24] compat_ioctl: simplify up block/ioctl.c
Date:   Wed, 11 Dec 2019 21:42:57 +0100
Message-Id: <20191211204306.1207817-24-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191211204306.1207817-1-arnd@arndb.de>
References: <20191211204306.1207817-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+8Rd6bScH9E1zZsBDpHLTq6M7+pje2Uc3WK0Esto0OQN+mxbaHT
 aHfBbYh+qqZ16iDXt9x6aCrQwksQMVQOYyljdKOviBykkd7cm65jGcmcLCwTIQabu4wlGw5
 OhQmwY2bny5wre0fclR/Vc7/Jur6lAzMHMskgzvGWnoF8m1PWcwidc7zVp12+dPpK0Ms7Oc
 tEjr8XCjyerHwlGyvOXCw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XlJmLjyUVaI=:IEiwhZ+ftAQTk4lgAB5yCj
 spMoW3dYnG1ljMiw2y0QiEXxIzZgyxIuA5UytkWBnz805LJIOS6TA8hW590MnHSAKwLzRdTFh
 CJFSxZxU9M/DUUx+Fxj+iv2iJEXRmAyQBnLdqh0Br+WihOUh7Mv6ttG4CBJLKtxV3EMjBtf42
 NRG7G66fMFBtI8CenmD6fyMnCnxBIySIUozWNzx8B38bm8l1fOiP+pBah8dLBBmXig5IPK/lp
 f4wUv418V+nvKrhOot5/L1PBIcZ1MMgkQQGd2uXD3MxTsV347+CE8LSlmaUyukVhBxlCdnzr+
 gbQ0A0Roo2LcUq5euUuKZC4JYaLVAHFMMzUSxr4KsqfoK2g0pQ3yTaRkKjt921Y8mmOgji6F3
 DekvdVLktY8ph3/D/NfDBm3GLM3HLgK0ljP8JX7ruppsMe2amOAJqD8H+Um0L8iZZfGTTYwgK
 8LBYFTPwxDqmtBWZO6PY4EdrktlMTKs5Gfq9IGc9vykHgKfjioEAd8ioOiRJNHx8MwYHj3QXn
 ZFml/+ZEvtYRCwTwSLBIO+BLlSt2cZylxrSWeFZKAjia9txLVGcUlMbps5JvExYgiA6/DNnr5
 9IMuALI+M1r1sKFWSsUG4fCjaUVQKSARjgFwbZGUcyRMNNQHBB6qwKEPLJLwhAzL9fhWW4UQh
 bZ5AWsRNJXLWuNNaP3OmdU8glrz7h92bN4Ply12xn2lfLIRgDWDeUo3iPQFOab85+44xegfRW
 QqRFvrB0q8Z97X0GO9AUP01OY1FW12MucFOrhM9lrrSN6VoqJ3/+sjld+hdfqQTgxzQQiGUIU
 XWlcK8coiuWuXCsDbUW30ZP5KwHoTbzJ6mMUq0Ph5twjNA1WEiDhwtiFQMd/XqcYx5Z2QxzIi
 kVewhxI/S7HbbXpELuWw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having separate implementations of blkdev_ioctl() often leads to these
getting out of sync, despite the comment at the top.

Since most of the ioctl commands are compatible, and we try very hard
not to add any new incompatible ones, move all the common bits into a
shared function and leave only the ones that are historically different
in separate functions for native/compat mode.

To deal with the compat_ptr() conversion, pass both the integer
argument and the pointer argument into the new blkdev_common_ioctl()
and make sure to always use the correct one of these.

blkdev_ioctl() is now only kept as a separate exported interfact
for drivers/char/raw.c, which lacks a compat_ioctl variant.
We should probably either move raw.c to staging if there are no
more users, or export blkdev_compat_ioctl() as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 block/ioctl.c | 269 ++++++++++++++++++++++----------------------------
 1 file changed, 117 insertions(+), 152 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index d6911a1149f5..127194b9f9bd 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -270,65 +270,45 @@ static int blk_ioctl_zeroout(struct block_device *bdev, fmode_t mode,
 			BLKDEV_ZERO_NOUNMAP);
 }
 
-static int put_ushort(unsigned long arg, unsigned short val)
+static int put_ushort(unsigned short __user *argp, unsigned short val)
 {
-	return put_user(val, (unsigned short __user *)arg);
+	return put_user(val, argp);
 }
 
-static int put_int(unsigned long arg, int val)
+static int put_int(int __user *argp, int val)
 {
-	return put_user(val, (int __user *)arg);
+	return put_user(val, argp);
 }
 
-static int put_uint(unsigned long arg, unsigned int val)
+static int put_uint(unsigned int __user *argp, unsigned int val)
 {
-	return put_user(val, (unsigned int __user *)arg);
+	return put_user(val, argp);
 }
 
-static int put_long(unsigned long arg, long val)
+static int put_long(long __user *argp, long val)
 {
-	return put_user(val, (long __user *)arg);
+	return put_user(val, argp);
 }
 
-static int put_ulong(unsigned long arg, unsigned long val)
+static int put_ulong(unsigned long __user *argp, unsigned long val)
 {
-	return put_user(val, (unsigned long __user *)arg);
+	return put_user(val, argp);
 }
 
-static int put_u64(unsigned long arg, u64 val)
+static int put_u64(u64 __user *argp, u64 val)
 {
-	return put_user(val, (u64 __user *)arg);
+	return put_user(val, argp);
 }
 
 #ifdef CONFIG_COMPAT
-static int compat_put_ushort(unsigned long arg, unsigned short val)
+static int compat_put_long(compat_long_t *argp, long val)
 {
-	return put_user(val, (unsigned short __user *)compat_ptr(arg));
+	return put_user(val, argp);
 }
 
-static int compat_put_int(unsigned long arg, int val)
+static int compat_put_ulong(compat_ulong_t *argp, compat_ulong_t val)
 {
-	return put_user(val, (compat_int_t __user *)compat_ptr(arg));
-}
-
-static int compat_put_uint(unsigned long arg, unsigned int val)
-{
-	return put_user(val, (compat_uint_t __user *)compat_ptr(arg));
-}
-
-static int compat_put_long(unsigned long arg, long val)
-{
-	return put_user(val, (compat_long_t __user *)compat_ptr(arg));
-}
-
-static int compat_put_ulong(unsigned long arg, compat_ulong_t val)
-{
-	return put_user(val, (compat_ulong_t __user *)compat_ptr(arg));
-}
-
-static int compat_put_u64(unsigned long arg, u64 val)
-{
-	return put_user(val, (compat_u64 __user *)compat_ptr(arg));
+	return put_user(val, argp);
 }
 #endif
 
@@ -547,9 +527,10 @@ struct compat_hd_geometry {
 	u32 start;
 };
 
-static int compat_hdio_getgeo(struct gendisk *disk, struct block_device *bdev,
-			struct compat_hd_geometry __user *ugeo)
+static int compat_hdio_getgeo(struct block_device *bdev,
+			      struct compat_hd_geometry __user *ugeo)
 {
+	struct gendisk *disk = bdev->bd_disk;
 	struct hd_geometry geo;
 	int ret;
 
@@ -603,13 +584,13 @@ static int blkdev_bszset(struct block_device *bdev, fmode_t mode,
 }
 
 /*
- * always keep this in sync with compat_blkdev_ioctl()
+ * Common commands that are handled the same way on native and compat
+ * user space. Note the separate arg/argp parameters that are needed
+ * to deal with the compat_ptr() conversion.
  */
-int blkdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
-			unsigned long arg)
+static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
+				unsigned cmd, unsigned long arg, void __user *argp)
 {
-	void __user *argp = (void __user *)arg;
-	loff_t size;
 	unsigned int max_sectors;
 
 	switch (cmd) {
@@ -632,60 +613,39 @@ int blkdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 	case BLKFINISHZONE:
 		return blkdev_zone_mgmt_ioctl(bdev, mode, cmd, arg);
 	case BLKGETZONESZ:
-		return put_uint(arg, bdev_zone_sectors(bdev));
+		return put_uint(argp, bdev_zone_sectors(bdev));
 	case BLKGETNRZONES:
-		return put_uint(arg, blkdev_nr_zones(bdev->bd_disk));
-	case HDIO_GETGEO:
-		return blkdev_getgeo(bdev, argp);
-	case BLKRAGET:
-	case BLKFRAGET:
-		if (!arg)
-			return -EINVAL;
-		return put_long(arg, (bdev->bd_bdi->ra_pages*PAGE_SIZE) / 512);
+		return put_uint(argp, blkdev_nr_zones(bdev->bd_disk));
 	case BLKROGET:
-		return put_int(arg, bdev_read_only(bdev) != 0);
-	case BLKBSZGET: /* get block device soft block size (cf. BLKSSZGET) */
-		return put_int(arg, block_size(bdev));
+		return put_int(argp, bdev_read_only(bdev) != 0);
 	case BLKSSZGET: /* get block device logical block size */
-		return put_int(arg, bdev_logical_block_size(bdev));
+		return put_int(argp, bdev_logical_block_size(bdev));
 	case BLKPBSZGET: /* get block device physical block size */
-		return put_uint(arg, bdev_physical_block_size(bdev));
+		return put_uint(argp, bdev_physical_block_size(bdev));
 	case BLKIOMIN:
-		return put_uint(arg, bdev_io_min(bdev));
+		return put_uint(argp, bdev_io_min(bdev));
 	case BLKIOOPT:
-		return put_uint(arg, bdev_io_opt(bdev));
+		return put_uint(argp, bdev_io_opt(bdev));
 	case BLKALIGNOFF:
-		return put_int(arg, bdev_alignment_offset(bdev));
+		return put_int(argp, bdev_alignment_offset(bdev));
 	case BLKDISCARDZEROES:
-		return put_uint(arg, 0);
+		return put_uint(argp, 0);
 	case BLKSECTGET:
 		max_sectors = min_t(unsigned int, USHRT_MAX,
 				    queue_max_sectors(bdev_get_queue(bdev)));
-		return put_ushort(arg, max_sectors);
+		return put_ushort(argp, max_sectors);
 	case BLKROTATIONAL:
-		return put_ushort(arg, !blk_queue_nonrot(bdev_get_queue(bdev)));
+		return put_ushort(argp, !blk_queue_nonrot(bdev_get_queue(bdev)));
 	case BLKRASET:
 	case BLKFRASET:
 		if(!capable(CAP_SYS_ADMIN))
 			return -EACCES;
 		bdev->bd_bdi->ra_pages = (arg * 512) / PAGE_SIZE;
 		return 0;
-	case BLKBSZSET:
-		return blkdev_bszset(bdev, mode, argp);
-	case BLKPG:
-		return blkpg_ioctl(bdev, argp);
 	case BLKRRPART:
 		return blkdev_reread_part(bdev);
-	case BLKGETSIZE:
-		size = i_size_read(bdev->bd_inode);
-		if ((size >> 9) > ~0UL)
-			return -EFBIG;
-		return put_ulong(arg, size >> 9);
-	case BLKGETSIZE64:
-		return put_u64(arg, i_size_read(bdev->bd_inode));
 	case BLKTRACESTART:
 	case BLKTRACESTOP:
-	case BLKTRACESETUP:
 	case BLKTRACETEARDOWN:
 		return blk_trace_ioctl(bdev, cmd, argp);
 	case IOC_PR_REGISTER:
@@ -701,12 +661,67 @@ int blkdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 	case IOC_PR_CLEAR:
 		return blkdev_pr_clear(bdev, argp);
 	default:
-		return __blkdev_driver_ioctl(bdev, mode, cmd, arg);
+		return -ENOIOCTLCMD;
 	}
 }
-EXPORT_SYMBOL_GPL(blkdev_ioctl);
+
+/*
+ * Always keep this in sync with compat_blkdev_ioctl()
+ * to handle all incompatible commands in both functions.
+ *
+ * New commands must be compatible and go into blkdev_common_ioctl
+ */
+int blkdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
+			unsigned long arg)
+{
+	int ret;
+	loff_t size;
+	void __user *argp = (void __user *)arg;
+
+	switch (cmd) {
+	/* These need separate implementations for the data structure */
+	case HDIO_GETGEO:
+		return blkdev_getgeo(bdev, argp);
+	case BLKPG:
+		return blkpg_ioctl(bdev, argp);
+
+	/* Compat mode returns 32-bit data instead of 'long' */
+	case BLKRAGET:
+	case BLKFRAGET:
+		if (!argp)
+			return -EINVAL;
+		return put_long(argp, (bdev->bd_bdi->ra_pages*PAGE_SIZE) / 512);
+	case BLKGETSIZE:
+		size = i_size_read(bdev->bd_inode);
+		if ((size >> 9) > ~0UL)
+			return -EFBIG;
+		return put_ulong(argp, size >> 9);
+
+	/* The data is compatible, but the command number is different */
+	case BLKBSZGET: /* get block device soft block size (cf. BLKSSZGET) */
+		return put_int(argp, block_size(bdev));
+	case BLKBSZSET:
+		return blkdev_bszset(bdev, mode, argp);
+	case BLKGETSIZE64:
+		return put_u64(argp, i_size_read(bdev->bd_inode));
+
+	/* Incompatible alignment on i386 */
+	case BLKTRACESETUP:
+		return blk_trace_ioctl(bdev, cmd, argp);
+	default:
+		break;
+	}
+
+	ret = blkdev_common_ioctl(bdev, mode, cmd, arg, argp);
+	if (ret == -ENOIOCTLCMD)
+		return __blkdev_driver_ioctl(bdev, mode, cmd, arg);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(blkdev_ioctl); /* for /dev/raw */
 
 #ifdef CONFIG_COMPAT
+
 #define BLKBSZGET_32		_IOR(0x12, 112, int)
 #define BLKBSZSET_32		_IOW(0x12, 113, int)
 #define BLKGETSIZE64_32		_IOR(0x12, 114, int)
@@ -716,13 +731,13 @@ EXPORT_SYMBOL_GPL(blkdev_ioctl);
    ENOIOCTLCMD for unknown ioctls. */
 long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 {
-	int ret = -ENOIOCTLCMD;
+	int ret;
+	void __user *argp = compat_ptr(arg);
 	struct inode *inode = file->f_mapping->host;
 	struct block_device *bdev = inode->i_bdev;
 	struct gendisk *disk = bdev->bd_disk;
 	fmode_t mode = file->f_mode;
 	loff_t size;
-	unsigned int max_sectors;
 
 	/*
 	 * O_NDELAY can be altered using fcntl(.., F_SETFL, ..), so we have
@@ -734,94 +749,44 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 		mode &= ~FMODE_NDELAY;
 
 	switch (cmd) {
+	/* These need separate implementations for the data structure */
 	case HDIO_GETGEO:
-		return compat_hdio_getgeo(disk, bdev, compat_ptr(arg));
-	case BLKPBSZGET:
-		return compat_put_uint(arg, bdev_physical_block_size(bdev));
-	case BLKIOMIN:
-		return compat_put_uint(arg, bdev_io_min(bdev));
-	case BLKIOOPT:
-		return compat_put_uint(arg, bdev_io_opt(bdev));
-	case BLKALIGNOFF:
-		return compat_put_int(arg, bdev_alignment_offset(bdev));
-	case BLKDISCARDZEROES:
-		return compat_put_uint(arg, 0);
-	case BLKFLSBUF:
-	case BLKROSET:
-	case BLKDISCARD:
-	case BLKSECDISCARD:
-	case BLKZEROOUT:
-	/*
-	 * the ones below are implemented in blkdev_locked_ioctl,
-	 * but we call blkdev_ioctl, which gets the lock for us
-	 */
-	case BLKRRPART:
-	case BLKREPORTZONE:
-	case BLKRESETZONE:
-	case BLKOPENZONE:
-	case BLKCLOSEZONE:
-	case BLKFINISHZONE:
-	case BLKGETZONESZ:
-	case BLKGETNRZONES:
-		return blkdev_ioctl(bdev, mode, cmd,
-				(unsigned long)compat_ptr(arg));
-	case BLKBSZSET_32:
-		return blkdev_ioctl(bdev, mode, BLKBSZSET,
-				(unsigned long)compat_ptr(arg));
+		return compat_hdio_getgeo(bdev, argp);
 	case BLKPG:
-		return compat_blkpg_ioctl(bdev, compat_ptr(arg));
+		return compat_blkpg_ioctl(bdev, argp);
+
+	/* Compat mode returns 32-bit data instead of 'long' */
 	case BLKRAGET:
 	case BLKFRAGET:
-		if (!arg)
+		if (!argp)
 			return -EINVAL;
-		return compat_put_long(arg,
+		return compat_put_long(argp,
 			       (bdev->bd_bdi->ra_pages * PAGE_SIZE) / 512);
-	case BLKROGET: /* compatible */
-		return compat_put_int(arg, bdev_read_only(bdev) != 0);
-	case BLKBSZGET_32: /* get the logical block size (cf. BLKSSZGET) */
-		return compat_put_int(arg, block_size(bdev));
-	case BLKSSZGET: /* get block device hardware sector size */
-		return compat_put_int(arg, bdev_logical_block_size(bdev));
-	case BLKSECTGET:
-		max_sectors = min_t(unsigned int, USHRT_MAX,
-				    queue_max_sectors(bdev_get_queue(bdev)));
-		return compat_put_ushort(arg, max_sectors);
-	case BLKROTATIONAL:
-		return compat_put_ushort(arg,
-					 !blk_queue_nonrot(bdev_get_queue(bdev)));
-	case BLKRASET: /* compatible, but no compat_ptr (!) */
-	case BLKFRASET:
-		if (!capable(CAP_SYS_ADMIN))
-			return -EACCES;
-		bdev->bd_bdi->ra_pages = (arg * 512) / PAGE_SIZE;
-		return 0;
 	case BLKGETSIZE:
 		size = i_size_read(bdev->bd_inode);
 		if ((size >> 9) > ~0UL)
 			return -EFBIG;
-		return compat_put_ulong(arg, size >> 9);
+		return compat_put_ulong(argp, size >> 9);
 
+	/* The data is compatible, but the command number is different */
+	case BLKBSZGET_32: /* get the logical block size (cf. BLKSSZGET) */
+		return put_int(argp, bdev_logical_block_size(bdev));
+	case BLKBSZSET_32:
+		return blkdev_bszset(bdev, mode, argp);
 	case BLKGETSIZE64_32:
-		return compat_put_u64(arg, i_size_read(bdev->bd_inode));
+		return put_u64(argp, i_size_read(bdev->bd_inode));
 
+	/* Incompatible alignment on i386 */
 	case BLKTRACESETUP32:
-	case BLKTRACESTART: /* compatible */
-	case BLKTRACESTOP:  /* compatible */
-	case BLKTRACETEARDOWN: /* compatible */
-		ret = blk_trace_ioctl(bdev, cmd, compat_ptr(arg));
-		return ret;
-	case IOC_PR_REGISTER:
-	case IOC_PR_RESERVE:
-	case IOC_PR_RELEASE:
-	case IOC_PR_PREEMPT:
-	case IOC_PR_PREEMPT_ABORT:
-	case IOC_PR_CLEAR:
-		return blkdev_ioctl(bdev, mode, cmd,
-				(unsigned long)compat_ptr(arg));
+		return blk_trace_ioctl(bdev, cmd, argp);
 	default:
-		if (disk->fops->compat_ioctl)
-			ret = disk->fops->compat_ioctl(bdev, mode, cmd, arg);
-		return ret;
+		break;
 	}
+
+	ret = blkdev_common_ioctl(bdev, mode, cmd, arg, argp);
+	if (ret == -ENOIOCTLCMD && disk->fops->compat_ioctl)
+		ret = disk->fops->compat_ioctl(bdev, mode, cmd, arg);
+
+	return ret;
 }
 #endif
-- 
2.20.0

