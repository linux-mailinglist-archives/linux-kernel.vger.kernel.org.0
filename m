Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 962885F961
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 15:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfGDNxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 09:53:07 -0400
Received: from inva021.nxp.com ([92.121.34.21]:55686 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727026AbfGDNxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 09:53:07 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 687B7200D9A;
        Thu,  4 Jul 2019 15:53:05 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 27095200D9D;
        Thu,  4 Jul 2019 15:53:00 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 6A9B9402C0;
        Thu,  4 Jul 2019 21:52:53 +0800 (SGT)
From:   fugang.duan@nxp.com
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org
Cc:     gregkh@linuxfoundation.org, festevam@gmail.com,
        daniel.baluta@gmail.com, fugang.duan@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH RESEND 1/1] dt-bindings: serial: lpuart: add the clock requirement for imx8qxp
Date:   Thu,  4 Jul 2019 21:43:55 +0800
Message-Id: <20190704134355.2402-1-fugang.duan@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fugang Duan <fugang.duan@nxp.com>

Add the baud clock requirement for imx8qxp.

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
---
 Documentation/devicetree/bindings/serial/fsl-lpuart.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
index 21483ba..3495eee 100644
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
@@ -13,7 +13,10 @@ Required properties:
 - reg : Address and length of the register set for the device
 - interrupts : Should contain uart interrupt
 - clocks : phandle + clock specifier pairs, one for each entry in clock-names
-- clock-names : should contain: "ipg" - the uart clock
+- clock-names : For vf610/ls1021a/imx7ulp, "ipg" clock is for uart bus/baud
+  clock. For imx8qxp lpuart, "ipg" clock is bus clock that is used to access
+  lpuart controller registers, it also requires "baud" clock for module to
+  receive/transmit data.
 
 Optional properties:
 - dmas: A list of two dma specifiers, one for each entry in dma-names.
-- 
2.7.4

