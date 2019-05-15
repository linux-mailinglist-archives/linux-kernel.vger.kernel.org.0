Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C85121F54A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 15:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfEONRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 09:17:51 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55653 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727472AbfEONRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 09:17:49 -0400
Received: by mail-wm1-f68.google.com with SMTP id x64so2639169wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 06:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u++X1W35XtSd6Brp1Xu3v+o+tJKXJfUZkbFJORikAHM=;
        b=1qoPgNDN45Tu7njXHQ5zHfRMkJJ/bEVK8IMYxeP7+FPgE2ZvaIp5BfS0cr75an3qiY
         5y+ZqiSTVhPVfl36+w7xjtRv8ZxB9scfN0MmcL0XvRvkbPLwUdoUCz2q9ESfnAj6mok9
         1re+ofb9uB9F2l6gw+bxcefLtL2CQbYNklITNiLIycc0aVLnrXP9Ew0alYTFaC8zqpJH
         NOo7Uu6mmIKTH7Ed0UDx1kpIU6RTRVvzw9tTqFTapUPVSpwS49zlw80fF63SD/q8HQ7p
         sWPiGv8Vgq22JUe8jQYKwLpbhX2T63dQD3bWMqDqrElYCdu56aw1QA6v5eEv/4T5lZ/R
         Id2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u++X1W35XtSd6Brp1Xu3v+o+tJKXJfUZkbFJORikAHM=;
        b=XQwXqDNwlPUdan1YVoi9frQDYmjsPo+6oRofJGNhUCq6k0as1AB/lLU3pKJaIoVI3L
         U1rUcIYsE25/UAsgV6JfhIpt0yTgkqjaXC2nnBbeUbRDyz9gKlJKseww19FHXrPIkPgI
         3NA9BGPesUABS09wi/a9IEgWQoTt2+8nG7ix6FYPaSg2DgzOHCe7HvjsUgROjXJKRkQe
         9sEKmGtmgfk3si/4JHC1DdlJWnIabflDP2jXKEGIBsKsyGe9LdJbYw4A5Uyq3EcHctN0
         cTyHHuSaq3mmJ1bgoz7gRFfekb+WJSJdZ+MioKnD0Cgyi7D37Vq1MGuEOORZUrwqNou5
         B9ow==
X-Gm-Message-State: APjAAAUbU4r5R7n4acS/v7puF1jD7srFGUuTZl1SD9aCz7yX47MoR7yz
        Sm3HjCrwnKslWghGQpbSKY1IVQ==
X-Google-Smtp-Source: APXvYqz1Zsao1PlUJkrXNCQN+z0NMG1m+WCWUNVYzJJ4SOvu24AilUVp0e9NTZtTdhQCijaZFi553Q==
X-Received: by 2002:a1c:7e08:: with SMTP id z8mr24007252wmc.36.1557926267509;
        Wed, 15 May 2019 06:17:47 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-11-31.w90-86.abo.wanadoo.fr. [90.86.214.31])
        by smtp.gmail.com with ESMTPSA id f10sm3268583wrg.24.2019.05.15.06.17.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 15 May 2019 06:17:46 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, matthias.bgg@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 3/5] dt-bindings: mfd: mt6397: Add bindings for MT6392 PMIC
Date:   Wed, 15 May 2019 15:17:39 +0200
Message-Id: <20190515131741.17294-4-fparent@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190515131741.17294-1-fparent@baylibre.com>
References: <20190515131741.17294-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the currently supported bindings for the MT6392 PMIC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

V3:
	* No change

V2:
	* New patch

---
 Documentation/devicetree/bindings/mfd/mt6397.txt | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
index 0ebd08af777d..aa6d2eb0eb19 100644
--- a/Documentation/devicetree/bindings/mfd/mt6397.txt
+++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
@@ -17,7 +17,10 @@ Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
 This document describes the binding for MFD device and its sub module.
 
 Required properties:
-compatible: "mediatek,mt6397" or "mediatek,mt6323"
+compatible: Should be one of:
+	- "mediatek,mt6397"
+	- "mediatek,mt6392"
+	- "mediatek,mt6323"
 
 Optional subnodes:
 
@@ -28,6 +31,8 @@ Optional subnodes:
 	Required properties:
 		- compatible: "mediatek,mt6397-regulator"
 	see Documentation/devicetree/bindings/regulator/mt6397-regulator.txt
+		- compatible: "mediatek,mt6392-regulator"
+	see Documentation/devicetree/bindings/regulator/mt6392-regulator.txt
 		- compatible: "mediatek,mt6323-regulator"
 	see Documentation/devicetree/bindings/regulator/mt6323-regulator.txt
 - codec
@@ -43,7 +48,10 @@ Optional subnodes:
 
 - keys
 	Required properties:
-		- compatible: "mediatek,mt6397-keys" or "mediatek,mt6323-keys"
+		- compatible: Should be one of:
+			- "mediatek,mt6397-keys"
+			- "mediatek,mt6392-keys"
+			- "mediatek,mt6323-keys"
 	see Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
 
 Example:
-- 
2.20.1

