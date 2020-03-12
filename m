Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1C21827AD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 05:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgCLEVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 00:21:35 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47066 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726028AbgCLEVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 00:21:35 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B8E0EF47DA97923627FA;
        Thu, 12 Mar 2020 12:21:26 +0800 (CST)
Received: from huawei.com (10.175.113.25) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Thu, 12 Mar 2020
 12:21:19 +0800
From:   Zheng Zengkai <zhengzengkai@huawei.com>
To:     <anton@tuxera.com>
CC:     <linux-ntfs-dev@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <zhengzengkai@huawei.com>
Subject: [PATCH -next] fs/ntfs: fix set but not used variable 'log_page_mask'
Date:   Thu, 12 Mar 2020 12:13:53 +0800
Message-ID: <20200312041353.19877-1-zhengzengkai@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

fs/ntfs/logfile.c: In function ntfs_check_logfile:
fs/ntfs/logfile.c:481:21:
 warning: variable log_page_mask set but not used [-Wunused-but-set-variable]

Actually log_page_mask can be used to replace 'log_page_size - 1' as it is set.

Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
---
 fs/ntfs/logfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs/logfile.c b/fs/ntfs/logfile.c
index a0c40f1be7ac..c35fcf389369 100644
--- a/fs/ntfs/logfile.c
+++ b/fs/ntfs/logfile.c
@@ -507,7 +507,7 @@ bool ntfs_check_logfile(struct inode *log_vi, RESTART_PAGE_HEADER **rp)
 	 * optimize log_page_size and log_page_bits into constants.
 	 */
 	log_page_bits = ntfs_ffs(log_page_size) - 1;
-	size &= ~(s64)(log_page_size - 1);
+	size &= ~(s64)(log_page_mask);
 	/*
 	 * Ensure the log file is big enough to store at least the two restart
 	 * pages and the minimum number of log record pages.
-- 
2.20.1

