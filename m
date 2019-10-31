Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF40FEB090
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 13:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfJaMqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 08:46:15 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5671 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726540AbfJaMqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 08:46:14 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 99A0EB15CB914ED5AC7D;
        Thu, 31 Oct 2019 20:46:08 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Thu, 31 Oct 2019 20:46:00 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <gregkh@linuxfoundation.org>, <akinobu.mita@gmail.com>
CC:     <tglx@linutronix.de>, <zhongjiang@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] notifier-error-inject: use DEFINE_DEBUGFS_ATTRIBUTE to define debugfs fops
Date:   Thu, 31 Oct 2019 20:42:08 +0800
Message-ID: <1572525728-23957-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is more clearly to use DEFINE_DEBUGFS_ATTRIBUTE to define debugfs file
operation rather than DEFINE_SIMPLE_ATTRIBUTE.

Meanwhile, debugfs_create_file() in debugfs_create_errno() can be replaced
by debugfs_create_file_unsafe().

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 lib/notifier-error-inject.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/notifier-error-inject.c b/lib/notifier-error-inject.c
index 21016b3..e5302f7 100644
--- a/lib/notifier-error-inject.c
+++ b/lib/notifier-error-inject.c
@@ -15,13 +15,13 @@ static int debugfs_errno_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(fops_errno, debugfs_errno_get, debugfs_errno_set,
+DEFINE_DEBUGFS_ATTRIBUTE(fops_errno, debugfs_errno_get, debugfs_errno_set,
 			"%lld\n");
 
 static struct dentry *debugfs_create_errno(const char *name, umode_t mode,
 				struct dentry *parent, int *value)
 {
-	return debugfs_create_file(name, mode, parent, value, &fops_errno);
+	return debugfs_create_file_unsafe(name, mode, parent, value, &fops_errno);
 }
 
 static int notifier_err_inject_callback(struct notifier_block *nb,
-- 
1.7.12.4

