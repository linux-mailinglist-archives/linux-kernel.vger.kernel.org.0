Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFA666A4A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 11:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfGLJpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jul 2019 05:45:45 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:36496 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726025AbfGLJpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 05:45:45 -0400
X-UUID: a05fce957f234c689701d9e2993a7a51-20190712
X-UUID: a05fce957f234c689701d9e2993a7a51-20190712
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 573154093; Fri, 12 Jul 2019 17:45:26 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 12 Jul 2019 17:45:25 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 12 Jul 2019 17:45:18 +0800
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        Owen Chen <owen.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wsd_upstream@mediatek.com>, CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, Macpaul Lin <macpaul.lin@mediatek.com>
Subject: [PATCH v6 2/8] dt-bindings: mediatek: Add smi dts binding for Mediatek MT6765 SoC
Date:   Fri, 12 Jul 2019 17:43:38 +0800
Message-ID: <1562924653-10056-3-git-send-email-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1562924653-10056-1-git-send-email-macpaul.lin@mediatek.com>
References: <1562924653-10056-1-git-send-email-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mars Cheng <mars.cheng@mediatek.com>

This patch adds MT6765 smi binding document

Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
Signed-off-by: Owen Chen <owen.chen@mediatek.com>
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/memory-controllers/mediatek,smi-common.txt          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
index 01744ec6a75b..f7122d88a885 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
@@ -18,6 +18,7 @@ Required properties:
 - compatible : must be one of :
 	"mediatek,mt2701-smi-common"
 	"mediatek,mt2712-smi-common"
+	"mediatek,mt6765-smi-common", "syscon"
 	"mediatek,mt7623-smi-common", "mediatek,mt2701-smi-common"
 	"mediatek,mt8173-smi-common"
 	"mediatek,mt8183-smi-common", "syscon"
-- 
2.18.0

