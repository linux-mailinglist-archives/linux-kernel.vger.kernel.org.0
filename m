Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25C0B97015
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 05:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfHUDLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 23:11:49 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39394 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfHUDLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 23:11:48 -0400
Received: by mail-pl1-f193.google.com with SMTP id z3so510674pln.6;
        Tue, 20 Aug 2019 20:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tfmgm4LIxxx9FZ0lj1a+BI18xaGv0RsnyVSEcXhiXYo=;
        b=pDy9bJxnBGKM1sKpIALE7tC8FeAmFQuMtZ1Bu4n2nDyhrPran3Ta7FiFeQQlQExPcj
         KHDchay8h9+7yByAof4eZ5E6HyepC035XGKBUhzGOsVtn6UCQXE8bugxFBJM2Jz6dj0u
         HeBCd/xxoFIYUbenH5WCe2vxFMlxAkpAFAd1Jl5ouinHaQTwsuCA4iNylUacmTinj0lf
         VVqxVwpF7L17EJSgJiPydsfetUrf88v3qNwFIO5y1wlCN7QJvemJ0e+WhIZencU8L2/O
         EZcidgGpdgytWToe7bwLRzaTRD6UKWzXWUJ8EDJqaBcbZVheT9wRiR2I3fgXOg7IYqCm
         FQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=tfmgm4LIxxx9FZ0lj1a+BI18xaGv0RsnyVSEcXhiXYo=;
        b=X99JNJR0Eiql1ClllKLLK1b1qdefDOHMWmkcu60G3qdCvAAYtXlibfoRGGU6du+w/c
         JoasVZHey7wpdBva+Wkeu4T4GbyuOawgPIhvBf7TcAIH1L+gqbN77yZnVf9LDJ+HvbzW
         l3QI1hPHvn3fpApaRuJlQ7CuvRMQWN4C+wpM4T2vPf7OMn60tMOgohwMsyU3LL14zVua
         v06TLdWJIyrPdGsQxQq6UtGBu/zVYLfg3ihYc6yaj6i8ONkvOIRUZJGe85xWbY5FyK90
         IlTh156Y4BfiUFDkAutPQMNLPze06zOh/Lk0uKcM5kO8f4g8d4TY5VRJu+Wzwbsg/4r5
         9A0A==
X-Gm-Message-State: APjAAAUzkxuz3GWkARa5eUOOo2qHhlG8hsSjNDlTt079uqB17y9IJ3EZ
        Xmi2VWQxM/rNEQuGF/T2XaU=
X-Google-Smtp-Source: APXvYqywbluDozgwfegRgr7JEenjh7blVGNMTCIZBGNYicQyVNkH/LJvp5txNVm0x2yEXo8FlfHXtQ==
X-Received: by 2002:a17:902:29e6:: with SMTP id h93mr10098249plb.39.1566357107026;
        Tue, 20 Aug 2019 20:11:47 -0700 (PDT)
Received: from localhost.localdomain ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id j15sm21540009pfe.3.2019.08.20.20.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 20:11:46 -0700 (PDT)
From:   Kever Yang <kever.yang@rock-chips.com>
To:     heiko@sntech.de
Cc:     linux-rockchip@lists.infradead.org,
        Kever Yang <kever.yang@rock-chips.com>,
        Akash Gajjar <Akash_Gajjar@mentor.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: arm: rockchip: remove reference to fennec board
Date:   Wed, 21 Aug 2019 11:11:24 +0800
Message-Id: <20190821031124.17806-2-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821031124.17806-1-kever.yang@rock-chips.com>
References: <20190821031124.17806-1-kever.yang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rk3288 fennec board has been removed, remove the binding document at
the same time.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

Changes in v2: None

 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 34865042f4e4..cc2f1c2d0cd0 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -424,11 +424,6 @@ properties:
               - rockchip,rk3288-evb-rk808
           - const: rockchip,rk3288
 
-      - description: Rockchip RK3288 Fennec
-        items:
-          - const: rockchip,rk3288-fennec
-          - const: rockchip,rk3288
-
       - description: Rockchip RK3328 Evaluation board
         items:
           - const: rockchip,rk3328-evb
-- 
2.17.1

