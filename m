Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACA142C0DB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 10:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfE1IIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 04:08:10 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33315 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfE1IIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 04:08:06 -0400
Received: by mail-wm1-f67.google.com with SMTP id v19so1644175wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 01:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rWm2X3Q1SHaRgDsfdal1fBD3D11iGm4q8VAE3tF/iqU=;
        b=ctHKr1LQXJ5vP+6axdeIJ+V9sZIoJ9v88fbLhQZM9CKzXmPKQkACV1zNcuL8tJ3IMJ
         Rr1DCS+lh5kGaXqFNvk4djnFFALMezxEZjRxbuIis5bBwJNUlvWtFRKK/uEn+zW4Zfac
         L/TZNlxszvAq6Jn66/fzhWOKX8AgMU/+O7Fg6qXA8O85/VeLQYdT23bxkLcEZqM9gH3Q
         YtpcVM/waV9YLR+yD5a9vPmygzJqf9NIxa0BxO6+esIKwmlSMws8naJIAxCgVGEko01O
         WuEoHz98UtI3LtPrzzfxG4Ka6p4Usy5odhD69vW4wg7uEuxnAa8uyOb+m3GqJDGe9saZ
         W8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rWm2X3Q1SHaRgDsfdal1fBD3D11iGm4q8VAE3tF/iqU=;
        b=FuO668w4H48AXcAm7TjEyn6WfG8P1ngMXcbFOoexhXLZ7G7vHF04Jus0WFObHRAjvo
         juYIunf/vQyTxx7JMaRm69SGl4nIaQIK/hhNVqsaIqb2tpreP/Yw62z6hDwHMC+dJ7Q/
         rcz0K8aw8WJZL6Loy0PyEV/oFxn74OSyGfRswstZoVZnRYY0ilabszlLr42S9vQMaFo8
         HtvllTJlDTuuvdsUwwUzwAPAKRLV2+5Wj290UANUaZg9dkfY8SN0XL9ArMck8Dp5Jema
         /1REdsn5ABx9kppG8kYBQLfMe/tNPX1oSrENOZAGgj32tzWh4VfA/6B8VpSGYmnf0aoE
         SmFA==
X-Gm-Message-State: APjAAAVayqAkaE4ud7nbIkha74aJcEZA4DAedfnu2miI3TocJWN/Wt5/
        DDZ8tTB988D+Rz8t0u/tsssxLg==
X-Google-Smtp-Source: APXvYqzCHJkvZAfJYctRLpCtxU9n2375PkWPEqPrqBU3t5zIM3N2tH7wsQ+C3uBM9n1nB4lMzlNv4A==
X-Received: by 2002:a1c:2109:: with SMTP id h9mr2249738wmh.68.1559030884486;
        Tue, 28 May 2019 01:08:04 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z74sm2456121wmc.2.2019.05.28.01.08.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 May 2019 01:08:03 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 1/3] dt-bindings: clk: meson: add g12b periph clock controller bindings
Date:   Tue, 28 May 2019 10:07:56 +0200
Message-Id: <20190528080758.17079-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190528080758.17079-1-narmstrong@baylibre.com>
References: <20190528080758.17079-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the documentation to support clock driver for the Amlogic G12B SoC.

G12B clock driver is very close, the main differences are :
- the clock tree is duplicated for the both clusters, and the
  SYS_PLL are swapped between the clusters
- G12B has additional clocks like for CSI an other components

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
index 5c8b105be4d6..6eaa52092313 100644
--- a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
+++ b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
@@ -10,6 +10,7 @@ Required Properties:
 		"amlogic,gxl-clkc" for GXL and GXM SoC,
 		"amlogic,axg-clkc" for AXG SoC.
 		"amlogic,g12a-clkc" for G12A SoC.
+		"amlogic,g12b-clkc" for G12B SoC.
 - clocks : list of clock phandle, one for each entry clock-names.
 - clock-names : should contain the following:
   * "xtal": the platform xtal
-- 
2.21.0

