Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1F518E4DE
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Mar 2020 22:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgCUVyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Mar 2020 17:54:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33877 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgCUVyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 17:54:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id z15so11890357wrl.1;
        Sat, 21 Mar 2020 14:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bxcr3nNnRLp2AG9FEGj15mIEI/kFHkOT02wIVui39kg=;
        b=SapOtdi4CUcy3PP4jh3XqIzTwXML5Wv/wnJb/OwAFB538IYea64Y6ExPjoIG0SzOij
         aazEeEFBMTbZRxJ4kBvuZfLBiYAQZaKjT4GHqsjMWzxDsm0IKi+b3CQjbL1re6vuKlxd
         dke7jLU0SPvxmQsNC4eBMfOrWt5c4xe+Qzhd8PQkjITqEcKBE2vwkjz4WEbWOyOj2TcF
         mnwq3ZsB1PXSG5zUc1W19Xb7xG0a5/GCRVcZUpk+RakV87qMK5qVqLisUIY+bXPYTbj5
         X8cwdXTV+ynxu6erBzcT+pbSop0dflfJjK2Atx6w31QfcHGOb7g8tZMpvEDxMzx1vuKB
         ORvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bxcr3nNnRLp2AG9FEGj15mIEI/kFHkOT02wIVui39kg=;
        b=NvKvbGyopxrNRyn7RfeXG8wiSmtwIvhcufV+wegbZuWFvbj8XqXH15AzJZ0MpUcIfZ
         SALNoMAZQ/8SlaabCnc86k1qySgcUPSz2xdDShkqBU7JK+Gs4/N0c4qfze9BEG+QyHDQ
         tYkMfyPaKq+DDV6pUqPXHISKfeDthZNE1Gi3KUJciXLSNgD7IYOEUZteSk51y5EddP1r
         E8vA30jSyulBHGAsj+3/VCVUbxfayAVk3eTuOSPycSUM550Y/eHBC8mjXEO9e9wyIOFe
         xDONWEo7wKqml0KSEn+nFRvW7EAt+OfBtyP//irM0ubhTvacJ0fP0fafsjkrYg4B0r+d
         zA1A==
X-Gm-Message-State: ANhLgQ2kR35d6a6yR8gKndFvsYP85SmAg+yNNd26mUmHetRdrAX71Xcz
        Tt/koWwya1uGSUsY2g1CCtU=
X-Google-Smtp-Source: ADFU+vsnerx72rIsn/e3/S0PUZrUA3I/NLF1OcJy9UClE81yPoADVu/RCabv7zYfNmrnE2Ad6JVelw==
X-Received: by 2002:a5d:528e:: with SMTP id c14mr20126416wrv.308.1584827673988;
        Sat, 21 Mar 2020 14:54:33 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id l83sm14113796wmf.43.2020.03.21.14.54.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2020 14:54:33 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robin.murphy@arm.com, aballier@gentoo.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] arm64: dts: rockchip: fix &pinctrl phy sub nodename for rk3399-nanopi4
Date:   Sat, 21 Mar 2020 22:54:21 +0100
Message-Id: <20200321215423.12176-4-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200321215423.12176-1-jbx6244@gmail.com>
References: <20200321215423.12176-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives for example this error:

arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dt.yaml: phy:
'#phy-cells' is a required property
arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dt.yaml: phy:
'#phy-cells' is a required property
arch/arm64/boot/dts/rockchip/rk3399-nanopi-neo4.dt.yaml: phy:
'#phy-cells' is a required property

'phy' is a reserved nodename and should not be used for pinctrl,
so change it to 'gmac'.

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema/schemas/
phy/phy-provider.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
index 20529105c..1d246c2ca 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
@@ -525,7 +525,7 @@
 		};
 	};
 
-	phy {
+	gmac {
 		phy_intb: phy-intb {
 			rockchip,pins = <3 RK_PB2 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
-- 
2.11.0

