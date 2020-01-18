Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88EE314184A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jan 2020 16:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgARPZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jan 2020 10:25:10 -0500
Received: from mx2.freebsd.org ([96.47.72.81]:23582 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbgARPZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 10:25:10 -0500
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mx1.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id 9773B7B638;
        Sat, 18 Jan 2020 15:25:08 +0000 (UTC)
        (envelope-from manu@FreeBSD.Org)
Received: from smtp.freebsd.org (smtp.freebsd.org [IPv6:2610:1c1:1:606c::24b:4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "smtp.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 480MF01jhmz44FZ;
        Sat, 18 Jan 2020 15:25:08 +0000 (UTC)
        (envelope-from manu@FreeBSD.Org)
Received: from localhost.localdomain (lfbn-idf2-1-1164-130.w90-92.abo.wanadoo.fr [90.92.223.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        (Authenticated sender: manu)
        by smtp.freebsd.org (Postfix) with ESMTPSA id 3942E17F81;
        Sat, 18 Jan 2020 15:25:07 +0000 (UTC)
        (envelope-from manu@FreeBSD.Org)
From:   Emmanuel Vadot <manu@FreeBSD.Org>
To:     mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Emmanuel Vadot <manu@freebsd.org>
Subject: [PATCH v2] arm64: dts: allwinner: a64: Add gpio bank supply for A64-Olinuxino
Date:   Sat, 18 Jan 2020 16:24:59 +0100
Message-Id: <20200118152459.17199-1-manu@FreeBSD.Org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emmanuel Vadot <manu@freebsd.org>

Add the regulators for each bank on this boards.
For VCC-PL only add a comment on what regulator is used. We cannot add
the property without causing a circular dependency as the PL pins are
used to talk to the PMIC.

Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
---
v2:
 - Remove vcc-pl-supply in r_pio as it cause a circular dependency.

 .../boot/dts/allwinner/sun50i-a64-olinuxino.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
index 01a9a52edae4..7e71b5b12f98 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
@@ -163,6 +163,17 @@ &ohci1 {
 	status = "okay";
 };
 
+&pio {
+	vcc-pa-supply = <&reg_dcdc1>;
+	vcc-pb-supply = <&reg_dcdc1>;
+	vcc-pc-supply = <&reg_dcdc1>;
+	vcc-pd-supply = <&reg_dcdc1>;
+	vcc-pe-supply = <&reg_aldo1>;
+	vcc-pf-supply = <&reg_dcdc1>;
+	vcc-pg-supply = <&reg_dldo4>;
+	vcc-ph-supply = <&reg_dcdc1>;
+};
+
 &r_rsb {
 	status = "okay";
 
@@ -175,6 +186,12 @@ axp803: pmic@3a3 {
 	};
 };
 
+/* VCC-PL is powered by aldo2 but we cannot add it as the RSB */
+/* interface used to talk to the PMIC in on the PL pins */
+/* &r_pio { */
+/*	vcc-pl-supply = <&reg_aldo2>; */
+/* }; */
+
 #include "axp803.dtsi"
 
 &ac_power_supply {
-- 
2.24.1

