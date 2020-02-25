Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBEF816B7D0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 03:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgBYCt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 21:49:28 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:43088 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726962AbgBYCt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 21:49:28 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 027CBEEF33CC69508D91;
        Tue, 25 Feb 2020 10:49:26 +0800 (CST)
Received: from euler.huawei.com (10.175.104.193) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Tue, 25 Feb 2020 10:49:17 +0800
From:   Hongbo Yao <yaohongbo@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <yaohongbo@huawei.com>, <chenzhou10@huawei.com>,
        <wangzhou1@hisilicon.com>, <xuzaibo@huawei.com>
Subject: [PATCH -next] crypto: hisilicon - qm depends on UACCE
Date:   Tue, 25 Feb 2020 11:03:56 +0800
Message-ID: <20200225030356.44008-1-yaohongbo@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.193]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If UACCE=m and CRYPTO_DEV_HISI_QM=y, the following error
is seen while building qm.o:

drivers/crypto/hisilicon/qm.o: In function `hisi_qm_init':
(.text+0x23c6): undefined reference to `uacce_alloc'
(.text+0x2474): undefined reference to `uacce_remove'
(.text+0x286b): undefined reference to `uacce_remove'
drivers/crypto/hisilicon/qm.o: In function `hisi_qm_uninit':
(.text+0x2918): undefined reference to `uacce_remove'
make[1]: *** [vmlinux] Error 1
make: *** [autoksyms_recursive] Error 2

It has the similar issue while CONFIG_CRYPTO_DEV_HISI_ZIP=y, fix
the config dependency for QM or ZIP here.

reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>
---
 drivers/crypto/hisilicon/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/hisilicon/Kconfig b/drivers/crypto/hisilicon/Kconfig
index 8851161f722f..b35c2ec15bc2 100644
--- a/drivers/crypto/hisilicon/Kconfig
+++ b/drivers/crypto/hisilicon/Kconfig
@@ -40,6 +40,7 @@ config CRYPTO_DEV_HISI_QM
 	tristate
 	depends on ARM64 || COMPILE_TEST
 	depends on PCI && PCI_MSI
+	depends on UACCE
 	help
 	  HiSilicon accelerator engines use a common queue management
 	  interface. Specific engine driver may use this module.
-- 
2.17.1

