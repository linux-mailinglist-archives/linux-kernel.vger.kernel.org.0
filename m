Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2F788B8E7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 14:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbfHMMoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 08:44:21 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4250 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728232AbfHMMoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 08:44:20 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A84FF4474F2B5D4DD674;
        Tue, 13 Aug 2019 20:44:18 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Tue, 13 Aug 2019
 20:44:09 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <mark@fasheh.com>, <jlbec@evilplan.org>,
        <ocfs2-devel@oss.oracle.com>, <linux-kernel@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH] ocfs2: need to check return value from kobject_set_name()
Date:   Tue, 13 Aug 2019 20:50:38 +0800
Message-ID: <1565700638-67200-1-git-send-email-yukuai3@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since kobject_set_name() might return an error, the return value need to 
be checked, otherwise there will be a warn:

mlog_sys_init
  kset_register
    kobject_add_internal
	  if (!kobj->name || !kobj->name[0]) {
        WARN(...);
        return -EINVAL;
	  }

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 fs/ocfs2/cluster/masklog.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/cluster/masklog.c b/fs/ocfs2/cluster/masklog.c
index d331c23..4fcef46 100644
--- a/fs/ocfs2/cluster/masklog.c
+++ b/fs/ocfs2/cluster/masklog.c
@@ -178,7 +178,8 @@ int mlog_sys_init(struct kset *o2cb_kset)
 	}
 	mlog_attr_ptrs[i] = NULL;
 
-	kobject_set_name(&mlog_kset.kobj, "logmask");
+	if (!kobject_set_name(&mlog_kset.kobj, "logmask"))
+		return -EINVAL;
 	mlog_kset.kobj.kset = o2cb_kset;
 	return kset_register(&mlog_kset);
 }
-- 
2.7.4

