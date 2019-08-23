Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 511019A815
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 09:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405082AbfHWHDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 03:03:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52046 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405045AbfHWHDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 03:03:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id k1so7890183wmi.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 00:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y6OlL/eR9h1Ghc3Dkq2YBZdnDsKxiiGiMpQwldNFWsU=;
        b=2BMhpGV4rttepJcUT2dvXB1b06ryYYyen4bJHkUiI5sHw3e49HDqSL3QaWqKk6BSoL
         HOBVmHBBbNTqVMQQyQxkDtCyqXxTjgmyJpsziONpWxz9pjtbbeuR1oeMGaamdsWw8ixU
         j7U5hyLej/ao83Mhm+S4vaGsTqPSK4ZRFL1JJbX4P4C8PrQ8B15ebcV4bpDlt1ZhREx8
         sfxd15gWro4lsT3pMjDrh4Vl4VLHHv1Kdz3sNhqJ+AcRXZcH4AWZnDapyzZjEuqrBRiB
         0gOR0HSheZa6D0C8ZZHELom0N/K7XWnUtnPDIklurgcwHf/V8QHqphX90dAQo1JOzVRm
         mYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y6OlL/eR9h1Ghc3Dkq2YBZdnDsKxiiGiMpQwldNFWsU=;
        b=GEz0rlcorzVNEtxoikg5nUOQ1i/KBlhFoK1jPpvJD2sPXhThisiPGu+48oYASCGP2L
         XefWvonsGtsBSP6HRxBQOJMevl1clostHGT8/f5OpmSh1KqarY3rHZp20LqQLKhkuxkJ
         hLDzAB9HWW+sNGEM4onNOYqP3d9kARQIqCjmBE5JdVKULHwlvh2hnNwabhTxjYwnGIJr
         xawUdyAHEh40WqvZm1oygq7KQlxSlkJZ5LJUonI5PZ3MssVf/574gibzlZS2pTbvwJvs
         pDBi6zA/zw8bqcWeV1G9/REcfvcAlwPfjD7BHkkA5t+YcGsFOpdOIGzcvP1WejCrMA1g
         g/nA==
X-Gm-Message-State: APjAAAWq+Xs3so+didIKzDSi8icwt3tzqbf27gIgeZN4LqjgBzQj5UOB
        qKWUfv7J4pf5kkfstFTwuFEDvQ==
X-Google-Smtp-Source: APXvYqxtN07laBxLSGSpNPngo3T29VHr60UhoGb5uhAhV6UuO0Ye5M829fLDQKUyMxekNg94cOFQNQ==
X-Received: by 2002:a1c:541e:: with SMTP id i30mr3210905wmb.54.1566543784635;
        Fri, 23 Aug 2019 00:03:04 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a26sm1741833wmg.45.2019.08.23.00.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 00:03:04 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RESEND PATCH v2 11/14] arm64: dts: meson-g12a-x96-max: fix compatible
Date:   Fri, 23 Aug 2019 09:02:45 +0200
Message-Id: <20190823070248.25832-12-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190823070248.25832-1-narmstrong@baylibre.com>
References: <20190823070248.25832-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following DT schemas check errors:
meson-g12a-x96-max.dt.yaml: /: compatible: ['amediatech,x96-max', 'amlogic,u200', 'amlogic,g12a'] is not valid under any of the given schemas

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index c1e58a69d434..4770ecac3d85 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -11,7 +11,7 @@
 #include <dt-bindings/sound/meson-g12a-tohdmitx.h>
 
 / {
-	compatible = "amediatech,x96-max", "amlogic,u200", "amlogic,g12a";
+	compatible = "amediatech,x96-max", "amlogic,g12a";
 	model = "Shenzhen Amediatech Technology Co., Ltd X96 Max";
 
 	aliases {
-- 
2.22.0

