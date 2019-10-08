Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04500CFA74
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 14:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731110AbfJHMx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 08:53:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48570 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730906AbfJHMx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:53:27 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EE9D35AAA5101B890E4B;
        Tue,  8 Oct 2019 20:53:25 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 8 Oct 2019
 20:53:16 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>, <linux-erofs@lists.ozlabs.org>
CC:     LKML <linux-kernel@vger.kernel.org>, Miao Xie <miaoxie@huawei.com>,
        "Li Guifu" <bluce.liguifu@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH for-next 5/5] erofs: set iowait for sync decompression
Date:   Tue, 8 Oct 2019 20:56:16 +0800
Message-ID: <20191008125616.183715-5-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191008125616.183715-1-gaoxiang25@huawei.com>
References: <20191008125616.183715-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For those tasks waiting I/O for sync decompression,
they should be better marked as IO wait state.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/zdata.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 878449f11665..be3c79421dba 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1282,8 +1282,8 @@ static void z_erofs_submit_and_unzip(struct super_block *sb,
 		return;
 
 	/* wait until all bios are completed */
-	wait_event(io[JQ_SUBMIT].u.wait,
-		   !atomic_read(&io[JQ_SUBMIT].pending_bios));
+	io_wait_event(io[JQ_SUBMIT].u.wait,
+		      !atomic_read(&io[JQ_SUBMIT].pending_bios));
 
 	/* let's synchronous decompression */
 	z_erofs_vle_unzip_all(&io[JQ_SUBMIT], pagepool);
-- 
2.17.1

