Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90C9FD0361
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 00:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfJHWXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 18:23:17 -0400
Received: from valentin-vidic.from.hr ([94.229.67.141]:41895 "EHLO
        valentin-vidic.from.hr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJHWXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 18:23:16 -0400
X-Virus-Scanned: Debian amavisd-new at valentin-vidic.from.hr
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
        id 42C6925D; Wed,  9 Oct 2019 00:23:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=valentin-vidic.from.hr; s=2017; t=1570573389;
        bh=gCUfr9ijiKWav6o1R8261PlBXptRHXBtHMu8ZFIIfpk=;
        h=From:To:Cc:Subject:Date:From;
        b=o51vqbaeFl/Epd2UP3431uHmkB3LyFRMsIDBxyj5/LXOGIymF0eb8IEWXc/Vihpr0
         k5cO4FAOh1pCcK1b5Jm1oZfwRaPKJQW3uKl5I/0FO1/RQbWDSFmm2y+iL+gXpoFCPv
         ECwAHqJv1SPvNl7ayGq7fVfiUClOOgETB2doDWZkcxt90DhHMC+n4TWidh/i2zD1uG
         lfo0LsWUUsrMTn9PO8paQ344Z/4/sx1PM/Ebo73LdzhUm6jZJsWuCIuXY/QYI46GZt
         +TdgZ9+fvZtSNcF4b4WpvqEcn7AI9o+yF/ph8LJADYzAfwhzvh1T2oBQ9gi6C84Q8R
         viDMTzmFsDP1Q==
From:   Valentin Vidic <vvidic@valentin-vidic.from.hr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Valentin Vidic <vvidic@valentin-vidic.from.hr>,
        syzbot+0761012cebf7bdb38137@syzkaller.appspotmail.com
Subject: [PATCH] usb: iowarrior: fix access to freed data structure
Date:   Wed,  9 Oct 2019 00:23:07 +0200
Message-Id: <20191008222307.18587-1-vvidic@valentin-vidic.from.hr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct iowarrior gets freed prematurely in iowarrior_release while
it is still being referenced from usb_interface, so let only
iowarrior_disconnect call iowarrior_delete.

Fixes: KMSAN: uninit-value in iowarrior_disconnect
Reported-by: syzbot+0761012cebf7bdb38137@syzkaller.appspotmail.com
Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
---
 drivers/usb/misc/iowarrior.c | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
index f5bed9f29e56..0492ea76c4bf 100644
--- a/drivers/usb/misc/iowarrior.c
+++ b/drivers/usb/misc/iowarrior.c
@@ -638,7 +638,6 @@ static int iowarrior_open(struct inode *inode, struct file *file)
 static int iowarrior_release(struct inode *inode, struct file *file)
 {
 	struct iowarrior *dev;
-	int retval = 0;
 
 	dev = file->private_data;
 	if (!dev)
@@ -650,27 +649,23 @@ static int iowarrior_release(struct inode *inode, struct file *file)
 	mutex_lock(&dev->mutex);
 
 	if (dev->opened <= 0) {
-		retval = -ENODEV;	/* close called more than once */
 		mutex_unlock(&dev->mutex);
-	} else {
-		dev->opened = 0;	/* we're closing now */
-		retval = 0;
-		if (dev->present) {
-			/*
-			   The device is still connected so we only shutdown
-			   pending read-/write-ops.
-			 */
-			usb_kill_urb(dev->int_in_urb);
-			wake_up_interruptible(&dev->read_wait);
-			wake_up_interruptible(&dev->write_wait);
-			mutex_unlock(&dev->mutex);
-		} else {
-			/* The device was unplugged, cleanup resources */
-			mutex_unlock(&dev->mutex);
-			iowarrior_delete(dev);
-		}
+		return -ENODEV;	/* close called more than once */
 	}
-	return retval;
+
+	dev->opened = 0;	/* we're closing now */
+	if (dev->present) {
+		/*
+		 * The device is still connected so we only shutdown
+		 * pending read/write ops.
+		 */
+		usb_kill_urb(dev->int_in_urb);
+		wake_up_interruptible(&dev->read_wait);
+		wake_up_interruptible(&dev->write_wait);
+	}
+
+	mutex_unlock(&dev->mutex);
+	return 0;
 }
 
 static __poll_t iowarrior_poll(struct file *file, poll_table * wait)
-- 
2.20.1

