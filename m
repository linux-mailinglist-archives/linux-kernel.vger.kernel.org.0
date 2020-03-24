Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B57AA1909CA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 10:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgCXJmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 05:42:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41561 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgCXJl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:41:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id h9so20525682wrc.8;
        Tue, 24 Mar 2020 02:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HNjGIiYj2PpNEKaGwYof99mf+bU/+Ss4GMUxM717vYs=;
        b=egl2JmPRGAUxRuOSAc1Jl1OqrLWKRg2CePCkrpRwV/8U2wzDPGGB7qXbEBo096GqjC
         GU1SkgX7ePypv9GkhRSPvEUbUN/QQHc092ELTeQLX4c2vHak9eIK9eboKOA7ZKrFO3lJ
         0FnuTJgeXdNL5zblpPbjtgWJUPNoPYq9HL5KMttBbjHzMh/mN9piTviAuPdLDuK1X1JJ
         LzPTeRD14ukONHC3+G+SqAMFrQ4LfX9fVqtSoU4glVxCJdu70Qa1g5T373UicfCdnbPC
         SjDQ98IZY/dNwrAWLc+amI9ubxYWky2cL46kf655OkghRmEyiFkqnQPqZbX9bRXlf9WR
         pbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HNjGIiYj2PpNEKaGwYof99mf+bU/+Ss4GMUxM717vYs=;
        b=BivX4CxY3bHggEcIb0pvLk01+/K6v7E/u4Kbg3s/1Abe6jEioNQm7rlCLgjzb0i/Yg
         7GSbIxGpyWCwv3/SJd7P3mh6BOe/sk0/MVWHTklH5Y5Jho1yIHpGl2o+bCtRUPpjFi57
         UTOIvoTQm1QRNOTBgYiPUXFEpZK7PQwsRMGHoAcSX08nQ/XqsLqZQkhwSHa63yP09LGD
         i2S/csVF8jKIVKQiDQo2JE+e3kYk17ts/xUDhIsdNHgq2BRS2+AUnDSvtosVC9NQhsFA
         /xpxTgd42Y6r3R0lXuMRmr7KMDIlNEc5WAz63aCZh32/Ewme2I7+iLsgEgSK3M5L6C0m
         6Gog==
X-Gm-Message-State: ANhLgQ1eytVA/Iu+v0PaBF0VELg4JpLvw0bpuE+bkHyKSVndYXyPDrno
        y6leMmw2nvRHM/zpzDcJTkc=
X-Google-Smtp-Source: ADFU+vv8C9cjYZxaDsbHr88EK25zLIa2C+78e0CD6QBdRLrO+K+8pTvsjYRa/RwUpjye0rYJNRrOew==
X-Received: by 2002:a5d:44d0:: with SMTP id z16mr13006905wrr.28.1585042918365;
        Tue, 24 Mar 2020 02:41:58 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id r15sm22489916wra.19.2020.03.24.02.41.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2020 02:41:57 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, heiko@sntech.de, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: sound: rockchip-i2s: add #sound-dai-cells property
Date:   Tue, 24 Mar 2020 10:41:48 +0100
Message-Id: <20200324094149.6904-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200324094149.6904-1-jbx6244@gmail.com>
References: <20200324094149.6904-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'#sound-dai-cells' is required to properly interpret
the list of DAI specified in the 'sound-dai' property,
so add them to 'rockchip-i2s.yaml'

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changed V2:
  Add Reviewed-by
---
 Documentation/devicetree/bindings/sound/rockchip-i2s.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml b/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml
index eff06b4b5..7cd0e278e 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml
@@ -77,6 +77,9 @@ properties:
       Required property for controllers which support multi channel
       playback/capture.
 
+  "#sound-dai-cells":
+    const: 0
+
 required:
   - compatible
   - reg
@@ -85,6 +88,7 @@ required:
   - clock-names
   - dmas
   - dma-names
+  - "#sound-dai-cells"
 
 additionalProperties: false
 
@@ -103,4 +107,5 @@ examples:
       dma-names = "tx", "rx";
       rockchip,capture-channels = <2>;
       rockchip,playback-channels = <8>;
+      #sound-dai-cells = <0>;
     };
-- 
2.11.0

