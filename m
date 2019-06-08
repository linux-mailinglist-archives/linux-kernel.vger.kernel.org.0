Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCD573A162
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2019 21:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbfFHTEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jun 2019 15:04:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32812 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbfFHTEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 15:04:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so5328165wru.0;
        Sat, 08 Jun 2019 12:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aFV8wLAz1XUXEXzc85OBEqEUiMkenB8CQtS+Vt1/BiM=;
        b=W3GI02+AJAI/VaMVlY/zu2APCio3iURaaXWz00uebnZQF1i5wIck7r84AquCmwxoSm
         QVUQlITH04SsEk5yX4n1+Htt/S66k/8DnxhJT+Sj9JpTUeLmarHPrJyerC6uO4U7D+c9
         J9bEwz26MFRSk4K4LX/TvVmadvj7t+s/s/3HH1H/7RfWjKHe7yyPegf1WG7Nb/XAeoL9
         I1TkQgIozoFyBYKtBukYrp+Yg6NwDQA8pTvQacx3wup+DG6a2hAEcjA0ctQ8xZ6u1IXe
         xno9GYn9TZOBxaybhLSP6waj8uZcqRJoJL7xa2PTEX3AE7vOxbv1XKXC8iIl2QEIQIBE
         ExXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aFV8wLAz1XUXEXzc85OBEqEUiMkenB8CQtS+Vt1/BiM=;
        b=GS/XcVi+eY4i/u4eIZ3jrfWYILLH873W1NicfV1hf6eVDl3P/Z5rkrPnn5vGyz/SAy
         YDsWCGo8ZoFRY4S7TOfmtGugaCI/iTJ7RDUDoqx2JkOauJ9ceoie+PAf5+oNMmaBZd88
         C/FZvmz4jRAjc+nselkips/zVtKfCWfDILcqUV1uEL4X93KxLDkIvnVFDqyK4k3zwd9W
         UWvxa4wwSC/0uLDXWN+IBCYt9ZAYQrBaC4eC8jm/GPpc/s7N/g/QGswi6PqI05sRont1
         1dhvwfQwoTl1EbukkgVBm98DG0EIYx0vDadxcuTeqPDpSfqyLpkyKB836GOFXsk90WGY
         7ouQ==
X-Gm-Message-State: APjAAAWgw/q3Z8dB9OhcZcFBNRH9ir6PH9/oYeJ7rtoh+iHhzu8shMxj
        rlKwWbF0z4mePUsGFVIr1YoKUB7x
X-Google-Smtp-Source: APXvYqxeWMqj9C2OusCvfves/EELauA2ecBxZT6qIcQg37NCmz0ahYkESZJeSIOqrDaeXSF3C0s2Eg==
X-Received: by 2002:adf:da48:: with SMTP id r8mr18981182wrl.18.1560020660535;
        Sat, 08 Jun 2019 12:04:20 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA400D12EFF43FED1E981.dip0.t-ipconnect.de. [2003:f1:33dd:a400:d12e:ff43:fed1:e981])
        by smtp.googlemail.com with ESMTPSA id t6sm5655062wmb.29.2019.06.08.12.04.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 08 Jun 2019 12:04:20 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, khilman@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 3/3] arm64: dts: meson: g12a: add the GPIO interrupt controller
Date:   Sat,  8 Jun 2019 21:04:11 +0200
Message-Id: <20190608190411.14018-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190608190411.14018-1-martin.blumenstingl@googlemail.com>
References: <20190608190411.14018-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO interrupts are used for the external Ethernet RGMII PHY interrupt
line.
Add the GPIO interrupt controller so we can describe that connection in
the dts files.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 6aec4cf87350..50fcdb3e55bb 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -2222,6 +2222,15 @@
 				#reset-cells = <1>;
 			};
 
+			gpio_intc: interrupt-controller@f080 {
+				compatible = "amlogic,meson-g12a-gpio-intc",
+					     "amlogic,meson-gpio-intc";
+				reg = <0x0 0xf080 0x0 0x10>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				amlogic,channel-interrupts = <64 65 66 67 68 69 70 71>;
+			};
+
 			pwm_ef: pwm@19000 {
 				compatible = "amlogic,meson-g12a-ee-pwm";
 				reg = <0x0 0x19000 0x0 0x20>;
-- 
2.21.0

