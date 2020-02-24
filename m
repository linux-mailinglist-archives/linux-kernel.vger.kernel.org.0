Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A70E116B2EE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 22:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgBXVlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 16:41:35 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:31498 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727459AbgBXVkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 16:40:40 -0500
X-Greylist: delayed 986 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Feb 2020 16:40:39 EST
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 01OLO4Ms008693;
        Mon, 24 Feb 2020 22:24:04 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 02/10] floppy: cleanup: expand macro UFDCS
Date:   Mon, 24 Feb 2020 22:23:44 +0100
Message-Id: <20200224212352.8640-3-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20200224212352.8640-1-w@1wt.eu>
References: <20200224212352.8640-1-w@1wt.eu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This macro doesn't bring much value and only slightly obfuscates the
code by silently using local variable "drive", let's expand it.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 drivers/block/floppy.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 93e0840..182148a 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -313,7 +313,6 @@ static bool initialized;
 #define UDP	(&drive_params[drive])
 #define UDRS	(&drive_state[drive])
 #define UDRWE	(&write_errors[drive])
-#define UFDCS	(&fdc_state[FDC(drive)])
 
 #define PH_HEAD(floppy, head) (((((floppy)->stretch & 2) >> 1) ^ head) << 2)
 #define STRETCH(floppy)	((floppy)->stretch & FD_STRETCH)
@@ -3549,7 +3548,7 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode, unsigned int
 	case FDRESET:
 		return user_reset_fdc(drive, (int)param, true);
 	case FDGETFDCSTAT:
-		outparam = UFDCS;
+		outparam = &fdc_state[FDC(drive)];
 		break;
 	case FDWERRORCLR:
 		memset(UDRWE, 0, sizeof(*UDRWE));
@@ -3833,7 +3832,7 @@ static int compat_getfdcstat(int drive,
 	struct floppy_fdc_state v;
 
 	mutex_lock(&floppy_mutex);
-	v = *UFDCS;
+	v = fdc_state[FDC(drive)];
 	mutex_unlock(&floppy_mutex);
 
 	memset(&v32, 0, sizeof(struct compat_floppy_fdc_state));
@@ -4062,8 +4061,8 @@ static int floppy_open(struct block_device *bdev, fmode_t mode)
 			buffer_track = -1;
 	}
 
-	if (UFDCS->rawcmd == 1)
-		UFDCS->rawcmd = 2;
+	if (fdc_state[FDC(drive)].rawcmd == 1)
+		fdc_state[FDC(drive)].rawcmd = 2;
 
 	if (!(mode & FMODE_NDELAY)) {
 		if (mode & (FMODE_READ|FMODE_WRITE)) {
-- 
2.9.0

