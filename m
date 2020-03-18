Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9A31893E4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 03:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbgCRCIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 22:08:46 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11714 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726229AbgCRCIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 22:08:45 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AC76B3D0B051E3C9A6F8;
        Wed, 18 Mar 2020 10:08:40 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Wed, 18 Mar 2020 10:08:25 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Gilad Ben-Yossef <gilad@benyossef.com>,
        Herbert Xu <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] crypto: ccree - remove duplicated include from cc_aead.c
Date:   Wed, 18 Mar 2020 02:00:40 +0000
Message-ID: <20200318020040.175704-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicated include.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/crypto/ccree/cc_aead.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/ccree/cc_aead.c b/drivers/crypto/ccree/cc_aead.c
index 875fa79a03eb..1cf51edbc4b9 100644
--- a/drivers/crypto/ccree/cc_aead.c
+++ b/drivers/crypto/ccree/cc_aead.c
@@ -9,7 +9,6 @@
 #include <crypto/gcm.h>
 #include <linux/rtnetlink.h>
 #include <crypto/internal/des.h>
-#include <linux/rtnetlink.h>
 #include "cc_driver.h"
 #include "cc_buffer_mgr.h"
 #include "cc_aead.h"



