Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27CEB99744
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 16:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387904AbfHVOr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 10:47:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5198 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727553AbfHVOr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:47:29 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EEFB67D1A43D9EF16AEE;
        Thu, 22 Aug 2019 22:47:13 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Thu, 22 Aug 2019
 22:47:03 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <leitao@debian.org>, <nayna@linux.ibm.com>, <pfsmorigo@gmail.com>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        <mpe@ellerman.id.au>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] crypto: nx - remove unused variables 'nx_driver_string' and 'nx_driver_version'
Date:   Thu, 22 Aug 2019 22:46:49 +0800
Message-ID: <20190822144649.19880-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/crypto/nx/nx.h:12:19: warning:
 nx_driver_string defined but not used [-Wunused-const-variable=]
drivers/crypto/nx/nx.h:13:19: warning:
 nx_driver_version defined but not used [-Wunused-const-variable=]

They are never used, so just remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/crypto/nx/nx.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/crypto/nx/nx.h b/drivers/crypto/nx/nx.h
index c6b5a3b..7ecca16 100644
--- a/drivers/crypto/nx/nx.h
+++ b/drivers/crypto/nx/nx.h
@@ -9,9 +9,6 @@
 #define NX_STRING	"IBM Power7+ Nest Accelerator Crypto Driver"
 #define NX_VERSION	"1.0"
 
-static const char nx_driver_string[] = NX_STRING;
-static const char nx_driver_version[] = NX_VERSION;
-
 /* a scatterlist in the format PHYP is expecting */
 struct nx_sg {
 	u64 addr;
-- 
2.7.4


