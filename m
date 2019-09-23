Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 237F4BADA5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 08:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392413AbfIWGD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 02:03:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51446 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387519AbfIWGD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 02:03:57 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7EA74DD58FF8F5F3B84D;
        Mon, 23 Sep 2019 14:03:55 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Mon, 23 Sep 2019
 14:03:47 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>
CC:     <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] nfsd: Make nfsd_reset_boot_verifier_locked static
Date:   Mon, 23 Sep 2019 13:58:59 +0800
Message-ID: <20190923055859.5616-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:

fs/nfsd/nfssvc.c:364:6: warning:
 symbol 'nfsd_reset_boot_verifier_locked' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/nfsd/nfssvc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 3caaf56..fdf7ed4 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -361,7 +361,7 @@ void nfsd_copy_boot_verifier(__be32 verf[2], struct nfsd_net *nn)
 	done_seqretry(&nn->boot_lock, seq);
 }
 
-void nfsd_reset_boot_verifier_locked(struct nfsd_net *nn)
+static void nfsd_reset_boot_verifier_locked(struct nfsd_net *nn)
 {
 	ktime_get_real_ts64(&nn->nfssvc_boot);
 }
-- 
2.7.4


