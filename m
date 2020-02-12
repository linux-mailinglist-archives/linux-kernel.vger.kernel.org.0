Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 452B415A6C3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 11:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgBLKoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 05:44:19 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33590 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgBLKoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 05:44:03 -0500
Received: by mail-lf1-f67.google.com with SMTP id n25so1270102lfl.0;
        Wed, 12 Feb 2020 02:44:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dW/gtpmwTFw+oEFIzLCTetdu7jdvkgezHPX1Sr93TwA=;
        b=VZ6vSPQ1+bh+AetrOMjQ/4Gm4kyUD55HounmT4vy3toVjhbL0FNrU2NcB8FInoOUmL
         R6tIDImjmBb0l50ccGa9QvgvcZgyuiC0vckW+kNeVv22uWGLaLS5C3H6glaTSNDxfMr+
         D1yYT9o84o+J1Z/YSBakCsJ4vboXO2dBPz9Zi54ZpBgwEjsdKV3zMkfdrwbfLZDTYvjU
         ZA1uoRHH5J93ZC0/fBE5kwOKRqI60nGOt3VS/APWKkdC7in6STYjGTrvd44sG9mElcMU
         lvVppOTSaZ+2TgD267ZmgXns6M/Il0Qe6KlzjGSHe+fihuyyL3qmnZxjA5Ih6rrUKVUI
         nxxg==
X-Gm-Message-State: APjAAAU5WeS8P55hTEjT4L54VOsPZ74D/UPa58NHFpYlzx3NypqD4hLR
        IsX+EdsZlzyLlzI0Li+FZLU=
X-Google-Smtp-Source: APXvYqzLv9Q5S1c1DIe6LSv7xAjK0nV9/GigVpccCCM69py78gj1tLuTt8v/gphZF/9ei+4cDgjc9Q==
X-Received: by 2002:a19:23d7:: with SMTP id j206mr6361123lfj.108.1581504240882;
        Wed, 12 Feb 2020 02:44:00 -0800 (PST)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id v2sm95791lfo.6.2020.02.12.02.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 02:43:59 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@xi.terra>)
        id 1j1pUs-0005CW-7b; Wed, 12 Feb 2020 11:43:58 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Barry Song <Baohua.Song@csr.com>,
        Johan Hovold <johan@kernel.org>, Ye He <Ye.He@csr.com>
Subject: [PATCH 2/3] ARM: dts: atlas7: fix space in gmac compatible string
Date:   Wed, 12 Feb 2020 11:43:47 +0100
Message-Id: <20200212104348.19940-3-johan@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200212104348.19940-1-johan@kernel.org>
References: <20200212104348.19940-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the space between manufacturer and model in the Synopsis compatible
string in the gmac node so that it matches the recommended format.

Note that there are no in-kernel drivers that use this compatible and
it is not present in any binding.

Fixes: 153645b3e037 ("ARM: dts: atlas7: add lost gmac node")
Cc: Ye He <Ye.He@csr.com>
Cc: Barry Song <Baohua.Song@csr.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 arch/arm/boot/dts/atlas7.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/atlas7.dtsi b/arch/arm/boot/dts/atlas7.dtsi
index 92b00e4740f6..f1e8c772a59e 100644
--- a/arch/arm/boot/dts/atlas7.dtsi
+++ b/arch/arm/boot/dts/atlas7.dtsi
@@ -1333,7 +1333,7 @@ uart5: uart@18060000 {
 				status = "disabled";
 			};
 			gmac: eth@180b0000 {
-				compatible = "snps, dwc-eth-qos";
+				compatible = "snps,dwc-eth-qos";
 				reg = <0x180b0000 0x4000>;
 				interrupts = <0 59 0>, <0 70 0>;
 				interrupt-names = "macirq", "macpmt";
-- 
2.24.1

