Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD79467FE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 21:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfFNTCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 15:02:33 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41558 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfFNTCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 15:02:32 -0400
Received: by mail-pg1-f195.google.com with SMTP id 83so2039319pgg.8;
        Fri, 14 Jun 2019 12:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fIRh2XHogKOPzGlSMAfw0Y3R1r0WmYblJh7xr9zVEVM=;
        b=Kwr5imp1sJTDpaaM8ydTfG4xZ3PQB4I2YwQP92gtlJPjp+0ir+jnIGIh/kISuAyuId
         P0lUpzcW3H2YCFEWjyzrc2tL9dwGF/sb6aT53hdGH2IFP1CrbWmc2HNJHWbXb7UBVRy+
         hnZSbIbzuOwZ5VDeCXeJO4UU+qjD8Jm11L/j1Oj+PvgapNlr/FJHOKwxaSLTFN0PXFbh
         FwnNYlRxm5Gqg7ZOCc4HG/+l6PGbDnbRMgjY39WD1H4b+Gqk3XBsR87Wmc+Y3wyYtcSi
         jlE+8oS7hWoZaOo6jdUZqfJlqeqc/0i/igvoI17t1D/abAuJR2DISsHfKG1ND7pkXeYU
         mjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fIRh2XHogKOPzGlSMAfw0Y3R1r0WmYblJh7xr9zVEVM=;
        b=BIWUbvzfro0EGN7k+42h1C5VYvElcMw/8O/l7I0VfLx7c7bs8jlgd4VMl80S6NAFvt
         UrjmtfQVmy28ulUU9ibp5uusB5eUXhX4t3HDnfbdEtrHtrm0PuEs6/9BFuoUyj+me5Xg
         7Gq/zpheHc+cyfR9LYkOyRFu2/V8zwVE8qJ7Gd+z+lXgys43IWradw6BGB0tLJ1yNXcR
         qFujMNpPdGYHCBUdc/1kl+V/t2d96hgxEScxTnT+om3uyrP6+f40/x5IRn50oZB/ko1T
         JLD7Q1T+YCCzw6u2xfOH3rW0cdcNP6ghvRbbMwC8bHqeM2t0Edy14IYlJHpASum3jRs7
         RnSg==
X-Gm-Message-State: APjAAAUUy86t4UZhiCQLY9VpYnajmlovSfHAa5IjALvT8hCrsUOP/wXf
        Fji3o8eTghkf5GFc45sNXFBECkZh
X-Google-Smtp-Source: APXvYqxqU2TQ1aZVb8lHhD8nMe+2Zh0ButW4PhfN5GiSP/wc0SrsCnxeNKFnBk5L6Fx2LidQ8OE7fQ==
X-Received: by 2002:a17:90a:c481:: with SMTP id j1mr12504510pjt.96.1560538952188;
        Fri, 14 Jun 2019 12:02:32 -0700 (PDT)
Received: from aw-bldr-10.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id s15sm4503208pfd.183.2019.06.14.12.02.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 12:02:31 -0700 (PDT)
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, thierry.reding@gmail.com, sam@ravnborg.org
Cc:     bjorn.andersson@linaro.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: [PATCH 1/2] dt-bindings: display: truly: Add MSM8998 MTP panel
Date:   Fri, 14 Jun 2019 12:02:20 -0700
Message-Id: <20190614190220.34568-1-jeffrey.l.hugo@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614185547.34518-1-jeffrey.l.hugo@gmail.com>
References: <20190614185547.34518-1-jeffrey.l.hugo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MSM8998 MTP uses the Truly display driver for its panel, but the
configuration differs slightly from the existing SDM845.  Add a compatible
to account for the differences.

Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
---
 .../devicetree/bindings/display/truly,nt35597.txt          | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/truly,nt35597.txt b/Documentation/devicetree/bindings/display/truly,nt35597.txt
index f39c77ee36ea..fda36c1ad3c3 100644
--- a/Documentation/devicetree/bindings/display/truly,nt35597.txt
+++ b/Documentation/devicetree/bindings/display/truly,nt35597.txt
@@ -1,10 +1,11 @@
 Truly model NT35597 DSI display driver
 
-The Truly NT35597 is a generic display driver, currently only configured
-for use in the 2K display on the Qualcomm SDM845 MTP board.
+The Truly NT35597 is a generic display driver used for the Qualcomm reference
+platforms.
 
 Required properties:
-- compatible: should be "truly,nt35597-2K-display"
+- compatible: should be "truly,nt35597-2K-display" (SDM845)
+	      "truly,nt35597-wqhd-cmd-dsc-display" (MSM8998)
 - vdda-supply: phandle of the regulator that provides the supply voltage
   Power IC supply
 - vdispp-supply: phandle of the regulator that provides the supply voltage
-- 
2.17.1

