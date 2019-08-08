Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB5C6857EC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 04:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730706AbfHHCDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 22:03:15 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54800 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730655AbfHHCDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 22:03:15 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DDAE935F919AAF914DE0;
        Thu,  8 Aug 2019 10:03:13 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Thu, 8 Aug 2019
 10:02:57 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jaegeuk@kernel.org>, <chao@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] f2fs: Fix build error while CONFIG_NLS=m
Date:   Thu, 8 Aug 2019 10:02:53 +0800
Message-ID: <20190808020253.27276-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_F2FS_FS=y but CONFIG_NLS=m, building fails:

fs/f2fs/file.o: In function `f2fs_ioctl':
file.c:(.text+0xb86f): undefined reference to `utf16s_to_utf8s'
file.c:(.text+0xe651): undefined reference to `utf8s_to_utf16s'

Select CONFIG_NLS to fix this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 61a3da4d5ef8 ("f2fs: support FS_IOC_{GET,SET}FSLABEL")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/f2fs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
index 110a38c..95f1b99 100644
--- a/fs/f2fs/Kconfig
+++ b/fs/f2fs/Kconfig
@@ -2,6 +2,7 @@
 config F2FS_FS
 	tristate "F2FS filesystem support"
 	depends on BLOCK
+	select NLS
 	select CRYPTO
 	select CRYPTO_CRC32
 	select F2FS_FS_XATTR if FS_ENCRYPTION
-- 
2.7.4


