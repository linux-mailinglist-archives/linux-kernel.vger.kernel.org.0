Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B33999E8D8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 15:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbfH0NOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 09:14:12 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5224 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729660AbfH0NOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 09:14:11 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7EFC672E772FE8289F6A;
        Tue, 27 Aug 2019 21:14:06 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Tue, 27 Aug 2019
 21:13:56 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <christian.gromm@microchip.com>,
        <dan.carpenter@oracle.com>, <colin.king@canonical.com>,
        <yuehaibing@huawei.com>
CC:     <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] staging: most: sound: Fix error path of audio_init
Date:   Tue, 27 Aug 2019 21:13:46 +0800
Message-ID: <20190827131346.12704-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If most_register_configfs_subsys() fails, we should
call most_deregister_component() do cleanup.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 919c03ae11b9 ("staging: most: enable configfs support")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/most/sound/sound.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/most/sound/sound.c b/drivers/staging/most/sound/sound.c
index 342f390..7981706 100644
--- a/drivers/staging/most/sound/sound.c
+++ b/drivers/staging/most/sound/sound.c
@@ -802,8 +802,11 @@ static int __init audio_init(void)
 	if (ret)
 		pr_err("Failed to register %s\n", comp.name);
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


