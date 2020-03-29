Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5A36196DCB
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Mar 2020 16:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgC2OFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Mar 2020 10:05:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38862 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbgC2OFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 10:05:05 -0400
Received: by mail-wm1-f66.google.com with SMTP id f6so11602780wmj.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 07:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KksWWx9+HSMSD+6b37njirIFwS8trrPXD/rr78+IGUc=;
        b=W/elufwgYXtXe7Tk9I53HReppQHFc8yHEXB/P8/HJRut0XOs/K0zjbatW3WwowGJBF
         DT3iGDtkWldiMdPihNuAeEnmj8qi4o9FuylqIBmr16JMySRpK6r+9SEF92a4xC+MWdHa
         65DW3/2225xXAXAb3dYom6mqUx0o9uhqbMCVkOiKGHf13tIleLKoARPNw5txEwZ1IKFJ
         nUam8IYXuU0N94ovhNm6rkHINdF9xn+nPJPKjnsYpFzOM9/gSrkf2eUtCq+GrjyP1A/z
         qddT4lYMDGllpw/8sY9uGjE/92GMhCyZRDKC5FKou7vysYjzfZngh34vYk8e+cxXkwaX
         NABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KksWWx9+HSMSD+6b37njirIFwS8trrPXD/rr78+IGUc=;
        b=DxW7deAOMcP0Mhun5RC1Elo4y/q4Vl4i08PYCtfPkL10g6Sz296sI44sC2jdOdLZmY
         nPlyvb7/MfTzXWRqVSDAVPbIPomdKUiZVOIOOHTIcPBUER5jBpzcNycF0ZYE44JRPP4D
         00/7FxNYQuucKnmqWAyN67jMNlMKMe75aEurTCyjZno90thv9gs6Tyls6Yt3hb54Lw2S
         lIHXvq0DWIH9xG3NHb8576YMXoeVR8uqxUIr3WJtWTgwlHMRtcFc1jzrr2T3LWDKCWzb
         SnewrLFSRg0PIZDthCD0rge63q1lJWupN6okp7gy+JbaFMK9y36p4aAKlnWuZXTHFJPD
         5DZQ==
X-Gm-Message-State: ANhLgQ2oPcxkGdhe4v3NjNZY9i4+V3JDOSHfL6LDwlfXalnKQNqJubbT
        R9wYKX9m/vC/SydMY4lsnJijoQ==
X-Google-Smtp-Source: ADFU+vtkzK3Ldfip3EFJMopr62c8QFlXt57oqf6V7xxShzr4vVm3pB8h748AOW1CUbaqTOy1v54rkg==
X-Received: by 2002:a7b:c091:: with SMTP id r17mr8376625wmh.178.1585490702304;
        Sun, 29 Mar 2020 07:05:02 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id j68sm6680817wrj.32.2020.03.29.07.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 07:05:01 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de
Cc:     bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Martijn Coenen <maco@android.com>
Subject: [PATCH] loop: Add LOOP_SET_FD_WITH_OFFSET ioctl.
Date:   Sun, 29 Mar 2020 16:04:59 +0200
Message-Id: <20200329140459.18155-1-maco@android.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configuring a loop device for a filesystem that is located at an offset
currently requires calling LOOP_SET_FD and LOOP_SET_STATUS(64)
consecutively. This has some downsides.

The most important downside is that it can be slow. Here's setting
up ~70 regular loop devices on an x86 Android device:

vsoc_x86:/system/apex # time for i in `seq 30 100`;
do losetup -r /dev/block/loop$i com.android.adbd.apex; done
    0m01.85s real     0m00.01s user     0m00.01s system

Here's configuring ~70 devices in the same way, but with an offset:

vsoc_x86:/system/apex # time for i in `seq 30 100`;
do losetup -r -o 4096 /dev/block/loop$i com.android.adbd.apex; done
    0m03.40s real     0m00.02s user     0m00.03s system

This is almost twice as slow; the main reason for this slowness is that
LOOP_SET_STATUS(64) calls blk_mq_freeze_queue() to freeze the associated
queue; this requires waiting for RCU synchronization, which I've
measured can take about 15-20ms on this device on average.

A more minor downside of having to do two ioctls is that on devices with
max_part > 0, the kernel will initiate a partition scan, which is
needless work if the image is at an offset.

This change introduces a new ioctl to combine setting the backing file
together with the offset, which avoids the above problems. Adding more
parameters could be a consideration, but offset appears to be the only
commonly used parameter that is required for accessing the device
safely.

Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c      | 25 +++++++++++++++++++------
 include/uapi/linux/loop.h |  6 ++++++
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index a42c49e04954..517031e1d10c 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -932,8 +932,8 @@ static void loop_update_rotational(struct loop_device *lo)
 		blk_queue_flag_clear(QUEUE_FLAG_NONROT, q);
 }
 
