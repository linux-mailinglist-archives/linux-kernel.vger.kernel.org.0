Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABBF12D28A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Dec 2019 18:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfL3RW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Dec 2019 12:22:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:57130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727490AbfL3RWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 12:22:24 -0500
Received: from localhost.localdomain (unknown [194.230.155.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81EF820730;
        Mon, 30 Dec 2019 17:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577726544;
        bh=fW+t00riNY8kM3dJLh4bxka9+sII9/uVpWad+1AZ0Tw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u2aHzgfeUvO3iKsjryPcGZoQsMLKJG+87TluSTqLzcnjC1QjcM1ICo2Ev8twpdm5i
         wUpRmEXSL2pLPWxWogcVHk0Sppn1clpcSnhFRayqIXyjDtB9zeuP3bnSlhwu8OaCP4
         0ytFHjdnp3pjZhn5eTUQB/kl+CSG34nCH3b27i4M=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/2] usb: phy: Enable compile testing for some of drivers
Date:   Mon, 30 Dec 2019 18:22:15 +0100
Message-Id: <20191230172215.17370-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191230172215.17370-1-krzk@kernel.org>
References: <20191230172215.17370-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the USB phy drivers can be compile tested to increase build
coverage.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/usb/phy/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index 24b4f091acb8..ff24fca0a2d9 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -162,7 +162,7 @@ config USB_MXS_PHY
 
 config USB_TEGRA_PHY
 	tristate "NVIDIA Tegra USB PHY Driver"
-	depends on ARCH_TEGRA
+	depends on ARCH_TEGRA || COMPILE_TEST
 	select USB_COMMON
 	select USB_PHY
 	select USB_ULPI
@@ -172,7 +172,7 @@ config USB_TEGRA_PHY
 
 config USB_ULPI
 	bool "Generic ULPI Transceiver Driver"
-	depends on ARM || ARM64
+	depends on ARM || ARM64 || COMPILE_TEST
 	select USB_ULPI_VIEWPORT
 	help
 	  Enable this to support ULPI connected USB OTG transceivers which
-- 
2.17.1

