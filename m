Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9176F12A07D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Dec 2019 12:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfLXL1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Dec 2019 06:27:46 -0500
Received: from gloria.sntech.de ([185.11.138.130]:47150 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbfLXL1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 06:27:46 -0500
Received: from [46.183.103.17] (helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1ijiLe-00033e-WC; Tue, 24 Dec 2019 12:27:37 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     dri-devel@lists.freedesktop.org
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com, heiko@sntech.de,
        maxime@cerno.tech,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH v4 1/3] dt-bindings: Add vendor prefix for Leadtek Technology
Date:   Tue, 24 Dec 2019 12:26:39 +0100
Message-Id: <20191224112641.30647-1-heiko@sntech.de>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

Shenzhen Leadtek Technology Co., Ltd. produces for example display
and touch panels.

Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 85e7c26a05c7..4e6248ec5ed9 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -513,6 +513,8 @@ patternProperties:
     description: Lantiq Semiconductor
   "^lattice,.*":
     description: Lattice Semiconductor
+  "^leadtek,.*":
+    description: Shenzhen Leadtek Technology Co., Ltd.
   "^leez,.*":
     description: Leez
   "^lego,.*":
-- 
2.24.0

