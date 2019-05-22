Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B823D26982
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 20:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbfEVSFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 14:05:00 -0400
Received: from gateway24.websitewelcome.com ([192.185.50.73]:12011 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728272AbfEVSE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 14:04:59 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id A3D1B33202
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 13:04:58 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id TVbmht0CB2qH7TVbmh85iU; Wed, 22 May 2019 13:04:58 -0500
X-Authority-Reason: nr=8
Received: from [189.250.47.159] (port=44510 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hTVbb-003Hxx-Rn; Wed, 22 May 2019 13:04:57 -0500
Date:   Wed, 22 May 2019 13:04:46 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] mtd: onenand_base: Avoid fall-through warnings
Message-ID: <20190522180446.GA30082@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.47.159
X-Source-L: No
X-Exim-ID: 1hTVbb-003Hxx-Rn
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.47.159]:44510
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NOTICE THAT:

"...we don't know whether we need fallthroughs or breaks there and this
is just a change to avoid having new warnings when switching to
-Wimplicit-fallthrough but this change might be entirely wrong."[1]

See the original thread of discussion here:

https://lore.kernel.org/patchwork/patch/1036251/

So, in preparation to enabling -Wimplicit-fallthrough, this patch silences
the following warnings:

drivers/mtd/nand/onenand/onenand_base.c: In function ‘onenand_check_features’:
drivers/mtd/nand/onenand/onenand_base.c:3264:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (ONENAND_IS_DDP(this))
      ^
drivers/mtd/nand/onenand/onenand_base.c:3284:2: note: here
  case ONENAND_DEVICE_DENSITY_2Gb:
  ^~~~
drivers/mtd/nand/onenand/onenand_base.c:3288:17: warning: this statement may fall through [-Wimplicit-fallthrough=]
   this->options |= ONENAND_HAS_UNLOCK_ALL;
drivers/mtd/nand/onenand/onenand_base.c:3290:2: note: here
  case ONENAND_DEVICE_DENSITY_1Gb:
  ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

[1] https://lore.kernel.org/lkml/20190509085318.34a9d4be@xps13/

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/mtd/nand/onenand/onenand_base.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/onenand/onenand_base.c b/drivers/mtd/nand/onenand/onenand_base.c
index f41d76248550..6cf4df9f8c01 100644
--- a/drivers/mtd/nand/onenand/onenand_base.c
+++ b/drivers/mtd/nand/onenand/onenand_base.c
@@ -3280,12 +3280,14 @@ static void onenand_check_features(struct mtd_info *mtd)
 			if ((this->version_id & 0xf) == 0xe)
 				this->options |= ONENAND_HAS_NOP_1;
 		}
+		/* Fall through - ? */
 
 	case ONENAND_DEVICE_DENSITY_2Gb:
 		/* 2Gb DDP does not have 2 plane */
 		if (!ONENAND_IS_DDP(this))
 			this->options |= ONENAND_HAS_2PLANE;
 		this->options |= ONENAND_HAS_UNLOCK_ALL;
+		/* Fall through - ? */
 
 	case ONENAND_DEVICE_DENSITY_1Gb:
 		/* A-Die has all block unlock */
-- 
2.21.0

