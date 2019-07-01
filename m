Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB6A145C69
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 14:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfFNMO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 08:14:26 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52478 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727544AbfFNMO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 08:14:26 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4CD46B2AEDDC10E6B47A;
        Fri, 14 Jun 2019 20:14:24 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Fri, 14 Jun 2019
 20:14:18 +0800
From:   <chengzhihao1@huawei.com>
To:     <david.oberhollenzer@sigma-star.at>, <richard@nod.at>,
        <boris.brezillon@bootlin.com>, <david@sigma-star.at>,
        <artem.bityutskiy@linux.intel.com>, <yi.zhang@huawei.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>
Subject: [PATCH mtd-utils] ubi-tests: fm_param: Replace 'fm_auto' with 'fm_autoconvert'
Date:   Fri, 14 Jun 2019 20:19:50 +0800
Message-ID: <1560514790-55222-1-git-send-email-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhihao Cheng <chengzhihao1@huawei.com>

The value of fm_param should be 'fm_autoconvert' rather than 'fm_auto' when
fastmap is supported by kernel. Currently, following verbose will appear in
dmesg when fm_param is set to 'fm_auto':

  ubi: unknown parameter 'fm_auto' ignored

This patch replace 'fm_auto' with 'fm_autoconvert' for fm_param, so ubi
kernel module can receive correct parameters.

----------------------------------------

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 tests/ubi-tests/ubi-stress-test.sh.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/ubi-tests/ubi-stress-test.sh.in b/tests/ubi-tests/ubi-stress-test.sh.in
index 42ccec5..657ef4b 100755
--- a/tests/ubi-tests/ubi-stress-test.sh.in
+++ b/tests/ubi-tests/ubi-stress-test.sh.in
@@ -117,7 +117,7 @@ run_test()
 		fm_param=
 	elif [ "$fm_supported" = "yes" ]; then
 		fastmap="disabled"
-		fm_param="fm_auto"
+		fm_param="fm_autoconvert"
 	else
 		echo "Fastmap is not supported, skip"
 		return 0
-- 
2.7.4

