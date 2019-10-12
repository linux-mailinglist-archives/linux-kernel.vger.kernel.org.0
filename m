Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCCB8D51E0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2019 20:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbfJLStm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Oct 2019 14:49:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43563 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729324AbfJLStE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 14:49:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id j18so15231416wrq.10;
        Sat, 12 Oct 2019 11:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GJDCD24q8FHHhxNDtUAkpzQYbJaDZYgAmYeaRlxpr/w=;
        b=UJ8N1YnyS5qFw+3hQ3wHH5qfKH2llANndMmxVbmKPRFZFunXLbuK+yD9tw96qzf0PE
         A/m0wISDjend/x20vATRDUG1JCXyrOYIj03D13PuaTDKLFnUuCPlSUhnsiC5zsNBsmjf
         mo2GoPkv27PlCPvWHWteG887VCHCMoLUOwiBggLgZFTPbeSwNRSUOnd0MbXcZ0wLvT65
         GJbc3aIp9DPxRCjJkTaweu1iaxBYYOjxlTAdT0ZMRdJ+c5eZZE0+4QsnFdMWvIcfgsWh
         atTuxyBXM2Ox6d7wdji6LRj0u0GszAubZBddCT7m4iFvlEmU+ZxQZ7qilVuyQL+8t505
         1wtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GJDCD24q8FHHhxNDtUAkpzQYbJaDZYgAmYeaRlxpr/w=;
        b=HK0rHGRtyEd+azZfApJSonON1sjzKUIYvOT6L4pg/sy0ZZdud/Gy0CGMy0tsLLE+qO
         7u87V9opR58Rf/CCN0CiaIB0v12sDjGzopL2RziwuzT5HpbROSYRVyd51swb6nxMx/ek
         f8rLD+MTENd4y8mskIFOIf1SNiIWF4gLdBw7IKFFy8QZyLcbyd4UQAJG+/hIRC0EwxyY
         TOHdB/jWhSUazB4N8cDlKdK1yCAl+9cX7OhMWfF705A68n7fcOB1UilvDDPlK5Yu5Cry
         xVho/XCtrhWR5sYMIuFMf11ulx0QKQ+Hqp8PAeTNSagxpHEoCtq1sJRu1A7wCF8BscIX
         i/aQ==
X-Gm-Message-State: APjAAAVYuh+7gd3VYUrWdYD5bAMaewr7wgVaPtiOz2+99CDwrx6VjGKo
        pb15F0I/hpe5aal1GkElhcIBXLM0
X-Google-Smtp-Source: APXvYqxnME26nF6TxFl78Rm1SskYXik1n78MVRjhh7ocTVWwXQmDS1/gxLMcjqW5qc6QHhau4k39EQ==
X-Received: by 2002:a5d:6581:: with SMTP id q1mr17970758wru.393.1570906142613;
        Sat, 12 Oct 2019 11:49:02 -0700 (PDT)
Received: from Red.localdomain ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id a13sm33670580wrf.73.2019.10.12.11.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2019 11:49:02 -0700 (PDT)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     catalin.marinas@arm.com, davem@davemloft.net,
        herbert@gondor.apana.org.au, linux@armlinux.org.uk,
        mark.rutland@arm.com, mripard@kernel.org, robh+dt@kernel.org,
        wens@csie.org, will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH v4 04/11] ARM: dts: sun8i: R40: add crypto engine node
Date:   Sat, 12 Oct 2019 20:48:45 +0200
Message-Id: <20191012184852.28329-5-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191012184852.28329-1-clabbe.montjoie@gmail.com>
References: <20191012184852.28329-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Crypto Engine is a hardware cryptographic offloader that supports
many algorithms.
It could be found on most Allwinner SoCs.

This patch enables the Crypto Engine on the Allwinner R40 SoC Device-tree.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index c9c2688db66d..421dfbbfd7ee 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -266,6 +266,15 @@
 			#phy-cells = <1>;
 		};
 
+		crypto: crypto@1c15000 {
+			compatible = "allwinner,sun8i-r40-crypto";
+			reg = <0x01c15000 0x1000>;
+			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CE>, <&ccu CLK_CE>;
+			clock-names = "bus", "mod";
+			resets = <&ccu RST_BUS_CE>;
+		};
+
 		ehci1: usb@1c19000 {
 			compatible = "allwinner,sun8i-r40-ehci", "generic-ehci";
 			reg = <0x01c19000 0x100>;
-- 
2.21.0

