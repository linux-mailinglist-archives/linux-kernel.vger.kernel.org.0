Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94DF2112360
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 08:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfLDHMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 02:12:17 -0500
Received: from mail-eopbgr680043.outbound.protection.outlook.com ([40.107.68.43]:59426
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725958AbfLDHMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 02:12:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhFW/lx1QHWFtUR9fCNZKIIiuHMNAy5xSUPOhcnEplKalgApXpLeIImyTEARtKj7IsSeCI5XA/Ipg2m/oHye9l2h0PywaK/yirMy/ykiCH85C2QBj01CRgrWF57b3Oo0ZwtfWzFQJIDaOWUViZPkLm29nfdTa8EYO2M95AuK6t2dYh1kyOsdH/x6fK4lswiuc3AV0MfYG0ZbfyA5fdhvmfBv6AZGnxdyUjTamdtkCYFScw2bfa6adwve0F3WBd/XQh+3eoTpx0g6o7rsXmOZ25ObVAm9VDn46leqhE56T0qTYTdT5OrTgiJVuz1yjJohQvhw0RGLX8G7YQxEoq3XHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NPgCtybnE9aG+hm3N4DTQ/JhcRkM7U5p3mkv6/yW2M=;
 b=HO+z8bXK20sJUqd++pDIe0+7PLxQjccuTjTdFqV03XM4ZXmc7MajfoDByhWO0IsPvyZPzcNfcDKRqulCv0jfxdl9/ZjXCZ5vQZp69HW9jdu1iCXDtBi4X48/Ps8NVVada7GMjH+ZbBaaG10Xb+qyc9iU/EiYFa8229AIAnbBcCJkFsrRWcGPmBOmgr3cDlKXZYbbN6sdqG6ZAUgMSKEw6+e2PbjXN49GoRaHRDmTq3NVTCxGuQ1fIMJVCgebCZDxCJJzssutA7qMvqxNj2w/7DYxXCLgg9iuImAladGd6WDoQ5WZkTQ3V3okDEiPtbksnvM8bwjhTnts7D/hEIIfwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NPgCtybnE9aG+hm3N4DTQ/JhcRkM7U5p3mkv6/yW2M=;
 b=Ge/MI23Eoi7upchTaX6O+3XdV1Nqy4TTuqP1lDpilyGUWbpvaQW87jZ6eOCwcSV1+1UyGq0dbFIovwulzwjhKDmM5LQcWNa9fPYEefPZKa0fi+tIOpR0tNs58MKL/D2yAXF9QN13+PpglFHg8pcozJcwsOpqNU7N1YpxFj9oa7o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rijo-john.Thomas@amd.com; 
Received: from CY4PR12MB1925.namprd12.prod.outlook.com (10.175.62.7) by
 CY4PR12MB1400.namprd12.prod.outlook.com (10.168.165.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Wed, 4 Dec 2019 07:11:52 +0000
Received: from CY4PR12MB1925.namprd12.prod.outlook.com
 ([fe80::cd8b:1d7e:31c2:e8b4]) by CY4PR12MB1925.namprd12.prod.outlook.com
 ([fe80::cd8b:1d7e:31c2:e8b4%7]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 07:11:52 +0000
From:   Rijo Thomas <Rijo-john.Thomas@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Gary Hook <gary.hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     Rijo Thomas <Rijo-john.Thomas@amd.com>,
        Nimesh Easow <Nimesh.Easow@amd.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [RFC PATCH v3 5/6] crypto: ccp - add TEE support for Raven Ridge
Date:   Wed,  4 Dec 2019 11:49:02 +0530
Message-Id: <de22c684e1e7d623bb9b743f13e3fcbcd6ff0957.1575438845.git.Rijo-john.Thomas@amd.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1575438845.git.Rijo-john.Thomas@amd.com>
References: <cover.1575438845.git.Rijo-john.Thomas@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: MAXPR0101CA0065.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::27) To CY4PR12MB1925.namprd12.prod.outlook.com
 (2603:10b6:903:120::7)
MIME-Version: 1.0
X-Mailer: git-send-email 1.9.1
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5fb806c2-9877-49cb-b401-08d778893ca1
X-MS-TrafficTypeDiagnostic: CY4PR12MB1400:|CY4PR12MB1400:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1400D42E8EF0D4AAEA605644CF5D0@CY4PR12MB1400.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0241D5F98C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(199004)(189003)(2616005)(66556008)(2906002)(66476007)(50466002)(48376002)(478600001)(14454004)(50226002)(11346002)(36756003)(81156014)(26005)(54906003)(110136005)(81166006)(3846002)(66946007)(8936002)(446003)(8676002)(5660300002)(6486002)(6116002)(386003)(186003)(6436002)(4326008)(99286004)(25786009)(6506007)(14444005)(118296001)(76176011)(16586007)(316002)(86362001)(52116002)(7736002)(51416003)(30864003)(6666004)(6512007)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1400;H:CY4PR12MB1925.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2oswe8aAMO7qpj5GJxTJrXFnqvWsdk0B8NiZi70iDvPD7SduH+pTXSiChIuqy5DOb6plwKp/avPYUK6EHGazwj15Cof1VcX5dkQB1BJiskz0193opwW1TvKDkeDalBAgLHROPuexFL9MOrXxlgRgN8pmwZk8Sa+yyAsFhHEN9NtAdMHGAhdTevwVJ3DqQYSPqQE2owxIGiq7Xbz7XC/v0FYR5ky+JEga5mUYEyK4rgpFJhhhVcDlP++qZ9gbKap/6W1yWS8r/SvzLyP2kT1TsxU4I/VxoNx7r1EBV3i+5FDIpGfTjVY7dJJGSRX89doNosfK32Gz5gAMW8zilj4Ydh7/xkyOBAUpdxslRpwVozl4P+yQF/x1iUQMcpt+LjqHZz2NsfpV7IufNT9H+puX+ohKOmOo8Vyv/l0g0yaQpLfM3jMvdMfOnGckDBWxKbVT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb806c2-9877-49cb-b401-08d778893ca1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 07:11:52.3655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0aF8fU65eVdYbJg7hwTFsHgZ8Ak6TYBamXCJsvuUS7NgM2CDSFi92mBeVl/Mgu0meSzUqNruib2ED/W9w1dv4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1400
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a PCI device entry for Raven Ridge. Raven Ridge is an APU with a
dedicated AMD Secure Processor having Trusted Execution Environment (TEE)
support. The TEE provides a secure environment for running Trusted
Applications (TAs) which implement security-sensitive parts of a feature.

This patch configures AMD Secure Processor's TEE interface by initializing
a ring buffer (shared memory between Rich OS and Trusted OS) which can hold
multiple command buffer entries. The TEE interface is facilitated by a set
of CPU to PSP mailbox registers.

The next patch will address how commands are submitted to the ring buffer.

Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Co-developed-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
Signed-off-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
---
 drivers/crypto/ccp/Makefile  |   3 +-
 drivers/crypto/ccp/psp-dev.c |  39 ++++++-
 drivers/crypto/ccp/psp-dev.h |   8 ++
 drivers/crypto/ccp/sp-dev.h  |  11 +-
 drivers/crypto/ccp/sp-pci.c  |  27 ++++-
 drivers/crypto/ccp/tee-dev.c | 238 +++++++++++++++++++++++++++++++++++++++++++
 drivers/crypto/ccp/tee-dev.h | 109 ++++++++++++++++++++
 7 files changed, 431 insertions(+), 4 deletions(-)
 create mode 100644 drivers/crypto/ccp/tee-dev.c
 create mode 100644 drivers/crypto/ccp/tee-dev.h

diff --git a/drivers/crypto/ccp/Makefile b/drivers/crypto/ccp/Makefile
index 3b29ea4..db362fe 100644
--- a/drivers/crypto/ccp/Makefile
+++ b/drivers/crypto/ccp/Makefile
@@ -9,7 +9,8 @@ ccp-$(CONFIG_CRYPTO_DEV_SP_CCP) += ccp-dev.o \
 ccp-$(CONFIG_CRYPTO_DEV_CCP_DEBUGFS) += ccp-debugfs.o
 ccp-$(CONFIG_PCI) += sp-pci.o
 ccp-$(CONFIG_CRYPTO_DEV_SP_PSP) += psp-dev.o \
-                                   sev-dev.o
+                                   sev-dev.o \
+                                   tee-dev.o
 
 obj-$(CONFIG_CRYPTO_DEV_CCP_CRYPTO) += ccp-crypto.o
 ccp-crypto-objs := ccp-crypto-main.o \
diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
index 3bedf72..e95e7aa 100644
--- a/drivers/crypto/ccp/psp-dev.c
+++ b/drivers/crypto/ccp/psp-dev.c
@@ -13,6 +13,7 @@
 #include "sp-dev.h"
 #include "psp-dev.h"
 #include "sev-dev.h"
+#include "tee-dev.h"
 
 struct psp_device *psp_master;
 
@@ -45,6 +46,9 @@ static irqreturn_t psp_irq_handler(int irq, void *data)
 	if (status) {
 		if (psp->sev_irq_handler)
 			psp->sev_irq_handler(irq, psp->sev_irq_data, status);
+
+		if (psp->tee_irq_handler)
+			psp->tee_irq_handler(irq, psp->tee_irq_data, status);
 	}
 
 	/* Clear the interrupt status by writing the same value we read. */
@@ -109,6 +113,25 @@ static int psp_check_support(struct psp_device *psp,
 	return 0;
 }
 
+static int psp_init(struct psp_device *psp, unsigned int capability)
+{
+	int ret;
+
+	if (!psp_check_sev_support(psp, capability)) {
+		ret = sev_dev_init(psp);
+		if (ret)
+			return ret;
+	}
+
+	if (!psp_check_tee_support(psp, capability)) {
+		ret = tee_dev_init(psp);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 int psp_dev_init(struct sp_device *sp)
 {
 	struct device *dev = sp->dev;
@@ -151,7 +174,7 @@ int psp_dev_init(struct sp_device *sp)
 		goto e_err;
 	}
 
-	ret = sev_dev_init(psp);
+	ret = psp_init(psp, capability);
 	if (ret)
 		goto e_irq;
 
@@ -189,6 +212,8 @@ void psp_dev_destroy(struct sp_device *sp)
 
 	sev_dev_destroy(psp);
 
+	tee_dev_destroy(psp);
+
 	sp_free_psp_irq(sp, psp);
 }
 
@@ -204,6 +229,18 @@ void psp_clear_sev_irq_handler(struct psp_device *psp)
 	psp_set_sev_irq_handler(psp, NULL, NULL);
 }
 
+void psp_set_tee_irq_handler(struct psp_device *psp, psp_irq_handler_t handler,
+			     void *data)
+{
+	psp->tee_irq_data = data;
+	psp->tee_irq_handler = handler;
+}
+
+void psp_clear_tee_irq_handler(struct psp_device *psp)
+{
+	psp_set_tee_irq_handler(psp, NULL, NULL);
+}
+
 struct psp_device *psp_get_master_device(void)
 {
 	struct sp_device *sp = sp_get_psp_master_device();
diff --git a/drivers/crypto/ccp/psp-dev.h b/drivers/crypto/ccp/psp-dev.h
index 7c014ac..ef38e41 100644
--- a/drivers/crypto/ccp/psp-dev.h
+++ b/drivers/crypto/ccp/psp-dev.h
@@ -40,13 +40,21 @@ struct psp_device {
 	psp_irq_handler_t sev_irq_handler;
 	void *sev_irq_data;
 
+	psp_irq_handler_t tee_irq_handler;
+	void *tee_irq_data;
+
 	void *sev_data;
+	void *tee_data;
 };
 
 void psp_set_sev_irq_handler(struct psp_device *psp, psp_irq_handler_t handler,
 			     void *data);
 void psp_clear_sev_irq_handler(struct psp_device *psp);
 
+void psp_set_tee_irq_handler(struct psp_device *psp, psp_irq_handler_t handler,
+			     void *data);
+void psp_clear_tee_irq_handler(struct psp_device *psp);
+
 struct psp_device *psp_get_master_device(void);
 
 #endif /* __PSP_DEV_H */
diff --git a/drivers/crypto/ccp/sp-dev.h b/drivers/crypto/ccp/sp-dev.h
index 0394c75..4235946 100644
--- a/drivers/crypto/ccp/sp-dev.h
+++ b/drivers/crypto/ccp/sp-dev.h
@@ -2,7 +2,7 @@
 /*
  * AMD Secure Processor driver
  *
- * Copyright (C) 2017-2018 Advanced Micro Devices, Inc.
+ * Copyright (C) 2017-2019 Advanced Micro Devices, Inc.
  *
  * Author: Tom Lendacky <thomas.lendacky@amd.com>
  * Author: Gary R Hook <gary.hook@amd.com>
@@ -45,8 +45,17 @@ struct sev_vdata {
 	const unsigned int cmdbuff_addr_hi_reg;
 };
 
+struct tee_vdata {
+	const unsigned int cmdresp_reg;
+	const unsigned int cmdbuff_addr_lo_reg;
+	const unsigned int cmdbuff_addr_hi_reg;
+	const unsigned int ring_wptr_reg;
+	const unsigned int ring_rptr_reg;
+};
+
 struct psp_vdata {
 	const struct sev_vdata *sev;
+	const struct tee_vdata *tee;
 	const unsigned int feature_reg;
 	const unsigned int inten_reg;
 	const unsigned int intsts_reg;
diff --git a/drivers/crypto/ccp/sp-pci.c b/drivers/crypto/ccp/sp-pci.c
index 733693d..56c1f61 100644
--- a/drivers/crypto/ccp/sp-pci.c
+++ b/drivers/crypto/ccp/sp-pci.c
@@ -2,7 +2,7 @@
 /*
  * AMD Secure Processor device driver
  *
- * Copyright (C) 2013,2018 Advanced Micro Devices, Inc.
+ * Copyright (C) 2013,2019 Advanced Micro Devices, Inc.
  *
  * Author: Tom Lendacky <thomas.lendacky@amd.com>
  * Author: Gary R Hook <gary.hook@amd.com>
@@ -274,6 +274,14 @@ static int sp_pci_resume(struct pci_dev *pdev)
 	.cmdbuff_addr_hi_reg	= 0x109e4,
 };
 
+static const struct tee_vdata teev1 = {
+	.cmdresp_reg		= 0x10544,
+	.cmdbuff_addr_lo_reg	= 0x10548,
+	.cmdbuff_addr_hi_reg	= 0x1054c,
+	.ring_wptr_reg          = 0x10550,
+	.ring_rptr_reg          = 0x10554,
+};
+
 static const struct psp_vdata pspv1 = {
 	.sev			= &sevv1,
 	.feature_reg		= 0x105fc,
@@ -287,6 +295,13 @@ static int sp_pci_resume(struct pci_dev *pdev)
 	.inten_reg		= 0x10690,
 	.intsts_reg		= 0x10694,
 };
+
+static const struct psp_vdata pspv3 = {
+	.tee			= &teev1,
+	.feature_reg		= 0x109fc,
+	.inten_reg		= 0x10690,
+	.intsts_reg		= 0x10694,
+};
 #endif
 
 static const struct sp_dev_vdata dev_vdata[] = {
@@ -320,12 +335,22 @@ static int sp_pci_resume(struct pci_dev *pdev)
 		.psp_vdata = &pspv2,
 #endif
 	},
+	{	/* 4 */
+		.bar = 2,
+#ifdef CONFIG_CRYPTO_DEV_SP_CCP
+		.ccp_vdata = &ccpv5a,
+#endif
+#ifdef CONFIG_CRYPTO_DEV_SP_PSP
+		.psp_vdata = &pspv3,
+#endif
+	},
 };
 static const struct pci_device_id sp_pci_table[] = {
 	{ PCI_VDEVICE(AMD, 0x1537), (kernel_ulong_t)&dev_vdata[0] },
 	{ PCI_VDEVICE(AMD, 0x1456), (kernel_ulong_t)&dev_vdata[1] },
 	{ PCI_VDEVICE(AMD, 0x1468), (kernel_ulong_t)&dev_vdata[2] },
 	{ PCI_VDEVICE(AMD, 0x1486), (kernel_ulong_t)&dev_vdata[3] },
+	{ PCI_VDEVICE(AMD, 0x15DF), (kernel_ulong_t)&dev_vdata[4] },
 	/* Last entry must be zero */
 	{ 0, }
 };
diff --git a/drivers/crypto/ccp/tee-dev.c b/drivers/crypto/ccp/tee-dev.c
new file mode 100644
index 0000000..ccbc2ce
--- /dev/null
+++ b/drivers/crypto/ccp/tee-dev.c
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: MIT
+/*
+ * AMD Trusted Execution Environment (TEE) interface
+ *
+ * Author: Rijo Thomas <Rijo-john.Thomas@amd.com>
+ * Author: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
+ *
+ * Copyright 2019 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/types.h>
+#include <linux/mutex.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/gfp.h>
+#include <linux/psp-sev.h>
+
+#include "psp-dev.h"
+#include "tee-dev.h"
+
+static bool psp_dead;
+
+static int tee_alloc_ring(struct psp_tee_device *tee, int ring_size)
+{
+	struct ring_buf_manager *rb_mgr = &tee->rb_mgr;
+	void *start_addr;
+
+	if (!ring_size)
+		return -EINVAL;
+
+	/* We need actual physical address instead of DMA address, since
+	 * Trusted OS running on AMD Secure Processor will map this region
+	 */
+	start_addr = (void *)__get_free_pages(GFP_KERNEL, get_order(ring_size));
+	if (!start_addr)
+		return -ENOMEM;
+
+	rb_mgr->ring_start = start_addr;
+	rb_mgr->ring_size = ring_size;
+	rb_mgr->ring_pa = __psp_pa(start_addr);
+
+	return 0;
+}
+
+static void tee_free_ring(struct psp_tee_device *tee)
+{
+	struct ring_buf_manager *rb_mgr = &tee->rb_mgr;
+
+	if (!rb_mgr->ring_start)
+		return;
+
+	free_pages((unsigned long)rb_mgr->ring_start,
+		   get_order(rb_mgr->ring_size));
+
+	rb_mgr->ring_start = NULL;
+	rb_mgr->ring_size = 0;
+	rb_mgr->ring_pa = 0;
+}
+
+static int tee_wait_cmd_poll(struct psp_tee_device *tee, unsigned int timeout,
+			     unsigned int *reg)
+{
+	/* ~10ms sleep per loop => nloop = timeout * 100 */
+	int nloop = timeout * 100;
+
+	while (--nloop) {
+		*reg = ioread32(tee->io_regs + tee->vdata->cmdresp_reg);
+		if (*reg & PSP_CMDRESP_RESP)
+			return 0;
+
+		usleep_range(10000, 10100);
+	}
+
+	dev_err(tee->dev, "tee: command timed out, disabling PSP\n");
+	psp_dead = true;
+
+	return -ETIMEDOUT;
+}
+
+static
+struct tee_init_ring_cmd *tee_alloc_cmd_buffer(struct psp_tee_device *tee)
+{
+	struct tee_init_ring_cmd *cmd;
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd)
+		return NULL;
+
+	cmd->hi_addr = upper_32_bits(tee->rb_mgr.ring_pa);
+	cmd->low_addr = lower_32_bits(tee->rb_mgr.ring_pa);
+	cmd->size = tee->rb_mgr.ring_size;
+
+	dev_dbg(tee->dev, "tee: ring address: high = 0x%x low = 0x%x size = %u\n",
+		cmd->hi_addr, cmd->low_addr, cmd->size);
+
+	return cmd;
+}
+
+static inline void tee_free_cmd_buffer(struct tee_init_ring_cmd *cmd)
+{
+	kfree(cmd);
+}
+
+static int tee_init_ring(struct psp_tee_device *tee)
+{
+	int ring_size = MAX_RING_BUFFER_ENTRIES * sizeof(struct tee_ring_cmd);
+	struct tee_init_ring_cmd *cmd;
+	phys_addr_t cmd_buffer;
+	unsigned int reg;
+	int ret;
+
+	BUILD_BUG_ON(sizeof(struct tee_ring_cmd) != 1024);
+
+	ret = tee_alloc_ring(tee, ring_size);
+	if (ret) {
+		dev_err(tee->dev, "tee: ring allocation failed %d\n", ret);
+		return ret;
+	}
+
+	tee->rb_mgr.wptr = 0;
+
+	cmd = tee_alloc_cmd_buffer(tee);
+	if (!cmd) {
+		tee_free_ring(tee);
+		return -ENOMEM;
+	}
+
+	cmd_buffer = __psp_pa((void *)cmd);
+
+	/* Send command buffer details to Trusted OS by writing to
+	 * CPU-PSP message registers
+	 */
+
+	iowrite32(lower_32_bits(cmd_buffer),
+		  tee->io_regs + tee->vdata->cmdbuff_addr_lo_reg);
+	iowrite32(upper_32_bits(cmd_buffer),
+		  tee->io_regs + tee->vdata->cmdbuff_addr_hi_reg);
+	iowrite32(TEE_RING_INIT_CMD,
+		  tee->io_regs + tee->vdata->cmdresp_reg);
+
+	ret = tee_wait_cmd_poll(tee, TEE_DEFAULT_TIMEOUT, &reg);
+	if (ret) {
+		dev_err(tee->dev, "tee: ring init command timed out\n");
+		tee_free_ring(tee);
+		goto free_buf;
+	}
+
+	if (reg & PSP_CMDRESP_ERR_MASK) {
+		dev_err(tee->dev, "tee: ring init command failed (%#010x)\n",
+			reg & PSP_CMDRESP_ERR_MASK);
+		tee_free_ring(tee);
+		ret = -EIO;
+	}
+
+free_buf:
+	tee_free_cmd_buffer(cmd);
+
+	return ret;
+}
+
+static void tee_destroy_ring(struct psp_tee_device *tee)
+{
+	unsigned int reg;
+	int ret;
+
+	if (!tee->rb_mgr.ring_start)
+		return;
+
+	if (psp_dead)
+		goto free_ring;
+
+	iowrite32(TEE_RING_DESTROY_CMD,
+		  tee->io_regs + tee->vdata->cmdresp_reg);
+
+	ret = tee_wait_cmd_poll(tee, TEE_DEFAULT_TIMEOUT, &reg);
+	if (ret) {
+		dev_err(tee->dev, "tee: ring destroy command timed out\n");
+	} else if (reg & PSP_CMDRESP_ERR_MASK) {
+		dev_err(tee->dev, "tee: ring destroy command failed (%#010x)\n",
+			reg & PSP_CMDRESP_ERR_MASK);
+	}
+
+free_ring:
+	tee_free_ring(tee);
+}
+
+int tee_dev_init(struct psp_device *psp)
+{
+	struct device *dev = psp->dev;
+	struct psp_tee_device *tee;
+	int ret;
+
+	ret = -ENOMEM;
+	tee = devm_kzalloc(dev, sizeof(*tee), GFP_KERNEL);
+	if (!tee)
+		goto e_err;
+
+	psp->tee_data = tee;
+
+	tee->dev = dev;
+	tee->psp = psp;
+
+	tee->io_regs = psp->io_regs;
+
+	tee->vdata = (struct tee_vdata *)psp->vdata->tee;
+	if (!tee->vdata) {
+		ret = -ENODEV;
+		dev_err(dev, "tee: missing driver data\n");
+		goto e_err;
+	}
+
+	ret = tee_init_ring(tee);
+	if (ret) {
+		dev_err(dev, "tee: failed to init ring buffer\n");
+		goto e_err;
+	}
+
+	dev_notice(dev, "tee enabled\n");
+
+	return 0;
+
+e_err:
+	psp->tee_data = NULL;
+
+	dev_notice(dev, "tee initialization failed\n");
+
+	return ret;
+}
+
+void tee_dev_destroy(struct psp_device *psp)
+{
+	struct psp_tee_device *tee = psp->tee_data;
+
+	if (!tee)
+		return;
+
+	tee_destroy_ring(tee);
+}
diff --git a/drivers/crypto/ccp/tee-dev.h b/drivers/crypto/ccp/tee-dev.h
new file mode 100644
index 0000000..b3db0fc
--- /dev/null
+++ b/drivers/crypto/ccp/tee-dev.h
@@ -0,0 +1,109 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2019 Advanced Micro Devices, Inc.
+ *
+ * Author: Rijo Thomas <Rijo-john.Thomas@amd.com>
+ * Author: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
+ *
+ */
+
+/* This file describes the TEE communication interface between host and AMD
+ * Secure Processor
+ */
+
+#ifndef __TEE_DEV_H__
+#define __TEE_DEV_H__
+
+#include <linux/device.h>
+#include <linux/mutex.h>
+
+#define TEE_DEFAULT_TIMEOUT		10
+#define MAX_BUFFER_SIZE			992
+
+/**
+ * enum tee_ring_cmd_id - TEE interface commands for ring buffer configuration
+ * @TEE_RING_INIT_CMD:		Initialize ring buffer
+ * @TEE_RING_DESTROY_CMD:	Destroy ring buffer
+ * @TEE_RING_MAX_CMD:		Maximum command id
+ */
+enum tee_ring_cmd_id {
+	TEE_RING_INIT_CMD		= 0x00010000,
+	TEE_RING_DESTROY_CMD		= 0x00020000,
+	TEE_RING_MAX_CMD		= 0x000F0000,
+};
+
+/**
+ * struct tee_init_ring_cmd - Command to init TEE ring buffer
+ * @low_addr:  bits [31:0] of the physical address of ring buffer
+ * @hi_addr:   bits [63:32] of the physical address of ring buffer
+ * @size:      size of ring buffer in bytes
+ */
+struct tee_init_ring_cmd {
+	u32 low_addr;
+	u32 hi_addr;
+	u32 size;
+};
+
+#define MAX_RING_BUFFER_ENTRIES		32
+
+/**
+ * struct ring_buf_manager - Helper structure to manage ring buffer.
+ * @ring_start:  starting address of ring buffer
+ * @ring_size:   size of ring buffer in bytes
+ * @ring_pa:     physical address of ring buffer
+ * @wptr:        index to the last written entry in ring buffer
+ */
+struct ring_buf_manager {
+	void *ring_start;
+	u32 ring_size;
+	phys_addr_t ring_pa;
+	u32 wptr;
+};
+
+struct psp_tee_device {
+	struct device *dev;
+	struct psp_device *psp;
+	void __iomem *io_regs;
+	struct tee_vdata *vdata;
+	struct ring_buf_manager rb_mgr;
+};
+
+/**
+ * enum tee_cmd_state - TEE command states for the ring buffer interface
+ * @TEE_CMD_STATE_INIT:      initial state of command when sent from host
+ * @TEE_CMD_STATE_PROCESS:   command being processed by TEE environment
+ * @TEE_CMD_STATE_COMPLETED: command processing completed
+ */
+enum tee_cmd_state {
+	TEE_CMD_STATE_INIT,
+	TEE_CMD_STATE_PROCESS,
+	TEE_CMD_STATE_COMPLETED,
+};
+
+/**
+ * struct tee_ring_cmd - Structure of the command buffer in TEE ring
+ * @cmd_id:      refers to &enum tee_cmd_id. Command id for the ring buffer
+ *               interface
+ * @cmd_state:   refers to &enum tee_cmd_state
+ * @status:      status of TEE command execution
+ * @res0:        reserved region
+ * @pdata:       private data (currently unused)
+ * @res1:        reserved region
+ * @buf:         TEE command specific buffer
+ */
+struct tee_ring_cmd {
+	u32 cmd_id;
+	u32 cmd_state;
+	u32 status;
+	u32 res0[1];
+	u64 pdata;
+	u32 res1[2];
+	u8 buf[MAX_BUFFER_SIZE];
+
+	/* Total size: 1024 bytes */
+} __packed;
+
+int tee_dev_init(struct psp_device *psp);
+void tee_dev_destroy(struct psp_device *psp);
+
+#endif /* __TEE_DEV_H__ */
-- 
1.9.1

