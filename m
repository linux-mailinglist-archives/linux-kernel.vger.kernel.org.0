Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A827313D75E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 11:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732178AbgAPKBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 05:01:33 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:58408 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731892AbgAPKBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 05:01:31 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.06717481|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.275125-0.0157719-0.709104;DS=CONTINUE|ham_system_inform|0.0411218-0.000541632-0.958337;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16368;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=17;RT=17;SR=0;TI=SMTPD_---.Gd3Kgdg_1579168866;
Received: from PC-liaoweixiong.allwinnertech.com(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.Gd3Kgdg_1579168866)
          by smtp.aliyun-inc.com(10.147.42.241);
          Thu, 16 Jan 2020 18:01:24 +0800
From:   WeiXiong Liao <liaoweixiong@allwinnertech.com>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        WeiXiong Liao <liaoweixiong@allwinnertech.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: [PATCH 10/11] blkoops: add interface for dirver to get information of blkoops
Date:   Thu, 16 Jan 2020 18:00:30 +0800
Message-Id: <1579168831-16399-11-git-send-email-liaoweixiong@allwinnertech.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1579168831-16399-1-git-send-email-liaoweixiong@allwinnertech.com>
References: <1579168831-16399-1-git-send-email-liaoweixiong@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's one of a series of patches for adaptive to MTD device.

MTD device need to check size of recorder and get mtddev index to verify
which mtd device to use. All it needs is defined in blkoops. So, there
should be a interface for MTD driver to get all information it need.

Signed-off-by: WeiXiong Liao <liaoweixiong@allwinnertech.com>
---
 fs/pstore/blkoops.c     | 47 ++++++++++++++++++++++++++++++++++++-----------
 include/linux/blkoops.h | 10 ++++++++++
 2 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/fs/pstore/blkoops.c b/fs/pstore/blkoops.c
index 3d57a3126c7b..2788cbb9882d 100644
--- a/fs/pstore/blkoops.c
+++ b/fs/pstore/blkoops.c
@@ -117,6 +117,20 @@
 #define DEFAULT_BLKDEV ""
 #endif
 
+#define check_size(name, defsize, alignsize) ({			\
+	long _##name_ = (name);					\
+	if ((name) < 0)						\
+		_##name_ = (defsize);				\
+	_##name_ = _##name_ <= 0 ? 0 : (_##name_ * 1024);	\
+	if (_##name_ & (alignsize - 1)) {			\
+		pr_info(#name " must align to %d\n",		\
+				(alignsize));			\
+		_##name_ = ALIGN(name, alignsize);		\
+	}							\
+	_##name_;						\
+})
+
+
 /**
  * register device to blkoops
  *
@@ -148,18 +162,10 @@ int blkoops_register_device(struct blkoops_device *bo_dev)
 		bo_dev->flags = BLKOOPS_DEV_SUPPORT_ALL;
 #define verify_size(name, defsize, alignsize, enable) {			\
 		long _##name_;						\
-		if (!(enable))						\
-			_##name_ = 0;					\
-		else if ((name) >= 0)					\
-			_##name_ = (name);				\
+		if (enable)						\
+			_##name_ = check_size(name, defsize, alignsize);\
 		else							\
-			_##name_ = (defsize);				\
-		_##name_ = _##name_ <= 0 ? 0 : (_##name_ * 1024);	\
-		if (_##name_ & (alignsize - 1)) {			\
-			pr_info(#name " must align to %d\n",		\
-					(alignsize));			\
-			_##name_ = ALIGN(name, alignsize);		\
-		}							\
+			_##name_ = 0;					\
 		name = _##name_ / 1024;					\
 		bzinfo->name = _##name_;				\
 	}
@@ -460,6 +466,25 @@ int blkoops_blkdev_info(dev_t *devt, sector_t *nr_sects, sector_t *start_sect)
 }
 EXPORT_SYMBOL_GPL(blkoops_blkdev_info);
 
+/* get information of blkoops */
+int  blkoops_info(struct blkoops_info *info)
+{
+	if (!blkdev[0] && strlen(DEFAULT_BLKDEV))
+		strncpy(blkdev, DEFAULT_BLKDEV, 80);
+
+	memcpy(info->device, blkdev, 80);
+	info->dump_oops = !!(dump_oops < 0 ? DEFAULT_DUMP_OOPS : dump_oops);
+
+	info->dmesg_size = check_size(dmesg_size, DEFAULT_DMESG_SIZE, 4096);
+	info->pmsg_size = check_size(pmsg_size, DEFAULT_PMSG_SIZE, 4096);
+	info->ftrace_size = check_size(ftrace_size, DEFAULT_FTRACE_SIZE, 4096);
+	info->console_size = check_size(console_size, DEFAULT_CONSOLE_SIZE,
+			4096);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(blkoops_info);
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("WeiXiong Liao <liaoweixiong@allwinnertech.com>");
 MODULE_DESCRIPTION("Wrapper for Pstore BLK with Oops logger");
diff --git a/include/linux/blkoops.h b/include/linux/blkoops.h
index 11cb3036ad5f..ea56f3f92360 100644
--- a/include/linux/blkoops.h
+++ b/include/linux/blkoops.h
@@ -81,4 +81,14 @@ int  blkoops_register_blkdev(unsigned int major, unsigned int flags,
 void blkoops_unregister_blkdev(unsigned int major);
 int  blkoops_blkdev_info(dev_t *devt, sector_t *nr_sects, sector_t *start_sect);
 
+struct blkoops_info {
+	int dump_oops;
+	char device[80];
+	unsigned long dmesg_size;
+	unsigned long pmsg_size;
+	unsigned long console_size;
+	unsigned long ftrace_size;
+};
+int  blkoops_info(struct blkoops_info *info);
+
 #endif
-- 
1.9.1

