Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7B02FCD2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 15:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfE3N7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 09:59:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18056 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726232AbfE3N7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 09:59:21 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6E5F5EED7AC29741A111;
        Thu, 30 May 2019 21:59:19 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Thu, 30 May 2019
 21:59:10 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jeyu@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <paulmck@linux.ibm.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2] kernel/module: Fix mem leak in module_add_modinfo_attrs
Date:   Thu, 30 May 2019 21:43:04 +0800
Message-ID: <20190530134304.4976-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20190515161212.28040-1-yuehaibing@huawei.com>
References: <20190515161212.28040-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In module_add_modinfo_attrs if sysfs_create_file
fails, we forget to free allocated modinfo_attrs
and roll back the sysfs files.

Fixes: 03e88ae1b13d ("[PATCH] fix module sysfs files reference counting")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: free from '--i' instead of 'i--'  
---
 kernel/module.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/module.c b/kernel/module.c
index 6e6712b..78e21a7 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1723,15 +1723,29 @@ static int module_add_modinfo_attrs(struct module *mod)
 		return -ENOMEM;
 
 	temp_attr = mod->modinfo_attrs;
-	for (i = 0; (attr = modinfo_attrs[i]) && !error; i++) {
+	for (i = 0; (attr = modinfo_attrs[i]); i++) {
 		if (!attr->test || attr->test(mod)) {
 			memcpy(temp_attr, attr, sizeof(*temp_attr));
 			sysfs_attr_init(&temp_attr->attr);
 			error = sysfs_create_file(&mod->mkobj.kobj,
 					&temp_attr->attr);
+			if (error)
+				goto error_out;
 			++temp_attr;
 		}
 	}
+
+	return 0;
+
+error_out:
+	for (; (attr = &mod->modinfo_attrs[i]) && i >= 0; --i) {
+		if (!attr->attr.name)
+			break;
+		sysfs_remove_file(&mod->mkobj.kobj, &attr->attr);
+		if (attr->free)
+			attr->free(mod);
+	}
+	kfree(mod->modinfo_attrs);
 	return error;
 }
 
-- 
2.7.4


