Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 057BDE9B74
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 13:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfJ3MYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 08:24:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34093 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfJ3MYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 08:24:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id e6so237555wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 05:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MKCua1iUyxONn+bsOWnRZuMnXqiDfqvw9FIMx0dZRF8=;
        b=JeM5H6a2s+6CWd9XEIxYAUqb70ZFjnB/1nhiQCi/ckl5nLth712zbo3IvCI/EbsOLT
         MNm9i6RSPi8qZuw3Fx29Wrvnw6dItVeND28wsGa6nVBFppFShvdau60mMt27hcRSsxx3
         TPPUuFWN2fsM0QwdasBVpdXmw28Jt72mUY7pjeMqijG7P6S4mwnhR6wApD8+UnNQERPd
         19uy3WIVQJEKLb/e4h5d7/kZ5z/PBDN507ElNHDwBVdO5DvGT5hVFVtxlgObftxX2ZTW
         s9gUsc334wSJF47aiFdPg/Hj0ezaiJ4SlPjA4Yi4CM5YLW+8DZSOe3BV4itybE7pp0Nk
         Kb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MKCua1iUyxONn+bsOWnRZuMnXqiDfqvw9FIMx0dZRF8=;
        b=PPnsCixNYk+ihpraMQSlu7zjwlmYFeO39eIqlcZpoW9FcpHYlJ4ingVVjWQ5GSju2H
         DLntxj6jzmo6CAyy1TM5wfkafmrnQNfVA8AXxz89toHQOo7XarnruvdZ7U+u2qYZmZ3O
         NzmzvjKGiJjgg1+ZSHF7j6A7JAXhbl6TgxM1zyxoas2P/zAcp9wnit+0WPza0dagqylX
         FYb3tzvsHERGLAOuzjKNh0p9xmYyZlCJ6GjJN2t5lXZ3iS8vfC9l6izm81eXQLzX2jbl
         qkMMsyWZaO249dvJSxPYRSFG/wtfxhg4SmDeMKPvmACgykfKFndC1UDQL0XCtbvRV03F
         mwJQ==
X-Gm-Message-State: APjAAAU2iZ4euxjXOV0cd4Yz4lHvAk/DIaTwhVJ8z5yGdTGmb7nIspNk
        3dluvW0K3eS6M8g/NyhPqZVTBiZZvHI=
X-Google-Smtp-Source: APXvYqzeJed9goyylmqlOBs3LxL7op1lRQ9/rFSPpVdMhG8ysk+IWFKHtQYfDtxb9UaVHLJiJm/kFQ==
X-Received: by 2002:adf:fe81:: with SMTP id l1mr2930329wrr.165.1572438273075;
        Wed, 30 Oct 2019 05:24:33 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id p13sm2075919wma.41.2019.10.30.05.24.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Oct 2019 05:24:32 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     mark.rutland@arm.com, mripard@kernel.org, robh+dt@kernel.org,
        wens@csie.org, jernej.skrabec@siol.net
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 1/3] ARM64: dts: sun50i-h6-pine-h64: state that the DT supports the modelB
Date:   Wed, 30 Oct 2019 12:24:13 +0000
Message-Id: <1572438255-26107-2-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572438255-26107-1-git-send-email-clabbe@baylibre.com>
References: <1572438255-26107-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current sun50i-h6-pine-h64 DT does not specify which model (A or B)
it supports.
When this file was created, only modelA was existing, but now both model
exists and with the time, this DT drifted to support the model B since it is
the most common one.
Furtheremore, some part of the model A does not work with it like ethernet and
HDMI connector (as confirmed by Jernej on IRC).

So it is time to settle the issue, and the easiest way is to state that
this DT is for model B.
Easiest since only a small name changes is required.
Doing the opposite (stating this file is for model A) will add changes (for
ethernet and HDMI) and so, will break too many setup.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml     | 4 ++--
 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 972b1e9ee804..9a1e4992b9e9 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -594,9 +594,9 @@ properties:
           - const: pine64,pine64-plus
           - const: allwinner,sun50i-a64
 
-      - description: Pine64 PineH64
+      - description: Pine64 PineH64 model B
         items:
-          - const: pine64,pine-h64
+          - const: pine64,pine-h64-modelB
           - const: allwinner,sun50i-h6
 
       - description: Pine64 LTS
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index 30102daf83cc..f9070d9e6c43 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -10,8 +10,8 @@
 #include <dt-bindings/gpio/gpio.h>
 
 / {
-	model = "Pine H64";
-	compatible = "pine64,pine-h64", "allwinner,sun50i-h6";
+	model = "Pine H64 model B";
+	compatible = "pine64,pine-h64-modelB", "allwinner,sun50i-h6";
 
 	aliases {
 		ethernet0 = &emac;
-- 
2.23.0

