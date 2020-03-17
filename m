Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07944188B24
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 17:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgCQQud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 12:50:33 -0400
Received: from mail-wr1-f97.google.com ([209.85.221.97]:40015 "EHLO
        mail-wr1-f97.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbgCQQuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 12:50:12 -0400
Received: by mail-wr1-f97.google.com with SMTP id f3so19654354wrw.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 09:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B45/nUfOtmmwVmpZUX1HJqLwFm+AFKdfWI8i6Ywg6f8=;
        b=MQR3s3prG83alxU3D/Cb53vMjAZpfe3c+nj12l08b+Iv4fGHT824TkeGL5LTwFw0ff
         5VIfeHCzUni9GRAW7Kylhm52QsqygNISP19LOB7y3+TWJ3S5PGz58rqOKu4FK01DRXcM
         25oQ1BKMyDJC349vdU/J5s2pwqGtZ0Urq9zKu+/yCqERvyStILze4KqcXMgdYd4bsBt6
         lrLeTDmRMDKr9tdakHKvtAQU370zYrlJNmX5Bz4PZHqU/prgdL7wD1APvD8d3cgJ+jaE
         4qjO/UYF3T9dZKFuKx1UzjVPo9cA3b6AXVw1pCvtqbU8lV7aKgq4CYOSXyI+hNB7ACWr
         BC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B45/nUfOtmmwVmpZUX1HJqLwFm+AFKdfWI8i6Ywg6f8=;
        b=eNy57YbiGFNit25gLuwAK/XjFIw3IcEZfiDyAFREI0YaE3QzoDHhTdkQQFnrXOYnJP
         BJ0AU4MzUZaS57xQf9v+k0yPtcIS6SWvDOpmXyXdqEupGMKVPTmSQ2fonK8uZ7pwCCQz
         2n0LrSe47b4hw8S1HonRd9RGQbZVYwu+mDeiVGZTbqTTO6o2VEJVChgJEA1c1nFLwjX4
         Dm5UTAFTuTdoRlPK6W1xXY8RaRFneTW4OBMxZ3gol5GcOw/e5Gy0oKWhuaYfDUvjvDBJ
         AIJ3z1ejHxYkEylK4XVgZZayTGSrOIjbsz0UqBx+m202ftZnHJYd2IKwmSaQu0y1dtkJ
         xPOQ==
X-Gm-Message-State: ANhLgQ0VKs1y7Drk1toDIIMkF8xWesNlkutKnsVBTkl+O9uQTPpAMI/R
        Mr3pr3fkQzOhfVFH6KjrtbEXPOObc6dC3lFZlRSM2CQ+FTLH
X-Google-Smtp-Source: ADFU+vtKvfOkBmGNK9FyHWUoAyk6vdyfZ1ec0Ho5dvQeINcuYSl4oJMECGNCB9ibYkr3JmuiaRGCOH7ZRSyi
X-Received: by 2002:adf:d0c2:: with SMTP id z2mr6857642wrh.223.1584463809425;
        Tue, 17 Mar 2020 09:50:09 -0700 (PDT)
Received: from mail.besancon.parkeon.com ([185.149.63.251])
        by smtp-relay.gmail.com with ESMTPS id s14sm59992wru.87.2020.03.17.09.50.09
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 17 Mar 2020 09:50:09 -0700 (PDT)
X-Relaying-Domain: flowbird.group
Received: from [172.16.13.134] (port=56876 helo=PC12445-BES.dynamic.besancon.parkeon.com)
        by mail.besancon.parkeon.com with esmtp (Exim 4.71)
        (envelope-from <martin.fuzzey@flowbird.group>)
        id 1jEFPt-0000dJ-1N; Tue, 17 Mar 2020 17:50:09 +0100
From:   Martin Fuzzey <martin.fuzzey@flowbird.group>
To:     Fugang Duan <fugang.duan@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org
Subject: [PATCH 2/4] ARM: dts: imx6: Use gpc for FEC interrupt controller to fix wake on LAN.
Date:   Tue, 17 Mar 2020 17:50:04 +0100
Message-Id: <1584463806-15788-3-git-send-email-martin.fuzzey@flowbird.group>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1584463806-15788-1-git-send-email-martin.fuzzey@flowbird.group>
References: <1584463806-15788-1-git-send-email-martin.fuzzey@flowbird.group>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to wake from suspend by ethernet magic packets the GPC must be
used as intc does not have wakeup functionality.

But the FEC DT node currently uses interrupt-extended, specificying intc,
this breaking WoL.

This problem is probably fallout from the stacked domain conversion as
intc used to chain to GPC.

So replace "interrupts-extended" by "interrupts" to use the default
parent which is GPC.

Fixes: b923ff6af0d5 ("ARM: imx6: convert GPC to stacked domains")

Signed-off-by: Martin Fuzzey <martin.fuzzey@flowbird.group>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index e6b4b85..bc488df 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1039,9 +1039,8 @@
 				compatible = "fsl,imx6q-fec";
 				reg = <0x02188000 0x4000>;
 				interrupt-names = "int0", "pps";
-				interrupts-extended =
-					<&intc 0 118 IRQ_TYPE_LEVEL_HIGH>,
-					<&intc 0 119 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <0 118 IRQ_TYPE_LEVEL_HIGH>,
+					     <0 119 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6QDL_CLK_ENET>,
 					 <&clks IMX6QDL_CLK_ENET>,
 					 <&clks IMX6QDL_CLK_ENET_REF>;
-- 
1.9.1

