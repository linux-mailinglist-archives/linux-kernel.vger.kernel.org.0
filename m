Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5F4C24346
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 00:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfETWA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 18:00:59 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43183 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbfETWA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 18:00:59 -0400
Received: by mail-pl1-f196.google.com with SMTP id gn7so3176417plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 15:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vtpw37UMclFgwsWmb0g3/F0Vs7Vu7ExQy0ncbvkEDZU=;
        b=EPZ0X+O4Hu/F2sATps1IWhS7QDdC7Am72erJCLSgGeemHLtkKl4v4yxKaEToIFQPwB
         N61A4R5TXNaf6/W06obkK79GwzeGrQB9FKapiEMCltkOH9tPsYwgegqkRv19LSHTA3AQ
         RB7232HKfLvJ0y1uqXxOZmTLCRdGvCWWqo4Cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vtpw37UMclFgwsWmb0g3/F0Vs7Vu7ExQy0ncbvkEDZU=;
        b=IcXV8nEaAQQtuCXcSUxAD2ngZFMjb6VYTUS07l2mM1Gg6ALww4VUETLIo4dfHebBTA
         zaXySjvSqNULn3yV2OB9n6isk1kBfP2+dNXN6Eaq1HzOKclqOn8p+jHvwLmaL494l+R5
         WuuXtL9/Z+2oM9/bc/KTcFyKhS+d+1ea883eTtYyOTTbyjhnabD+RoOLA7M7HzONzGRa
         gljRMVGhYWBxe4y6aW5vRzguQ1D16Ru0emA/H3O9NbZn/czpMD7B2PLFzkogzSq0TBfX
         TZw/Eau+p0EcRTwliZqNb4pIh9D2rhxYOJk+lpk7OcHyG+QkteJgkxvb/aY1E9cuZYkn
         H+Bg==
X-Gm-Message-State: APjAAAW/xed5G2jibmCllr+s8Y68eOJBQzvsGkgq5Wix9DVdj7HIzxGD
        hFKktEmNj09A8RJCMKy4KlOlow==
X-Google-Smtp-Source: APXvYqzLoewKhT1vDuz7GtTRsQScroD7YBJPCR6KbPfxnrP99Cz3ZYVhsa75U2HjYsoh8F23esun7g==
X-Received: by 2002:a17:902:aa97:: with SMTP id d23mr78594959plr.313.1558389658649;
        Mon, 20 May 2019 15:00:58 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id k192sm18805998pga.20.2019.05.20.15.00.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 15:00:58 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 1/3] ARM: dts: rockchip: disable GPU 500 MHz OPP for veyron
Date:   Mon, 20 May 2019 15:00:49 -0700
Message-Id: <20190520220051.54847-1-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NPLL is the only safe way to generate 500 MHz for the GPU. The
downstream Chrome OS 3.14 kernel ('official' kernel for veyron
devices) re-purposes NPLL to HDMI and hence disables the OPP for
the GPU (see https://crrev.com/c/1574579). Disable it here as well
to keep in sync and avoid problems in case someone decides to
re-purpose NPLL.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v2:
- patch added to the series
---
 arch/arm/boot/dts/rk3288-veyron.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
index 90c8312d01ff..ec10ce4fcf04 100644
--- a/arch/arm/boot/dts/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -174,6 +174,14 @@
 	temperature = <100000>;
 };
 
+/*
+ * Remove 500 MHz since the only way to make 500 MHz is via the NPLL
+ * which might be used for HDMI.
+ */
+&gpu_opp_table {
+	/delete-node/ opp-500000000;
+};
+
 &hdmi {
 	ddc-i2c-bus = <&i2c5>;
 	status = "okay";
-- 
2.21.0.1020.gf2820cf01a-goog

