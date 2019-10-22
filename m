Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 510C3E00AE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 11:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731356AbfJVJ0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 05:26:33 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55352 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731217AbfJVJ0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 05:26:32 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BC7A0B948B91837CA99E;
        Tue, 22 Oct 2019 17:26:30 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Tue, 22 Oct 2019 17:26:24 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix wrong description in document
Date:   Tue, 22 Oct 2019 17:26:11 +0800
Message-ID: <20191022092611.58191-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported in bugzilla, default value of DEF_RAM_THRESHOLD was fixed by
commit 29710bcf9426 ("f2fs: fix wrong percentage"), however leaving wrong
description in document, fix it.

https://bugzilla.kernel.org/show_bug.cgi?id=205203

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 Documentation/filesystems/f2fs.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index 7e1991328473..29020af0cff9 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -346,7 +346,7 @@ Files in /sys/fs/f2fs/<devname>
 
  ram_thresh                   This parameter controls the memory footprint used
 			      by free nids and cached nat entries. By default,
-			      10 is set, which indicates 10 MB / 1 GB RAM.
+			      1 is set, which indicates 10 MB / 1 GB RAM.
 
  ra_nid_pages		      When building free nids, F2FS reads NAT blocks
 			      ahead for speed up. Default is 0.
-- 
2.18.0.rc1

