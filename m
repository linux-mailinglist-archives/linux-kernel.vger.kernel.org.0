Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D266871673
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 12:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389259AbfGWKp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 06:45:28 -0400
Received: from foss.arm.com ([217.140.110.172]:52602 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389175AbfGWKo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 06:44:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39285337;
        Tue, 23 Jul 2019 03:44:56 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.197.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 505F83F71A;
        Tue, 23 Jul 2019 03:44:55 -0700 (PDT)
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 8/9] dt-bindings: interrupt-controller: arm,gic-v3: Describe EPPI range support
Date:   Tue, 23 Jul 2019 11:44:36 +0100
Message-Id: <20190723104437.154403-9-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190723104437.154403-1-maz@kernel.org>
References: <20190723104437.154403-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the GICv3 binding to allow interrupts in the EPPI range.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 .../devicetree/bindings/interrupt-controller/arm,gic-v3.yaml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
index 98a3ecda8e07..1fe147daca4c 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
@@ -44,12 +44,13 @@ properties:
       be at least 4.
 
       The 1st cell is the interrupt type; 0 for SPI interrupts, 1 for PPI
-      interrupts, 2 for interrupts in the Extended SPI range. Other values
-      are reserved for future use.
+      interrupts, 2 for interrupts in the Extended SPI range, 3 for the
+      Extended PPI range. Other values are reserved for future use.
 
       The 2nd cell contains the interrupt number for the interrupt type.
       SPI interrupts are in the range [0-987]. PPI interrupts are in the
       range [0-15]. Extented SPI interrupts are in the range [0-1023].
+      Extended PPI interrupts are in the range [0-127].
 
       The 3rd cell is the flags, encoded as follows:
       bits[3:0] trigger type and level flags.
-- 
2.20.1

