Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 542D9D88F6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 09:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389870AbfJPHHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 03:07:53 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35901 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389242AbfJPHHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:07:52 -0400
Received: by mail-lf1-f65.google.com with SMTP id u16so3931917lfq.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 00:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C5W4rfltqSQyC6633naN9KjlUdmam1uxpZxtzibKLXI=;
        b=kJgCFEaSbYOV78577b0Ifo8DUmHrNrAiSODv6VkpiQ4SsErZ0fDKXWgP+lG+SP68U1
         g2+OJWELlDAWIyzUEeuYCzDkjAIq9q3NuZlY4+DKZHtzZyJpUo1TEJQ5Fze/xCow80pj
         ddwFOQnF3LNlQLSb4GW3fvmmKlH+76ebwhYkbd6muLw/S8pnBs6XTXIiqSZvknfgaFlO
         XmbwblaP0FEOXpl45+rSovSa7Yo7izxRSGTPovF4k2LamxPDIM3EfkqVC3khx+6jqAmm
         PUqxpOc+Ite7T0fqQ9TebPT4SlyZiFo/05lf4kx4j9LSGnOoyFywilVOlGmmTRZOXDuq
         XkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C5W4rfltqSQyC6633naN9KjlUdmam1uxpZxtzibKLXI=;
        b=JKtb2JLl4v0FnmDK32SWs64sdKaGynmZTD98BUrqRJCiT2gp5m/vNLVpjVKcYkpel/
         SqPfUWiZ0lw6h4XSaDNVv4J1Mr6o8tWj04e/WittYdAu0tAoGJm+QMpar50NuysqHuUs
         n9qopeIzJFRoq9/hGTAK+77mPeICosTV1jTv6KzFPUfWljygr4u6eEjTs88G1ywNAVkY
         pojmXPCi74WV7kjJYmwJSRg4r5rWdvkgfv3kDwIEbGUFQs5JL9nrsGsI/zdIp5XelrkW
         3SxA1QF7lP4MHqUF7hhhIdEOben2V7Tv/rQnLKVh/Wn28b1MjZTm+NS8Xzc5vIwqhNfY
         2IOw==
X-Gm-Message-State: APjAAAXNKH1cV/d8B6wwZuzEKJmX0r5ZQysOeGFbZQgaGoL7X73u3CMj
        3vW/fTPBo/Fml/gXFOYZJXs=
X-Google-Smtp-Source: APXvYqx587pbMaOeJksPCwQe5cRGVDrtU25sgCJnYB02iQnvoCaKcxZz7a5nKyeK3Eyk3aql8YmWLw==
X-Received: by 2002:ac2:59d0:: with SMTP id x16mr23951110lfn.16.1571209670659;
        Wed, 16 Oct 2019 00:07:50 -0700 (PDT)
Received: from localhost.localdomain (c213-102-65-51.bredband.comhem.se. [213.102.65.51])
        by smtp.gmail.com with ESMTPSA id j191sm1361493lfj.49.2019.10.16.00.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 00:07:49 -0700 (PDT)
From:   codekipper@gmail.com
To:     mripard@kernel.org, wens@csie.org, linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v6 6/7] dt-bindings: ASoC: sun4i-i2s: Add H6 compatible
Date:   Wed, 16 Oct 2019 09:07:39 +0200
Message-Id: <20191016070740.121435-7-codekipper@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016070740.121435-1-codekipper@gmail.com>
References: <20191016070740.121435-1-codekipper@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

H6 I2S is very similar to H3, except that it supports up to 16 channels
and thus few registers have fields on different position.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 .../devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml      | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
index eb3992138eec..6928d0a1dcc8 100644
--- a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
@@ -24,6 +24,7 @@ properties:
       - items:
           - const: allwinner,sun50i-a64-i2s
           - const: allwinner,sun8i-h3-i2s
+      - const: allwinner,sun50i-h6-i2s
 
   reg:
     maxItems: 1
@@ -59,6 +60,7 @@ allOf:
               - allwinner,sun8i-a83t-i2s
               - allwinner,sun8i-h3-i2s
               - allwinner,sun50i-a64-codec-i2s
+              - allwinner,sun50i-h6-i2s
 
     then:
       required:
-- 
2.23.0

