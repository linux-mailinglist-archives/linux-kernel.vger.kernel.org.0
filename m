Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 604BF9D794
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 22:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbfHZUos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 16:44:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35520 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730446AbfHZUoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 16:44:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id k2so16604625wrq.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 13:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E/rktgRZOj4ajpikVv+crFkgra/A+VXyEZXp2OkGiIA=;
        b=vFprOVQgqZZeaPGJRKWqtJlyJWWYc41QHKy3hDxXhTuDk2oleQKX7dQolHl7/Oxuru
         5hkxV/8bVU6PBNELYJclSf2uFdJbSDT3kbZdZZFx7oCl8Y2hQ5eX6vS4a0MJkOxOrdj0
         6WIsVdZZx+C1dr5WnFF16NeyqAi2Oclo02KxSKJ3ShiuCOXP02Y5Vwo91UuO0voT8DZ0
         rGsFr9zu2P4Qt+H+BlZUhItrQu+SEO/H2H7t0hOKKwc7zY+uxXrBeG/+KopHS5j63Tbf
         zc6OmQktG7Q6E5Oj5EnTVV3DUm51dcEipqvTf9NuLebRYDVlOwVFKrvblaQz/WTIo58a
         /36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E/rktgRZOj4ajpikVv+crFkgra/A+VXyEZXp2OkGiIA=;
        b=Gx3HMuPdhBh7ZSjimhxba1cuVHA+7mSJsh0sBXy/oYUW5zcyr/tB2KJTuSbQXf3cl/
         2ioM/te/OcyxeHCzw3b2jeajJde8B1w8g0ifz/nLa3NWPZlWkM1hgZQ/4IeYwU92y6ki
         gGySlNfBO3xCSGHHiHh+zd0SXwnJM1o01v1wjEuk13NYt7jYSdNAFm5jJM/uHmTSuPg8
         VmSWstntHxr3BgJ41aLQuX7NORyxbLs7+kIx7/uKoluT3pRYOtW0CBRrjHVe1W5/ps5E
         c6//SL+STOvGKDiGUA/D+qa4G700BE6FsqyPJdQG+rSLEo2Pr10VTdt9OykeOnYpK1o3
         HJZg==
X-Gm-Message-State: APjAAAXQ9hxfDwtj+ohnxKhjn5ma51FOq1nQ0Sdk2vpz/xk9p1bMn0u2
        oBrnV+man7d4Llrnigpn0mn4cg==
X-Google-Smtp-Source: APXvYqwrPcj7Q2zz31NQ98L1E4NhW094ay+Ifj4n9fBNDxdH95mhUc+hr94YfFHJaxmEzKz5xIgF/w==
X-Received: by 2002:adf:9e09:: with SMTP id u9mr24766472wre.169.1566852283910;
        Mon, 26 Aug 2019 13:44:43 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:f881:f5ed:b15d:96ab])
        by smtp.gmail.com with ESMTPSA id 20sm549557wmk.34.2019.08.26.13.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 13:44:42 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support)
Subject: [PATCH 03/20] dt-bindings: timer: Add missing compatibles
Date:   Mon, 26 Aug 2019 22:43:50 +0200
Message-Id: <20190826204407.17759-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190826204407.17759-1-daniel.lezcano@linaro.org>
References: <df27caba-d9f8-e64d-0563-609f8785ecb3@linaro.org>
 <20190826204407.17759-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

Newer Allwinner SoCs have different number of interrupts, let's add
different compatibles for all of them to deal with this properly.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../timer/allwinner,sun4i-a10-timer.yaml      | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/allwinner,sun4i-a10-timer.yaml b/Documentation/devicetree/bindings/timer/allwinner,sun4i-a10-timer.yaml
index 7292a424092c..20adc1c8e9cc 100644
--- a/Documentation/devicetree/bindings/timer/allwinner,sun4i-a10-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/allwinner,sun4i-a10-timer.yaml
@@ -14,6 +14,8 @@ properties:
   compatible:
     enum:
       - allwinner,sun4i-a10-timer
+      - allwinner,sun8i-a23-timer
+      - allwinner,sun8i-v3s-timer
       - allwinner,suniv-f1c100s-timer
 
   reg:
@@ -39,6 +41,30 @@ allOf:
           minItems: 6
           maxItems: 6
 
+  - if:
+      properties:
+        compatible:
+          items:
+            const: allwinner,sun8i-a23-timer
+
+    then:
+      properties:
+        interrupts:
+          minItems: 2
+          maxItems: 2
+
+  - if:
+      properties:
+        compatible:
+          items:
+            const: allwinner,sun8i-v3s-timer
+
+    then:
+      properties:
+        interrupts:
+          minItems: 3
+          maxItems: 3
+
   - if:
       properties:
         compatible:
-- 
2.17.1

