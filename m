Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 576FD4C572
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 04:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731300AbfFTCi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 22:38:29 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:55694 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726519AbfFTCi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 22:38:28 -0400
X-UUID: 2e9552a46603490ca53c595f1df235cb-20190620
X-UUID: 2e9552a46603490ca53c595f1df235cb-20190620
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1354593118; Thu, 20 Jun 2019 10:38:20 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 20 Jun 2019 10:38:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 20 Jun 2019 10:38:18 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH v6 01/14] dt-bindings: mediatek: Add property to mt8183 smi-common
Date:   Thu, 20 Jun 2019 10:37:53 +0800
Message-ID: <1560998286-9189-2-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1560998286-9189-1-git-send-email-weiyi.lu@mediatek.com>
References: <1560998286-9189-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For scpsys driver using regmap based syscon driver API.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 .../devicetree/bindings/memory-controllers/mediatek,smi-common.txt      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
index b478ade..01744ec 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
@@ -20,7 +20,7 @@ Required properties:
 	"mediatek,mt2712-smi-common"
 	"mediatek,mt7623-smi-common", "mediatek,mt2701-smi-common"
 	"mediatek,mt8173-smi-common"
-	"mediatek,mt8183-smi-common"
+	"mediatek,mt8183-smi-common", "syscon"
 - reg : the register and size of the SMI block.
 - power-domains : a phandle to the power domain of this local arbiter.
 - clocks : Must contain an entry for each entry in clock-names.
-- 
1.8.1.1.dirty

