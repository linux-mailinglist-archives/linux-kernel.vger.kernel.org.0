Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85C373B34F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 12:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389535AbfFJKgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 06:36:52 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:6479 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389217AbfFJKgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 06:36:43 -0400
X-UUID: fbe0b5d2e00a47b19b283de073143dad-20190610
X-UUID: fbe0b5d2e00a47b19b283de073143dad-20190610
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 697743266; Mon, 10 Jun 2019 18:36:35 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 10 Jun 2019 18:36:33 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 10 Jun 2019 18:36:33 +0800
From:   Neal Liu <neal.liu@mediatek.com>
To:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>
CC:     Neal Liu <neal.liu@mediatek.com>, <linux-crypto@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        Crystal Guo <Crystal.Guo@mediatek.com>
Subject: [PATCH v3 1/3] soc: mediatek: add SMC fid table for SIP interface
Date:   Mon, 10 Jun 2019 18:36:22 +0800
Message-ID: <1560162984-26104-2-git-send-email-neal.liu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1560162984-26104-1-git-send-email-neal.liu@mediatek.com>
References: <1560162984-26104-1-git-send-email-neal.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: AB049FDEE81F782DF02F0C1296A73261E00F082DEA0E126DB98903FBC0B15F5C2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Add a header file to provide SIP interface to ATF
2. Add hwrng SMC fid

Signed-off-by: Neal Liu <neal.liu@mediatek.com>
---
 include/linux/soc/mediatek/mtk_sip_svc.h |   33 ++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 include/linux/soc/mediatek/mtk_sip_svc.h

diff --git a/include/linux/soc/mediatek/mtk_sip_svc.h b/include/linux/soc/mediatek/mtk_sip_svc.h
new file mode 100644
index 0000000..e70c325
--- /dev/null
+++ b/include/linux/soc/mediatek/mtk_sip_svc.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ */
+
+#ifndef _MTK_SECURE_API_H_
+#define _MTK_SECURE_API_H_
+
+#include <linux/kernel.h>
+
+/* Error Code */
+#define SIP_SVC_E_SUCCESS		0
+#define SIP_SVC_E_NOT_SUPPORTED		-1
+#define SIP_SVC_E_INVALID_PARAMS	-2
+#define SIP_SVC_E_INVALID_RANGE		-3
+#define SIP_SVC_E_PERMISSION_DENY	-4
+
+#ifdef CONFIG_ARM64
+#define MTK_SIP_SMC_AARCH_BIT		BIT(30)
+#else
+#define MTK_SIP_SMC_AARCH_BIT		0
+#endif
+
+/*******************************************************************************
+ * Defines for Mediatek runtime services func ids
+ ******************************************************************************/
+
+/* Security related SMC call */
+/* HWRNG */
+#define MTK_SIP_KERNEL_GET_RND \
+	(0x82000206 | MTK_SIP_SMC_AARCH_BIT)
+
+#endif /* _MTK_SECURE_API_H_ */
-- 
1.7.9.5

