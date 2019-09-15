Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B406B31CB
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2019 21:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfIOTlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Sep 2019 15:41:22 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:50940 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbfIOTlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 15:41:22 -0400
Received: from localhost.localdomain ([93.23.196.41])
        by mwinf5d03 with ME
        id 1vhJ210060u43at03vhJXW; Sun, 15 Sep 2019 21:41:20 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 15 Sep 2019 21:41:20 +0200
X-ME-IP: 93.23.196.41
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     linus.walleij@linaro.org, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] drm/mcde: Fix some resource leak in an error path in 'mcde_probe()'
Date:   Sun, 15 Sep 2019 21:41:14 +0200
Message-Id: <20190915194114.27658-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All error handling paths before and after this one go to the
'clk_disable' label in order to free some resources.

So the same here.

Fixes: ca5be902a87d ("drm/mcde: Fix uninitialized variable")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/mcde/mcde_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mcde/mcde_drv.c b/drivers/gpu/drm/mcde/mcde_drv.c
index 9a09eba53182..5649887d2b90 100644
--- a/drivers/gpu/drm/mcde/mcde_drv.c
+++ b/drivers/gpu/drm/mcde/mcde_drv.c
@@ -484,7 +484,8 @@ static int mcde_probe(struct platform_device *pdev)
 	}
 	if (!match) {
 		dev_err(dev, "no matching components\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto clk_disable;
 	}
 	if (IS_ERR(match)) {
 		dev_err(dev, "could not create component match\n");
-- 
2.20.1

