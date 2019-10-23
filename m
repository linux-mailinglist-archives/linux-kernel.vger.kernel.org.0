Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05137E1D64
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 15:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391908AbfJWNyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 09:54:35 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4711 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390181AbfJWNye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:54:34 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1A8149213314023501A7;
        Wed, 23 Oct 2019 21:54:27 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Wed, 23 Oct 2019
 21:54:17 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <dhowells@redhat.com>
CC:     <linux-afs@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <pmladek@suse.com>, <sergey.senozhatsky@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] afs: remove unused variable 'afs_zero_fid'
Date:   Wed, 23 Oct 2019 21:54:08 +0800
Message-ID: <20191023135408.32932-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fs/afs/fsclient.c:18:29: warning:
 afs_zero_fid defined but not used [-Wunused-const-variable=]

It is never used since commit 025db80c9e42 ("afs: Trace
the initiation and completion of client calls")

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/afs/yfsclient.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index 9ac035c..46c679e 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -15,8 +15,6 @@
 #include "xdr_fs.h"
 #include "protocol_yfs.h"
 
-static const struct afs_fid afs_zero_fid;
-
 static inline void afs_use_fs_server(struct afs_call *call, struct afs_cb_interest *cbi)
 {
 	call->cbi = afs_get_cb_interest(cbi);
-- 
2.7.4


