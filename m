Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC087A254
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 09:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730551AbfG3Het (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 03:34:49 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:33705 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730504AbfG3Her (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 03:34:47 -0400
X-UUID: 0d8ca158fbb7499ab9b555112207c27f-20190730
X-UUID: 0d8ca158fbb7499ab9b555112207c27f-20190730
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 568279707; Tue, 30 Jul 2019 15:34:38 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 30 Jul 2019 15:34:33 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 30 Jul 2019 15:34:33 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Mathias Nyman <mathias.nyman@intel.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH v2 1/2] dt-bindings: usb: mtk-xhci: add an optional xhci_ck clock
Date:   Tue, 30 Jul 2019 15:34:15 +0800
Message-ID: <1564472056-27875-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 147A02A2D28A053AF47239BB8AEC3BDE4930BA5F6B6165F1BDEBE0E466D4E08B2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new optional clock xhci_ck

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2 changes:
  1. add the new clock at the end, suggested by Rob
---
 Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
index 266c2d917a28..f3e4acecabe8 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
@@ -30,7 +30,8 @@ Required properties:
 	the following ones are optional:
 	"ref_ck": reference clock used by low power mode etc,
 	"mcu_ck": mcu_bus clock for register access,
-	"dma_ck": dma_bus clock for data transfer by DMA
+	"dma_ck": dma_bus clock for data transfer by DMA,
+	"xhci_ck": controller clock
 
  - phys : see usb-hcd.txt in the current directory
 
@@ -100,7 +101,7 @@ Required properties:
  - clocks : a list of phandle + clock-specifier pairs, one for each
 	entry in clock-names
  - clock-names : must contain "sys_ck", and the following ones are optional:
-	"ref_ck", "mcu_ck" and "dma_ck"
+	"ref_ck", "mcu_ck" and "dma_ck", "xhci_ck"
 
 Optional properties:
  - vbus-supply : reference to the VBUS regulator;
-- 
2.21.0

