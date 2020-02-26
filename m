Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 204B616F8F7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 09:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbgBZII2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 03:08:28 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:31574 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727327AbgBZII2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 03:08:28 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 01Q87i3b001962;
        Wed, 26 Feb 2020 09:07:44 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 14/16] floppy: introduce new functions fdc_inb() and fdc_outb()
Date:   Wed, 26 Feb 2020 09:07:30 +0100
Message-Id: <20200226080732.1913-4-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20200226080732.1913-1-w@1wt.eu>
References: <20200224212352.8640-1-w@1wt.eu>
 <20200226080732.1913-1-w@1wt.eu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two functions replace fd_inb() and fd_outb() in that they take
the FDC in argument. This will ease the separation of the base address
and the port everywhere the code is used.
---
 drivers/block/floppy.c | 42 ++++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index d521899..250a451 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -594,6 +594,16 @@ static unsigned char fsector_t;	/* sector in track */
 static unsigned char in_sector_offset;	/* offset within physical sector,
 					 * expressed in units of 512 bytes */
 
+static inline unsigned char fdc_inb(int fdc, unsigned long addr)
+{
+	return fd_inb(addr);
+}
+
+static inline void fdc_outb(unsigned char value, int fdc, unsigned long addr)
+{
+	fd_outb(value, addr);
+}
+
 static inline bool drive_no_geom(int drive)
 {
 	return !current_type[drive] && !ITYPE(drive_state[drive].fd_device);
@@ -743,14 +753,14 @@ static int disk_change(int drive)
 		  "checking disk change line for drive %d\n", drive);
 	debug_dcl(drive_params[drive].flags, "jiffies=%lu\n", jiffies);
 	debug_dcl(drive_params[drive].flags, "disk change line=%x\n",
-		  fd_inb(FD_DIR) & 0x80);
+		  fdc_inb(fdc, FD_DIR) & 0x80);
 	debug_dcl(drive_params[drive].flags, "flags=%lx\n",
 		  drive_state[drive].flags);
 
 	if (drive_params[drive].flags & FD_BROKEN_DCL)
 		return test_bit(FD_DISK_CHANGED_BIT,
 				&drive_state[drive].flags);
-	if ((fd_inb(FD_DIR) ^ drive_params[drive].flags) & 0x80) {
+	if ((fdc_inb(fdc, FD_DIR) ^ drive_params[drive].flags) & 0x80) {
 		set_bit(FD_VERIFY_BIT, &drive_state[drive].flags);
 					/* verify write protection */
 
@@ -807,7 +817,7 @@ static int set_dor(int fdc, char mask, char data)
 			disk_change(drive);
 		}
 		fdc_state[fdc].dor = newdor;
-		fd_outb(newdor, FD_DOR);
+		fdc_outb(newdor, fdc, FD_DOR);
 
 		unit = newdor & 0x3;
 		if (!is_selected(olddor, unit) && is_selected(newdor, unit)) {
@@ -822,8 +832,8 @@ static void twaddle(void)
 {
 	if (drive_params[current_drive].select_delay)
 		return;
-	fd_outb(fdc_state[fdc].dor & ~(0x10 << UNIT(current_drive)), FD_DOR);
-	fd_outb(fdc_state[fdc].dor, FD_DOR);
+	fdc_outb(fdc_state[fdc].dor & ~(0x10 << UNIT(current_drive)), fdc, FD_DOR);
+	fdc_outb(fdc_state[fdc].dor, fdc, FD_DOR);
 	drive_state[current_drive].select_date = jiffies;
 }
 
@@ -864,7 +874,7 @@ static void set_fdc(int drive)
 #endif
 	if (fdc_state[fdc].rawcmd == 2)
 		reset_fdc_info(1);
-	if (fd_inb(FD_STATUS) != STATUS_READY)
+	if (fdc_inb(fdc, FD_STATUS) != STATUS_READY)
 		fdc_state[fdc].reset = 1;
 }
 
@@ -1103,7 +1113,7 @@ static int wait_til_ready(void)
 	if (fdc_state[fdc].reset)
 		return -1;
 	for (counter = 0; counter < 10000; counter++) {
-		status = fd_inb(FD_STATUS);
+		status = fdc_inb(fdc, FD_STATUS);
 		if (status & STATUS_READY)
 			return status;
 	}
@@ -1124,7 +1134,7 @@ static int output_byte(char byte)
 		return -1;
 
 	if (is_ready_state(status)) {
-		fd_outb(byte, FD_DATA);
+		fdc_outb(byte, fdc, FD_DATA);
 		output_log[output_log_pos].data = byte;
 		output_log[output_log_pos].status = status;
 		output_log[output_log_pos].jiffies = jiffies;
@@ -1157,7 +1167,7 @@ static int result(void)
 			return i;
 		}
 		if (status == (STATUS_DIR | STATUS_READY | STATUS_BUSY))
-			reply_buffer[i] = fd_inb(FD_DATA);
+			reply_buffer[i] = fdc_inb(fdc, FD_DATA);
 		else
 			break;
 	}
