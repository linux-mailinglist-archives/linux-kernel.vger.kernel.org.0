Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB8AF166328
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 17:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbgBTQdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 11:33:39 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34033 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbgBTQdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:33:38 -0500
Received: by mail-lj1-f194.google.com with SMTP id x7so4913946ljc.1;
        Thu, 20 Feb 2020 08:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mU6goqc1IxvONiqvTYZTB/JhR8b7wxr9PjlrU6ggYOQ=;
        b=Zy/6H47iNhc6duTlQoHmZ3mvdacWIOPP+1YBoY72p7IK93DvVHCJ2x09p5VX3fLRrk
         FXoPl1UBTcn4UTW9t//xUkil5xwvVdYyLugGBLJJ+lmVA9h0TzMaPEhFH3/DAIM+CWpn
         /8wOMCqRF2iB+Y9BDTxGGvR/GAhRnDZO+vPumX1BrYCkLLG/nQsPKeAKl1ErArHNbFHf
         UjzQK2O28plVU+TUCK3FLKkCdxrkiC06V1mYlVktQgNdaxXtiDdQxNqGAgG0Pd27nek2
         uUUBOExBI/7LyRqXhxIfkv+LJFGphjn/OshscVzSuEXYigNovfAg2dYfCISIskOrS8As
         ay4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mU6goqc1IxvONiqvTYZTB/JhR8b7wxr9PjlrU6ggYOQ=;
        b=bPsoikSjp25d2zl5+bgTD5u1/IxtW6d3/wgrhvdA7VXRMb3qRWA0x4tmkPB6M1Csd5
         AlDQlWIjWgeg9HW6HXrpLrcBO8A3iN1yvu3zwirhYhPMUym42pfbF/MQl2JAZTUbob6a
         7dU6xxvuV24vksnFZjdZQDZIHNZHv4n2Zuo+zQdod03OMt/3muWUsniIEMpG2un905rG
         xJfGxAnwTcVNIpbmhCZobyr8OTcT1C7YjNgkBOWZyV+PyE2jNAhOG4dmxArDfI2ikUMh
         EcMi0cl0TWVxV8GXr2osRCeFueGww0d08ybUO/LR3AlggRMZ4jM9THg5j8m/ElByQmMX
         FK5g==
X-Gm-Message-State: APjAAAWhe5hiuuoNiT8d4ajm+SbPEbu6zjwU4XnkXKNdrxjOR++Rw47m
        46OWYLqjIb77cTSl0Oey3Pg=
X-Google-Smtp-Source: APXvYqzchIlyDbx+qLJ5TUp/c7SgjF1aZOiaYFR9U7AG7zzWR3ChSqgwodz6x6oEG8NwsgbH3OfHjg==
X-Received: by 2002:a2e:810d:: with SMTP id d13mr19485514ljg.113.1582216416742;
        Thu, 20 Feb 2020 08:33:36 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id y7sm2097292ljy.92.2020.02.20.08.33.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Feb 2020 08:33:36 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] arm64: dts: meson-gxl-s905x-p212: add bluetooth nodes
Date:   Thu, 20 Feb 2020 20:32:46 +0400
Message-Id: <1582216366-12964-1-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the uart_A alias (no longer required) and adds the bluetooth
node to the P212 device tree.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
index 43eb7d1..6ac678f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
@@ -15,7 +15,6 @@
 / {
 	aliases {
 		serial0 = &uart_AO;
-		serial1 = &uart_A;
 		ethernet0 = &ethmac;
 	};
 
@@ -180,6 +179,14 @@
 	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
 	pinctrl-names = "default";
 	uart-has-rtscts;
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
+		max-speed = <2000000>;
+		clocks = <&wifi32k>;
+		clock-names = "lpo";
+	};
 };
 
 &uart_AO {
-- 
2.7.4

