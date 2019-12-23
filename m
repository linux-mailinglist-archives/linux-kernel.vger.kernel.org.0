Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD791129667
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Dec 2019 14:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfLWNSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Dec 2019 08:18:10 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39242 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfLWNSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 08:18:10 -0500
Received: by mail-pg1-f196.google.com with SMTP id b137so8813798pga.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 05:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YI1v+z8jxNo/h/j7idm/0EKSnx3iifQZL/1wkb63EVY=;
        b=NC56cI6/Z/H7oTnHAnJ09gyexnPHn4BiJOYPYq5aP1muAWM1ORzqA8pzUEOnRw8nYp
         epKje1I/XIJaj3u6zbTm0w5yn0zlcjh8hsY25dOubLMowIQeW/O4dHnate74cyV/EuHs
         y/9WSbvBsEDXIbs3cLMoD2zHjg1WNY+/hIkXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YI1v+z8jxNo/h/j7idm/0EKSnx3iifQZL/1wkb63EVY=;
        b=EtpnA3IW0lCCDESlXOis5TGSLMXgCDyygpcj9Apu+nHnBqTF6Qy5497Sw82YSM0XH1
         1/2rHf16V/oroVVXjexoXqL0wF1lhD1qTOs1FoAyL1kPdBfzxmpiozYSLX8OMTdaQQVU
         c3hD+9bAvfuFRK6dP72Z08m2TRJwsgTHtB+Wog0zVnBWG5NPPiWytUQWDlmksjzH7Rj3
         hV6b2Wiy+U+3SsigWZ3spbOVj3U224SBeSNVzRRA9CT2iF/I5RXRegWnZgwzEjVzWUVJ
         zmzGP1gjgdKSXImIKEE1D48IPk9nvcURmwbX6kUR0JXjEqnFzBj+xrWuvZTjcUUT+Oui
         hd3w==
X-Gm-Message-State: APjAAAXU7nCVsIMRWUa2eeIYY92yADRRshAF0YsWSNqaBtvE7l1w8ykP
        QVKi+bfI+Pu4La6Q7jHSsPc05A==
X-Google-Smtp-Source: APXvYqyGVdeczBs5yRxyBCpYz4pqjAoDs2yBT7CWuKxBsDQCMyszUoKgfbCh2g1PZKtcKNMYizSH2g==
X-Received: by 2002:a63:3245:: with SMTP id y66mr31152112pgy.234.1577107088874;
        Mon, 23 Dec 2019 05:18:08 -0800 (PST)
Received: from localhost.localdomain ([49.206.201.226])
        by smtp.gmail.com with ESMTPSA id h16sm24731770pfn.85.2019.12.23.05.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 05:18:07 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: [PATCH] ARM: dts: imx6q-icore-mipi: Use 1.5 version of i.Core MX6DL
Date:   Mon, 23 Dec 2019 18:47:50 +0530
Message-Id: <20191223131750.2589-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EDIMM STARTER KIT i.Core 1.5 MIPI Evaluation is based on
the 1.5 version of the i.Core MX6 cpu module. The 1.5 version
differs from the original one for a few details, including the
ethernet PHY interface clock provider.

With this commit, the ethernet interface works properly:
SMSC LAN8710/LAN8720 2188000.ethernet-1:00: attached PHY driver

While before using the 1.5 version, ethernet failed to startup
do to un-clocked PHY interface:
fec 2188000.ethernet eth0: could not attach to PHY

Similar fix has merged for i.Core MX6Q but missed to update for DL.

Fixes: a8039f2dd089 ("ARM: dts: imx6dl: Add Engicam i.CoreM6 1.5 Quad/Dual MIPI starter kit support")
Cc: Jacopo Mondi <jacopo@jmondi.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/imx6dl-icore-mipi.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6dl-icore-mipi.dts b/arch/arm/boot/dts/imx6dl-icore-mipi.dts
index e43bccb78ab2..d8f3821a0ffd 100644
--- a/arch/arm/boot/dts/imx6dl-icore-mipi.dts
+++ b/arch/arm/boot/dts/imx6dl-icore-mipi.dts
@@ -8,7 +8,7 @@
 /dts-v1/;
 
 #include "imx6dl.dtsi"
-#include "imx6qdl-icore.dtsi"
+#include "imx6qdl-icore-1.5.dtsi"
 
 / {
 	model = "Engicam i.CoreM6 DualLite/Solo MIPI Starter Kit";
-- 
2.18.0.321.gffc6fa0e3

