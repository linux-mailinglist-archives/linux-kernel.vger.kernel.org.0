Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3E8725A0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 05:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfGXD5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 23:57:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2745 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725855AbfGXD5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 23:57:47 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CEE496E40C58B4D5EB37;
        Wed, 24 Jul 2019 11:57:45 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Wed, 24 Jul 2019 11:57:39 +0800
From:   Zhou Wang <wangzhou1@hisilicon.com>
To:     <robert.jarzmik@free.fr>, <axboe@fb.com>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH resend v2] lib: scatterlist: Fix to support no mapped sg
Date:   Wed, 24 Jul 2019 11:54:23 +0800
Message-ID: <1563940463-95597-1-git-send-email-wangzhou1@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function sg_split, the second sg_calculate_split will return -EINVAL
when in_mapped_nents is 0.

Indeed there is no need to do second sg_calculate_split and sg_split_mapped
when in_mapped_nents is 0, as in_mapped_nents indicates no mapped entry in
original sgl.

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
v2: Just add Acked-by from Robert.

 lib/sg_split.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/lib/sg_split.c b/lib/sg_split.c
index 9982c63..60a0bab 100644
--- a/lib/sg_split.c
+++ b/lib/sg_split.c
@@ -176,11 +176,13 @@ int sg_split(struct scatterlist *in, const int in_mapped_nents,
 	 * The order of these 3 calls is important and should be kept.
 	 */
 	sg_split_phys(splitters, nb_splits);
-	ret = sg_calculate_split(in, in_mapped_nents, nb_splits, skip,
-				 split_sizes, splitters, true);
-	if (ret < 0)
-		goto err;
-	sg_split_mapped(splitters, nb_splits);
+	if (in_mapped_nents) {
+		ret = sg_calculate_split(in, in_mapped_nents, nb_splits, skip,
+					 split_sizes, splitters, true);
+		if (ret < 0)
+			goto err;
+		sg_split_mapped(splitters, nb_splits);
+	}
 
 	for (i = 0; i < nb_splits; i++) {
 		out[i] = splitters[i].out_sg;
-- 
2.8.1

