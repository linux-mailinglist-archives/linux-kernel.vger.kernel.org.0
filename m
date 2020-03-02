Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17D631759DA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 12:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgCBL6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 06:58:21 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36220 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbgCBL6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 06:58:21 -0500
Received: by mail-wm1-f66.google.com with SMTP id g83so8192450wme.1;
        Mon, 02 Mar 2020 03:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+bOUkmuWmtrqLnmLhYcvBOjbDQxV1smzTu5vD7lLcDs=;
        b=sIzU5chb1GcVyQMtdhpn+YMKLwGB4nwgzWG4cTyD3MtUUTWThAccAtZgHBK2bvUasL
         R8Hbv6HtwejqQMuIQi1wfxlo+0bbSQMujWY58KyK2vyrPX1EdzYoYeRqnl+DsVKoNA2C
         gSFJd6WZtAo9jY3QDaXyVqLy7c/Lv7fjjA9lvu5SW03q6BkHXwJHqyaVkNm0G2zAvLSl
         TV5XCTgdRZ+MmZ/ZSS4mpaJx0+XPiVaeefJpxE/HbeQxRcZIqBQqzkDSGr2kFHMVBrVO
         TJ7LFy6gPcbPwtgaZ0LYmKTWqjRy4xVmEQGD7+FSkHJR37xQGgBwRKT4hgFWeRd7hKoY
         P5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+bOUkmuWmtrqLnmLhYcvBOjbDQxV1smzTu5vD7lLcDs=;
        b=i6s+DdP6BU7to5db4XFtZ9AomZi1kfytN9KPwRjPrTmpjiCWyBVGjeDokAgxpVhQYM
         KbSN7ZcWoAuzj64+r5ehfrPam6zvfarB5jXfclnELj30bcsJ3X9HH8LFuTJanfJksthV
         yzfDzYygukKjSfGg9gFCcTsIg3yMFrY0YBuGq4f2MCJ+hU3RdfNMDmJ6MmbB2u2gplfX
         Z/xm215V7bq/6MTHZpRCNJFaq99VDIoYaXiK6V0wOCCYEFniWPdZTBHD6+uejBPyk+d7
         3o3JKoD7DiCK5jdxk9i5bLU9G2/nt9qjXiKbWQ7s1K/ZqQQvxndfzlVQNPwE151uQr8Y
         2k9A==
X-Gm-Message-State: APjAAAWPQIQkNl/fuGywvKdfrQ1zNs5UVa+xbb1TK/iE5IF/khWNzwFT
        hA3vZDvlGnuc88K8qva38o8=
X-Google-Smtp-Source: APXvYqwn+pGS0GpOR51cYA0edtXDgnNHd3aAxUL57dOeGCuHOdepkQXfPsdL9BGqEiQLUUFCtRYQZQ==
X-Received: by 2002:a1c:a502:: with SMTP id o2mr12079496wme.94.1583150299586;
        Mon, 02 Mar 2020 03:58:19 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id o16sm12653303wrj.5.2020.03.02.03.58.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2020 03:58:19 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: usb: dwc2: add compatible property for rk3328 usb
Date:   Mon,  2 Mar 2020 12:58:11 +0100
Message-Id: <20200302115812.7207-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives these errors:

arch/arm64/boot/dts/rockchip/rk3328-a1.dt.yaml: usb@ff580000: compatible:
['rockchip,rk3328-usb', 'rockchip,rk3066-usb', 'snps,dwc2']
is not valid under any of the given schemas
arch/arm64/boot/dts/rockchip/rk3328-evb.dt.yaml: usb@ff580000: compatible:
['rockchip,rk3328-usb', 'rockchip,rk3066-usb', 'snps,dwc2']
is not valid under any of the given schemas
arch/arm64/boot/dts/rockchip/rk3328-rock64.dt.yaml: usb@ff580000: compatible:
['rockchip,rk3328-usb', 'rockchip,rk3066-usb', 'snps,dwc2']
is not valid under any of the given schemas
arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dt.yaml: usb@ff580000: compatible:
['rockchip,rk3328-usb', 'rockchip,rk3066-usb', 'snps,dwc2']
is not valid under any of the given schemas

The compatible property for rk3328 dwc2 usb was somehow never added to
the documention. Fix this error by adding
'rockchip,rk3328-usb', 'rockchip,rk3066-usb', 'snps,dwc2'
to dwc2.yaml.

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/usb/dwc2.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/usb/dwc2.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml b/Documentation/devicetree/bindings/usb/dwc2.yaml
index e95ba9373..e9f4cea21 100644
--- a/Documentation/devicetree/bindings/usb/dwc2.yaml
+++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
@@ -41,6 +41,10 @@ properties:
           - const: rockchip,rk3288-usb
           - const: rockchip,rk3066-usb
           - const: snps,dwc2
+      - items:
+          - const: rockchip,rk3328-usb
+          - const: rockchip,rk3066-usb
+          - const: snps,dwc2
       - const: lantiq,arx100-usb
       - const: lantiq,xrx200-usb
       - items:
-- 
2.11.0

