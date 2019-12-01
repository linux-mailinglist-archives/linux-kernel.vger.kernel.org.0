Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD93910E02B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2019 04:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfLADDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Nov 2019 22:03:23 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:44359 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726906AbfLADDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 22:03:23 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TjWnwF9_1575169372;
Received: from localhost(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0TjWnwF9_1575169372)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 01 Dec 2019 11:03:00 +0800
From:   Wen Yang <wenyang@linux.alibaba.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     xlpang@linux.alibaba.com, Wen Yang <wenyang@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: core: fix regulator_register() error paths to properly release rdev
Date:   Sun,  1 Dec 2019 11:02:50 +0800
Message-Id: <20191201030250.38074-1-wenyang@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several issues with the error handling code of
the regulator_register() function:
        ret = device_register(&rdev->dev);
        if (ret != 0) {
                put_device(&rdev->dev); --> rdev released
                goto unset_supplies;
        }
...
unset_supplies:
...
        unset_regulator_supplies(rdev); --> use-after-free
...
clean:
        if (dangling_of_gpiod)
                gpiod_put(config->ena_gpiod);
        kfree(rdev);                     --> double free

We add a variable to record the failure of device_register() and
move put_device() down a bit to avoid the above issues.

Fixes: c438b9d01736 ("regulator: core: Move registration of regulator device")
Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 drivers/regulator/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 09a3550..4b22622 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5002,6 +5002,7 @@ struct regulator_dev *
 	struct regulator_dev *rdev;
 	bool dangling_cfg_gpiod = false;
 	bool dangling_of_gpiod = false;
+	bool reg_device_fail = false;
 	struct device *dev;
 	int ret, i;
 
@@ -5187,7 +5188,7 @@ struct regulator_dev *
 	dev_set_drvdata(&rdev->dev, rdev);
 	ret = device_register(&rdev->dev);
 	if (ret != 0) {
-		put_device(&rdev->dev);
+		reg_device_fail = true;
 		goto unset_supplies;
 	}
 
@@ -5218,7 +5219,10 @@ struct regulator_dev *
 clean:
 	if (dangling_of_gpiod)
 		gpiod_put(config->ena_gpiod);
-	kfree(rdev);
+	if (reg_device_fail)
+		put_device(&rdev->dev);
+	else
+		kfree(rdev);
 	kfree(config);
 rinse:
 	if (dangling_cfg_gpiod)
-- 
1.8.3.1

