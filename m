Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0489D175AE8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 13:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgCBMye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 07:54:34 -0500
Received: from mail-pf1-f173.google.com ([209.85.210.173]:43628 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727627AbgCBMyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 07:54:33 -0500
Received: by mail-pf1-f173.google.com with SMTP id s1so5529015pfh.10;
        Mon, 02 Mar 2020 04:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uMxGOYQ+JxxN+O1T925iEJ5h0tLf69vjSjHFydFp+AE=;
        b=enXtbT3e+ROcThYr6oVqVBI/HVigs5WOu1/ul3YLMfB3mIdmxS1CxpT7IEA7njxp23
         TQuVb6j2tl5NF7O61Rs268ipaiymB86PQAOD9213Ot1w4PoF/bJY7KeBtsJ6TQTqK1Ol
         oCYlRxZJvMwX241uJ+6vAew3YJwZnlGpOQGFoyLXO1s0MsuX9zoxRGk2wO+s5nY50G8q
         lgTMAAhwJBXR89m0STTfq+JAab1TZ1iVb5sX6GBWwMH53KDsoO/GgcuCaE4+jIVpg0wd
         5ZF6YyLqpQByc10K8yK0MoA88WsgWn9KlHUPhIHxgqAhXK3EeC4Ksvovmhg3C2E69aIs
         DP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uMxGOYQ+JxxN+O1T925iEJ5h0tLf69vjSjHFydFp+AE=;
        b=uQh67voi36WQMb0MOW9bCtVKgIVsd40kOnSqgEr86IW5IicpBGe5uNNMXXy0DgzNSc
         vAq/IGb+Kn+afL/eREVTQwJWoNJ3+wIf55wZwNgjKzBwnhKHSXAJ9og5ur85bW+w6WeP
         MMkvahSjolASW3oQ8feuWLtXajh6jb2KUZ9AY+JM5M5HMvGjJZ3cHcAfpEwj6Iok7ZK7
         fKOWr2KVw163Fni+5pLhyjn4q9HKzkc7tFo+unNJnxwh9hl6+3w+nUamrqrF77X7IOvA
         yOeVcJWH3Ez41wY4D8QqGzJbbIkWIjxZxbiaxaV2cMfGv00ljLeJgosftrkG/JQ8I5tf
         z8EA==
X-Gm-Message-State: ANhLgQ2N1flupMB3Ha9btYxgq/pWtdla/zdWpDbh48KOm918DiPBdg+/
        AZIq265pYF/hmMRkB4VhXdk=
X-Google-Smtp-Source: ADFU+vv8UO5DZUj4Cm2KLq9PeaLrwLT/JEJcifzctp/QmapoHpejSvulRH8fj/9l9BGFUuZfvFAWJg==
X-Received: by 2002:a63:ce4f:: with SMTP id r15mr6183820pgi.400.1583153671525;
        Mon, 02 Mar 2020 04:54:31 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.208])
        by smtp.gmail.com with ESMTPSA id p2sm2138238pfb.41.2020.03.02.04.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 04:54:31 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCHv2 1/2] arm64: dts: meson: Add missing regulator linked to VDDAO_3V3 regulator to FLASH_VDD
Date:   Mon,  2 Mar 2020 12:53:08 +0000
Message-Id: <20200302125310.742-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200302125310.742-1-linux.amoon@gmail.com>
References: <20200302125310.742-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per schematics add missing VDDAO_3V3 power supply to FLASH_VDD
regulator. Also add TFLASH_VDD_EN signal name to gpio pin.

Fixes: c35f6dc5c377 (arm64: dts: meson: Add minimal support for Odroid-N2)
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Previous changes:
	drop the logs comments as they were not usefull.
---
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
index 0e54c1dc2842..fe5680411c07 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
@@ -54,6 +54,7 @@ tflash_vdd: regulator-tflash_vdd {
 		gpio = <&gpio_ao GPIOAO_8 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 		regulator-always-on;
+		vin-supply = <&vddao_3v3>;
 	};
 
 	tf_io: gpio-regulator-tf_io {
-- 
2.25.1

