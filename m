Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC266191C02
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 22:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgCXVgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 17:36:17 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:51297 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbgCXVgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 17:36:17 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id EFD3080237;
        Wed, 25 Mar 2020 10:36:14 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1585085774;
        bh=ygbzvsrszuyiwFOJ6DWF6cMbXhOt/OKPVtDodTTPLdQ=;
        h=From:To:Cc:Subject:Date;
        b=PJ+d9JXLbGDYteYWKsRRXzfnrDkOVeWl15ZYMaedcDI7PJYkc6+1k6cLNc74/9Ju2
         dcKfXcM+dZ/xt5xVdbYirqnFKQuJiJXPoGOnx9Qbqsjchr/w78nYURVEwVdeHfSbTx
         xjCmSml6u43crzbmm6Y1yfJtqculaLWl9RQb04Lt5yS+gw3k6Bd20/jKEOvnBtpL9S
         Zy2ls1UfOfnaN4Um8mNUoaxjwFT67GBfgJeqXyJkZsS6I3x2H+ya5zw0Z1V1X+/z7+
         qlR5rFD8QAk1t+9OZPnxd0lewOR0OfVMUKREtsu0sPvsCSPsZRt60SUHTuX9WL7cih
         EBxHAuysnACYQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e7a7d4f0000>; Wed, 25 Mar 2020 10:36:15 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 419BE13EEB7;
        Wed, 25 Mar 2020 10:36:14 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id BEBB428006C; Wed, 25 Mar 2020 10:36:14 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     mpe@ellerman.id.au, robh+dt@kernel.org, mark.rutland@arm.com,
        paulus@samba.org, benh@kernel.crashing.org
Cc:     Hamish Martin <hamish.martin@alliedtelesis.co.nz>,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] powerpc/fsl: Add cache properties for T2080/T2081
Date:   Wed, 25 Mar 2020 10:36:12 +1300
Message-Id: <20200324213612.31614-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the d-cache/i-cache properties for the T208x SoCs. The L1 cache on
these SoCs is 32KiB and is split into 64 byte blocks (lines).

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/powerpc/boot/dts/fsl/t208xsi-pre.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/t208xsi-pre.dtsi b/arch/powerpc/bo=
ot/dts/fsl/t208xsi-pre.dtsi
index 3f745de44284..2ad27e16ac16 100644
--- a/arch/powerpc/boot/dts/fsl/t208xsi-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t208xsi-pre.dtsi
@@ -81,6 +81,10 @@ cpus {
 		cpu0: PowerPC,e6500@0 {
 			device_type =3D "cpu";
 			reg =3D <0 1>;
+			d-cache-line-size =3D <64>;
+			i-cache-line-size =3D <64>;
+			d-cache-size =3D <32768>;
+			i-cache-size =3D <32768>;
 			clocks =3D <&clockgen 1 0>;
 			next-level-cache =3D <&L2_1>;
 			fsl,portid-mapping =3D <0x80000000>;
@@ -88,6 +92,10 @@ cpu0: PowerPC,e6500@0 {
 		cpu1: PowerPC,e6500@2 {
 			device_type =3D "cpu";
 			reg =3D <2 3>;
+			d-cache-line-size =3D <64>;
+			i-cache-line-size =3D <64>;
+			d-cache-size =3D <32768>;
+			i-cache-size =3D <32768>;
 			clocks =3D <&clockgen 1 0>;
 			next-level-cache =3D <&L2_1>;
 			fsl,portid-mapping =3D <0x80000000>;
@@ -95,6 +103,10 @@ cpu1: PowerPC,e6500@2 {
 		cpu2: PowerPC,e6500@4 {
 			device_type =3D "cpu";
 			reg =3D <4 5>;
+			d-cache-line-size =3D <64>;
+			i-cache-line-size =3D <64>;
+			d-cache-size =3D <32768>;
+			i-cache-size =3D <32768>;
 			clocks =3D <&clockgen 1 0>;
 			next-level-cache =3D <&L2_1>;
 			fsl,portid-mapping =3D <0x80000000>;
@@ -102,6 +114,10 @@ cpu2: PowerPC,e6500@4 {
 		cpu3: PowerPC,e6500@6 {
 			device_type =3D "cpu";
 			reg =3D <6 7>;
+			d-cache-line-size =3D <64>;
+			i-cache-line-size =3D <64>;
+			d-cache-size =3D <32768>;
+			i-cache-size =3D <32768>;
 			clocks =3D <&clockgen 1 0>;
 			next-level-cache =3D <&L2_1>;
 			fsl,portid-mapping =3D <0x80000000>;
--=20
2.25.1

