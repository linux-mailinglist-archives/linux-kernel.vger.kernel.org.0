Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 045B816B2CC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 22:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgBXVkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 16:40:47 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:31498 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728040AbgBXVkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 16:40:43 -0500
X-Greylist: delayed 986 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Feb 2020 16:40:39 EST
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 01OLO5UU008696;
        Mon, 24 Feb 2020 22:24:05 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 05/10] floppy: cleanup: expand macro UDRWE
Date:   Mon, 24 Feb 2020 22:23:47 +0100
Message-Id: <20200224212352.8640-6-w@1wt.eu>
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
 drivers/block/floppy.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 522fbcc..a76a9bb 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -310,8 +310,6 @@ static bool initialized;
 #define DRS	(&drive_state[current_drive])
 #define DRWE	(&write_errors[current_drive])
 
-#define UDRWE	(&write_errors[drive])
-
 #define PH_HEAD(floppy, head) (((((floppy)->stretch & 2) >> 1) ^ head) << 2)
 #define STRETCH(floppy)	((floppy)->stretch & FD_STRETCH)
 
@@ -3553,10 +3551,10 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode, unsigned int
 		outparam = &fdc_state[FDC(drive)];
 		break;
 	case FDWERRORCLR:
-		memset(UDRWE, 0, sizeof(*UDRWE));
+		memset(&write_errors[drive], 0, sizeof(write_errors[drive]));
 		return 0;
 	case FDWERRORGET:
-		outparam = UDRWE;
+		outparam = &write_errors[drive];
 		break;
 	case FDRAWCMD:
 		if (type)
@@ -3867,7 +3865,7 @@ static int compat_werrorget(int drive,
 
 	memset(&v32, 0, sizeof(struct compat_floppy_write_errors));
 	mutex_lock(&floppy_mutex);
-	v = *UDRWE;
+	v = write_errors[drive];
 	mutex_unlock(&floppy_mutex);
 	v32.write_errors = v.write_errors;
 	v32.first_error_sector = v.first_error_sector;
@@ -4643,7 +4641,7 @@ static int __init do_floppy_init(void)
 	/* initialise drive state */
 	for (drive = 0; drive < N_DRIVE; drive++) {
 		memset(&drive_state[drive], 0, sizeof(drive_state[drive]));
-		memset(UDRWE, 0, sizeof(*UDRWE));
+		memset(&write_errors[drive], 0, sizeof(write_errors[drive]));
 		set_bit(FD_DISK_NEWCHANGE_BIT, &drive_state[drive].flags);
 		set_bit(FD_DISK_CHANGED_BIT, &drive_state[drive].flags);
 		set_bit(FD_VERIFY_BIT, &drive_state[drive].flags);
-- 
2.9.0

