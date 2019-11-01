Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B97F5EBEBE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 08:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbfKAH5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 03:57:20 -0400
Received: from plaes.org ([188.166.43.21]:36468 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbfKAH5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 03:57:20 -0400
Received: from localhost (unknown [IPv6:2001:bb8:4008:20:21a:64ff:fe97:f60])
        by plaes.org (Postfix) with ESMTPSA id 980E74025B;
        Fri,  1 Nov 2019 07:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1572595038; bh=i+ZqLGUS44ULpCRaPbBqLE0eAwbLrZ4yMyEiWtjqn6U=;
        h=From:To:Cc:Subject:Date:From;
        b=Fs5VzKQ7WptAn+lRGlvPRXhyyFRwSVYe2MsQuPTOdt7fCcMqQsNclIDAMQJdLBmCk
         Flc85f5M2TF7zJfPsFR6xAhPPdJ9JY3W08QPay6lDLpxQGWkTB/d5bs1aNxFkZsHkm
         j4QRL3eQF7g8XHxQZMMGME93qZ74+DItlRlSfKqXQaCcnkTTeC0ZKX6xtCDl4U7xm2
         luV/VdEhLlp/Ehz11o8/rq+Ll0uZoNChaE/lowuyfn/hHhN0XJhDnaH1T/MBzYFwc6
         AZVYINkUTaB/G7I5dLY40mXhXWYgoeoECLywNEQOsCI9fQtiBIZjL6wDohZvdB3uGD
         FuK2wLF8M8Z/Q==
From:   Priit Laes <plaes@plaes.org>
To:     Russell King <linux@armlinux.org.uk>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Priit Laes <plaes@plaes.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     igor.pecovnik@gmail.com, priit.laes@paf.com, usunov@olimex.com
Subject: [PATCH] ARM: sunxi_defconfig: Enable MICREL_PHY
Date:   Fri,  1 Nov 2019 09:57:09 +0200
Message-Id: <20191101075712.3058-1-plaes@plaes.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include support for Micrel KSZ9031 PHY driver in sunxi_defconfig,
which fixes issues of link not coming up at boot time with
certain link partners.

Micrel KSZ9031 PHY chip is used on Olimex A20-OLinuXino-LIME2
boards.

The errata fix itself has been implemented in commit
"3aed3e2a143c96: net: phy: micrel: add Asym Pause workaround"

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 arch/arm/configs/sunxi_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index df433abfcb02..eb7efa2639d1 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -56,6 +56,7 @@ CONFIG_SUN4I_EMAC=y
 CONFIG_STMMAC_ETH=y
 # CONFIG_NET_VENDOR_VIA is not set
 # CONFIG_NET_VENDOR_WIZNET is not set
+CONFIG_MICREL_PHY=y
 # CONFIG_WLAN is not set
 CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_SUN4I_LRADC=y
-- 
2.20.1

