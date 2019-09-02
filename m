Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25184A4EF7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 07:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbfIBFuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 01:50:01 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37200 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfIBFuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 01:50:00 -0400
Received: by mail-pg1-f195.google.com with SMTP id d1so6892212pgp.4;
        Sun, 01 Sep 2019 22:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bEt/v03msRhcSdb84WAU8NHWudPBzPmtzl8y/Hh3kS4=;
        b=WMJhAxPoJN8DisxWl5waf30CVRgh8kXpifzL/ZQZvj1CU37xonIlh4EjK8nqXOgdru
         4UOSWWA40MXJ7llJBClZ+d/IdMWlXLpjY1Al7ROmfHu+NTQqXcek8AoEPmfUdsSVrX5Q
         QRLYuwRoHzo8cDyTfn9ojZ5xuOHDrY4pnH8VEA1/lQ0C8xYyuoBNdXLtAY85scCMFfij
         M53oi19xU0GthorbJYhBabIsArXAA9CQUuftZ+CyfDUEj5GIZx98URVtCXFaepwRgMhA
         R1LZljKZ//WCeqs575PuMzJaSb5mjzHRtcOo/ZUALQJ24bP/pdqEzsXd1O+eb1/iyBlZ
         ACdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bEt/v03msRhcSdb84WAU8NHWudPBzPmtzl8y/Hh3kS4=;
        b=CkdRkLm7dhyAYnWEiTtq10aewzlSzGNPuEl2to76f9eHAFXcEfHbfqS5v3hSe2AZvx
         uyXWed/BLqxi6YhvKX2aUOGaVtSnUVgIaPNhLhLOgOZwMw/5ZJcMQA+M5/4BohbDVka/
         dG6QEOXhXsv/YCS81PKByus0L+zX5Ns/AZgXfeHQG1tFxGO5d8dne5Z1wErrVQ1m+OmL
         8OQKGTVS3CwUQC+HyDcGwzhRBvcDXK02gOQyDuufsiufYRxbonPPG4nTp+hDPcdvbX71
         WW0dta8+zWdSAUY2mCzo9GoDoRRM6K4aaGzAcNuowsyUR/EQ2XgHkOZ1DfG2Ftbx+Ovs
         sTCQ==
X-Gm-Message-State: APjAAAUIZ7WS+Fg3+Qppk/d/2smwbVwB4bDNlruVPm/Ke8TA9Vq+H+A4
        BpWA4YXFH9/QanqX5qiydso=
X-Google-Smtp-Source: APXvYqxAONevxOs+Hkw8NzwlLEpAGF1KjUE5QTW87zosAlr+KlXZG8qaFyXXXByHEzhUij/y1LvOtQ==
X-Received: by 2002:a62:6801:: with SMTP id d1mr31832332pfc.117.1567403400103;
        Sun, 01 Sep 2019 22:50:00 -0700 (PDT)
Received: from localhost.localdomain ([45.114.62.203])
        by smtp.gmail.com with ESMTPSA id 136sm16533912pfz.123.2019.09.01.22.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2019 22:49:59 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCHv4-next 2/3] arm64: dts: meson: odroid-c2: Add missing linking regulator to usb bus
Date:   Mon,  2 Sep 2019 05:49:34 +0000
Message-Id: <20190902054935.4899-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190902054935.4899-1-linux.amoon@gmail.com>
References: <20190902054935.4899-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing linking regulator node to usb bus for power usb devices.

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Re-base on linux-next
Added Ack from Martin.

Changes from previous patch
[1] https://lore.kernel.org/patchwork/patch/1031243/
split the changes and add the comments to power source
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 0cb5831d9daf..d4c8b896dd26 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -36,8 +36,15 @@
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 
+		/*
+		 * signal name from schematics: PWREN
+		 */
 		gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
+		/*
+		 * signal name from sehematics: USB_POWER
+		 */
+		vin-supply = <&p5v0>;
 	};
 
 	leds {
-- 
2.23.0

