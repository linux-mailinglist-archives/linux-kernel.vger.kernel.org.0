Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C402C92019
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 11:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfHSJW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 05:22:29 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:37221 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727398AbfHSJWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 05:22:11 -0400
X-UUID: 1bb2bc64cdb54b7b8962f7d6475efcf3-20190819
X-UUID: 1bb2bc64cdb54b7b8962f7d6475efcf3-20190819
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <mars.cheng@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 1411708213; Mon, 19 Aug 2019 17:22:00 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 19 Aug 2019 17:22:00 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 19 Aug 2019 17:22:00 +0800
From:   Mars Cheng <mars.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, mtk01761 <wendell.lin@mediatek.com>,
        <linux-clk@vger.kernel.org>, Mars Cheng <mars.cheng@mediatek.com>
Subject: [PATCH v2 01/11] dt-bindings: mediatek: add support for mt6779 reference board
Date:   Mon, 19 Aug 2019 17:21:32 +0800
Message-ID: <1566206502-4347-2-git-send-email-mars.cheng@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1566206502-4347-1-git-send-email-mars.cheng@mediatek.com>
References: <1566206502-4347-1-git-send-email-mars.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update binding document for mt6779 reference board

Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/mediatek.yaml          |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index a4ad2eb..4043c50 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -48,6 +48,10 @@ properties:
           - const: mediatek,mt6765
       - items:
           - enum:
+              - mediatek,mt6779-evb
+          - const: mediatek,mt6779
+      - items:
+          - enum:
               - mediatek,mt6795-evb
           - const: mediatek,mt6795
       - items:
-- 
1.7.9.5

