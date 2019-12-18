Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B013F123EA6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 05:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfLRErd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 23:47:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:34476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbfLRErd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 23:47:33 -0500
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFF4620715;
        Wed, 18 Dec 2019 04:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576644452;
        bh=eC2bTR5Nkmvf2hgzbrBdYOzQGZ9iz4olZoASTWentL4=;
        h=From:To:Cc:Subject:Date:From;
        b=03panMM7i10MTKkulWSQQELugfIRDUetMkvoNf/Pepl+5CbShiE3MqAahnLqDgH0A
         VYgS+czKP01EWQHU4hwahvXS8I8TRITlEZB6Gc+QhZk8tXE1ji0WviUxnsO5L4M2I4
         NSbZLJGaTyL2OqPxzLCYbc6fT/yUcXvspnk2s8Mg=
Received: by wens.tw (Postfix, from userid 1000)
        id 059ED5FCD0; Wed, 18 Dec 2019 12:47:28 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH RESEND] regulator: axp20x: Fix AXP22x ELDO2 regulator enable bitmask
Date:   Wed, 18 Dec 2019 12:47:20 +0800
Message-Id: <20191218044720.21990-1-wens@kernel.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

A copy-paste error was introduced when bitmasks were converted to
macros, incorrectly setting the enable bitmask for ELDO2 to the one
for ELDO1 for the AXP22x units.

Fix it by using the correct macro.

On affected boards, ELDO1 and/or ELDO2 are used to power the camera,
which is currently unsupported.

Fixes: db4a555f7c4c ("regulator: axp20x: use defines for masks")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

(Originally sent before v5.5-rc1 was tagged.)

Small fix. Patches [1] supporting the camera sensor interface on the
Allwinner R40 based BPI-M2U board depend on this at runtime to power on
the camera correctly.

[1] https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=217057

---
 drivers/regulator/axp20x-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 989506bd90b1..fe369cba34fb 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -605,7 +605,7 @@ static const struct regulator_desc axp22x_regulators[] = {
 		 AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_ELDO1_MASK),
 	AXP_DESC(AXP22X, ELDO2, "eldo2", "eldoin", 700, 3300, 100,
 		 AXP22X_ELDO2_V_OUT, AXP22X_ELDO2_V_OUT_MASK,
-		 AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_ELDO1_MASK),
+		 AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_ELDO2_MASK),
 	AXP_DESC(AXP22X, ELDO3, "eldo3", "eldoin", 700, 3300, 100,
 		 AXP22X_ELDO3_V_OUT, AXP22X_ELDO3_V_OUT_MASK,
 		 AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_ELDO3_MASK),
-- 
2.24.0

