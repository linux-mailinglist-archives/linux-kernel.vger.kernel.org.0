Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3885512BDD6
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Dec 2019 16:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfL1PGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Dec 2019 10:06:17 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:42377 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfL1PGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 10:06:17 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xBSF5xPd031649, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xBSF5xPd031649
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Sat, 28 Dec 2019 23:05:59 +0800
Received: from james-BS01.localdomain (172.21.190.33) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Sat, 28 Dec 2019 23:05:59 +0800
From:   James Tai <james.tai@realtek.com>
To:     <linux-realtek-soc@lists.infradead.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: arm: realtek: Document RTD1319 and Realtek PymParticle EVB
Date:   Sat, 28 Dec 2019 23:05:52 +0800
Message-ID: <20191228150553.6210-2-james.tai@realtek.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191228150553.6210-1-james.tai@realtek.com>
References: <20191228150553.6210-1-james.tai@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define compatible strings for Realtek RTD1319 SoC and Realtek PymParticle
EVB.

Signed-off-by: James Tai <james.tai@realtek.com>
---
 Documentation/devicetree/bindings/arm/realtek.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/realtek.yaml b/Documentation/devicetree/bindings/arm/realtek.yaml
index e11616883736..cc46d1e27ecc 100644
--- a/Documentation/devicetree/bindings/arm/realtek.yaml
+++ b/Documentation/devicetree/bindings/arm/realtek.yaml
@@ -43,6 +43,12 @@ properties:
               - synology,ds418 # Synology DiskStation DS418
           - const: realtek,rtd1296
 
+      # RTD1319 SoC based boards
+      - items:
+          - enum:
+              - realtek,pymparticle # Realtek PymParticle EVB
+          - const: realtek,rtd1319
+
       # RTD1395 SoC based boards
       - items:
           - enum:
-- 
2.24.1

