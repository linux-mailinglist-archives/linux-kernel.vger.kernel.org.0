Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 811A2ABF24
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 20:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392367AbfIFSLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 14:11:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56276 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387514AbfIFSLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 14:11:17 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1i6IhW-0007zm-Uk; Fri, 06 Sep 2019 18:11:15 +0000
From:   Colin King <colin.king@canonical.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: matrox: make array wtst_xlat static const, makes object smaller
Date:   Fri,  6 Sep 2019 19:11:14 +0100
Message-Id: <20190906181114.31414-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the array wtst_xlat on the stack but instead make it
static const. Makes the object code smaller by 89 bytes.

Before:
   text	   data	    bss	    dec	    hex	filename
  14347	    840	      0	  15187	   3b53	fbdev/matrox/matroxfb_misc.o

After:
   text	   data	    bss	    dec	    hex	filename
  14162	    936	      0	  15098	   3afa	fbdev/matrox/matroxfb_misc.o

(gcc version 9.2.1, amd64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/video/fbdev/matrox/matroxfb_misc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/matrox/matroxfb_misc.c b/drivers/video/fbdev/matrox/matroxfb_misc.c
index c7aaca12805e..feb0977c82eb 100644
--- a/drivers/video/fbdev/matrox/matroxfb_misc.c
+++ b/drivers/video/fbdev/matrox/matroxfb_misc.c
@@ -673,7 +673,10 @@ static int parse_pins5(struct matrox_fb_info *minfo,
 	if (bd->pins[115] & 4) {
 		minfo->values.reg.mctlwtst_core = minfo->values.reg.mctlwtst;
 	} else {
-		u_int32_t wtst_xlat[] = { 0, 1, 5, 6, 7, 5, 2, 3 };
+		static const u_int32_t wtst_xlat[] = {
+			0, 1, 5, 6, 7, 5, 2, 3
+		};
+
 		minfo->values.reg.mctlwtst_core = (minfo->values.reg.mctlwtst & ~7) |
 						  wtst_xlat[minfo->values.reg.mctlwtst & 7];
 	}
-- 
2.20.1

