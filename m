Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAFCE6D3E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 08:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732980AbfJ1H3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 03:29:25 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:28197 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730235AbfJ1H3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 03:29:25 -0400
X-UUID: 9a0ae1fdd78b4f489b6a9f0e21b44ff3-20191028
X-UUID: 9a0ae1fdd78b4f489b6a9f0e21b44ff3-20191028
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <eason.yen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 817277668; Mon, 28 Oct 2019 15:29:21 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 28 Oct 2019 15:29:13 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 28 Oct 2019 15:29:14 +0800
From:   Eason Yen <eason.yen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, Eason Yen <eason.yen@mediatek.com>
Subject: [PATCH v1 1/1] soc: mediatek: add SMC fid table for SIP interface
Date:   Mon, 28 Oct 2019 15:29:09 +0800
Message-ID: <1572247749-4276-2-git-send-email-eason.yen@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1572247749-4276-1-git-send-email-eason.yen@mediatek.com>
References: <1572247749-4276-1-git-send-email-eason.yen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Add a header file to provide SIP interface to ATF
2. Add AUDIO SMC fid

Change-Id: I218e9f571cea079268a5414725a81e9b35702e33
Signed-off-by: Eason Yen <eason.yen@mediatek.com>
---
 include/linux/soc/mediatek/mtk_sip_svc.h |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 include/linux/soc/mediatek/mtk_sip_svc.h

diff --git a/include/linux/soc/mediatek/mtk_sip_svc.h b/include/linux/soc/mediatek/mtk_sip_svc.h
new file mode 100644
index 0000000..00ee0f4
--- /dev/null
+++ b/include/linux/soc/mediatek/mtk_sip_svc.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ */
+
+#ifndef __MTK_SIP_SVC_H__
+#define __MTK_SIP_SVC_H__
+
+#include <linux/kernel.h>
+
+/* Error Code */
+#define SIP_SVC_E_SUCCESS               0
+#define SIP_SVC_E_NOT_SUPPORTED         -1
+#define SIP_SVC_E_INVALID_PARAMS        -2
+#define SIP_SVC_E_INVALID_Range         -3
+#define SIP_SVC_E_PERMISSION_DENY       -4
+
+#ifdef CONFIG_ARM64
+#define MTK_SIP_SMC_AARCH_BIT			0x40000000
+#else
+#define MTK_SIP_SMC_AARCH_BIT			0x00000000
+#endif
+
+/* AUDIO related SMC call */
+#define MTK_SIP_AUDIO_CONTROL \
+	(0x82000517 | MTK_SIP_SMC_AARCH_BIT)
+#endif
+/* __MTK_SIP_SVC_H__ */
-- 
1.7.9.5

