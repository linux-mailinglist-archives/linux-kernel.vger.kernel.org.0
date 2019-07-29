Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C48578CCD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 15:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbfG2N0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 09:26:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51919 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbfG2N01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 09:26:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so53867727wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 06:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R6hdLNTeTLszU/ud7dutUthDOGKXlHCQCe41wjZK7aU=;
        b=0nT0UBPaPJkbO96T/NeeoaVXvWJfeqkrgODoXD0hOabcIm/f2SKNcWdJ/jtQXajVGE
         sDwo4o1RVSOuR34im6wlMPfJOfqXGEg6MNUHLfbN0IczVG7hVswHO/ZZpUsu0QSWWQuc
         H+O+vJ3uOgaQGg9JudhYQT6tZ4PmKFssXJJqvA/UjVP5LG+UyB9PKv7MfSvmt9CHXsmg
         uvp9QYBO1D+9LEiLeSZIBvIrrGYQhcnpZXsE6deaCdxpXlzS8unPgG4d7o9JRkol8e/9
         rMmtBUzbQY4JALFZbzdZQKsSaB0Xh344gwxaYr4hVkcY9jXtPK2WpwJN9VxZdHmdGdbd
         VA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R6hdLNTeTLszU/ud7dutUthDOGKXlHCQCe41wjZK7aU=;
        b=gskyjOS8Qj/6dXYq7p1/nkUEXyZFcD6JplqhXNnlRMNcugygmJ59zEzTNvWW2koe8a
         XhzGI1WRXV3gZDWqGrG9fGd3ZaPzoM7M23ULZzhS2AF5GWbXyt0+N3hDkdiDZucA91M8
         5P8nKPxHPZ6AVdDmRmmMqESd07W4Gkb4ll93gN71rEaNja3Qw8QSIGtWM1HNbYpe5h89
         PKor/fIWbNX+9PGVw8tux84Jo9VkY37cFN7gzM83/VPVkyuE6X6jeAn8pRueqvQOsIBC
         V3aglh84vMS/W75XaDdlAb3MC5+76pCZrQZSyfkavKE9o43PenGUSjX1sxvdvEUn3VZ6
         0T9Q==
X-Gm-Message-State: APjAAAVZ1hpHtTnedtmv2eP3M05R0vl0vzWWn57lIxTqDkcg015cAgH9
        loR6oCgdjUsvX4pgCzVnZ/RWQA==
X-Google-Smtp-Source: APXvYqwHel1y9s9VMLRTKwHHIa1SbFDtk17K0BVQG+dg4SRlAeWevQDYthnrDjTJ9oF+jyOJSg21NA==
X-Received: by 2002:a1c:cb01:: with SMTP id b1mr30878151wmg.69.1564406786208;
        Mon, 29 Jul 2019 06:26:26 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y2sm50270053wrl.4.2019.07.29.06.26.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 06:26:25 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/6] arm64: dts: meson-g12-common: add pwm_a on GPIOE_2 pinmux
Date:   Mon, 29 Jul 2019 15:26:18 +0200
Message-Id: <20190729132622.7566-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729132622.7566-1-narmstrong@baylibre.com>
References: <20190729132622.7566-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ao_pinctrl subnode for the pwm_a function on GPIOE_2.

Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 06e186ca41e3..38d70ce1cfc7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -1970,6 +1970,14 @@
 						};
 					};
 
+					pwm_a_e_pins: pwm-a-e {
+						mux {
+							groups = "pwm_a_e";
+							function = "pwm_a_e";
+							bias-disable;
+						};
+					};
+
 					pwm_ao_a_pins: pwm-ao-a {
 						mux {
 							groups = "pwm_ao_a";
-- 
2.22.0

