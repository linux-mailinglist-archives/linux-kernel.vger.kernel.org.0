Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E31216F8F4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 09:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbgBZIII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 03:08:08 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:31568 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbgBZIIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 03:08:07 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 01Q87i8Y001961;
        Wed, 26 Feb 2020 09:07:44 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 13/16] floppy: prepare ARM code to simplify base address separation
Date:   Wed, 26 Feb 2020 09:07:29 +0100
Message-Id: <20200226080732.1913-3-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20200226080732.1913-1-w@1wt.eu>
References: <20200224212352.8640-1-w@1wt.eu>
 <20200226080732.1913-1-w@1wt.eu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fd_outb() macro on ARM relies on a special fd_setdor() macro when
the register is FD_DOR and both will need to be changed to accept a
separate base address. Let's just remerge them to simplify the change
and make this code more easily reviewable.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/arm/include/asm/floppy.h | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/arch/arm/include/asm/floppy.h b/arch/arm/include/asm/floppy.h
index f683953..c665136 100644
--- a/arch/arm/include/asm/floppy.h
+++ b/arch/arm/include/asm/floppy.h
@@ -9,12 +9,17 @@
 #ifndef __ASM_ARM_FLOPPY_H
 #define __ASM_ARM_FLOPPY_H
 
-#define fd_outb(val,port)			\
-	do {					\
-		if ((port) == (u32)FD_DOR)	\
-			fd_setdor((val));	\
-		else				\
-			outb((val),(port));	\
+#define fd_outb(val,port)						\
+	do {								\
+		int new_val = (val);					\
+		if ((port) == (u32)FD_DOR) {				\
+			if (new_val & 0xf0)				\
+				new_val = (new_val & 0x0c) |		\
+					  floppy_selects[new_val & 3];	\
+			else						\
+				new_val &= 0x0c;			\
+		}							\
+		outb(new_val, (port));					\
 	} while(0)
 
 #define fd_inb(port)		inb((port))
@@ -55,16 +60,6 @@ static unsigned char floppy_selects[4] =
 	{ 0x10, 0x21, 0x23, 0x33 },
 };
 
-#define fd_setdor(dor)								\
-do {										\
-	int new_dor = (dor);							\
-	if (new_dor & 0xf0)							\
-		new_dor = (new_dor & 0x0c) | floppy_selects[new_dor & 3];	\
-	else									\
-		new_dor &= 0x0c;						\
-	outb(new_dor, FD_DOR);							\
-} while (0)
-
 #define FDC1 (0x3f0)
 
 #define FLOPPY0_TYPE 4
-- 
2.9.0

