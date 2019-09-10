Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94D13AE2A0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 05:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392892AbfIJDxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Sep 2019 23:53:25 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:52764 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbfIJDxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 23:53:25 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id C1B4C15CBF0;
        Tue, 10 Sep 2019 12:53:23 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-14) with ESMTPS id x8A3rMkM019024
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 10 Sep 2019 12:53:23 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-14) with ESMTPS id x8A3rM9R011465
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 10 Sep 2019 12:53:22 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id x8A3rJHW011464;
        Tue, 10 Sep 2019 12:53:19 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Jan Stancek <jstancek@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, systemd-devel@lists.freedesktop.org
Subject: Re: [PATCH] fat: fix corruption in fat_alloc_new_dir()
References: <fc8878aeefea128c105c49671b2a1ac4694e1f48.1567468225.git.jstancek@redhat.com>
        <87v9u3xf5q.fsf@mail.parknet.co.jp>
        <339755031.10549626.1567969588805.JavaMail.zimbra@redhat.com>
Date:   Tue, 10 Sep 2019 12:53:19 +0900
In-Reply-To: <339755031.10549626.1567969588805.JavaMail.zimbra@redhat.com>
        (Jan Stancek's message of "Sun, 8 Sep 2019 15:06:28 -0400 (EDT)")
Message-ID: <87r24o24eo.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Stancek <jstancek@redhat.com> writes:

>> Using the device while mounting same device doesn't work reliably like
>> this race. (getblk() is intentionally used to get the buffer to write
>> new data.)
>
> Are you saying this is expected even if 'usage' is just read?

Yes, assuming exclusive access.

>> mount(2) internally opens the device by EXCL mode, so I guess udev opens
>> without EXCL (I dont know if it is intent or not).
>
> I gave this a try and added O_EXCL to udev-builtin-blkid.c. My system had trouble
> booting, it was getting stuck on mounting LVM volumes.
>
> So, I'm not sure how to move forward here. 

OK. I'm still think the userspace should avoid to use blockdev while
mounting though, this patch will workaround this race with small race.

Can you test this?

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


[PATCH] fat: Workaround the race with userspace's read via blockdev while mounting

If userspace reads the buffer via blockdev while mounting,
sb_getblk()+modify can race with buffer read via blockdev.

For example,

         FS                         userspace
    bh = sb_getblk()
    modify bh->b_data
                                  read
				    ll_rw_block(bh)
				      fill bh->b_data by on-disk data
				      /* lost modified data by FS */
				      set_buffer_uptodate(bh)
    set_buffer_uptodate(bh)

The userspace should not use the blockdev while mounting though, the
udev seems to be already doing this.  Although I think the udev should
try to avoid this, workaround the race by small overhead.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/dir.c    |   13 +++++++++++--
 fs/fat/fatent.c |    3 +++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff -puN fs/fat/dir.c~fat-workaround-getblk fs/fat/dir.c
--- linux/fs/fat/dir.c~fat-workaround-getblk	2019-09-10 09:29:51.137292020 +0900
+++ linux-hirofumi/fs/fat/dir.c	2019-09-10 09:39:15.366295152 +0900
@@ -1100,8 +1100,11 @@ static int fat_zeroed_cluster(struct ino
 			err = -ENOMEM;
 			goto error;
 		}
+		/* Avoid race with userspace read via bdev */
+		lock_buffer(bhs[n]);
 		memset(bhs[n]->b_data, 0, sb->s_blocksize);
 		set_buffer_uptodate(bhs[n]);
+		unlock_buffer(bhs[n]);
 		mark_buffer_dirty_inode(bhs[n], dir);
 
 		n++;
@@ -1158,6 +1161,8 @@ int fat_alloc_new_dir(struct inode *dir,
 	fat_time_unix2fat(sbi, ts, &time, &date, &time_cs);
 
 	de = (struct msdos_dir_entry *)bhs[0]->b_data;
+	/* Avoid race with userspace read via bdev */
+	lock_buffer(bhs[0]);
 	/* filling the new directory slots ("." and ".." entries) */
 	memcpy(de[0].name, MSDOS_DOT, MSDOS_NAME);
 	memcpy(de[1].name, MSDOS_DOTDOT, MSDOS_NAME);
@@ -1180,6 +1185,7 @@ int fat_alloc_new_dir(struct inode *dir,
 	de[0].size = de[1].size = 0;
 	memset(de + 2, 0, sb->s_blocksize - 2 * sizeof(*de));
 	set_buffer_uptodate(bhs[0]);
+	unlock_buffer(bhs[0]);
 	mark_buffer_dirty_inode(bhs[0], dir);
 
 	err = fat_zeroed_cluster(dir, blknr, 1, bhs, MAX_BUF_PER_PAGE);
@@ -1237,11 +1243,14 @@ static int fat_add_new_entries(struct in
 
 			/* fill the directory entry */
 			copy = min(size, sb->s_blocksize);
+			/* Avoid race with userspace read via bdev */
+			lock_buffer(bhs[n]);
 			memcpy(bhs[n]->b_data, slots, copy);
-			slots += copy;
-			size -= copy;
 			set_buffer_uptodate(bhs[n]);
+			unlock_buffer(bhs[n]);
 			mark_buffer_dirty_inode(bhs[n], dir);
+			slots += copy;
+			size -= copy;
 			if (!size)
 				break;
 			n++;
diff -puN fs/fat/fatent.c~fat-workaround-getblk fs/fat/fatent.c
--- linux/fs/fat/fatent.c~fat-workaround-getblk	2019-09-10 09:36:20.247225406 +0900
+++ linux-hirofumi/fs/fat/fatent.c	2019-09-10 09:36:43.847100048 +0900
@@ -388,8 +388,11 @@ static int fat_mirror_bhs(struct super_b
 				err = -ENOMEM;
 				goto error;
 			}
+			/* Avoid race with userspace read via bdev */
+			lock_buffer(c_bh);
 			memcpy(c_bh->b_data, bhs[n]->b_data, sb->s_blocksize);
 			set_buffer_uptodate(c_bh);
+			unlock_buffer(c_bh);
 			mark_buffer_dirty_inode(c_bh, sbi->fat_inode);
 			if (sb->s_flags & SB_SYNCHRONOUS)
 				err = sync_dirty_buffer(c_bh);
_
