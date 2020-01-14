Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A80C513AD6C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 16:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbgANPTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 10:19:32 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46927 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728753AbgANPTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:19:30 -0500
Received: by mail-pf1-f193.google.com with SMTP id n9so6712266pff.13;
        Tue, 14 Jan 2020 07:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pYLYIQ4AXwrDijnXG7fyC1V6sRvDJ4/R/roB4Qo6Zxw=;
        b=anhpgPS0TNrx4rscQ1fsJUX3ipjlnKo0kACDbboWahGlXANNmsDyqqaSOxvhUl6RKR
         Ix5h67Q5h2dXu309FdYQuqNKF/2z6nMXE4d1Ew3yGA0Xv3+EF9O8YDIt9H2wehmB5tG4
         rfYlxxmxvYSo7AikwOIDBPdLvU0mUBN0F3s5v66FuBOAVZDcmftL55Abq+kvW3QSMy25
         N7eWgHCXn18AIMtkrs9d3WXX387lsDiGgXZHBPTEhW+I+ajdF5+9ZZDuf22hB4oP06s6
         7V+hSGrEqKEdfXcEc+m2zKe0YxAg7V0IpXta41rH/enA4GIT12K4a7jp5OX0KqOg/zKj
         mWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pYLYIQ4AXwrDijnXG7fyC1V6sRvDJ4/R/roB4Qo6Zxw=;
        b=WCls411VwahBLa18GXB0rU/W0O7+ZLE97MnP3YGIXGoWYDKysqph9PBL6U3at8wT4D
         vMabqpV8tNGajLcr9lF6T8ZP7+9obKNTxy0VOb7+PQq75UajTBD/iHZ2x+jwGouSQj1/
         enFyFCoJDlfne1o9IKyq3Wbtuj+Dg3FDCByOteVsK7TJrqt+QfGfJU115qcVmuak7yGU
         9O8oQFtzSx3fd71rgtJ9naxk5LGyJTUdZOj8NSKZPyrg0LdwxYp5BuEFrMj+U2sS5ijZ
         fig2+DJkn996peR0reMY+KQIpr86/tEcS+HmD4KFGqLJCsi4M3cd8d5KaSvjVGTbQ5D9
         d2IA==
X-Gm-Message-State: APjAAAWF17hLS74jQDtFRkqnWP9YhG1M9QbzHADqi6eDqMoSMfx/n1e9
        jMlJ8W6eh8gSu7GTNJj9gKs=
X-Google-Smtp-Source: APXvYqwviDgHrH8oA4UwR2DqLHslkWeyWCa7d0tpYyg91c68HslBpCVNjqbP4sGBQUi0uuu8jAJR3g==
X-Received: by 2002:a62:a209:: with SMTP id m9mr25365455pff.16.1579015169572;
        Tue, 14 Jan 2020 07:19:29 -0800 (PST)
Received: from localhost.localdomain (c-67-165-113-11.hsd1.wa.comcast.net. [67.165.113.11])
        by smtp.gmail.com with ESMTPSA id 207sm18834425pfu.88.2020.01.14.07.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 07:19:28 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] ARM: dts: vf610-zii-spb4: Add voltage monitor DT node
Date:   Tue, 14 Jan 2020 07:19:04 -0800
Message-Id: <20200114151906.25491-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200114151906.25491-1-andrew.smirnov@gmail.com>
References: <20200114151906.25491-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a DT node for various voltage supply rails connected to SoC's ADC
for voltage monitoring purposes.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/boot/dts/vf610-zii-spb4.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-zii-spb4.dts b/arch/arm/boot/dts/vf610-zii-spb4.dts
index 77e1484211e4..55b4201e27f6 100644
--- a/arch/arm/boot/dts/vf610-zii-spb4.dts
+++ b/arch/arm/boot/dts/vf610-zii-spb4.dts
@@ -42,6 +42,14 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};
+
+	supply-voltage-monitor {
+		compatible = "iio-hwmon";
+		io-channels = <&adc0 8>, /* 28V_SW   */
+			      <&adc0 9>, /* +3.3V    */
+			      <&adc1 8>, /* VCC_1V5  */
+			      <&adc1 9>; /* VCC_1V2  */
+	};
 };
 
 &adc0 {
-- 
2.21.0

