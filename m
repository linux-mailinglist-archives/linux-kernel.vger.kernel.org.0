Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 819A7650A1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 05:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbfGKDaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 23:30:39 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38628 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725977AbfGKDaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 23:30:39 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5FEEBF942977EC5AC0C3;
        Thu, 11 Jul 2019 11:30:36 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 11 Jul 2019
 11:30:26 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lee.jones@linaro.org>, <tony.xie@rock-chips.com>,
        <stefan@olimex.com>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] mfd: rk808: Mark rk8xx_resume and rk8xx_suspend as __maybe_unused
Date:   Thu, 11 Jul 2019 11:30:06 +0800
Message-ID: <20190711033006.55320-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build warning:

drivers/mfd/rk808.c:752:12: warning: 'rk8xx_resume' defined but not used [-Wunused-function]
drivers/mfd/rk808.c:732:12: warning: 'rk8xx_suspend' defined but not used [-Wunused-function]

The function is declared unconditionally but only called
while CONFIG_PM_SLEEP is set.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/mfd/rk808.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index 601cefb..9a9e631 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -729,7 +729,7 @@ static int rk808_remove(struct i2c_client *client)
 	return 0;
 }
 
-static int rk8xx_suspend(struct device *dev)
+static int __maybe_unused rk8xx_suspend(struct device *dev)
 {
 	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
 	int ret = 0;
@@ -749,7 +749,7 @@ static int rk8xx_suspend(struct device *dev)
 	return ret;
 }
 
-static int rk8xx_resume(struct device *dev)
+static int __maybe_unused rk8xx_resume(struct device *dev)
 {
 	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
 	int ret = 0;
-- 
2.7.4


