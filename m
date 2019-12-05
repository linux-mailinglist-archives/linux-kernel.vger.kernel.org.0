Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D86F4114156
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 14:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbfLENTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 08:19:05 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40223 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729466AbfLENTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 08:19:04 -0500
Received: by mail-wm1-f67.google.com with SMTP id t14so3627353wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 05:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=KAcKcn55ZC43+JsoEE9iyrk0uGRkJUBkt2eSWXtjjKo=;
        b=z/AWAzgTX0lOM8lIimEzXZL7Es4PlvY117PPDM5y91/gJWLVNvax+sEu/s82VqZ440
         vob2+6JF+W81MIZk3BFY/ujYte0tJHFGvhtjsJ5aQEWgBRhGSLcBSpMPJyxTH/Z1X1wm
         02JNXm9nfzqxdBG2ZUDfHA4bYU4Z9seReUmQGXD6yvef5qFTp3K/NHLw03EmWKng+OYB
         ontBzr7W7OIfSh22VzC3Q1DBGidUhES8jJ10tkL2Jk9xhtWlPeVTP5tuHfQCgFUr2Y/M
         5LY1e+Ee7pi1Gkz2fx2dcPuClzq1yfjFK+JzEslYStsNBxf3B5kNQXPyK5M2/8/7eBr6
         LUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KAcKcn55ZC43+JsoEE9iyrk0uGRkJUBkt2eSWXtjjKo=;
        b=TyimPDUCzWiwak9SNy7fMvZOLXciCbH2/tHtkQ3WJa2SmIeXPSPOcTxcnxs8tJLlcP
         vFCTlrVFZyZJlMBybyIZMJv4WaiQ2BylXe05I0oXSqeuHZ/F7fXgsFoO+q6ow0R688lV
         1EZV5012IrCNyS2OOTgkNEHcw3LJud/mJmQViqLJNp8N3LmRUE/maS6yMADQ5U24IR9+
         96YlvTQoKIk6b1OPM58nUbK7Z2LSmls6460oQP58YeQRJj43aH1TQTRLGkgO8/ULa7vd
         hw9FQCFJzVx5TB4q578tJx+C00OOORiIhe3tJ/DKmVsHc3w+SrhCd21U88YoKWqC7avq
         RrRg==
X-Gm-Message-State: APjAAAWl7GLgECT+1t9RFfGPTBtusrwEIcZ/zrNT+hqQRb5EiZ+Hckxn
        aAUVCilkvxusXfhlUVFsikAmIg==
X-Google-Smtp-Source: APXvYqyZesiIZmY7RGMT4MF4IpUnHfAqJR6vCTBVsLVzWRfkp34Mu3brQAC1PF+x3trPEIdHrmPcdA==
X-Received: by 2002:a7b:cc0c:: with SMTP id f12mr5122129wmh.5.1575551942365;
        Thu, 05 Dec 2019 05:19:02 -0800 (PST)
Received: from glaroque-ThinkPad-T480.home ([2a01:cb1d:6e7:d500:82a9:347a:43f3:d2ca])
        by smtp.gmail.com with ESMTPSA id c4sm8333656wml.7.2019.12.05.05.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 05:19:01 -0800 (PST)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     khilman@baylibre.com, devicetree@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: meson-sm1-sei610: add gpio bluetooth interrupt
Date:   Thu,  5 Dec 2019 14:19:00 +0100
Message-Id: <20191205131900.2059-1-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add gpio irq to support interrupt trigger mode.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
hi,

this patch depends of 
https://lkml.org/lkml/2019/12/4/644

Guillaume

 arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
index 2c90f4713d0e..a8bb3fa9fec9 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
@@ -591,6 +591,8 @@
 
 	bluetooth {
 		compatible = "brcm,bcm43438-bt";
+		interrupt-parent = <&gpio_intc>;
+		interrupts = <95 IRQ_TYPE_LEVEL_HIGH>;
 		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
 		max-speed = <2000000>;
 		clocks = <&wifi32k>;
-- 
2.17.1

