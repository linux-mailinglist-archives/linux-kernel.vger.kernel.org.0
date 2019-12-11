Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55CC711A60B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 09:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfLKIlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 03:41:44 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38536 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfLKIlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 03:41:44 -0500
Received: by mail-pg1-f193.google.com with SMTP id a33so10210398pgm.5;
        Wed, 11 Dec 2019 00:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NsX+54XryMi2VELIlseSEX982HiAeN+ixQnkqnlA7YM=;
        b=LmSCzEKlLF9GA2NDPubkojoLRS1e9leBh1jLX86uZVx6zzLug+HCFJqv78bTvWeQ+g
         jKeqADdNLjCPNYb78KIB8IolMywHdHzgFDuqdtrTXlnwQMQ/r0xW54gkzlRpFwEQbYqZ
         stjB6Lp32jDGktWCXe42LqB9lE+Cg2BizkCyAFox+NMheVEt+/XJDUEA+TOs1xP2a9tn
         t3JJP8WRF/l48UiXw1RcvV650X2ryFnvl9Vstmk+BqjhdaMWyexnopBPg7lGbCNZLG7c
         SNp5xDwmmklLOIYTQNOHUBGJ51KL2d2H6JpMM2hz1kGtNDbPB8bH+Pft+0Vq6CEwiQ04
         T35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NsX+54XryMi2VELIlseSEX982HiAeN+ixQnkqnlA7YM=;
        b=lMNUY5wdY559lBdYlXyFjFdqQMEHWb5/rr5fQVJgXOSdajZKY2Zy50th554BsSJFRL
         enGLzQdX6E9BJ20gqKwSbhrx+CD0A8XPm1EcZEZyoXv4fNOYDXyd9B51xsd9W2WDpmSb
         ezkLbRMVn23vjndSTo+xEKWecfiOfUcmkRsfNNLZNg8/QF2E0kYud1uE4SUEDr4WVvh3
         lRRubNzVNqJZdfvuJ0Nwi95qsIE4MyJaYVHVVIFtxA4CqfFJiJplZxtb+kcI++x0w6Z/
         bKWEMg/DoNEqbqi/8jgwfe4pKv6YiIKs0a8UwmTNQVbfv7F2MR4ow92KVrsOdwfR1moG
         aOyw==
X-Gm-Message-State: APjAAAUXKiEk7OxCNLMxfUrK8fMFFd6dbOP40yoFRf7qZBX9tA6Rx23z
        0z0rHC/Y/kYb2VLsSLaC1Oo=
X-Google-Smtp-Source: APXvYqzJMVswmGLym+pZbQ6L9I2M3QaOEA5y6ogXLZGiNgCt//erJUC4U3w+uiICKuF3gfbZKbVHcA==
X-Received: by 2002:a63:d406:: with SMTP id a6mr2888017pgh.264.1576053703526;
        Wed, 11 Dec 2019 00:41:43 -0800 (PST)
Received: from localhost.localdomain ([103.51.73.137])
        by smtp.gmail.com with ESMTPSA id e16sm1806233pgk.77.2019.12.11.00.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 00:41:43 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: [PATCHv1 1/3] arm64: dts: amlogic: adds crypto hardware node for GXBB SoCs
Date:   Wed, 11 Dec 2019 08:41:10 +0000
Message-Id: <20191211084112.971-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211084112.971-1-linux.amoon@gmail.com>
References: <20191211084112.971-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the crypto hardware node for all GXBB SoCs.

Cc: Corentin Labbe <clabbe@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Tested on Odroid C2 GXBB
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 0cb40326b0d3..bac8fbfd4f01 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -14,6 +14,16 @@ / {
 	compatible = "amlogic,meson-gxbb";
 
 	soc {
+		crypto: crypto@c883e000 {
+			compatible = "amlogic,gxbb-crypto";
+			reg = <0x0 0xc883e000 0x0 0x36>;
+			interrupts = <GIC_SPI 188 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 189 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&clkc CLKID_BLKMV>;
+			clock-names = "blkmv";
+			status = "okay";
+		};
+
 		usb0_phy: phy@c0000000 {
 			compatible = "amlogic,meson-gxbb-usb2-phy";
 			#phy-cells = <0>;
-- 
2.24.0

