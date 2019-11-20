Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86116103DD7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 15:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731885AbfKTO7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 09:59:36 -0500
Received: from albert.telenet-ops.be ([195.130.137.90]:46402 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731836AbfKTO7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 09:59:31 -0500
Received: from ramsan ([84.195.182.253])
        by albert.telenet-ops.be with bizsmtp
        id UEzU2100c5USYZQ06EzUK4; Wed, 20 Nov 2019 15:59:30 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iXRS4-0002Im-K9; Wed, 20 Nov 2019 15:59:28 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iXRS4-0002EJ-IZ; Wed, 20 Nov 2019 15:59:28 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 2/2] reset: Align logic and flow in managed helpers
Date:   Wed, 20 Nov 2019 15:59:27 +0100
Message-Id: <20191120145927.8523-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191120145927.8523-1-geert+renesas@glider.be>
References: <20191120145927.8523-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__devm_reset_control_get() and devm_reset_control_array_get() are very
similar, but they do not look similar, due to inverted logic.
Make them more similar, following the "bail out early" paradigm.

Adjust the logic and flow in devm_reset_controller_register() to match
the two other functions.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Use IS_ERR_OR_NULL().
---
 drivers/reset/core.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 7597c70e04d5b42b..01c0c7aa835cbfe2 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -150,13 +150,14 @@ int devm_reset_controller_register(struct device *dev,
 		return -ENOMEM;
 
 	ret = reset_controller_register(rcdev);
-	if (!ret) {
-		*rcdevp = rcdev;
-		devres_add(dev, rcdevp);
-	} else {
+	if (ret) {
 		devres_free(rcdevp);
+		return ret;
 	}
 
+	*rcdevp = rcdev;
+	devres_add(dev, rcdevp);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(devm_reset_controller_register);
@@ -787,13 +788,14 @@ struct reset_control *__devm_reset_control_get(struct device *dev,
 		return ERR_PTR(-ENOMEM);
 
 	rstc = __reset_control_get(dev, id, index, shared, optional, acquired);
-	if (!IS_ERR_OR_NULL(rstc)) {
-		*ptr = rstc;
-		devres_add(dev, ptr);
-	} else {
+	if (IS_ERR_OR_NULL(rstc)) {
 		devres_free(ptr);
+		return rstc;
 	}
 
+	*ptr = rstc;
+	devres_add(dev, ptr);
+
 	return rstc;
 }
 EXPORT_SYMBOL_GPL(__devm_reset_control_get);
@@ -919,22 +921,21 @@ EXPORT_SYMBOL_GPL(of_reset_control_array_get);
 struct reset_control *
 devm_reset_control_array_get(struct device *dev, bool shared, bool optional)
 {
-	struct reset_control **devres;
-	struct reset_control *rstc;
+	struct reset_control **ptr, *rstc;
 
-	devres = devres_alloc(devm_reset_control_release, sizeof(*devres),
-			      GFP_KERNEL);
-	if (!devres)
+	ptr = devres_alloc(devm_reset_control_release, sizeof(*ptr),
+			   GFP_KERNEL);
+	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
 	rstc = of_reset_control_array_get(dev->of_node, shared, optional, true);
 	if (IS_ERR_OR_NULL(rstc)) {
-		devres_free(devres);
+		devres_free(ptr);
 		return rstc;
 	}
 
-	*devres = rstc;
-	devres_add(dev, devres);
+	*ptr = rstc;
+	devres_add(dev, ptr);
 
 	return rstc;
 }
-- 
2.17.1

