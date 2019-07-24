Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A12E1740ED
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 23:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbfGXVik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 17:38:40 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:45044 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbfGXVik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 17:38:40 -0400
Received: from localhost.localdomain ([92.140.204.221])
        by mwinf5d44 with ME
        id gleY200114n7eLC03leZD3; Wed, 24 Jul 2019 23:38:37 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 24 Jul 2019 23:38:37 +0200
X-ME-IP: 92.140.204.221
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, b.zolnierkie@samsung.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] backlight: lms283gf05: Fix a typo in the description passed to 'devm_gpio_request_one()'
Date:   Wed, 24 Jul 2019 23:38:28 +0200
Message-Id: <20190724213828.16916-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The description passed to 'devm_gpio_request_one()' should be related to
LMS283GF05, not LMS285GF05.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/video/backlight/lms283gf05.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/lms283gf05.c b/drivers/video/backlight/lms283gf05.c
index 4237aaa7f269..4b62ed7e58c0 100644
--- a/drivers/video/backlight/lms283gf05.c
+++ b/drivers/video/backlight/lms283gf05.c
@@ -161,7 +161,7 @@ static int lms283gf05_probe(struct spi_device *spi)
 		ret = devm_gpio_request_one(&spi->dev, pdata->reset_gpio,
 				GPIOF_DIR_OUT | (!pdata->reset_inverted ?
 				GPIOF_INIT_HIGH : GPIOF_INIT_LOW),
-				"LMS285GF05 RESET");
+				"LMS283GF05 RESET");
 		if (ret)
 			return ret;
 	}
-- 
2.20.1

