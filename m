Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A31DF7C0E4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 14:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387539AbfGaMOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 08:14:36 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37800 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729082AbfGaMOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:14:18 -0400
Received: by mail-wm1-f66.google.com with SMTP id f17so59590479wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 05:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4dhyanCajCoQ1NdrxY9RmPZmRRskdkUd8pA1FbO4zdo=;
        b=fYS3TgnwrniuqSiM6EH8XBX5NO0WHBVCvOQ0paEeMa5/j1L16S3eMBI475LTjoV8ui
         XZMH/qiesdnDqiwtIhyM1C2/aKEjieF90KHqB6+woi/R04pCoUA/DS7g8FxIvxCnVtge
         CGwXU2VF0b6n9CWoTmUCdsFiMDjRLlu5sziIWWZIkiHdyN0Y/Wsf0v2npxS2fT0fS+lM
         erUXS9kjSafOR4vz6DeIvqCDioiICAfx5E4DG2s8qQ9IObARQnUnjfv1c+5qN9fxljuk
         dnOaSG3+0/aKtms73knvFjaJth/VFSJ1fRgV96ir5bKG0YYN6P1Pt94Qm3nVEVGmD6W2
         8e7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4dhyanCajCoQ1NdrxY9RmPZmRRskdkUd8pA1FbO4zdo=;
        b=p9MxzuPVPcW9Yuf0BJ5T7LyHaI0CCliyNEEtO/0osFvExUUgHofqj8MLpY0zTeuaoM
         p5WRkZTBOEeeZbup2gTq4iErum9YgpG1wKoJem+w/7rtFQ/ruSwzmYUj+ioPKq6slK5X
         ddH2jzkgGo0DXXfyCGFRPhAXe377zCGBTx+m3OtvZfcE2DOXgPuPvBYcS2PJnBkMO1Zv
         J/ptDx/NtGJiNtgqhI75Ve0GXAQISDg6X2HRBQvmktlrIieq/OxM7C+W6RTR/7cQeZu0
         jGUDKj2qe7M0FLtc6YZ05VpbXbK0Kb+Py7sYt0N6SI93vuqGu+UiVt/3Vl4ka6b6+s5m
         299g==
X-Gm-Message-State: APjAAAXYhzTX8dpu0evMc09qFjSzxuwF1cgGjrhC3IvIMJZTbWDKe51s
        +tP71D8t6Jq7DMe7W3dpp9pX1w==
X-Google-Smtp-Source: APXvYqxRDiGgBTKX4OvpK3DPoOUb/3Cu6lXEUEkKcn4C86RVnIxo9nRbAkWga96jF5qAdQmTIoHbSA==
X-Received: by 2002:a7b:c251:: with SMTP id b17mr37174245wmj.143.1564575257149;
        Wed, 31 Jul 2019 05:14:17 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a64sm3613713wmf.1.2019.07.31.05.14.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 05:14:16 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     daniel.lezcano@linaro.org, khilman@baylibre.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/6] arm64: dts: meson: sei510: Add minimal thermal zone
Date:   Wed, 31 Jul 2019 14:14:07 +0200
Message-Id: <20190731121409.17285-5-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731121409.17285-1-glaroque@baylibre.com>
References: <20190731121409.17285-1-glaroque@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add minimal thermal zone for DDR and CPU sensor

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
index c7a87368850b..79ae514e238d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
@@ -33,6 +33,19 @@
 		ethernet0 = &ethmac;
 	};
 
+	thermal-zones {
+		soc_thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <100>;
+			thermal-sensors = <&cpu_temp 0>;
+		};
+		ddr_thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <100>;
+			thermal-sensors = <&ddr_temp 1>;
+		};
+	};
+
 	mono_dac: audio-codec-0 {
 		compatible = "maxim,max98357a";
 		#sound-dai-cells = <0>;
-- 
2.17.1

