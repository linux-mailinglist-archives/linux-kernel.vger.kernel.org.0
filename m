Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2899F16FC6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 06:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfEHD74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 23:59:56 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:5536 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727053AbfEHD7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 23:59:55 -0400
X-UUID: 2e7a773f80f84351866eb209fb35bfa7-20190508
X-UUID: 2e7a773f80f84351866eb209fb35bfa7-20190508
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1036691782; Wed, 08 May 2019 11:59:49 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 8 May 2019 11:59:47 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 8 May 2019 11:59:47 +0800
From:   <neal.liu@mediatek.com>
To:     <mpm@selenic.com>, <herbert@gondor.apana.org.au>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <matthias.bgg@gmail.com>
CC:     <wsd_upstream@mediatek.com>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Neal Liu <neal.liu@mediatek.com>
Subject: [PATCH 2/3] dt-bindings: rng: update bindings for MT67xx SoCs
Date:   Wed, 8 May 2019 11:58:56 +0800
Message-ID: <1557287937-2410-3-git-send-email-neal.liu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1557287937-2410-1-git-send-email-neal.liu@mediatek.com>
References: <1557287937-2410-1-git-send-email-neal.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neal Liu <neal.liu@mediatek.com>

Document the binding used by the Mediatek MT67xx SoCs random
number generator with TrustZone enabled.

Signed-off-by: Neal Liu <neal.liu@mediatek.com>
---
 Documentation/devicetree/bindings/rng/mtk-rng.txt |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/rng/mtk-rng.txt b/Documentation/devicetree/bindings/rng/mtk-rng.txt
index 2bc89f1..5f40316 100644
--- a/Documentation/devicetree/bindings/rng/mtk-rng.txt
+++ b/Documentation/devicetree/bindings/rng/mtk-rng.txt
@@ -3,9 +3,12 @@ found in MediaTek SoC family
 
 Required properties:
 - compatible	    : Should be
-			"mediatek,mt7622-rng", 	"mediatek,mt7623-rng" : for MT7622
-			"mediatek,mt7629-rng",  "mediatek,mt7623-rng" : for MT7629
-			"mediatek,mt7623-rng" : for MT7623
+			"mediatek,mt7622-rng", "mediatek,mt7623-rng" for MT7622
+			"mediatek,mt7629-rng", "mediatek,mt7623-rng" for MT7629
+			"mediatek,mt7623-rng" for MT7623
+			"mediatek,mt67xx-rng" for MT67xx ARMv8 SoCs
+
+Optional properties:
 - clocks	    : list of clock specifiers, corresponding to
 		      entries in clock-names property;
 - clock-names	    : Should contain "rng" entries;
@@ -19,3 +22,7 @@ rng: rng@1020f000 {
 	clocks = <&infracfg CLK_INFRA_TRNG>;
 	clock-names = "rng";
 };
+
+hwrng: hwrng {
+	compatible = "mediatek,mt67xx-rng";
+};
-- 
1.7.9.5

