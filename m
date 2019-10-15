Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4CBCD8162
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 22:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388455AbfJOU7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 16:59:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33732 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728276AbfJOU7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 16:59:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id r17so3170499wme.0;
        Tue, 15 Oct 2019 13:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q85wWT1Ntix0umS+jHesJR+Bc8njDJ95cdjzzQg8isg=;
        b=CylCMKtkQlC4uueCkpuJi9WczWZOQTKFedytAMI5AAAcdHpeUc/P3orCB8s1rMUvEd
         KvRPubUzd0n/80xL/ZS1d+TRarHeHCacs5PLzcP0h1CYDs2NSBwp2GTaSBnez4a2dU5M
         8caGlVXkpe7E6dQhSEz4LhnBjhKDRqUNjVlQISHns8Hz2RDlwCKnJTPrl1e6+aCkDIRn
         BJL+xLt0XVtC9T6U+n8WIh4sH/DibNEkvV3zJM9gndFW3MXdxstFFP+cdaW25ljMU2Zp
         bzzeu8zrgJPkYODuJgVv3Xu+u4MS3QdsmEJ5SbSJrcG6Lmzltep8qm+wy1jvID7fdlOo
         9SwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q85wWT1Ntix0umS+jHesJR+Bc8njDJ95cdjzzQg8isg=;
        b=EaVSEgMn46SGgNypH6AqPDsS3ltdlpezW6ipYJxGB6LXkNFU8c4c2sr+bQorESMtuv
         rqq9/vmI4tVVm4Vv1Yfkfmjw1KdP0h+75WbtQxF0Geq4rsH5CTmyWrPve2taS8SPy9mo
         eN+2lG9NpK2MijDfgQq79NHDFtGyCi1pLlbO9MPe2Pclrc4x6e5TMgYi86wqT/WaqsTO
         9NIqa15E1ybVP+bKvPM6uo73oSxtnzm1yUrbGBpeMOt8xzLb2Zyn+8IPM9Db07IlOlVx
         Yszp0ksGw1rPo36qUTyP73ybdb6dC5qYmBGcFJ0i/mwdKN4SS3urup7RQocf3M2W/51n
         VXmg==
X-Gm-Message-State: APjAAAV8Vg3ka8P9SZR++Vu4Wdk9W06PR/03mWzo5yW7mFGkwu6c39+3
        ++zjesJwZ3G5nTuyEvyM1oA=
X-Google-Smtp-Source: APXvYqz9JsvtcsXk7EmrFoq9r6t7wKeiaW5swS27FNq1ZgoZtcMm9xCDFbmybDRzY8x3UlNy/yhsug==
X-Received: by 2002:a7b:cc06:: with SMTP id f6mr309275wmh.158.1571173141190;
        Tue, 15 Oct 2019 13:59:01 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id j18sm19216963wrs.85.2019.10.15.13.59.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 13:59:00 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] arm64: dts: rockchip: rk3399-rock-pi-4: restyle rockchip,pins
Date:   Tue, 15 Oct 2019 22:58:51 +0200
Message-Id: <20191015205852.4200-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191015191000.2890-1-jbx6244@gmail.com>
References: <20191015191000.2890-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The define RK_FUNC_1 is no longer used,
so restyle the rockchip,pins definitions.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts
index 1ae1ebd4e..188d9dfc2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts
@@ -486,21 +486,18 @@
 
 	sdio0 {
 		sdio0_bus4: sdio0-bus4 {
-			rockchip,pins =
-				<2 20 RK_FUNC_1 &pcfg_pull_up_20ma>,
-				<2 21 RK_FUNC_1 &pcfg_pull_up_20ma>,
-				<2 22 RK_FUNC_1 &pcfg_pull_up_20ma>,
-				<2 23 RK_FUNC_1 &pcfg_pull_up_20ma>;
+			rockchip,pins = <2 RK_PC4 1 &pcfg_pull_up_20ma>,
+					<2 RK_PC5 1 &pcfg_pull_up_20ma>,
+					<2 RK_PC6 1 &pcfg_pull_up_20ma>,
+					<2 RK_PC7 1 &pcfg_pull_up_20ma>;
 		};
 
 		sdio0_cmd: sdio0-cmd {
-			rockchip,pins =
-				<2 24 RK_FUNC_1 &pcfg_pull_up_20ma>;
+			rockchip,pins = <2 RK_PD0 1 &pcfg_pull_up_20ma>;
 		};
 
 		sdio0_clk: sdio0-clk {
-			rockchip,pins =
-				<2 25 RK_FUNC_1 &pcfg_pull_none_20ma>;
+			rockchip,pins = <2 RK_PD1 1 &pcfg_pull_none_20ma>;
 		};
 	};
 
@@ -532,8 +529,7 @@
 
 	wifi {
 		wifi_enable_h: wifi-enable-h {
-			rockchip,pins =
-				<0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
+			rockchip,pins = <0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 
 		wifi_host_wake_l: wifi-host-wake-l {
-- 
2.11.0

