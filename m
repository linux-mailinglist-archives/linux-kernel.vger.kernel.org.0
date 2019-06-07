Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4460A38D45
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 16:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbfFGOgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 10:36:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38075 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729720AbfFGOg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 10:36:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id d18so2425187wrs.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 07:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uNmSu3t0eQ+1oavLsnh0wBIiE+Ac7ZRJiZuct8dB414=;
        b=JuZ09n+jR8uN91ascpcUjzRt195iDXq3u5wnE0G5pRr7FuE1MqdCje2rZXrN+pGu8V
         UWkFmq+G0gAbJ3Yjp0Ft9CVrBrWuVNepyVkJHPB3ddsr6ulWnAXdedFXCDDcPWVXr60c
         WIV2PpI3Nav38CwvWH25XsDBlZyScH6jX7cZP8qxezS+YpPy+XjHfPkrox7QoaXRJQ+h
         VcphiFcErQhJxhrHtCY2OjLW60x1rrgw6lw8lBIv/AUj9YKhK2e9D19U7DJ3dYM/6FVS
         VRuRGrIE8RHndI3FprkBT3gzIoizI2XR61+QBqp2AQHON7aA4homOZqfqN/iTe7OVTwi
         6xKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uNmSu3t0eQ+1oavLsnh0wBIiE+Ac7ZRJiZuct8dB414=;
        b=q3DzEiDU66g5ZnfosvYi+XdR4v/l32cft5QMtlASIKmJsgW2AkzppXVPGTzTLUeQL/
         BzdxO1pIIYlf3qbGc+j7aPRmU/Nh5kVQmhd4MbyDnkNt2uAgdRtKEWDxQGShgYA6gfsY
         tiYz7CAZRskXpxf1Q50aoDhx8ajqLOWz6kmxrgEhpxbXMkizk+ch/Rh6fm8lxui70C/4
         Mmtrm0rFky2S59rt0vyxnzpsXZehNZ/bjjymKl8ZUa3ZA69mTVfePzD+e7Ja3goJshFX
         GABaZoBIR8D+9smO2XEz8evVsSjlJOyd3z5JOAXQNDwuxeQUxhf5Fe4OL6RkG0VAtYa/
         YZNA==
X-Gm-Message-State: APjAAAUTLHEmzYNXmMCKwaIKmhvkCEzakwL+ZY7I1m8+AZxbe+dgaQH7
        liQ5+ilnzTJ8S0CxmT1/FG5yzA==
X-Google-Smtp-Source: APXvYqyRTjuKUejtw/CpnhndB3HutsB4At+jy75Klf1cYI3Vro7bHQ3+grYE6mGUBYnEaB3ReWo20w==
X-Received: by 2002:adf:b64b:: with SMTP id i11mr33953671wre.205.1559918187019;
        Fri, 07 Jun 2019 07:36:27 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t63sm2999829wmt.6.2019.06.07.07.36.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Jun 2019 07:36:25 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 4/4] arm64: dts: meson-g12a-x96-max: bump bluetooth bus speed to 2Mbaud/s
Date:   Fri,  7 Jun 2019 16:36:18 +0200
Message-Id: <20190607143618.32213-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607143618.32213-1-narmstrong@baylibre.com>
References: <20190607143618.32213-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting to 2Mbaud/s is the nominal bus speed for common usages.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index aa9da5de5c2d..300c29dad49f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -206,6 +206,7 @@
 	bluetooth {
 		compatible = "brcm,bcm43438-bt";
 		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
+		max-speed = <2000000>;
 		clocks = <&wifi32k>;
 		clock-names = "lpo";
 	};
-- 
2.21.0

