Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 994BA193C18
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 10:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgCZJnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 05:43:43 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59782 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727688AbgCZJnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 05:43:43 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3A5ADECA0A74F860A0BF;
        Thu, 26 Mar 2020 17:43:39 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Thu, 26 Mar 2020 17:43:31 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: add missing CONFIG_F2FS_FS_COMPRESSION
Date:   Thu, 26 Mar 2020 17:43:28 +0800
Message-ID: <20200326094328.83818-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compression sysfs node should not be shown if f2fs module disables
compression feature.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 5f4fec83a6c6..5bf155a3a8d1 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -662,7 +662,9 @@ static struct attribute *f2fs_feat_attrs[] = {
 #endif
 	ATTR_LIST(sb_checksum),
 	ATTR_LIST(casefold),
+#ifdef CONFIG_F2FS_FS_COMPRESSION
 	ATTR_LIST(compression),
+#endif
 	NULL,
 };
 ATTRIBUTE_GROUPS(f2fs_feat);
-- 
2.18.0.rc1

