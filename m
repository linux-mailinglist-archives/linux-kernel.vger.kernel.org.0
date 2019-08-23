Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C82399A81F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 09:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392554AbfHWHDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 03:03:33 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52037 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404994AbfHWHDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 03:03:02 -0400
Received: by mail-wm1-f65.google.com with SMTP id k1so7889978wmi.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 00:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zZM+2enzuUNFCA37SD/7zYxLMBFSG+C8Aa4ksqqieas=;
        b=RcHgUPSetZMb6XVkRBcbgGh3voKANG45YMVzzKFcBxplKZXPJ6qQ79gYxNulJpGOeI
         BpeCqli79E2juPK5/L3Oo09h3P+RbZKuC86ktySK7JHgQhx2cyDTYKiHBr58swEdihU4
         wIIPqLQXAHv5XiPJlJ1rdUXO/cESPQ3k5rg7NMeWBFFOYfwzy3HVS5RdopLunT/guGbA
         33wnYMm0Lg7o7sq2ToCZ7BymmWmuLbcbUAH/roNTnFvHR7OFtunORr5PVt4e+qyB/Z05
         MFFvG6SkRWCPKzHuZzUSdeSWgFEKv2fjE+0PyWUzi9buLFxuU06W9Q6rw+pLi+4916x0
         v8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zZM+2enzuUNFCA37SD/7zYxLMBFSG+C8Aa4ksqqieas=;
        b=ZkweoaJsIgWVNhkC6hI5zkRN26uckfGBiFdDwG27VSPuuVGQLd6acObggibYq0J/k2
         4tJE3lmupG9iOhVxhWG7OvBkckPeSY30sfSnM3lW1jwPUAJz8uIQc6zACUUlQuOKMyGf
         UPNQCwdQGAU1KAjtLpDd2Lqdgsv/bYozRMWpDNn97cxPOS0t6GwG6xSwiIkHLioOiQm9
         QOOX8M0B8axsXhnJ5FBOQlLiSpuHRaUq9OFejN/UVDS3czqJRfr5KREmCdUQrBalWpKE
         nHbEsJaOCX9zsDpMB0VbQ8qRjr/9WcA08og8PpM7EZ47hnoy1GFOq5d84tQnmFzyD6SX
         NsJw==
X-Gm-Message-State: APjAAAVRvKzqQ6aphQmmyXd6RF9ug9EXbxoMlCLs5KVE5Hxapfsqw8+J
        wRbaQrhGoEHJmbnxI2TCtH5bCbLboPci2w==
X-Google-Smtp-Source: APXvYqyk17sTfM7f3T7mT0ImLFGi8x3Ic4MHhGFXmX6vZ1hYbXK3bzb6MkvBUg/eQKrGDTAjN2YO8g==
X-Received: by 2002:a1c:5453:: with SMTP id p19mr3357995wmi.120.1566543780920;
        Fri, 23 Aug 2019 00:03:00 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a26sm1741833wmg.45.2019.08.23.00.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 00:03:00 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RESEND PATCH v2 07/14] arm64: dts: meson-gx: fix periphs bus node name
Date:   Fri, 23 Aug 2019 09:02:41 +0200
Message-Id: <20190823070248.25832-8-narmstrong@baylibre.com>
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
meson-gxbb-nanopi-k2.dt.yaml: periphs@c8834000: $nodename:0: 'periphs@c8834000' does not match '^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
meson-gxl-s805x-libretech-ac.dt.yaml: periphs@c8834000: $nodename:0: 'periphs@c8834000' does not match '^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 74a2cdff0563..6733050d735f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -451,7 +451,7 @@
 			amlogic,canvas = <&canvas>;
 		};
 
-		periphs: periphs@c8834000 {
+		periphs: bus@c8834000 {
 			compatible = "simple-bus";
 			reg = <0x0 0xc8834000 0x0 0x2000>;
 			#address-cells = <2>;
-- 
2.22.0

