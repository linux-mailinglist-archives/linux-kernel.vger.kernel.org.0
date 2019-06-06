Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7779D36D6D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 09:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfFFHiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 03:38:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfFFHiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 03:38:13 -0400
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D511120872;
        Thu,  6 Jun 2019 07:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559806692;
        bh=SaCo5XTxFSdoSTx0adxdVSEm12HbPMedDe8u08eNtC4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OIUKUn6shQ6GwRLxaWBHSnKYtvydlkduoU3TpKCNajvOUsFFqkQ7O2+rGEpGNcZOQ
         vgpYq56PxceZAPGsLZ1OfHqwe9z62Uo9/gE/efaP7o7pzxdXBUmIa2qjVRVK1a0ce5
         wmr+Cowh4Kokl7XQjm3+qHRM0oP76DfrH+iD8HH0=
From:   guoren@kernel.org
To:     marc.zyngier@arm.com, mark.rutland@arm.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, jason@lakedaemon.net,
        guoren@kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V5 2/3] dt-bindings: interrupt-controller: Update csky mpintc
Date:   Thu,  6 Jun 2019 15:37:32 +0800
Message-Id: <1559806653-11249-3-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559806653-11249-1-git-send-email-guoren@kernel.org>
References: <1559806653-11249-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Add trigger type setting for csky,mpintc. The driver also could
support #interrupt-cells <1> and it wouldn't invalidate existing
DTs. Here we only show the complete format.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Reviewed-by: Rob Herring <robh+dt@kernel.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 .../bindings/interrupt-controller/csky,mpintc.txt    | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
index ab921f1..e134053 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
@@ -6,11 +6,16 @@ C-SKY Multi-processors Interrupt Controller is designed for ck807/ck810/ck860
 SMP soc, and it also could be used in non-SMP system.
 
 Interrupt number definition:
-
   0-15  : software irq, and we use 15 as our IPI_IRQ.
  16-31  : private  irq, and we use 16 as the co-processor timer.
  31-1024: common irq for soc ip.
 
+Interrupt triger mode: (Defined in dt-bindings/interrupt-controller/irq.h)
+ IRQ_TYPE_LEVEL_HIGH (default)
+ IRQ_TYPE_LEVEL_LOW
+ IRQ_TYPE_EDGE_RISING
+ IRQ_TYPE_EDGE_FALLING
+
 =============================
 intc node bindings definition
 =============================
@@ -26,15 +31,22 @@ intc node bindings definition
 	- #interrupt-cells
 		Usage: required
 		Value type: <u32>
-		Definition: must be <1>
+		Definition: <2>
 	- interrupt-controller:
 		Usage: required
 
-Examples:
+Examples: ("interrupts = <irq_num IRQ_TYPE_XXX>")
 ---------
+#include <dt-bindings/interrupt-controller/irq.h>
 
 	intc: interrupt-controller {
 		compatible = "csky,mpintc";
-		#interrupt-cells = <1>;
+		#interrupt-cells = <2>;
 		interrupt-controller;
 	};
+
+	device: device-example {
+		...
+		interrupts = <34 IRQ_TYPE_EDGE_RISING>;
+		interrupt-parent = <&intc>;
+	};
-- 
2.7.4

