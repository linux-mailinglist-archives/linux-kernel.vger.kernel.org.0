Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0871002F8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 11:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfKRKwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 05:52:11 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:52702 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726460AbfKRKwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 05:52:11 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 400376F20A7C1EA285CE;
        Mon, 18 Nov 2019 18:52:09 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Mon, 18 Nov 2019
 18:51:58 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <liviu.dudau@arm.com>,
        <sudeep.holla@arm.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH] regulator: vexpress: Use PTR_ERR_OR_ZERO() to simplify code
Date:   Mon, 18 Nov 2019 18:59:22 +0800
Message-ID: <1574074762-34629-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warning:

drivers/regulator/vexpress-regulator.c:78:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/regulator/vexpress-regulator.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/regulator/vexpress-regulator.c b/drivers/regulator/vexpress-regulator.c
index 1235f46..5d39663 100644
--- a/drivers/regulator/vexpress-regulator.c
+++ b/drivers/regulator/vexpress-regulator.c
@@ -75,10 +75,7 @@ static int vexpress_regulator_probe(struct platform_device *pdev)
 	config.of_node = pdev->dev.of_node;

 	rdev = devm_regulator_register(&pdev->dev, desc, &config);
-	if (IS_ERR(rdev))
-		return PTR_ERR(rdev);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(rdev);
 }

 static const struct of_device_id vexpress_regulator_of_match[] = {
--
2.7.4

