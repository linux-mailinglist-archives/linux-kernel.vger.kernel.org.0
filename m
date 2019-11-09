Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECCEF5D37
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2019 04:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfKIDhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 22:37:35 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5750 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725895AbfKIDhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 22:37:35 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5E7C2D1528BB2E8FAC0A;
        Sat,  9 Nov 2019 11:37:32 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Sat, 9 Nov 2019
 11:37:26 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jk@ozlabs.org>, <joel@jms.id.au>, <eajames@linux.ibm.com>,
        <andrew@aj.id.au>
CC:     <alistair@popple.id.au>, <linux-fsi@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] fsi: aspeed: Use devm_kfree in aspeed_master_release()
Date:   Sat, 9 Nov 2019 11:36:34 +0800
Message-ID: <20191109033634.30544-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20191109033209.45244-1-yuehaibing@huawei.com>
References: <20191109033209.45244-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'aspeed' is allocated by devm_kzalloc(), it should not be
freed by kfree().

Fixes: 1edac1269c02 ("fsi: Add ast2600 master driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: fix log typos
---
 drivers/fsi/fsi-master-aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index 3dd82dd..0f63eec 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -361,7 +361,7 @@ static void aspeed_master_release(struct device *dev)
 	struct fsi_master_aspeed *aspeed =
 		to_fsi_master_aspeed(dev_to_fsi_master(dev));
 
-	kfree(aspeed);
+	devm_kfree(dev, aspeed);
 }
 
 /* mmode encoders */
-- 
2.7.4


