Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B68818BC02
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 17:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgCSQMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 12:12:10 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50994 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbgCSQMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 12:12:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id z13so3163589wml.0;
        Thu, 19 Mar 2020 09:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KrbGWoGHrNAkN/7yoRVhGOKa+eWQ1UuA90EUgfCOQho=;
        b=JqKQF2NSbWpkaB2YQgRtXi4pRnvqxVXmxEgbnq8qDBmDopCObaDOAnMTXtkDT0oNU5
         cpvIF2wxDxKAj4elpcd6dfsDzZbAuKrT43BAPG1Jqa8ten4zIMVGeoOg/n+6miEMbmaB
         ZBuaerwrjc1U/nDIL23r8oouA0huCJJndVhe2FNfSxsGzsbvc86yZKm3cHMMu1XpFsvn
         bZVyC8ug9BqSrbIHzKlxBxwqs/QljYkfVWQLmPt1gS8WqFmCB+fKSLSrW6E448fWLMfx
         HHcmiofaLLNdeWPJscgY4LsFVR13MCTf23SaGz6OUcs0rLggP81rdpWr0w50nyvmU3Fb
         EHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KrbGWoGHrNAkN/7yoRVhGOKa+eWQ1UuA90EUgfCOQho=;
        b=EBEvymiFSM6Ix6Tw/U+sXePad9F4W8dh5pEFYqL8aUlUV4UINyEZDXW1lw+2ViGDi+
         EdsNPzerdQ24ZBElgGAyCOSMcIl9GMmS1FEv+Pjb8/RNT0zXat/nBpjTwMdceNzaVMi+
         EQRrkNUXNG16lOYeFpO2MURqlQgxkpt9s1IgS/DcJM0J9SnOH0fXE94qhzF+aqaciO1O
         0lRR+dYSkJYItUC6tFBPEhlIS5VPv8IP+69oDUnST3g2LJ7cX5iwWayo67/8e4E8R680
         vdcf2J6gjDdK8svVIhIlLjhezxJpcGx8agGTabo8IqiaNto3ZGBo24+9TQgD5JlHX+fB
         r2SQ==
X-Gm-Message-State: ANhLgQ3gflIWJ+xe9qWaey2k5S6rdBIW1s3N0ryCMgsGs/fD16fTAJk5
        4NnIgdDm+7me7OKCjYqbRvM=
X-Google-Smtp-Source: ADFU+vui/AhR7WL50TXv0XoVgoj9U4tQmO2VTlUOWhnKa9HAfhIMLkPJTm7GaGae0ATpMTrjXS2SRQ==
X-Received: by 2002:a7b:c0cf:: with SMTP id s15mr4793754wmh.106.1584634328020;
        Thu, 19 Mar 2020 09:12:08 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w204sm3973485wma.1.2020.03.19.09.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2020 09:12:07 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 2/2] ARM: dts: rockchip: fix yaml warnings for rk3288-pmu-sram compatible nodes
Date:   Thu, 19 Mar 2020 17:11:59 +0100
Message-Id: <20200319161159.24548-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200319161159.24548-1-jbx6244@gmail.com>
References: <20200319161159.24548-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives for example these warnings:

arch/arm/boot/dts/rk3288-evb-act8846.dt.yaml: sram@ff720000:
'#address-cells' is a required property
arch/arm/boot/dts/rk3288-evb-act8846.dt.yaml: sram@ff720000:
'#size-cells' is a required property
arch/arm/boot/dts/rk3288-evb-act8846.dt.yaml: sram@ff720000:
'ranges' is a required property

Fix this error by adding '#address-cells', '#size-cells' and
'ranges' to the 'rockchip,rk3288-pmu-sram' compatible node
in rk3288.dtsi.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/sram/sram.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
Not tested with hardware.

Changed v2:
  Fix dtsi.
---
 arch/arm/boot/dts/rk3288.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 07681f1f0..e72368a7a 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -731,6 +731,9 @@
 	pmu_sram: sram@ff720000 {
 		compatible = "rockchip,rk3288-pmu-sram", "mmio-sram";
 		reg = <0x0 0xff720000 0x0 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x0 0xff720000 0x1000>;
 	};
 
 	pmu: power-management@ff730000 {
-- 
2.11.0

