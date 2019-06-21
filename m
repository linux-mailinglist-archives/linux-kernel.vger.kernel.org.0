Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE964EBE0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 17:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfFUPXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 11:23:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:19056 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726031AbfFUPXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 11:23:10 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 70F72877303C2B4B42B0;
        Fri, 21 Jun 2019 23:23:08 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Fri, 21 Jun 2019
 23:23:01 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <christian.gromm@microchip.com>,
        <colin.king@canonical.com>, <dan.carpenter@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] staging: most: Fix error path of audio_init
Date:   Fri, 21 Jun 2019 23:16:37 +0800
Message-ID: <20190621151637.34544-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If most_register_configfs_subsys fails, call
most_deregister_component to clean up.

Fixes: 919c03ae11b9 ("staging: most: enable configfs support")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/most/sound/sound.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/most/sound/sound.c b/drivers/staging/most/sound/sound.c
index 342f390..05996a5 100644
--- a/drivers/staging/most/sound/sound.c
+++ b/drivers/staging/most/sound/sound.c
@@ -799,11 +799,17 @@ static int __init audio_init(void)
 	INIT_LIST_HEAD(&adpt_list);
 
 	ret = most_register_component(&comp);
-	if (ret)
+	if (ret) {
 		pr_err("Failed to register %s\n", comp.name);
+		return ret;
+	}
+
 	ret = most_register_configfs_subsys(&comp);
-	if (ret)
+	if (ret) {
 		pr_err("Failed to register %s configfs subsys\n", comp.name);
+		most_deregister_component(&comp);
+	}
+
 	return ret;
 }
 
-- 
2.7.4


