Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 150F6E9720
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 08:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfJ3H1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 03:27:10 -0400
Received: from lucky1.263xmail.com ([211.157.147.133]:46708 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfJ3H1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 03:27:10 -0400
Received: from localhost (unknown [192.168.167.69])
        by lucky1.263xmail.com (Postfix) with ESMTP id 27AE7782E3;
        Wed, 30 Oct 2019 15:26:55 +0800 (CST)
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P24329T139764409022208S1572420409020177_;
        Wed, 30 Oct 2019 15:26:54 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <aa4f6e373c65ec03269a1d2ffc15d6c0>
X-RL-SENDER: andy.yan@rock-chips.com
X-SENDER: yxj@rock-chips.com
X-LOGIN-NAME: andy.yan@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Andy Yan <andy.yan@rock-chips.com>
To:     heiko@sntech.de, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH 1/2] dt-bindings: Add doc for Firefly ROC-RK3308-CC board
Date:   Wed, 30 Oct 2019 15:26:48 +0800
Message-Id: <20191030072648.29738-1-andy.yan@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for Firefly ROC-RK3308-CC board.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index bf86e8237363..6b6c9d5611ce 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -77,6 +77,11 @@ properties:
           - const: firefly,firefly-rk3288-reload
           - const: rockchip,rk3288
 
+      - description: Firefly ROC-RK3308-CC
+        items:
+          - const: firefly, roc-rk3308-cc
+          - const: rockchip,rk3308
+
       - description: Firefly Firefly-RK3399
         items:
           - const: firefly,firefly-rk3399
-- 
2.17.1



