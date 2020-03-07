Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 491F917CCC8
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Mar 2020 09:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgCGIK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Mar 2020 03:10:27 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11194 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725907AbgCGIK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 03:10:26 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A364B773BC8948E5605A;
        Sat,  7 Mar 2020 16:10:19 +0800 (CST)
Received: from huawei.com (10.67.133.63) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Sat, 7 Mar 2020
 16:10:09 +0800
From:   Qiang Su <suqiang4@huawei.com>
To:     <gregkh@linuxfoundation.org>, <suqiang4@huawei.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH V2] UIO: make maximum memory and port regions configurable
Date:   Sat, 7 Mar 2020 16:10:08 +0800
Message-ID: <20200307081008.26848-1-suqiang4@huawei.com>
X-Mailer: git-send-email 2.12.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.133.63]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now each uio device can only support 5 memory regions and
5 port regions. It is far from enough for some big system.
On the other hand, the hard-coded style is not flexible.

Consider the marco is used as array index, so a range for
the config is set in menuconfig. The range is set as 1 to 512.
The default value is still set as 5 to keep consistent with
current code.

Signed-off-by: Qiang Su <suqiang4@huawei.com>
Reported-by: kbuild test robot <lkp@intel.com>
---
Changes since v1:
- also make port regions configurable in menuconfig.
- fix kbuild errors.
---
 drivers/uio/Kconfig        | 18 ++++++++++++++++++
 include/linux/uio_driver.h |  4 ++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
index 202ee81cfc2b..cee7d93cfea2 100644
--- a/drivers/uio/Kconfig
+++ b/drivers/uio/Kconfig
@@ -165,4 +165,22 @@ config UIO_HV_GENERIC
 	  to network and storage devices from userspace.
 
 	  If you compile this as a module, it will be called uio_hv_generic.
+
+config MAX_UIO_MAPS
+	depends on UIO
+	int "Maximum of memory nodes each uio device support(1-512)"
+	range 1 512
+	default 5
+	help
+	  make the max number of memory regions in uio device configurable.
+
+config MAX_UIO_PORT_REGIONS
+	depends on UIO
+	int "Maximum of port regions each uio device support(1-512)"
+	range 1 512
+	default 5
+	help
+	  make the max number of port regions in uio device configurable.
+
+
 endif
diff --git a/include/linux/uio_driver.h b/include/linux/uio_driver.h
index 01081c4726c0..5dc60088834c 100644
--- a/include/linux/uio_driver.h
+++ b/include/linux/uio_driver.h
@@ -44,7 +44,7 @@ struct uio_mem {
 	struct uio_map		*map;
 };
 
-#define MAX_UIO_MAPS	5
+#define MAX_UIO_MAPS	CONFIG_MAX_UIO_MAPS
 
 struct uio_portio;
 
@@ -64,7 +64,7 @@ struct uio_port {
 	struct uio_portio	*portio;
 };
 
-#define MAX_UIO_PORT_REGIONS	5
+#define MAX_UIO_PORT_REGIONS	CONFIG_MAX_UIO_PORT_REGIONS
 
 struct uio_device {
         struct module           *owner;
-- 
2.12.3

