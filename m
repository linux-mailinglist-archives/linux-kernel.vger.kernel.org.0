Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADF8615174D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 10:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgBDJBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 04:01:00 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46752 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgBDJA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 04:00:59 -0500
Received: by mail-pg1-f194.google.com with SMTP id z124so9306099pgb.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 01:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i1Hdx03KpzIJqjLnNBsm/Ab9J3/wfB5FKXcb0BZf37c=;
        b=gdpVUwZQGp+PFX0HmzPpHsr4OR52mtM9cPrby2RkLoy7VLucoantTtPRh03D0ZUOlE
         BLGIVReOeQg5bSr2Grqo3YwCT1UedIVL/pxIAKiqlEV6QNQg6uDX6vqEDBeXZmfgFo0d
         a+REiyWTR2zoLWiPecytEmSUk0b23jcouNhfd7oTD2LBwQx0rTivE7FD2AK3E3E70k2S
         P842xQek2LaQswjaKu/z4l87jd/LkK8bBTBO2bOyGCYaDeHQ6r/9/odzEPMvw/Xq0AXU
         c6btJ32pKbFAuo7jzbyEh0rqCgwAUVl0uos1qUVDf/dC+Y2Bg3kfE3TSDDgCWABHpCZY
         8EIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i1Hdx03KpzIJqjLnNBsm/Ab9J3/wfB5FKXcb0BZf37c=;
        b=n2lprgOEz37/Toyj/uN+psGKP33ryRlYDDP4xAcevN0wr0PB4BRsnaufKu+WRNgGVa
         s3jaa+35uUiMcL9GohpgNdvl0uNTzGkFCbiCdgrtx5zkB0G5wqzleG8YyDiq8GXAskOB
         UopYJXS40rn5u+88NMP8EQrYXj8Bpo02ZKRWMRSWE+IqFOscypeNI0Zjy1VGOAShZHSY
         AROr9AmWGfHgWYshVUkb89bOTvTkkSEfM5y3KrqgU8TlE5LoqUVAOAhsAhPrA3IawE1u
         2A3oKkk/P0S+HlY5ZKrj03HAFCCuvJgIhFflJLBpwovn+c4YtBM23u78f9S0ZlbdJJIX
         /fpw==
X-Gm-Message-State: APjAAAXVb9BdnxHx1FGkcScfgquqIItSPaTzhNPWld79g1ClXJTzwRTy
        2UMmVe/PHycUZ4/NJ2psCfQ=
X-Google-Smtp-Source: APXvYqzXibLzgNJBHrGQYFI65lIG3QOgtpQMXx/kNDGLspr7gjJTVVudOKHU6y5WxUiy9RozMCMLcQ==
X-Received: by 2002:a62:8601:: with SMTP id x1mr29872722pfd.0.1580806858980;
        Tue, 04 Feb 2020 01:00:58 -0800 (PST)
Received: from localhost.localdomain ([240e:379:959:d990::fa3])
        by smtp.gmail.com with ESMTPSA id 72sm23144151pfw.7.2020.02.04.01.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 01:00:58 -0800 (PST)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     devel@driverdev.osuosl.org
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        NeilBrown <neil@brown.name>, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: mt7621-dts: add dt node for 2nd/3rd uart on mt7621
Date:   Tue,  4 Feb 2020 16:59:31 +0800
Message-Id: <20200204090022.123261-1-gch981213@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 3 uarts on mt7621. This patch adds device tree node for
2nd and 2rd ones.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
 drivers/staging/mt7621-dts/mt7621.dtsi | 38 ++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/staging/mt7621-dts/mt7621.dtsi b/drivers/staging/mt7621-dts/mt7621.dtsi
index d89d68ffa7bc..cee23710d03b 100644
--- a/drivers/staging/mt7621-dts/mt7621.dtsi
+++ b/drivers/staging/mt7621-dts/mt7621.dtsi
@@ -166,6 +166,44 @@ uartlite: uartlite@c00 {
 			no-loopback-test;
 		};
 
+		uartlite2: uartlite@d00 {
+			compatible = "ns16550a";
+			reg = <0xd00 0x100>;
+
+			clock-frequency = <50000000>;
+
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SHARED 27 IRQ_TYPE_LEVEL_HIGH>;
+
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			no-loopback-test;
+
+			status = "disabled";
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart2_pins>;
+		};
+
+		uartlite3: uartlite@e00 {
+			compatible = "ns16550a";
+			reg = <0xe00 0x100>;
+
+			clock-frequency = <50000000>;
+
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SHARED 28 IRQ_TYPE_LEVEL_HIGH>;
+
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			no-loopback-test;
+
+			status = "disabled";
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart3_pins>;
+		};
+
 		spi0: spi@b00 {
 			status = "disabled";
 
-- 
2.24.1

