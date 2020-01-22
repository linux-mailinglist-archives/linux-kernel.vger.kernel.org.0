Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C468144D9C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 09:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgAVIZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 03:25:54 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:36064 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729165AbgAVIZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 03:25:51 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00M8Pjl8108048;
        Wed, 22 Jan 2020 02:25:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579681545;
        bh=SrEGW4i7yjeGxteEupp6hdS4iZlr2G083XuAg3UxTfQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vvoH3t9Q7eyyDedYnpcoGIsEgSsqgZ3VaNcviq1Xdw/pNpfwg4ZpFTEidFTRR/CGZ
         2+OIstk5jIyivDqDtR4vJZIR2QYBWkYGIZDDdBnS/DZOudWufNuDplTe6vP4AfD2xi
         AJRLqXgdo8+X5Du7lYT4RQNQ/k1/uFYUGFKlqwbk=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00M8Pi66085365;
        Wed, 22 Jan 2020 02:25:44 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 22
 Jan 2020 02:25:44 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 22 Jan 2020 02:25:44 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00M8PeAH046830;
        Wed, 22 Jan 2020 02:25:42 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <t-kristo@ti.com>, <nm@ti.com>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/9] arm64: dts: ti: k3-am65-main: Correct main NAVSS representation
Date:   Wed, 22 Jan 2020 10:26:13 +0200
Message-ID: <20200122082621.4974-2-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122082621.4974-1-peter.ujfalusi@ti.com>
References: <20200122082621.4974-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NAVSS is a subsystem containing different IPs, it is not really a bus.
Change the compatible from "simple-bus" to "simple-mfd" to reflect that.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index efb24579922c..e40f7acbec42 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -385,8 +385,8 @@ intr_main_gpio: interrupt-controller0 {
 		ti,sci-rm-range-girq = <0x1>;
 	};
 
-	cbass_main_navss: interconnect0 {
-		compatible = "simple-bus";
+	cbass_main_navss: navss@30800000 {
+		compatible = "simple-mfd";
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

