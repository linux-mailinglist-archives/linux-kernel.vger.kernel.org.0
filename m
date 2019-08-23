Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB1359A826
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 09:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405031AbfHWHDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 03:03:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40164 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387550AbfHWHC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 03:02:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id c3so7598795wrd.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 00:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z/b1mhikbg+EPmNH/s2Xt1LyR+vNVX1tk6yq7Qa4/MI=;
        b=nOu1hJ2wwRA59HSMRqpTfcIiHiskYmD68/3tC7t8v4OpPhcAvKvuh3bNdLHQK0POnp
         FhtFeuTMXCkb6SSnCYDrKkGQWN31zpRQAsntyWJmIRqsansJmJB8bL0MtDAVYFsYc7o1
         dvHMX9GWDaWycAn4GP5zXKfxylz7pfrp1pGOyGK8fEQaNUufNuiDe0nFGiKTV6dfIR/J
         hrJB3C4I5O8R5vc88faq+kMormgsNPzuYggeAGBmwqnFIADMqfAG0whVOW8P9WUP1FKO
         WhA/+NDagtIQ8/3s0OLrXUZLfMOR13KWND700Lgyev7nWSNwhB+v0ziUWpu1IkiqjYN/
         MWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z/b1mhikbg+EPmNH/s2Xt1LyR+vNVX1tk6yq7Qa4/MI=;
        b=ErNycP/6Fdpi2MRv2xBuCwlsbFdhU5tlzLxDEKp/etA7U3dBnieqEArA9G7DNqHx3c
         H3NJnvleYm9hSS95gC8sZMC3bSSFSWyAFCdTZkel3+Xra1ntFSTv7NHeb1rCi7c9MacU
         xp6sKZHBo+TkId3Wba+t3kgAxmMd0eQ/6hEirqWWJqhW39SbEMrZuzoktW5Pm7wFPCdl
         1mik5DPEE2zqgExKrUNyPlp4UtbpgWLqolLyFRjNbFt/lETyUtrOSEOMhjlQEPoYgnNB
         mDH5GFXXRosiFzs5ws91011g/Hwcm7HDCylb0vzHCkrhLxrRuP4qcVAPeum5JMJwpsTe
         hAlQ==
X-Gm-Message-State: APjAAAUs8lyIyzwFK+thUYFaqFDek4l0RyZO45PBtPyH+q70bGe9jj0W
        8ckEPlu0SF0Z4uzxoK42jYTImA==
X-Google-Smtp-Source: APXvYqyuqMJL2L5NeOppIMame3Tj3HMfeW5/PBCBwC0GPH9k/60jj7yNgLoziG/B+Lt97Ilb64QaUg==
X-Received: by 2002:adf:d4c6:: with SMTP id w6mr3262263wrk.98.1566543776738;
        Fri, 23 Aug 2019 00:02:56 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a26sm1741833wmg.45.2019.08.23.00.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 00:02:56 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RESEND PATCH v2 03/14] arm64: dts: meson-gx: fix reset controller compatible
Date:   Fri, 23 Aug 2019 09:02:37 +0200
Message-Id: <20190823070248.25832-4-narmstrong@baylibre.com>
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
meson-gxbb-nanopi-k2.dt.yaml: reset-controller@4404: compatible:0: 'amlogic,meson-gx-reset' is not one of ['amlogic,meson8b-reset', 'amlogic,meson-gxbb-reset', 'amlogic,meson-axg-reset']

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 239ec08b3023..08c01e11ba1b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -220,7 +220,7 @@
 			};
 
 			reset: reset-controller@4404 {
-				compatible = "amlogic,meson-gx-reset", "amlogic,meson-gxbb-reset";
+				compatible = "amlogic,meson-gxbb-reset";
 				reg = <0x0 0x04404 0x0 0x9c>;
 				#reset-cells = <1>;
 			};
-- 
2.22.0

