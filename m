Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACB4C3D390
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 19:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405882AbfFKRJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 13:09:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52788 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405615AbfFKRJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 13:09:23 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hakGn-0002YS-I1; Tue, 11 Jun 2019 17:09:13 +0000
From:   Colin King <colin.king@canonical.com>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] video: fbdev: atmel_lcdfb: remove redundant initialization to variable ret
Date:   Tue, 11 Jun 2019 18:09:13 +0100
Message-Id: <20190611170913.20913-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently variable ret is being initialized with -ENOENT however that
value is never read and ret is being re-assigned later on. Hence this
assignment is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/video/fbdev/atmel_lcdfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
index fb117ccbeab3..930cc3f92e01 100644
--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -950,7 +950,7 @@ static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
 	struct fb_videomode fb_vm;
 	struct gpio_desc *gpiod;
 	struct videomode vm;
-	int ret = -ENOENT;
+	int ret;
 	int i;
 
 	sinfo->config = (struct atmel_lcdfb_config*)
-- 
2.20.1

