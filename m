Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E21DDBADAE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 08:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392768AbfIWGL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 02:11:27 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47676 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387519AbfIWGL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 02:11:26 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F1D232EEFC1EE13C5623;
        Mon, 23 Sep 2019 14:11:24 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Mon, 23 Sep 2019
 14:11:18 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <agk@redhat.com>, <snitzer@redhat.com>, <dm-devel@redhat.com>,
        <ntsironis@arrikto.com>, <iliastsi@arrikto.com>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] dm clone: Make __hash_find static
Date:   Mon, 23 Sep 2019 14:11:11 +0800
Message-ID: <20190923061111.39956-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/md/dm-clone-target.c:594:34: warning:
 symbol '__hash_find' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/md/dm-clone-target.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-clone-target.c b/drivers/md/dm-clone-target.c
index cd6f9e9..0f99b68 100644
--- a/drivers/md/dm-clone-target.c
+++ b/drivers/md/dm-clone-target.c
@@ -591,8 +591,9 @@ static struct hash_table_bucket *get_hash_table_bucket(struct clone *clone,
  *
  * NOTE: Must be called with the bucket lock held
  */
-struct dm_clone_region_hydration *__hash_find(struct hash_table_bucket *bucket,
-					      unsigned long region_nr)
+static struct
+dm_clone_region_hydration *__hash_find(struct hash_table_bucket *bucket,
+				       unsigned long region_nr)
 {
 	struct dm_clone_region_hydration *hd;
 
-- 
2.7.4


