Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D21CC12A55A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Dec 2019 02:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfLYBG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Dec 2019 20:06:27 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40725 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfLYBGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 20:06:25 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so3510686wmi.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 17:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G4iZPYSHcETHrh5Mkc153Wxpky0z21UUEkDTh50Atls=;
        b=msRtbZFynJxyeGYd1lLRmtThZVgLm2dEpIET/tJJqL5w33Yudoh1KnAI1z44ZUCWTp
         xfufU2VgGKTFimD++HDIvcWWQR3OpZB7AgJRoxq3fNf7Ln/ggHPZTHrk+WwEPdIRNeZu
         +xLf1p+b2bOs8UbWJ9s6M8XNAEkfZbJPCdf6frKrEf6HlfBAn0PSKAaZscsdrtItC+dB
         zRermTHOfe0Vk2AfNHPwJKJsbRrXD4ZGEFJaWBHMzc0/ezn21ZBi+2rkJ6lC3xHMaX6a
         zkKUrI7kSAt4tpv8DxJVICRBIwZgUjJes8tlIe7yNyJhHIyxkLf0foj1DTnc8K6siX4R
         Xl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G4iZPYSHcETHrh5Mkc153Wxpky0z21UUEkDTh50Atls=;
        b=d4l5xbXBbO4ll42uKQRkEpYNZzSG6wJiitW9nlCaqz1qukJYqFt61tK5PshTZHjfDH
         Z3xgJHb8xu8VaTerQdpF9fox7J8x0cSQyXm+sFWNIEZqqnjE4LjCVkPbxl5YKv13MzXI
         HBoYuHo7Lvo9zCACRZrvZDOyGAb6p27+dKHtP9mzoIpBLPhH2dzfmXydfeotUnVPWjPf
         ClRfJC2YlgO3kt1BQRrmlnczuYdlqGRSIxrmnoK5tNCdsQcV3m+VCf1aMqBd9Q++AOWK
         rUGgcNhItqhSJmo3Hn6mu2rfZuBOgjRtZA+dhyasWvHtGo/ntAfkfrFJQktixx4HyDW3
         BUUQ==
X-Gm-Message-State: APjAAAU8FVCaWuikg0pl4b7senOW97Xkz2Jx+b1ktnDGYfgXKjoPwcqV
        /NAaMYxICNNSV+lvV3t+w9w=
X-Google-Smtp-Source: APXvYqx49sT+9J+WOgr59XRUu/8x5Jzm+pok9R0Glahlhx8JQErqlHoMTLJicMdzR504M8AdRVZ4Dg==
X-Received: by 2002:a1c:5419:: with SMTP id i25mr6508859wmb.150.1577235984382;
        Tue, 24 Dec 2019 17:06:24 -0800 (PST)
Received: from localhost.localdomain (p200300F1373A1900428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:373a:1900:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id x26sm4066127wmc.30.2019.12.24.17.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 17:06:23 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 3/3] ARM: dts: meson8b: use the actual frequency for the GPU's 364MHz OPP
Date:   Wed, 25 Dec 2019 02:06:07 +0100
Message-Id: <20191225010607.1504239-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191225010607.1504239-1-martin.blumenstingl@googlemail.com>
References: <20191225010607.1504239-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock setup on Meson8 cannot achieve a Mali frequency of exactly
182.15MHz. The vendor driver uses "FCLK_DIV7 / 1" for this frequency,
which translates to 2550MHz / 7 / 1 = 364285714Hz.
Update the GPU operating point to that specific frequency to not confuse
myself when comparing the frequency from the .dts with the actual clock
rate on the system.

Fixes: c3ea80b6138cae ("ARM: dts: meson8b: add the Mali-450 MP2 GPU")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 5b5791924753..e34b039b9357 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -126,8 +126,8 @@ opp-255000000 {
 			opp-hz = /bits/ 64 <255000000>;
 			opp-microvolt = <1100000>;
 		};
-		opp-364300000 {
-			opp-hz = /bits/ 64 <364300000>;
+		opp-364285714 {
+			opp-hz = /bits/ 64 <364285714>;
 			opp-microvolt = <1100000>;
 		};
 		opp-425000000 {
-- 
2.24.1

