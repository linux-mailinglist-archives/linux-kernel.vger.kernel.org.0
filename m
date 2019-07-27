Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2540C7789D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2019 14:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbfG0MNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Jul 2019 08:13:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40887 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbfG0MNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 08:13:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id r1so57019808wrl.7
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 05:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5qILRtduAUfIHbRYJc2OqUYhBvVLfrX/ZR6fVK293Dg=;
        b=OMghRo1khsXGsH/E3U8li8QeP9nGMpoQ9pv8NdPqjMB11WNhVxf0zBgRIA5t+7cSE/
         CiL566CDiElHLOqEQkSY0JUFMUZbo+BL0oS/AAAqjq+hHV5tREnSs6Gs5rCv9g23JxQJ
         3n4dNgJ5IZrjjena3mYsGgu4L1ywaQAjFhaKaubM5KIZHt+SD4h+HtCgyNJhrlA4VlxI
         3hWTX3sFLoAsvdzLjlxs3CSjq71HDgET2c0K/RCjy3f2JKmzV1dYwWIIE5iPkxNzaWwy
         CZQiXrOyaL+p5v9lP4jPT7Cuz00G39ecfbKPyVh1O2sCsbrwelERx6vOC4WkqV1re5Ei
         C4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5qILRtduAUfIHbRYJc2OqUYhBvVLfrX/ZR6fVK293Dg=;
        b=b57J+9pxdEYPdn1mx2rq8s9xWTTlBiOs7d/c36BAwfh5gEGuss2DjkpXU+SLJKl8b6
         uVJlORXfs7SxfM/21jnmpVgcrfSwZC5tKjvT213KqNQKCzWNpjjZRsgIzUE1vPEOdwIv
         5qLntNolTOlJ7P+k8G3NZ4/LiWbEKFmi46TzIf6NxQ3B1JbBXYH9ujRHVku9LBPnIGuq
         2L7d+F7wWdAODfIqt+Uor6aw/jFSlGwNRYiwMgs/OwHDp1yrjC/zTeIlACZDA/SkGrvN
         FrwlMdGh2SopVHbAf6NAVIdWsPBspYeEYdY3KIJomndX5O18GZiOMs9iIZfP20zwm8vV
         xqww==
X-Gm-Message-State: APjAAAWfhUG8+M24v8RoC1exJ4vf++KSRlxN0eeJNhwjmcKkqUyiEviA
        ne1g4KK2XJF6KiT84P3eVjI=
X-Google-Smtp-Source: APXvYqwNsLsnl3W1cQVmOuElc6fGGraRV+A5W8UDKBaaQI954FwVDQ69i9eU6haQms0rDvfSR4mkLg==
X-Received: by 2002:adf:9ece:: with SMTP id b14mr59108580wrf.192.1564229584036;
        Sat, 27 Jul 2019 05:13:04 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133C65C00B418D0F4A25A19EC.dip0.t-ipconnect.de. [2003:f1:33c6:5c00:b418:d0f4:a25a:19ec])
        by smtp.googlemail.com with ESMTPSA id o26sm111786569wro.53.2019.07.27.05.13.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Jul 2019 05:13:03 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 1/4] ARM: dts: meson8b: add the PWM_D output pin
Date:   Sat, 27 Jul 2019 14:12:54 +0200
Message-Id: <20190727121257.18017-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190727121257.18017-1-martin.blumenstingl@googlemail.com>
References: <20190727121257.18017-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PWM_D output is used for the VDDEE PWM regulator which supplies for
example the Mali GPU on the EC-100 and Odroid-C1 boards. Add the output
pin the VDDEE regulators can be added.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index fba2c70c2fda..30fca9bb4bbe 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -361,6 +361,14 @@
 			};
 		};
 
+		pwm_d_pins: pwm-d {
+			mux {
+				groups = "pwm_d";
+				function = "pwm_d";
+				bias-disable;
+			};
+		};
+
 		uart_b0_pins: uart-b0 {
 			mux {
 				groups = "uart_tx_b0",
-- 
2.22.0

