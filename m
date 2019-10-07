Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80527CE2EF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 15:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbfJGNRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 09:17:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35114 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfJGNRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:17:17 -0400
Received: by mail-pf1-f194.google.com with SMTP id 205so8671441pfw.2;
        Mon, 07 Oct 2019 06:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c9wnC908x8Dc2ovfvaEIwhdZFAXDuGhcSt8cyx50jRo=;
        b=YwWpqvPJtwEpzVZMlfk5DEXF+OvWK+s+K9aWVNRyvA/uzd2w3N0n9BHxibOLIGgpCX
         9s8gt/Ru3gD0HTSBH79mBN6zJfcBsR1iQ19s1RSO5KuCIerBSnosMeqwsQYIRuBfTSXt
         j9T/Yz9zT2f7e2FZas6Li+b3i3O304LBu65wWHGUf3iPY9tpKo1A7BmKhE8d72L+DWyg
         eriv8XF4lneIamLiwQvSHqWgp1QOFDQLtjY2faLQJ7gARQ0Q4+tXv2n1rHX8XgwnEtBo
         OMWuoj+Nw7ehynSS3DSR1pNTu8PGFdRVBl9m3yZPZx6xSlPYFLILx+mxq+dAcu0Q6DBo
         smBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c9wnC908x8Dc2ovfvaEIwhdZFAXDuGhcSt8cyx50jRo=;
        b=OXoCIp8g1jlAG4bGa58BGGkhX2gPXrWBZD4iHQp/E8eWhj+Lu83ZN1tcMgbro7vrY5
         ZVVjxrQblfLF2t0ikqIIKlqSUTWSs5wEMWkF5gNjlAj0DMbl0EmXQbjtL2kTMpxUSb7G
         5vWJ//1Qre04wZZLOxJYCmc14z7D5LscguPmumfo6yaBVFm/TkxQr8kZcD3BY0w8nrMm
         V+vKEIAqwTPr/l5OlMMNO7d4vBoMeaq74RqXtyhTF+mnsf8eEQkR+xw2yUecyTZ/zP6/
         ro15lmfGirzW3ua2p8RPdT5W8uHjLZP+8YKw0qXhYKgcisqA4inyaDgSje/y4Es/oiJs
         9Hfw==
X-Gm-Message-State: APjAAAVd5dZc1q0f8v8LeExRLQv93Pqh23XL3BWB9K4XOZZB0zENh3Xy
        Zsy/DHxvPqk4Qyyhvz5K7p8=
X-Google-Smtp-Source: APXvYqy6LK+V/L4wpvKfrkRzRZD8R95qPwJMkTBR0Y0ZiyfkdL06PzRvWTUvyg1QUlf2W/7+0HzEIw==
X-Received: by 2002:a17:90a:2744:: with SMTP id o62mr32896684pje.139.1570454236533;
        Mon, 07 Oct 2019 06:17:16 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.138])
        by smtp.gmail.com with ESMTPSA id r186sm16938650pfr.40.2019.10.07.06.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 06:17:16 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFCv1 2/5] arm64: dts: meson: Add missing pwm control gpio signal for pwm-regulator
Date:   Mon,  7 Oct 2019 13:16:46 +0000
Message-Id: <20191007131649.1768-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191007131649.1768-1-linux.amoon@gmail.com>
References: <20191007131649.1768-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per schematics add missing VDDCPUA_PWM and VDDCPUB_PWM
gpio signal use to enable/disable the pwm regulator for DVFS.

Fixes: d14734a04a8a (arm64: dts: meson-g12b-odroid-n2: enable DVFS)
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
index a9a661258886..66262a6ab3fe 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
@@ -135,6 +135,8 @@
 
 		regulator-boot-on;
 		regulator-always-on;
+		/* VDDCPUA_PWM */
+		enable-gpios = <&gpio GPIOE_1 GPIO_ACTIVE_HIGH>;
 	};
 
 	vddcpu_b: regulator-vddcpu-b {
@@ -154,6 +156,8 @@
 
 		regulator-boot-on;
 		regulator-always-on;
+		/* VDDCPUB_PWM */
+		enable-gpios = <&gpio GPIOE_2 GPIO_ACTIVE_HIGH>;
 	};
 
 	hub_5v: regulator-hub_5v {
-- 
2.23.0

