Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A676B7C7EB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 17:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730381AbfGaP7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 11:59:35 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56174 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729832AbfGaP61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:58:27 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D86B9402557CD4B6EF46;
        Wed, 31 Jul 2019 23:58:25 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 31 Jul
 2019 23:58:19 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chao Yu <yuchao0@huawei.com>, <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v2 08/22] staging: erofs: kill CONFIG_EROFS_FS_IO_MAX_RETRIES
Date:   Wed, 31 Jul 2019 23:57:38 +0800
Message-ID: <20190731155752.210602-9-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731155752.210602-1-gaoxiang25@huawei.com>
References: <20190731155752.210602-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_EROFS_FS_IO_MAX_RETRIES seems a runtime setting
and users have no idea about the change in behaviour.

Let's remove the setting currently and could turn it
into a module parameter if it's really needed.

Suggested-by: David Sterba <dsterba@suse.cz>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/Kconfig    | 9 ---------
 drivers/staging/erofs/internal.h | 8 ++------
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/erofs/Kconfig b/drivers/staging/erofs/Kconfig
index 2577cbb46a5b..747e9eebfaa5 100644
--- a/drivers/staging/erofs/Kconfig
+++ b/drivers/staging/erofs/Kconfig
@@ -78,15 +78,6 @@ config EROFS_FAULT_INJECTION
 	  Test EROFS to inject faults such as ENOMEM, EIO, and so on.
 	  If unsure, say N.
 
-config EROFS_FS_IO_MAX_RETRIES
-	int "EROFS IO Maximum Retries"
-	depends on EROFS_FS
-	default "5"
-	help
-	  Maximum retry count of IO Errors.
-
-	  If unsure, leave the default value (5 retries, 6 IOs at most).
-
 config EROFS_FS_ZIP
 	bool "EROFS Data Compresssion Support"
 	depends on EROFS_FS
diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index 959bd0ae9d74..a3b9fcdd0c27 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -279,6 +279,8 @@ static inline void z_erofs_exit_zip_subsystem(void) {}
 #error erofs cannot be used in this platform
 #endif
 
+#define EROFS_IO_MAX_RETRIES_NOFAIL     5
+
 #define ROOT_NID(sb)		((sb)->root_nid)
 
 #define erofs_blknr(addr)       ((addr) / EROFS_BLKSIZ)
@@ -467,12 +469,6 @@ static inline void __submit_bio(struct bio *bio, unsigned int op,
 	submit_bio(bio);
 }
 
-#ifndef CONFIG_EROFS_FS_IO_MAX_RETRIES
-#define EROFS_IO_MAX_RETRIES_NOFAIL	0
-#else
-#define EROFS_IO_MAX_RETRIES_NOFAIL	CONFIG_EROFS_FS_IO_MAX_RETRIES
-#endif
-
 struct page *__erofs_get_meta_page(struct super_block *sb, erofs_blk_t blkaddr,
 				   bool prio, bool nofail);
 
-- 
2.17.1