@@ -1352,7 +1362,7 @@ static int fdc_dtr(void)
 		return 0;
 
 	/* Set dtr */
-	fd_outb(raw_cmd->rate & 3, FD_DCR);
+	fdc_outb(raw_cmd->rate & 3, fdc, FD_DCR);
 
 	/* TODO: some FDC/drive combinations (C&T 82C711 with TEAC 1.2MB)
 	 * need a stabilization period of several milliseconds to be
@@ -1796,11 +1806,11 @@ static void reset_fdc(void)
 	release_dma_lock(flags);
 
 	if (fdc_state[fdc].version >= FDC_82072A)
-		fd_outb(0x80 | (fdc_state[fdc].dtr & 3), FD_STATUS);
+		fdc_outb(0x80 | (fdc_state[fdc].dtr & 3), fdc, FD_STATUS);
 	else {
-		fd_outb(fdc_state[fdc].dor & ~0x04, FD_DOR);
+		fdc_outb(fdc_state[fdc].dor & ~0x04, fdc, FD_DOR);
 		udelay(FD_RESET_DELAY);
-		fd_outb(fdc_state[fdc].dor, FD_DOR);
+		fdc_outb(fdc_state[fdc].dor, fdc, FD_DOR);
 	}
 }
 
@@ -1827,7 +1837,7 @@ static void show_floppy(void)
 	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE, 16, 1,
 		       reply_buffer, resultsize, true);
 
-	pr_info("status=%x\n", fd_inb(FD_STATUS));
+	pr_info("status=%x\n", fdc_inb(fdc, FD_STATUS));
 	pr_info("fdc_busy=%lu\n", fdc_busy);
 	if (do_floppy)
 		pr_info("do_floppy=%ps\n", do_floppy);
@@ -4875,7 +4885,7 @@ static int floppy_grab_irq_and_dma(void)
 	for (fdc = 0; fdc < N_FDC; fdc++) {
 		if (fdc_state[fdc].address != -1) {
 			reset_fdc_info(1);
-			fd_outb(fdc_state[fdc].dor, FD_DOR);
+			fdc_outb(fdc_state[fdc].dor, fdc, FD_DOR);
 		}
 	}
 	fdc = 0;
@@ -4883,7 +4893,7 @@ static int floppy_grab_irq_and_dma(void)
 
 	for (fdc = 0; fdc < N_FDC; fdc++)
 		if (fdc_state[fdc].address != -1)
-			fd_outb(fdc_state[fdc].dor, FD_DOR);
+			fdc_outb(fdc_state[fdc].dor, fdc, FD_DOR);
 	/*
 	 * The driver will try and free resources and relies on us
 	 * to know if they were allocated or not.
-- 
2.9.0

