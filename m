Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 221CD38905
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 13:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfFGL2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 07:28:53 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:60400 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbfFGL2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 07:28:53 -0400
Received: from ramsan ([84.194.111.163])
        by andre.telenet-ops.be with bizsmtp
        id MnUp2000W3XaVaC01nUpZF; Fri, 07 Jun 2019 13:28:51 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hZD3B-0004FB-GT; Fri, 07 Jun 2019 13:28:49 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hZD3B-0003ja-Et; Fri, 07 Jun 2019 13:28:49 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Marek Vasut <marek.vasut@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Jiri Kosina <trivial@kernel.org>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] mtd: spi-nor: Spelling s/Writ/Write/
Date:   Fri,  7 Jun 2019 13:28:48 +0200
Message-Id: <20190607112848.14313-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/mtd/spi-nor/spi-nor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index cbb0965f85ca4c86..ad61492186ae9198 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -200,7 +200,7 @@ struct sfdp_header {
  *         register does not modify status register 2.
  * - 101b: QE is bit 1 of status register 2. Status register 1 is read using
  *         Read Status instruction 05h. Status register2 is read using
- *         instruction 35h. QE is set via Writ Status instruction 01h with
+ *         instruction 35h. QE is set via Write Status instruction 01h with
  *         two data bytes where bit 1 of the second byte is one.
  *         [...]
  */
-- 
2.17.1

