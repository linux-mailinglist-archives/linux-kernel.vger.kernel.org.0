Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F348195541
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 11:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgC0K3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 06:29:16 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12200 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726002AbgC0K3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 06:29:16 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B42F6FE9ADC2211BA8A4;
        Fri, 27 Mar 2020 18:29:13 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Fri, 27 Mar 2020 18:29:04 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: add missing CONFIG_F2FS_FS_COMPRESSION
Date:   Fri, 27 Mar 2020 18:29:00 +0800
Message-ID: <20200327102900.103786-1-yuchao0@huawei.com>
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
v2:
- add missing CONFIG_F2FS_FS_COMPRESSION
 fs/f2fs/sysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 5f4fec83a6c6..e3bbbef9b4f0 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -580,7 +580,9 @@ F2FS_FEATURE_RO_ATTR(verity, FEAT_VERITY);
 #endif
 F2FS_FEATURE_RO_ATTR(sb_checksum, FEAT_SB_CHECKSUM);
 F2FS_FEATURE_RO_ATTR(casefold, FEAT_CASEFOLD);
+#ifdef CONFIG_F2FS_FS_COMPRESSION
 F2FS_FEATURE_RO_ATTR(compression, FEAT_COMPRESSION);
+#endif
 
 #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
 static struct attribute *f2fs_attrs[] = {
@@ -662,7 +664,9 @@ static struct attribute *f2fs_feat_attrs[] = {
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

