Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1286B954F9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 05:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbfHTDUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 23:20:05 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38008 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728647AbfHTDUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 23:20:05 -0400
Received: by mail-pf1-f195.google.com with SMTP id o70so2448735pfg.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 20:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fh6tIiEv0zJCLKpGDGUD3lhAE/UdGuL0cohxSYv7X6Y=;
        b=bQ0Dfme4RHc8MbBQdhndPG7oN46WssQZ9776bzrfeF2+bZI3N0ScdM2tX7ddr0gh/0
         AXQdtH/sADUXENW1Vo9FtE4j/YjibXaQ8nQLdgV5YrhiQ6go6725QFh1U+nUMJf7dL7t
         Fa3Qo2p8Jm8WuEzQCIQ98nCj5kgnhNzYh1eYRs8UY5LX/BLFBwU5hOVr5LAjfFkLvLPq
         oCn2UrJCygQKR3LRMke9vlfzJqpMUW8J+DKzD9XHCeK8ge0xgl7q8Sl1v2XXkW3x0/mg
         Ec9tXygwNpqbwckNKOHAn0Svb7p5+T4GF/LfxwxW0gGryFjM3b3KjLMRq+eFBCvBwmLi
         5Wxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fh6tIiEv0zJCLKpGDGUD3lhAE/UdGuL0cohxSYv7X6Y=;
        b=cAP120pvWHME7alxwEv6+nk69vqrTGdwpDSuRLCVGtqS7dy2s281yuWfLO6YU33pfx
         /I7kyisgGMos13zWXhGzm9RBzq6wGfJ1gjI3kCnCuqbVLpe3LvX6/mzOoGHHNyFnBDKG
         flZZDrXAE5rF2UrSCvbftATI0er2WBIIN7zt1G8B5+2h0FaBAfjTWEY5klpkmJ5yRj12
         CcaZwiM8EcVIjNUQE46paNLtkeairM9LjVnnrmx/qnkh9OyAlJ+TlqJowZsm7+VQZ3ag
         cKKcSMGICjYXpXsnuy1BzOgsyiQ6f4kxIYO175GO3UWw0Xh+r7BdXb0F3/RMfnQ9ZaaR
         FGaw==
X-Gm-Message-State: APjAAAWCDYi893xVg7HAFqm6ugLzybah0pUcj1K3tGWMeRAXyBushy+/
        otGb+q9bknHqTTR0sS88Afw=
X-Google-Smtp-Source: APXvYqwxADzQNLa+SFEuwXalUyCiVcCEzis3PXmwQrsbtrNme0Qotb4Ol3qYKYuWxkTnBA/ZpsqkOw==
X-Received: by 2002:a17:90a:2ecb:: with SMTP id h11mr16861705pjs.108.1566271204531;
        Mon, 19 Aug 2019 20:20:04 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id s67sm16155665pjb.8.2019.08.19.20.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 20:20:03 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: vf610-zii-dev-rev-b: Drop redundant I2C properties
Date:   Mon, 19 Aug 2019 20:19:52 -0700
Message-Id: <20190820031952.14804-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop redundant I2C properties that are already specified in
vf610-zii-dev.dtsi

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
index 48086c5e8549..e500911ce0a5 100644
--- a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
+++ b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
@@ -323,11 +323,6 @@
 };
 
 &i2c0 {
-	clock-frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c0>;
-	status = "okay";
-
 	gpio5: io-expander@20 {
 		compatible = "nxp,pca9554";
 		reg = <0x20>;
@@ -350,11 +345,6 @@
 };
 
 &i2c2 {
-	clock-frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c2>;
-	status = "okay";
-
 	tca9548@70 {
 		compatible = "nxp,pca9548";
 		pinctrl-0 = <&pinctrl_i2c_mux_reset>;
-- 
2.21.0

