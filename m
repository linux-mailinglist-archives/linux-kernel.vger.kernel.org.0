Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEAE619926E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 11:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbgCaJlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 05:41:17 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34077 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730273AbgCaJlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:41:15 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 02V9f6hP024526;
        Tue, 31 Mar 2020 11:41:06 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 19/23] floppy: cleanup: make check_wp() not rely on current_{fdc,drive} anymore
Date:   Tue, 31 Mar 2020 11:40:50 +0200
Message-Id: <20200331094054.24441-20-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20200331094054.24441-1-w@1wt.eu>
References: <20200331094054.24441-1-w@1wt.eu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the fdc and drive are passed in argument so that the function does
not use current_fdc nor current_drive anymore.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 drivers/block/floppy.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index b929b60afe9b..b9a3a04c2636 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -1561,29 +1561,29 @@ static void seek_interrupt(void)
 	floppy_ready();
 }
 
-static void check_wp(void)
+static void check_wp(int fdc, int drive)
 {
-	if (test_bit(FD_VERIFY_BIT, &drive_state[current_drive].flags)) {
+	if (test_bit(FD_VERIFY_BIT, &drive_state[drive].flags)) {
 					/* check write protection */
-		output_byte(current_fdc, FD_GETSTATUS);
-		output_byte(current_fdc, UNIT(current_drive));
-		if (result(current_fdc) != 1) {
-			fdc_state[current_fdc].reset = 1;
+		output_byte(fdc, FD_GETSTATUS);
+		output_byte(fdc, UNIT(drive));
+		if (result(fdc) != 1) {
+			fdc_state[fdc].reset = 1;
 			return;
 		}
-		clear_bit(FD_VERIFY_BIT, &drive_state[current_drive].flags);
+		clear_bit(FD_VERIFY_BIT, &drive_state[drive].flags);
 		clear_bit(FD_NEED_TWADDLE_BIT,
-			  &drive_state[current_drive].flags);
-		debug_dcl(drive_params[current_drive].flags,
+			  &drive_state[drive].flags);
+		debug_dcl(drive_params[drive].flags,
 			  "checking whether disk is write protected\n");
-		debug_dcl(drive_params[current_drive].flags, "wp=%x\n",
+		debug_dcl(drive_params[drive].flags, "wp=%x\n",
 			  reply_buffer[ST3] & 0x40);
 		if (!(reply_buffer[ST3] & 0x40))
 			set_bit(FD_DISK_WRITABLE_BIT,
-				&drive_state[current_drive].flags);
+				&drive_state[drive].flags);
 		else
 			clear_bit(FD_DISK_WRITABLE_BIT,
-				  &drive_state[current_drive].flags);
+				  &drive_state[drive].flags);
 	}
 }
 
@@ -1627,7 +1627,7 @@ static void seek_floppy(void)
 			track = 1;
 		}
 	} else {
-		check_wp();
+		check_wp(current_fdc, current_drive);
 		if (raw_cmd->track != drive_state[current_drive].track &&
 		    (raw_cmd->flags & FD_RAW_NEED_SEEK))
 			track = raw_cmd->track;
-- 
2.20.1

