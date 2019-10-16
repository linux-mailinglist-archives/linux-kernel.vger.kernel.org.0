Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD510D983D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 19:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394088AbfJPRIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 13:08:37 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41433 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389259AbfJPRIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 13:08:35 -0400
Received: by mail-lf1-f67.google.com with SMTP id r2so18091438lfn.8;
        Wed, 16 Oct 2019 10:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tPzq/4pAdFPsSANJ/9NHJEoF3soP3uhPziVivyFbVzY=;
        b=p2tUHLOCFaKYtSzu+8kqWT2Dzna3tCZCKO0yQhQ0QcSNFhesJBaDW4i8xBo9fc8T3f
         g4eJS93zAfvcr0wQv321p5gCDYU8yH11j7caUaImTHabE7jMqFUhfsMfEfncCCqpvda1
         JxleoaFtrXcAMuQ0kM0H7K6Uh6gAE7Iqnx3mwfp69rfGBM6pO7eiVCa7GjaVPh5JmNON
         cnFSELeJrbWBRGjeHBuHMwLciJgxseg5AG5TFGnCrsxzIDYHgYDX4RSIahqW49/yQDuo
         gmMmpIVwBMdBUFEMHczk+8drg+XldueaYcTmFPEZ85TA3lhIOO/rfDiJle9687mWEZOV
         IMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tPzq/4pAdFPsSANJ/9NHJEoF3soP3uhPziVivyFbVzY=;
        b=iljaUr71jys+IFCwAOAFPNXheuVfDjM74YLoFe+FJrRNsMoe6DfGC6E1f6jPI8A+wM
         X3JYIZ3376Jnw/h/HebWpd1s2wIeNSOggESWJ0Wx8seFrsJ/TgZBOKkWB5gcP4t2hopf
         cxzQECCM4KoixApSmwq1k3uAVtP78A/9jktC0bU1CkMTyBEmzfTkcPzFMLGCJTMtNlMv
         GYdbD+DRUo4HNomwykf/dr2Bd6RdliFF+rI1YbvO8GjhTcF2dYGeR5vQCXmXihmDilSN
         aHz48+QGRNMSviHUVL43dftaOo4bvkTx0TQkNqba9+GyhS4i0r2LHsUJEr1CDdB6pWJm
         BgQw==
X-Gm-Message-State: APjAAAWwcJUhIXmokWcCtSiCK0vrtjpprv/Yr28wCvpbHgYBYTv8jlyD
        8N1DXkokVLhHbsb6eI+m2nc=
X-Google-Smtp-Source: APXvYqztlIKXFcwsX9T4q5xwz9eoGg3GnsOg0q124ETsT305HLl5q3GH2LzOddyA4J/Q6XbgkwM9Cw==
X-Received: by 2002:ac2:4830:: with SMTP id 16mr521889lft.35.1571245712219;
        Wed, 16 Oct 2019 10:08:32 -0700 (PDT)
Received: from localhost.localdomain ([87.101.228.250])
        by smtp.gmail.com with ESMTPSA id q24sm6299182ljj.6.2019.10.16.10.08.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Oct 2019 10:08:31 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 2/2] arm64: dts: meson-gxbb-vega-s95: set rc-vega-s9x ir keymap
Date:   Wed, 16 Oct 2019 21:07:37 +0400
Message-Id: <1571245657-4471-3-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571245657-4471-1-git-send-email-christianshewitt@gmail.com>
References: <1571245657-4471-1-git-send-email-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the rc-vega-s9x keymap to the existing IR node in the device tree.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index 43b11e3..0cc6d18 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -152,6 +152,7 @@
 	status = "okay";
 	pinctrl-0 = <&remote_input_ao_pins>;
 	pinctrl-names = "default";
+	linux,rc-map-name = "rc-vega-s9x";
 };
 
 &pwm_ef {
-- 
2.7.4

