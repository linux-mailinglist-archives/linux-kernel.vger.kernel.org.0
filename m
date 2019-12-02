Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D94010E8C5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 11:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfLBK32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 05:29:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:57626 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727451AbfLBK3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 05:29:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0D394AD00;
        Mon,  2 Dec 2019 10:29:23 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v2 8/9] dt-bindings: arm: realtek: Add Realtek Lion Skin EVB
Date:   Mon,  2 Dec 2019 11:29:09 +0100
Message-Id: <20191202102910.26916-9-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191202102910.26916-1-afaerber@suse.de>
References: <20191202102910.26916-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define a compatible string for Realtek RTD1395 Lion Skin eval board.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v2: New
 
 Documentation/devicetree/bindings/arm/realtek.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/realtek.yaml b/Documentation/devicetree/bindings/arm/realtek.yaml
index dc097ed5a7e5..40ca4c3f21f4 100644
--- a/Documentation/devicetree/bindings/arm/realtek.yaml
+++ b/Documentation/devicetree/bindings/arm/realtek.yaml
@@ -45,6 +45,7 @@ properties:
       - items:
           - enum:
               - bananapi,bpi-m4 # Banana Pi BPI-M4
+              - realtek,lion-skin # Realtek Lion Skin EVB
           - const: realtek,rtd1395
 
       # RTD1619 SoC based boards
-- 
2.16.4

