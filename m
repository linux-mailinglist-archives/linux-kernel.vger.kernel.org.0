Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD2F1A2D1D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 05:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfH3DCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 23:02:02 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34154 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727920AbfH3DB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 23:01:58 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 115084CA086545A548F5;
        Fri, 30 Aug 2019 11:01:56 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 30 Aug
 2019 11:01:46 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Joe Perches <joe@perches.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v2 7/7] erofs: reduntant assignment in __erofs_get_meta_page()
Date:   Fri, 30 Aug 2019 11:00:40 +0800
Message-ID: <20190830030040.10599-7-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830030040.10599-1-gaoxiang25@huawei.com>
References: <20190830030040.10599-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Joe Perches suggested [1],
 		err = bio_add_page(bio, page, PAGE_SIZE, 0);
-		if (unlikely(err != PAGE_SIZE)) {
+		if (err != PAGE_SIZE) {
 			err = -EFAULT;
 			goto err_out;
 		}

The initial assignment to err is odd as it's not
actually an error value -E<FOO> but a int size
from a unsigned int len.

Here the return is either 0 or PAGE_SIZE.

This would be more legible to me as:

		if (bio_add_page(bio, page, PAGE_SIZE, 0) != PAGE_SIZE) {
			err = -EFAULT;
			goto err_out;
		}

[1] https://lore.kernel.org/r/74c4784319b40deabfbaea92468f7e3ef44f1c96.camel@perches.com/
Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
v2: no change, just resend in case of dependency problem;

 fs/erofs/data.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 0f2f1a839372..0983807737fd 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -69,8 +69,7 @@ struct page *__erofs_get_meta_page(struct super_block *sb,
 			goto err_out;
 		}
 
-		err = bio_add_page(bio, page, PAGE_SIZE, 0);
-		if (err != PAGE_SIZE) {
+		if (bio_add_page(bio, page, PAGE_SIZE, 0) != PAGE_SIZE) {
 			err = -EFAULT;
 			goto err_out;
 		}
-- 
2.17.1

