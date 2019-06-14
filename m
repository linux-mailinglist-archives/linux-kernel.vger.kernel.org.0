Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 659C4464AA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 18:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfFNQoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 12:44:07 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42775 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbfFNQoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:44:06 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so1783495pff.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 09:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7rjQuB296hfp4qUoq+6jTshGIZnt17kv/able4oYgNY=;
        b=jcBZ6YMltICKDAXDCZu7yT0KHax9GStXh55CAzwxRtyM1XcvrLR4OeHIh+melge7j8
         8KlHTIWZZj09dAZONDclCazGOwpGX2wsWeiBI2/Z76lDWhXgfMlFtFx+bCcmcR6e1w2a
         il57TilFvp/301Ukd0ea7ssDIf2cdSg9z35GI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7rjQuB296hfp4qUoq+6jTshGIZnt17kv/able4oYgNY=;
        b=YsPDpg2lyd7l/QrTrv2yY2oyC8QCM4lNRS5IOWlTTXf76O382BPkaj9sh/oy/c5ui9
         83Dlk07V+wfMQN6j7BHQBrZYoEyRd+cTDOJ/YAnv8v5sG5a5v7MeWNUDSC+Km9wuvkyn
         /vQP5+d6F9CYGCmtW+2C5BjHkaf737dX4IsVDXQINQq6rvBsIebyYrPDTG2GjH9ndyAo
         g7Ytcl7wwfUHkKtTAWzY+OWiT+xutT1lDs4acFmafLZ/NY98sYfJ7QPafEBXsN/w+8DJ
         hb1INzq+XAOQ2IcwyGqnQqDBUYz77LHn1HyYMI3C/DeAKfwXzqXaxQl4RdPepG64xzCP
         IWVQ==
X-Gm-Message-State: APjAAAWEh7E2NNq9UC+EObAg5LDvU5q+rAEKFBnNT4A7nSbjHwWRP3/i
        mzy6QIFnZJ0WDmMyiSFPlnSdJg==
X-Google-Smtp-Source: APXvYqxP0WmrTVw50rx/FytEhR6NAKnXMvz/RCUMoTAx8wmz1g6jzNa4s+rIzY3i9D8U4EzfOzGmgg==
X-Received: by 2002:a17:90a:b00b:: with SMTP id x11mr12178417pjq.120.1560530645251;
        Fri, 14 Jun 2019 09:44:05 -0700 (PDT)
Received: from localhost.localdomain ([115.97.180.18])
        by smtp.gmail.com with ESMTPSA id 85sm1639583pfv.130.2019.06.14.09.44.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 09:44:04 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 6/9] dt-bindings: sun6i-dsi: Add R40 MIPI-DSI compatible (w/ A64 fallback)
Date:   Fri, 14 Jun 2019 22:13:21 +0530
Message-Id: <20190614164324.9427-7-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190614164324.9427-1-jagan@amarulasolutions.com>
References: <20190614164324.9427-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIPI DSI controller on Allwinner R40 is similar on
the one on A64 like doesn't associate any DSI_SCLK gating.

So, add R40 compatible and append A64 compatible as fallback.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
index d0ce51fea103..438f1f999aeb 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
@@ -13,6 +13,7 @@ Required properties:
   - compatible: value must be one of:
     * allwinner,sun6i-a31-mipi-dsi
     * allwinner,sun50i-a64-mipi-dsi
+    * allwinner,sun8i-r40-mipi-dsi, allwinner,sun50i-a64-mipi-dsi
   - reg: base address and size of memory-mapped region
   - interrupts: interrupt associated to this IP
   - clocks: phandles to the clocks feeding the DSI encoder
-- 
2.18.0.321.gffc6fa0e3

