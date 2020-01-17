Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02CA3140CC6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 15:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgAQOjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 09:39:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:57410 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727243AbgAQOjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:39:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 29BCDABE9;
        Fri, 17 Jan 2020 14:39:01 +0000 (UTC)
From:   Mian Yousaf Kaukab <ykaukab@suse.de>
To:     linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org
Cc:     linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com,
        suzuki.poulose@arm.com, alexander.shishkin@linux.intel.com,
        Mian Yousaf Kaukab <ykaukab@suse.de>
Subject: [PATCH RFC 02/15] coresight: remove multiple init calls from funnel driver
Date:   Fri, 17 Jan 2020 15:39:57 +0100
Message-Id: <20200117144010.11149-3-ykaukab@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200117144010.11149-1-ykaukab@suse.de>
References: <20200117144010.11149-1-ykaukab@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dynamic-funnel uses module_amba_driver to register. Whereas
static-funnel uses builtin_platform_driver. Combine these init calls
into a single module_init/exit pair in preparation to make the driver
modular.

Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
---
 drivers/hwtracing/coresight/coresight-funnel.c | 30 ++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 08d8f2b3565f..32cbf112ae34 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -342,7 +342,6 @@ static struct platform_driver static_funnel_driver = {
 		.suppress_bind_attrs = true,
 	},
 };
-builtin_platform_driver(static_funnel_driver);
 
 static int dynamic_funnel_probe(struct amba_device *adev,
 				const struct amba_id *id)
@@ -373,7 +372,34 @@ static struct amba_driver dynamic_funnel_driver = {
 	.probe		= dynamic_funnel_probe,
 	.id_table	= dynamic_funnel_ids,
 };
-module_amba_driver(dynamic_funnel_driver);
+
+static int __init funnel_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&static_funnel_driver);
+	if (ret) {
+		pr_info("Error registering platform driver\n");
+		return ret;
+	}
+
+	ret = amba_driver_register(&dynamic_funnel_driver);
+	if (ret) {
+		pr_info("Error registering amba driver\n");
+		platform_driver_unregister(&static_funnel_driver);
+	}
+
+	return ret;
+}
+
+static void __exit funnel_exit(void)
+{
+	platform_driver_unregister(&static_funnel_driver);
+	amba_driver_unregister(&dynamic_funnel_driver);
+}
+
+module_init(funnel_init);
+module_exit(funnel_exit);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("CoreSight Funnel driver");
-- 
2.16.4

