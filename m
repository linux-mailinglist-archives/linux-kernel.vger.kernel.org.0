Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21E7C1909E1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 10:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgCXJqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 05:46:08 -0400
Received: from smtpbgsg2.qq.com ([54.254.200.128]:60692 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbgCXJqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:46:08 -0400
X-QQ-mid: bizesmtp17t1585043161txrzbg3g
Received: from localhost.localdomain (unknown [210.242.163.205])
        by esmtp6.qq.com (ESMTP) with 
        id ; Tue, 24 Mar 2020 17:45:58 +0800 (CST)
X-QQ-SSF: 01400000002000I0R720000A0000000
X-QQ-FEAT: QzH0LXO1kxblCOA3FX5oB6XbkyGsnhwJmuMZvC7UyqecKsDN6omVQuaXllHwO
        13OEo9gQdSgoPQlMHybM3xob8LwXKmmvQ7LwD/nqE37KmEeEo5y2Ludcknjvo5FkPEps8c3
        Bhh0Akm8oJE/1I6q0sGxV/bUZlGo/Xxuiz2+9qlxE4rYwT14Pnt1ha79+zfALp0YOKVnThi
        myqkMatG/lFLx6eqN/yBZwr6jHCT25YMIOgZVplJwK58a9wGqzDsiE470YRp5AwwUzcNbk5
        SKBVPYE+3zIKv3WCR1w0sh9PC7TVSVaV6tDrlpUWWE3bqlJ+Cg4ORiqFoH0a1+XPaEVMyFE
        DfMvqJqW2k2PXKqHUtF3x1SrNK+Ywhm3jUOXR1q
X-QQ-GoodBg: 2
From:   David Lu <david.lu@bitland.com.cn>
To:     david.lu@bitland.com.cn
Cc:     jungle.chiang@bitland.com.cn,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: boe,tv101wum-n16: Add compatible for boe tv105wum-nw0.
Date:   Tue, 24 Mar 2020 17:45:25 +0800
Message-Id: <20200324094525.4758-1-david.lu@bitland.com.cn>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:bitland.com.cn:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings documentation for BOE TV105WUM-NW0 10.5" WUXGA TFT LCD
panel.

Signed-off-by: David Lu <david.lu@bitland.com.cn>
Change-Id: I450c0e52aae080728d4794bdffc50bb0d2f39f40
---
 .../devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml     | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
index 740213459134..7f5df5851017 100644
--- a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
+++ b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
@@ -24,6 +24,8 @@ properties:
       - boe,tv101wum-n53
         # AUO B101UAN08.3 10.1" WUXGA TFT LCD panel
       - auo,b101uan08.3
+        # BOE TV105WUM-NW0 10.5" WUXGA TFT LCD panel
+      - boe,tv105wum-nw0
 
   reg:
     description: the virtual channel number of a DSI peripheral
-- 
2.24.1



