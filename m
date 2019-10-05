Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2D2CCA57
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2019 16:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbfJEOT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Oct 2019 10:19:29 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45393 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727715AbfJEOT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 10:19:28 -0400
Received: by mail-pl1-f193.google.com with SMTP id u12so4521866pls.12
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 07:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j71JSmqo2p/lC+pVotGwXL+zyAoHaLpisutyi3M3xfk=;
        b=c+bNHX150ih1LLE2k5LrQDgeo2hmhkZLqKyEExZX/B9Swz4KTLiOD9Tf1g9nTLGKsa
         YqPTXWFZnLndq79saXmDqpW7gRgHF3ZqVz6kDb/BW0O0RXfwr0kO947ZodH7f5X2p4c5
         fgCyZ0HJsarIkoZGz+CU1cmFxaXs0+2q01eB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j71JSmqo2p/lC+pVotGwXL+zyAoHaLpisutyi3M3xfk=;
        b=RLIY0nPJU6VK+WrG1Ebdv8rGTKJEUI1RSiNkVqdQ9BdOwr9r7Sg6nG/zwiQa3tHfe7
         Z5EiouaYESI1LGwfjxoMKUzCI/lj//vrBgRuRoRFxkWvPMECjn/wGw+rHoG3y3DWFDml
         uJR3v6dL/KXwXxcGdnK7I/HN2OpbD6jmwygHixf8pAkTz1LXjIrqDIOOrun7Vq1ksOUh
         jq6fgbpdIREQMmELtWxEzXsrtt/SSgc5VTXTvc1v04GtVFCPoLPqVFCEGR3r0LueScx1
         rEDVbqG0FDWNq4ZmfkANbAolEw7AbzTy/5qEqVaBw6ykMUYkCWViai7QKfPGXWrpJDrM
         MWJg==
X-Gm-Message-State: APjAAAWgTF7z1MowdfW9P2cxMbuNDHtMR/GLLzaJXPXAtLR3Jj/+dbcE
        DZfHAkTJ7DSri9W5jWeFUOkhlQ==
X-Google-Smtp-Source: APXvYqyUl411uM87vrRwvlJ+wF+fjjwaiPL9XpGjvqCaxZBcb4sTtYi07sCxLpjnKzSjOFwvn84EDg==
X-Received: by 2002:a17:902:b182:: with SMTP id s2mr20310966plr.219.1570285168104;
        Sat, 05 Oct 2019 07:19:28 -0700 (PDT)
Received: from localhost.localdomain ([115.97.180.31])
        by smtp.gmail.com with ESMTPSA id y138sm8977604pfb.174.2019.10.05.07.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 07:19:27 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     michael@amarulasolutions.com, Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v10 1/6] dt-bindings: sun6i-dsi: Add A64 MIPI-DSI compatible
Date:   Sat,  5 Oct 2019 19:49:08 +0530
Message-Id: <20191005141913.22020-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191005141913.22020-1-jagan@amarulasolutions.com>
References: <20191005141913.22020-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIPI DSI controller in Allwinner A64 is similar to A33.

But unlike A33, A64 doesn't have DSI_SCLK gating so it is valid
to with separate compatible for A64 on the same driver.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml        | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
index dafc0980c4fa..cfcc84d38084 100644
--- a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
@@ -15,7 +15,9 @@ properties:
   "#size-cells": true
 
   compatible:
-    const: allwinner,sun6i-a31-mipi-dsi
+    enum:
+      - const: allwinner,sun6i-a31-mipi-dsi
+      - const: allwinner,sun50i-a64-mipi-dsi
 
   reg:
     maxItems: 1
-- 
2.18.0.321.gffc6fa0e3

