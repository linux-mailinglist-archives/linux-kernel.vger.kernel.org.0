Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB916176132
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 18:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbgCBRj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 12:39:29 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46931 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgCBRj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 12:39:29 -0500
Received: by mail-oi1-f193.google.com with SMTP id a22so11094196oid.13;
        Mon, 02 Mar 2020 09:39:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X9zcIcdoADWttD9sf5DAldLHlzVytCHULye58nSjDHs=;
        b=Hanrhh/05UdZs/6laCHM29mGMcIA0WZbYlhMTqFEnXF+lLMsFpwpTUAShkW58G1xJv
         vkE8FhM8LKAiFIrJF5CpWiGQ2QgGqCAkiuvPZg2iIct+bcp2HDc67zfgTtt20vvvCIIr
         KnMcYSV11wyTELnGUbw9U7T5KAShNVmbbi7cd2dwfLjE7bUTeVomjj+R8KOwLabqanXI
         ujHBWNk5eGtA6vnjys5bpkXWTTt+EruxrCjw8/sWeojqX4ovNuBGSt12E4l0K+kPxS2X
         M5vGTlorj2a8BvuEy9HPRwOFLLtkB4gOz43syRATmHG+ZMaHIA0QOUVQ7ex26HOyjJ7S
         CiOA==
X-Gm-Message-State: ANhLgQ3jySpJmd8+j8TpEir6bEF8sxAzO0/X9lcWpbAcTURA0ri074wx
        zXU36BUvyK0b/cM4CB59hlCD/l8=
X-Google-Smtp-Source: ADFU+vsmrD8kEzsGB4EHLM139fJ5gq3JFiz5uA3T+lSUhISodybv0ChcJ9PEO2muhmNL8JzBlhF98Q==
X-Received: by 2002:aca:abd6:: with SMTP id u205mr176435oie.12.1583170768009;
        Mon, 02 Mar 2020 09:39:28 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n16sm6757577otk.25.2020.03.02.09.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 09:39:26 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dt-bindings: bus: Drop empty compatible string in example
Date:   Mon,  2 Mar 2020 11:39:25 -0600
Message-Id: <20200302173925.24261-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to add generic checks of compatible strings, drop
the compatible as '...' is not a valid compatible string.

Cc: Maxime Ripard <mripard@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/bus/allwinner,sun8i-a23-rsb.yaml         | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/bus/allwinner,sun8i-a23-rsb.yaml b/Documentation/devicetree/bindings/bus/allwinner,sun8i-a23-rsb.yaml
index 9fe11ceecdba..80973619342d 100644
--- a/Documentation/devicetree/bindings/bus/allwinner,sun8i-a23-rsb.yaml
+++ b/Documentation/devicetree/bindings/bus/allwinner,sun8i-a23-rsb.yaml
@@ -70,7 +70,6 @@ examples:
         #size-cells = <0>;
 
         pmic@3e3 {
-            compatible = "...";
             reg = <0x3e3>;
 
             /* ... */
-- 
2.20.1

