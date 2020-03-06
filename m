Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A84BE17B737
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 08:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgCFHLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Mar 2020 02:11:41 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11188 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725927AbgCFHLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 02:11:41 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 12B0DF2D68E79AE1DDCC;
        Fri,  6 Mar 2020 15:11:33 +0800 (CST)
Received: from huawei.com (10.67.133.63) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Fri, 6 Mar 2020
 15:11:23 +0800
From:   Qiang Su <suqiang4@huawei.com>
To:     <gregkh@linuxfoundation.org>, <suqiang4@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <leeyou.li@huawei.com>,
        <nixiaoming@huawei.com>
Subject: [PATCH] UIO: make MAX_UIO_MAPS configurable by menuconfig
Date:   Fri, 6 Mar 2020 15:11:22 +0800
Message-ID: <20200306071122.71838-1-suqiang4@huawei.com>
X-Mailer: git-send-email 2.12.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.133.63]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now each uio device can only support 5 memory entry. It is
far from enough for some big system. On the other hand, the
hard-coded style is not flexible.
Consider the marco is used as array index, so we set a range
for the config in menuconfig. The range is set as 1 to 512.
The default value is still 5 to keep consistent with current
code.

Signed-off-by: Qiang Su <suqiang4@huawei.com>
---
 drivers/uio/Kconfig        | 9 +++++++++
 include/linux/uio_driver.h | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
index 202ee81cfc2b..31c53f1dd86a 100644
--- a/drivers/uio/Kconfig
+++ b/drivers/uio/Kconfig
@@ -165,4 +165,13 @@ config UIO_HV_GENERIC
 	  to network and storage devices from userspace.
 
 	  If you compile this as a module, it will be called uio_hv_generic.
+
+config UIO_MAX_UIO_MAPS
+	depends on UIO
+	int "Maximum of memory nodes each uio device support(1-512)"
+	range 1 512
+	default 5
+	help
+	  make the max number of uio device configurable.
+
 endif
diff --git a/include/linux/uio_driver.h b/include/linux/uio_driver.h
index 01081c4726c0..efdf8f6bf8bf 100644
--- a/include/linux/uio_driver.h
+++ b/include/linux/uio_driver.h
@@ -44,7 +44,7 @@ struct uio_mem {
 	struct uio_map		*map;
 };
 
-#define MAX_UIO_MAPS	5
+#define MAX_UIO_MAPS	CONFIG_MAX_UIO_MAPS
 
 struct uio_portio;
 
-- 
2.12.3

