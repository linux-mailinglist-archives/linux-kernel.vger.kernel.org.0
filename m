Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDE37A3090
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 09:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbfH3HPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 03:15:44 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:40714 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728026AbfH3HPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 03:15:16 -0400
X-UUID: f34e058454754cb5bc0790330a0629e8-20190830
X-UUID: f34e058454754cb5bc0790330a0629e8-20190830
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 355332502; Fri, 30 Aug 2019 15:15:12 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 30 Aug 2019 15:15:08 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 30 Aug 2019 15:15:08 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 04/11] dt-bindings: phy-mtk-tphy: add a new reference clock
Date:   Fri, 30 Aug 2019 15:14:51 +0800
Message-ID: <1567149298-29366-4-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1567149298-29366-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1567149298-29366-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 48380304956D9A8EE5F15AEF3A53E6C474D4B96782904CFB2F375617D38876062000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usually the digital and analog phys use the same reference clock,
but on some platforms, they are separated, so add another optional
clock to support it.
In order to keep the clock names consistent with PHY IP's, use
the da_ref for analog phy and ref clock for digital phy.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: fix typo of analog and needed
---
 Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt b/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
index 48bc1a2e9299..a859b0db4051 100644
--- a/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
+++ b/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
@@ -41,9 +41,12 @@ Optional properties (PHY_TYPE_USB2 port (child) node):
 - clocks	: a list of phandle + clock-specifier pairs, one for each
 		  entry in clock-names
 - clock-names	: may contain
-		  "ref": 48M reference clock for HighSpeed anolog phy; and 26M
-			reference clock for SuperSpeed anolog phy, sometimes is
+		  "ref": 48M reference clock for HighSpeed (digital) phy; and 26M
+			reference clock for SuperSpeed (digital) phy, sometimes is
 			24M, 25M or 27M, depended on platform.
+		  "da_ref": the reference clock of analog phy, used if the clocks
+			of analog and digital phys are separated, otherwise uses
+			"ref" clock only if needed.
 
 - mediatek,eye-src	: u32, the value of slew rate calibrate
 - mediatek,eye-vrt	: u32, the selection of VRT reference voltage
-- 
2.23.0