-static int loop_set_fd(struct loop_device *lo, fmode_t mode,
-		       struct block_device *bdev, unsigned int arg)
+static int loop_set_fd_with_offset(struct loop_device *lo, fmode_t mode,
+		struct block_device *bdev, unsigned int arg, loff_t offset)
 {
 	struct file	*file;
 	struct inode	*inode;
@@ -957,7 +957,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	 * here to avoid changing device under exclusive owner.
 	 */
 	if (!(mode & FMODE_EXCL)) {
-		claimed_bdev = bd_start_claiming(bdev, loop_set_fd);
+		claimed_bdev = bd_start_claiming(bdev, loop_set_fd_with_offset);
 		if (IS_ERR(claimed_bdev)) {
 			error = PTR_ERR(claimed_bdev);
 			goto out_putf;
@@ -1002,6 +1002,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	lo->transfer = NULL;
 	lo->ioctl = NULL;
 	lo->lo_sizelimit = 0;
+	lo->lo_offset = offset;
 	lo->old_gfp_mask = mapping_gfp_mask(mapping);
 	mapping_set_gfp_mask(mapping, lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
 
@@ -1042,14 +1043,14 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	if (partscan)
 		loop_reread_partitions(lo, bdev);
 	if (claimed_bdev)
-		bd_abort_claiming(bdev, claimed_bdev, loop_set_fd);
+		bd_abort_claiming(bdev, claimed_bdev, loop_set_fd_with_offset);
 	return 0;
 
 out_unlock:
 	mutex_unlock(&loop_ctl_mutex);
 out_bdev:
 	if (claimed_bdev)
-		bd_abort_claiming(bdev, claimed_bdev, loop_set_fd);
+		bd_abort_claiming(bdev, claimed_bdev, loop_set_fd_with_offset);
 out_putf:
 	fput(file);
 out:
@@ -1601,7 +1602,7 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 
 	switch (cmd) {
 	case LOOP_SET_FD:
-		return loop_set_fd(lo, mode, bdev, arg);
+		return loop_set_fd_with_offset(lo, mode, bdev, arg, 0);
 	case LOOP_CHANGE_FD:
 		return loop_change_fd(lo, bdev, arg);
 	case LOOP_CLR_FD:
@@ -1624,6 +1625,17 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 		break;
 	case LOOP_GET_STATUS64:
 		return loop_get_status64(lo, (struct loop_info64 __user *) arg);
+	case LOOP_SET_FD_WITH_OFFSET: {
+		struct loop_fd_with_offset fdwo;
+
+		if (copy_from_user(&fdwo,
+				(struct loop_fd_with_offset __user *) arg,
+				sizeof(struct loop_fd_with_offset)))
+			return -EFAULT;
+
+		return loop_set_fd_with_offset(lo, mode, bdev, fdwo.fd,
+				fdwo.lo_offset);
+	}
 	case LOOP_SET_CAPACITY:
 	case LOOP_SET_DIRECT_IO:
 	case LOOP_SET_BLOCK_SIZE:
@@ -1774,6 +1786,7 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 	case LOOP_SET_CAPACITY:
 	case LOOP_CLR_FD:
 	case LOOP_GET_STATUS64:
+	case LOOP_SET_FD_WITH_OFFSET:
 	case LOOP_SET_STATUS64:
 		arg = (unsigned long) compat_ptr(arg);
 		/* fall through */
diff --git a/include/uapi/linux/loop.h b/include/uapi/linux/loop.h
index 080a8df134ef..289829bc5abd 100644
--- a/include/uapi/linux/loop.h
+++ b/include/uapi/linux/loop.h
@@ -60,6 +60,11 @@ struct loop_info64 {
 	__u64		   lo_init[2];
 };
 
+struct loop_fd_with_offset {
+	__u64          lo_offset;
+	__u32          fd;
+};
+
 /*
  * Loop filter types
  */
@@ -90,6 +95,7 @@ struct loop_info64 {
 #define LOOP_SET_CAPACITY	0x4C07
 #define LOOP_SET_DIRECT_IO	0x4C08
 #define LOOP_SET_BLOCK_SIZE	0x4C09
+#define LOOP_SET_FD_WITH_OFFSET	0x4C0A
 
 /* /dev/loop-control interface */
 #define LOOP_CTL_ADD		0x4C80
-- 
2.26.0.rc2.310.g2932bb562d-goog

