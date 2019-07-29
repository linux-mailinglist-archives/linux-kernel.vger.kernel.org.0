Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8011E78C94
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 15:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388050AbfG2NRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 09:17:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34857 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbfG2NRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 09:17:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id y4so61829485wrm.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 06:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ltJPPDWabsUlJorNT/pL+2/ECTl6gVgAMBWFdGaDQ84=;
        b=pVbiBPMm6SpLXIpX+IysAx+M7uYYiZVNUHK4cRqpcHT4bhslA9fb1WJdYavZyEaF14
         TttRxyNTWjKiIqvdRwzAND5beoTc63m4e36jXYVL+MLX47ItIFt7BPZulacmatmymlEX
         RrMrgBeQIu8+AVEy3dmmL2CIFYGA/+mwAPtBUrtiDgJ36sTXFhtLIpaIq2GlARknK9QH
         X4r2gXXGEUFf0BTmac0lvKalJhjAC0qC8O+V3EoTfdJv6pouRN+9wlfz+AfjInZAkYOx
         AS0DY+ed0wPnjfQLhaBS51YyK2oUWtav5L/mAcsXNpHCLrpz/JvhEZVoREK2RrL1iy8S
         Atgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ltJPPDWabsUlJorNT/pL+2/ECTl6gVgAMBWFdGaDQ84=;
        b=Euo78ac06pgXz7rtZItKBAwmsoK6+62uIgXbhSeWCNsi4wjdnYT/wz9kitNK4egPR0
         dKZTRzcHf13kXNg++mS1L3TDHvu/svCjdtfkG0CuhgXkxAmh+XK2VSMEGc4xgP2u/5dG
         94EADCwPSUo49lGv3zxnmwe+A1s8YSSh42+EIOpdn9MiYdqa3gl+/sD5U/CMdlOOpVOw
         KCQQbIB+GVkGkMN2h6L/4FNbKyymnOXqg0NozKRKGVVroECN2ZglNn44yo3pXDQu7BjI
         mC7Y6EbPKglz7s/73tc44qg488nhy7YRZoHlajMyZ2vhA/opQoEaE4q//ViqpaN3XOZO
         HlIQ==
X-Gm-Message-State: APjAAAWau80mmL/OZLrY5eOcNb/Eu9p+fmvpKMKjgsskYoIkE/tY9wLg
        zpoCgmctedDzlC3xsEu2troEAQ==
X-Google-Smtp-Source: APXvYqwryv/2IoM8ffGzyChl3S2d0DkZh7a8zvilEyFNjbR2pZuJzuKruegF7emcN7xLlzRI3SlLPg==
X-Received: by 2002:adf:f40b:: with SMTP id g11mr51785582wro.81.1564406222292;
        Mon, 29 Jul 2019 06:17:02 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id b5sm52520490wru.69.2019.07.29.06.17.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 06:17:01 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 4/4] clk: meson: g12a: expose CPUB clock ID for G12B
Date:   Mon, 29 Jul 2019 15:16:56 +0200
Message-Id: <20190729131656.7308-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729131656.7308-1-narmstrong@baylibre.com>
References: <20190729131656.7308-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose the CPUB clock id to add DVFS to the second CPU cluster of
the Amlogic G12B SoC.

Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 include/dt-bindings/clock/g12a-clkc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/g12a-clkc.h b/include/dt-bindings/clock/g12a-clkc.h
index b6b127e45634..8ccc29ac7a72 100644
--- a/include/dt-bindings/clock/g12a-clkc.h
+++ b/include/dt-bindings/clock/g12a-clkc.h
@@ -137,5 +137,6 @@
 #define CLKID_VDEC_HEVC				207
 #define CLKID_VDEC_HEVCF			210
 #define CLKID_TS				212
+#define CLKID_CPUB_CLK				224
 
 #endif /* __G12A_CLKC_H */
-- 
2.22.0

