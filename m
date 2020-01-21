Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D02F14354F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 02:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgAUBnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 20:43:16 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:50708 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726935AbgAUBnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 20:43:15 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2F48EFB88482C54FEED4;
        Tue, 21 Jan 2020 09:43:13 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Tue, 21 Jan 2020 09:43:03 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <jens.wiklander@linaro.org>
CC:     <gary.hook@amd.com>, <Devaraj.Rangasamy@amd.com>,
        <Rijo-john.Thomas@amd.com>, <herbert@gondor.apana.org.au>,
        <tee-dev@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH -next] tee: amdtee: fix return value check in amdtee_driver_init
Date:   Tue, 21 Jan 2020 09:38:12 +0800
Message-ID: <20200121013812.18153-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocation function kzalloc returns NULL not ERR_PTR on failure.
Replace IS_ERR with NULL check.

Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 drivers/tee/amdtee/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
index be8937e..6370bb5 100644
--- a/drivers/tee/amdtee/core.c
+++ b/drivers/tee/amdtee/core.c
@@ -446,11 +446,11 @@ static int __init amdtee_driver_init(void)
 	}
 
 	drv_data = kzalloc(sizeof(*drv_data), GFP_KERNEL);
-	if (IS_ERR(drv_data))
+	if (!drv_data)
 		return -ENOMEM;
 
 	amdtee = kzalloc(sizeof(*amdtee), GFP_KERNEL);
-	if (IS_ERR(amdtee)) {
+	if (!amdtee) {
 		rc = -ENOMEM;
 		goto err_kfree_drv_data;
 	}
-- 
2.7.4

