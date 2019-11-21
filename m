Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62956105422
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 15:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfKUOPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 09:15:20 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32935 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbfKUOPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 09:15:18 -0500
Received: by mail-pl1-f195.google.com with SMTP id ay6so1649906plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 06:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I6yA6TdrKO0G1JGypZEAKYVfmifyHMcNDjr9W3hUK+E=;
        b=OU+GiCP10q9PnP8bkEcFaAdutdza/iERr+D0OoLljK1MmkZMko724GceiauVEvI5Qy
         i+jRkFfhJKSvUbE8cP0wU8IXLB28x6Cy2XOR2ZsqnhydicNZpRBcPrXBRxG9vQS8ZI0F
         kUhIL72l450esX8mcjqodnluupinKQ49p/SiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I6yA6TdrKO0G1JGypZEAKYVfmifyHMcNDjr9W3hUK+E=;
        b=rdq3PXrKE4laUlXd9Zi4jf3Ws3ZLtKlRmCht5VHKSsdx4b4NIMiTQzK8vIMlOLTqCx
         JvfzB9elbZtb6sBqZyjRqPTdsOrevgEVuGCN6wZqEn3tOmn43xIslZsTa5qsjWPIzmu9
         g0YOl2n+1tAJEPKQJv2jI0MwhtS4QJiiaFGL0h9RYEjsRMpIhpS6v9KcCnqtWi5VZF16
         5cEqLrqtOBRFXQOOYymzHP5mBIPOwZurXrzEhqEYBmGNg4MttANsgJ9bz+kXM6dkCdR7
         O3tZc/0BK9PmA3OrRD1eofvcWWazZ7bFQj26P74Yd7TIBlqZbnAfxwsD7LgdKQNPqGvM
         GGxQ==
X-Gm-Message-State: APjAAAXdfH0D+I1rkovgS7e+35w++zW/a0+NtrJ5vQpoCssEL09xzWWw
        2maUAEU5qvSY3QBzrMmzkJPuIQ==
X-Google-Smtp-Source: APXvYqzs2J4YhqGXlT0xDxYXUbauaCJnilI7GqLrXPtDGy4WsDd4PG5Ypm+uC16rNirt3o8Uj6Hwjg==
X-Received: by 2002:a17:90a:33ce:: with SMTP id n72mr11931278pjb.17.1574345716897;
        Thu, 21 Nov 2019 06:15:16 -0800 (PST)
Received: from localhost.localdomain ([115.97.180.31])
        by smtp.gmail.com with ESMTPSA id w138sm4072304pfc.68.2019.11.21.06.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 06:15:16 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Akash Gajjar <akash@openedev.com>, Tom Cubie <tom@radxa.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 3/5] dt-bindings: arm: rockchip: Add Rock Pi N10 binding
Date:   Thu, 21 Nov 2019 19:44:43 +0530
Message-Id: <20191121141445.28712-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191121141445.28712-1-jagan@amarulasolutions.com>
References: <20191121141445.28712-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rock Pi N10 is a Rockchip RK3399Pro based SBC, which has
- VMARC RK3399Pro SOM (as per SMARC standard) from Vamrs.
- Compatible carrier board from Radxa.

VMARC RK3399Pro SOM need to mount on top of dalang carrier
board for making Rock PI N10 SBC.

Add dt-bindings for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- none

 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 51aa458833a9..afa6b2e5aeed 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -423,6 +423,11 @@ properties:
           - const: radxa,rockpi4
           - const: rockchip,rk3399
 
+      - description: Radxa ROCK Pi N10
+        items:
+          - const: radxa,rockpi-n10
+          - const: rockchip,rk3399pro
+
       - description: Radxa Rock2 Square
         items:
           - const: radxa,rock2-square
-- 
2.18.0.321.gffc6fa0e3

