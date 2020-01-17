Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 020521401D6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 03:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387624AbgAQCWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 21:22:12 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9646 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729941AbgAQCWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 21:22:12 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 23EC03111015E7FE6893;
        Fri, 17 Jan 2020 10:22:10 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Fri, 17 Jan 2020
 10:22:01 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <stfrench@microsoft.com>, <pc@cjr.nz>
CC:     <linux-cifs@vger.kernel.org>, <samba-technical@lists.samba.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] cifs: Fix return value in __update_cache_entry
Date:   Fri, 17 Jan 2020 10:21:56 +0800
Message-ID: <20200117022156.57844-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

copy_ref_data() may return error, it should be
returned to upstream caller.

Fixes: 03535b72873b ("cifs: Avoid doing network I/O while holding cache lock")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/cifs/dfs_cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/dfs_cache.c b/fs/cifs/dfs_cache.c
index 5617efe..03cfaa1 100644
--- a/fs/cifs/dfs_cache.c
+++ b/fs/cifs/dfs_cache.c
@@ -593,7 +593,7 @@ static int __update_cache_entry(const char *path,
 
 	kfree(th);
 
-	return 0;
+	return rc;
 }
 
 static int get_dfs_referral(const unsigned int xid, struct cifs_ses *ses,
-- 
2.7.4


