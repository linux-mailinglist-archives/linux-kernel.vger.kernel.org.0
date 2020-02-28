Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0237C1730D5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 07:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgB1GOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 01:14:45 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43017 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgB1GOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 01:14:45 -0500
Received: by mail-wr1-f66.google.com with SMTP id e10so162534wrr.10;
        Thu, 27 Feb 2020 22:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=V7hcfg4eflxPQJhhG1KndzdHDXeH+yawJ68Tsyyhejo=;
        b=oEn4bNNwpMt6DqG3AmAQqLjKM5UUcUdjQY0aWw6vyjicqAaWzpM9BHLTp1jHJoXVm3
         HQDdayMMifnuuBkft9/YFeNKfyyIfZLB4mKhtOxODdV9h+9TyL7rF7lBBX7ytiEFfSZ5
         mgNG3mkwccHJAc9hiQHYnYqXBQnkvlE+0e6Lj6vUPN7F62/4TD/nNoIfpJUSGV8LnEyR
         qf5ryWMFcA9NyQnnMWdgMk1BJncEj0NDZNo6ebBrW5GJu593T5ySY5XmZ/iOkOEEqoAx
         DkZI8QaN3Q8hgmK78UTeq534oen07/myJEiqKUh+fvsAzvcxyMUXk11jLcd/AF0XgZ16
         RQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=V7hcfg4eflxPQJhhG1KndzdHDXeH+yawJ68Tsyyhejo=;
        b=sG1vq/zjmJIGf5B2c9edMjmyoVSXgYfQHodclLvIe76WRM1qLig61pQCP2Zs3X0iwN
         pJ0VMuxr+edzmjdqyh95aimXBiMQKGIYZM+C8t70DhyUC2GYOvFQWvpwTrHPLEuBLeVT
         sN6+A2YId2hMch5s5xCwuUjCXk9Xb+4D3Q8v2cqyz5YS/56SuLARl81IqxFxMnfGGiRq
         7tCSGLITNyQYKW6CnBqkakgFVJ7g9fZ6lEN/Myr2aACWPH1YXMHFTc0EO6q0FxTTlCJw
         y+DF6AVfYZ7XnNzQnF87j0DyrYbRJkIVWJMXkBhNoUC1zQPn/Dw4o0ydxEHpcI9t5XDt
         9QfQ==
X-Gm-Message-State: APjAAAW8Sa5lgc0w9/98blQXW0bCHczuuwbpiO3M/b+k47twsGODWrbd
        J22lG67iNJpgF5wKMfzeEyo=
X-Google-Smtp-Source: APXvYqwb8w751wXsSCK0pdQEDc0f1MsYrHDqMC4V0cCyXZwk1vuD4FeHuMsy7PsXoJ7wCkCZzEmN6Q==
X-Received: by 2002:a5d:5647:: with SMTP id j7mr3068045wrw.265.1582870483014;
        Thu, 27 Feb 2020 22:14:43 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w7sm682554wmi.9.2020.02.27.22.14.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Feb 2020 22:14:42 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: arm: fix Rockchip Kylin board bindings
Date:   Fri, 28 Feb 2020 07:14:33 +0100
Message-Id: <20200228061436.13506-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives this error:

arch/arm/boot/dts/rk3036-kylin.dt.yaml: /: compatible:
['rockchip,rk3036-kylin', 'rockchip,rk3036']
is not valid under any of the given schemas

Fix this error by changing 'rockchip,kylin-rk3036' to
'rockchip,rk3036-kylin' in rockchip.yaml.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/rockchip.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 874b0eaa2..203158038 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -443,7 +443,7 @@ properties:
 
       - description: Rockchip Kylin
         items:
-          - const: rockchip,kylin-rk3036
+          - const: rockchip,rk3036-kylin
           - const: rockchip,rk3036
 
       - description: Rockchip PX3 Evaluation board
-- 
2.11.0

