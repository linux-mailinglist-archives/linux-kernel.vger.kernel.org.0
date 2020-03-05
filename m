Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC67D179E36
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 04:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgCEDWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 22:22:41 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38211 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgCEDWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 22:22:41 -0500
Received: by mail-lj1-f194.google.com with SMTP id w1so4396279ljh.5;
        Wed, 04 Mar 2020 19:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3mB+9DFC1lhPqKCLUg8wWNOr6OLdsbgJhYt45juNV4c=;
        b=ZBqRIV3mw57AzVzWvfRKqbJP+qj4XrMyTc3hniC+bx8+Agj8CUUIZ5v3MHzOTOhlyZ
         +9S6xfpvbS/8sDF/ipsgcmrHF2666OlRC53ZU0gxPEqxgdhcY6M3KUykkPsTtF1jWwMS
         fVGjiF0eyxO4DoUU4mrQ5SowuqCRSRDjX3Ho06fgKMcSyJkfC7YgbB+D8jQkmGWyAwUv
         VV+SGQD/cocVl9eJw65LLYSE2FXMN74/e8kmTTSqr4Us48ZQ1kvOWWuEPAx+64km0XRM
         bNFOhGCHKVVnXkvaArgsvKRBCGZR+sxd4urguclTv/DsGN7/PNiczl0XVZ0979C8s2kg
         /aOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3mB+9DFC1lhPqKCLUg8wWNOr6OLdsbgJhYt45juNV4c=;
        b=RDncERe5v7R2YewJtyCTz/VIo+DM59KLdB3GdE9rbluDBgE+aW8JmOdpcZa3KwCTk+
         DM9lQ/qWbH12fD/e0QpfmS3l4ozTmBa1ti4a9qONIzBlEabSGytZ67Y0cyIofyxEGyV+
         0A+0S0cJO37WXsnyV/7twstfEq1rwLk26VYDRlJkO5nh+2UKwIlCX88j13+VsNpLHjiV
         kfLyGNjTmNVdVUVlRbeNgQFj6MHPlrk3GgcZCc1b3LsRGVZdu9pE0p0FcIS57oXaMsLR
         20m7GCJQ4SvyJdiWtd0fU298fEBGpVlZPq3K46OlXEv1XLYYZgD8QoyS6pvIAmVvmVXd
         /ERA==
X-Gm-Message-State: ANhLgQ3vrsmUCEaVRCmmL7zjiamlabEp+BVJkPvQPEfWPhRr7gDoiP7k
        04YPVyFxksJjCBpYfyenc8U=
X-Google-Smtp-Source: ADFU+vsT8c8IQQAuagnGyzjVSQWhLBYwqhCPXVcX2ouaJon7zOHjLn7537bD/t2sH6K53/W2qY5BnQ==
X-Received: by 2002:a2e:9e16:: with SMTP id e22mr4067684ljk.220.1583378559246;
        Wed, 04 Mar 2020 19:22:39 -0800 (PST)
Received: from localhost.localdomain ([37.76.255.38])
        by smtp.gmail.com with ESMTPSA id u5sm2865688ljl.75.2020.03.04.19.22.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Mar 2020 19:22:38 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2] arm64: dts: meson: khadas-vim3: move model to g12b-khadas-vim3 dtsi
Date:   Thu,  5 Mar 2020 07:21:48 +0400
Message-Id: <1583378508-14312-1-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The common meson-khadas-vim3.dtsi is now shared with VIM3L so move the
VIM3 model name to meson-g12b-khadas-vim3.dtsi.

meson-sm1-khadas-vim3l.dts contains the VIM3L model name.

changes in v2
- fix typo in commit message

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi | 2 ++
 arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi      | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
index 5548634..2b2d72c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
@@ -8,6 +8,8 @@
 #include <dt-bindings/sound/meson-g12a-tohdmitx.h>
 
 / {
+	model = "Khadas VIM3";
+
 	vddcpu_a: regulator-vddcpu-a {
 		/*
 		 * MP8756GD Regulator.
diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
index 90815fa..0ef60c7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
@@ -9,8 +9,6 @@
 #include <dt-bindings/gpio/meson-g12a-gpio.h>
 
 / {
-	model = "Khadas VIM3";
-
 	aliases {
 		serial0 = &uart_AO;
 		ethernet0 = &ethmac;
-- 
2.7.4

