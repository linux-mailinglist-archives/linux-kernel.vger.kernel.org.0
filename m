Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 914F420DDF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 19:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfEPRZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 13:25:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33106 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfEPRZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 13:25:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id h17so1905538pgv.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 10:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ousylPICmwH1og6gjNylTr7gaxUc1ig3ZdhjNRxPghU=;
        b=dgGSuA8VDPXv7Fj5Q5+ofTuWInUTRLCEGimaJ/XwDGZgH8iS5qpn3DIYuedOUERjIX
         TgF/rxteIL7Z4FgxhseTSJdM60kvzN7B9+j7MOUShrmdYPyIeiqsNXzbHYJYAtdG1MRf
         sXk2aqJnxCwgTHfdsfrBaJ3wtHTlqnbyhdVh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ousylPICmwH1og6gjNylTr7gaxUc1ig3ZdhjNRxPghU=;
        b=LGthnhpdfuATN6Q2Tm+J5AP5dszsKOVynjEyO+KWFgVX+5tDzk8JtiMkkihkZHchRP
         ZHRmRUAn5ubiK2JGKXIx4PXdy0x7KLAqFjDsfeBay9K1ZE2yFgYbpjWbZQ4Lv/B3NPZj
         CGQVnPRbsr2UMXAp7Tp7ph8tLEm73viXO+rzukemjqSTZPONFL2V392tnzY7oxmdT4BB
         Z9DBmsEMR6IARkNxkKTZaRfVd03aId2bcBjfckZ86N5JrIONzQ2jz8CaLIOv85/X4YYP
         v8m/ze7U9k1BA7HKpRTC9Io9UEK4MBeTc/aVm1/tdsz4k0Ow/2elTKDm5yGUqjpOCPyY
         zYTg==
X-Gm-Message-State: APjAAAVpefPrlNs5QUUQcmoiidggrYPe8TirtScoJ6W5g0rpkcxkao7C
        f0E2BQxRMJc5kfjuuMJw2LZB/w==
X-Google-Smtp-Source: APXvYqyRLtHHdZ/6gBoDhAq+Ft8DnEuAOLEu1Tag/6FSXqdLHOz2xTh+/UUVMzZ7Jib/lJnPD2TaUw==
X-Received: by 2002:a62:570a:: with SMTP id l10mr54993359pfb.151.1558027516911;
        Thu, 16 May 2019 10:25:16 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id f29sm17110563pfq.11.2019.05.16.10.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 10:25:16 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 2/3] ARM: dts: rockchip: Add #cooling-cells entry for rk3288 GPU
Date:   Thu, 16 May 2019 10:25:09 -0700
Message-Id: <20190516172510.181473-2-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190516172510.181473-1-mka@chromium.org>
References: <20190516172510.181473-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Mali GPU of the rk3288 can be used as cooling device, add
a #cooling-cells entry for it.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
Changes in v2:
- added Doug's 'Reviewed-by' tag
---
 arch/arm/boot/dts/rk3288.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index a024d1e7e74c..14d9609f0b15 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -1273,6 +1273,7 @@
 		interrupt-names = "job", "mmu", "gpu";
 		clocks = <&cru ACLK_GPU>;
 		operating-points-v2 = <&gpu_opp_table>;
+		#cooling-cells = <2>; /* min followed by max */
 		power-domains = <&power RK3288_PD_GPU>;
 		status = "disabled";
 	};
-- 
2.21.0.1020.gf2820cf01a-goog

