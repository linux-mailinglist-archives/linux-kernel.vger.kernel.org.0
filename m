Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 285979A7FA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 09:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404907AbfHWHBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 03:01:02 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:28305 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404825AbfHWHAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 03:00:47 -0400
X-UUID: db88dd1f74574e0388bb8f928a007f56-20190823
X-UUID: db88dd1f74574e0388bb8f928a007f56-20190823
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1064793824; Fri, 23 Aug 2019 15:00:24 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 23 Aug 2019 15:00:16 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 23 Aug 2019 15:00:15 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 01/11] dt-bindings: phy-mtk-tphy: add two optional properties for u2phy
Date:   Fri, 23 Aug 2019 15:00:08 +0800
Message-ID: <e99c0d7a55869a4425250c601b80a3331c9d0976.1566542696.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 7EFDBC5C3B5D1A8683947C55EFDED4DCC5C21582BB30387B921ACFE14F6B4FD72000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two optional properties, one for J-K test, another for disconnect
threshold, both of them can be used to debug disconnection issues.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt b/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
index a5f7a4f0dbc1..d5b327f85fa2 100644
--- a/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
+++ b/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
@@ -52,6 +52,8 @@ Optional properties (PHY_TYPE_USB2 port (child) node):
 - mediatek,eye-vrt	: u32, the selection of VRT reference voltage
 - mediatek,eye-term	: u32, the selection of HS_TX TERM reference voltage
 - mediatek,bc12	: bool, enable BC12 of u2phy if support it
+- mediatek,discth	: u32, the voltage of disconnect threshold
+- mediatek,intr	: u32, the value of internal R (resistance)
 
 Example:
 
-- 
2.23.0

