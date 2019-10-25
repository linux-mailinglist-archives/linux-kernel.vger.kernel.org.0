Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B512E53F3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 20:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbfJYSvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 14:51:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45294 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbfJYSvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 14:51:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id q13so3471057wrs.12;
        Fri, 25 Oct 2019 11:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q+iACLBvw6hCCkNMWVDo9dYY6POCxwyjg5JBiN7Fojg=;
        b=hH3PiQ5/C4qYxSEafpBHVzLMCHo2J8w8CaFH8dzSqQ5dZQ1MdF+nCFkUgvxrVhHu8N
         6Pr0NJNWZh9Js2JvQrcAuP69DLEmY4RJL4gWcoK+FSrWyjs/h2iJc1laowwR21SEV9c+
         h+6quHN/6rLXtZjjds2vwt8sBLwdegz5sY3/GxPIltxQx5GkF9/BKHswcwmBOBwQeWpn
         e/D00AkZX6JGayCqws4pD6jJNusH42MeN+iFdJd3fV3tDxS25lziBRXb0x693TkEkijj
         LcCvy1j9ZnkYDKjrN/8Bt3rx6ZsgAclMOtJpyNI15d4GWcPH7L8YYqrFNLuuKARVPgpl
         GQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q+iACLBvw6hCCkNMWVDo9dYY6POCxwyjg5JBiN7Fojg=;
        b=R3NkAuCU5vOwfVVjMsHJxQu9emoyhNa136ZxFvT7K1T3sUszuZGQHKlMvaecxyTuSJ
         wzfIJfHgrPQY7G6/CDntPiszGlfbN+o+4I6HtcVFtJV2CR8vsb+dtx5XLeNErcaJkQby
         Vh+7cSYbDOucJ9a3uEwpbN2MPE1cxnIqQIIOckoQSjGaqPN4RS7OEhEEug+hf8dLMJO7
         igULcPB2KiMR4hv+lwGjbSZfd5ehiV0ZgaT6adfQ03tPIYF7GNRrSiCy7l5O/49yFBZE
         xYu+C2qsbIdDloK9Ktmzj1fsqk7HEVRf5av8ESUhP+Tpql0N9bSrhnHT/+lz/6dL9nG7
         9rzA==
X-Gm-Message-State: APjAAAUz5/XnIlJ6yAdOdRq1mg+q9/+s5bPzjqO4TQGIr+LQoc4+RM80
        qVq+jctouMgwwuO7axjosuI=
X-Google-Smtp-Source: APXvYqw6fwwDvCcymz+NQ1L4FhDY53LrjehhsmqG/5kU0ansV1t3WcjQGsP4tlyreAjV4OdTXN0m8Q==
X-Received: by 2002:a5d:4283:: with SMTP id k3mr4346397wrq.236.1572029497894;
        Fri, 25 Oct 2019 11:51:37 -0700 (PDT)
Received: from Red.localdomain (lfbn-1-7036-79.w90-116.abo.wanadoo.fr. [90.116.209.79])
        by smtp.googlemail.com with ESMTPSA id l22sm4821683wrb.45.2019.10.25.11.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 11:51:37 -0700 (PDT)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mark.rutland@arm.com, mripard@kernel.org, p.zabel@pengutronix.de,
        robh+dt@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH v3 4/4] ARM: dts: sun9i: a80: Add Security System node
Date:   Fri, 25 Oct 2019 20:51:28 +0200
Message-Id: <20191025185128.24068-5-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025185128.24068-1-clabbe.montjoie@gmail.com>
References: <20191025185128.24068-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Security System is a hardware cryptographic accelerator that support
AES/MD5/SHA1/DES/3DES/PRNG/RSA algorithms.
It could be found on Allwinner SoC A80 and A83T

This patch adds it on the Allwinner A80 SoC Device-tree.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index b5c46934b5b1..1d900f591d5f 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -457,6 +457,15 @@
 			reg = <0x01700000 0x100>;
 		};
 
+		crypto: crypto@1c02000 {
+			compatible = "allwinner,sun9i-a80-crypto";
+			reg = <0x01c02000 0x1000>;
+			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&ccu RST_BUS_SS>;
+			clocks = <&ccu CLK_BUS_SS>, <&ccu CLK_SS>;
+			clock-names = "bus", "mod";
+		};
+
 		mmc0: mmc@1c0f000 {
 			compatible = "allwinner,sun9i-a80-mmc";
 			reg = <0x01c0f000 0x1000>;
-- 
2.21.0

