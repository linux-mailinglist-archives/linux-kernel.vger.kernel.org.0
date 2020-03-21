Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1C1F18E4DF
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Mar 2020 22:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgCUVyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Mar 2020 17:54:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37760 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbgCUVyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 17:54:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id w10so11900253wrm.4;
        Sat, 21 Mar 2020 14:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CRbOK0Ug5vXhs9Z5fx1QPwSTD+scMmXofqeuZ2mekL0=;
        b=ZeU5GSaazwnBvQe4FiH0Pxb6wa5Q9/UWZtE29jPBGqMsThgxKNMe2flZjSeEa7evUG
         xm9aj/xmgysYMgjKSMGjkduMqHh7Vh2nDZZEwBJxZY5oQPvXbTKaJJCd82Q1knkRK6dH
         0XqGEKxQxGLfexoPbESNTIeE8AMICKO1JkAHG+EGnZES+3F2S8bugNdjF2tQe9vRNJX2
         zVC8kReytt4t7UMbwa7rlFrZdzPyAItaBm7tSCctbSGH+6bV5wNwKlO8EVzdGlPxEVRp
         PxPFE8Ks1e+z/fM9Jl/uIBC78R/9hPjPn3kfdptZNMH49Vcr7g8uI2uyJPpKSBbXCf5a
         Q9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CRbOK0Ug5vXhs9Z5fx1QPwSTD+scMmXofqeuZ2mekL0=;
        b=InJWpymJPx3IkOP63tVzL3zhkXxA8rxD8j64qpRst7qOzo60xeWiUYTHQOJF2Lm3NM
         B+q+iobqfXcyj6gXvgPJdhi6SqGwTwx1Cr6gM+vLowm5+baMEH2MzlS+jWHE/cCPc1HZ
         PHho5b7fOwOZiucwFSoPam7FHYtSxnKvSbZCDZgxjhDiuY8eujp5vwzDZfPoWZubqcdm
         PPP2VZu7+J+h/lIUvLYgt+ZX2w5lRQLBbJuyXsE1BVJ1+ZqMdmuxsAO3dkwEWuRa9uD1
         ObzNjz6w/+fR9nsG3Q4a6+6o5ot8mjlJTseQhcMZYJah4/uZ6Xxrgab3ARzg0QYJjHhs
         XZ5g==
X-Gm-Message-State: ANhLgQ3spvrS1epzPiE7emzxCHM9o7KlFYIh822tE2Gg7zNOisli/E/B
        75oGGlvnbDqtNHEDZq5uors=
X-Google-Smtp-Source: ADFU+vtATJV3UPOuxt1SDCJN9hIZRqrM8HTS/NXRJUM+lx3c5VqCCNm2IXp0T90Nk916rwvxDgkyAw==
X-Received: by 2002:adf:f7cb:: with SMTP id a11mr10473149wrq.79.1584827674881;
        Sat, 21 Mar 2020 14:54:34 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id l83sm14113796wmf.43.2020.03.21.14.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2020 14:54:34 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robin.murphy@arm.com, aballier@gentoo.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] arm64: dts: rockchip: fix rtl8211e nodename for rk3399-orangepi
Date:   Sat, 21 Mar 2020 22:54:22 +0100
Message-Id: <20200321215423.12176-5-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200321215423.12176-1-jbx6244@gmail.com>
References: <20200321215423.12176-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives this error:

arch/arm64/boot/dts/rockchip/rk3399-orangepi.dt.yaml: phy@1:
'#phy-cells' is a required property

The phy nodename is used by a phy-handle.
The parent node is compatible with "snps,dwmac-mdio",
so change nodename to 'ethernet-phy', for which '#phy-cells'
is not a required property

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema/schemas/
phy/phy-provider.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts b/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
index f9f7246d4..afbcd213c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
@@ -214,7 +214,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		rtl8211e: phy@1 {
+		rtl8211e: ethernet-phy@1 {
 			reg = <1>;
 			interrupt-parent = <&gpio3>;
 			interrupts = <RK_PB2 IRQ_TYPE_LEVEL_LOW>;
-- 
2.11.0

