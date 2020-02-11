Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE22F158CBE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 11:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgBKKfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 05:35:06 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:57186 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728388AbgBKKfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 05:35:05 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48GzgC0Wtzz20t;
        Tue, 11 Feb 2020 11:35:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1581417303; bh=ZyBwZUGyD7qjPPbQlhdlCzFxIwy0/NfhkGAFyrsfD7Q=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=CaoXz8EhHAoo2lAK9lz+Q0VDhnel5DjRjx1ioqTJSf2RloKgI7K1WvmVuJbLFhcgE
         Ljl6Dt/EzGzT7yYfNwWKnMcW4SCQvZIiHhYDjwOFliEPxju8RJqpDAacAX5JV2MwF0
         hiEctQogTxhvsZPfneLihAiIY5XLY2C9vB+RWTdnpZ3gZyeuIy7zkPjz3HC7MjK0FL
         1G7MnTDUDoI/NbjkIur8emYcMk0hQvF0qrXmw3gz1l7Hloa1QOoykcQNMTLWmzgS1Q
         NpnCXIQOOUXoNESfbL+GCiVeXpS0/bhxKrN2GhyqnxmmTyhUZByNZakGKxBDiBTK2q
         y+LkXFDWpuhEw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.1 at mail
Date:   Tue, 11 Feb 2020 11:35:02 +0100
Message-Id: <96b95d52d0b613065fe655f1d0fe9d7c6adf65fb.1581416843.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1581416843.git.mirq-linux@rere.qmqm.pl>
References: <cover.1581416843.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 4/6] staging: wfx: follow compatible = vendor,chip format
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     =?UTF-8?B?SsOpcsO0bWU=?= Pouiller <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As for SPI, follow "vendor,chip" format 'compatible' string also for
SDIO bus.

Fixes: 0096214a59a7 ("staging: wfx: add support for I/O access")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 .../devicetree/bindings/net/wireless/siliabs,wfx.txt          | 4 ++--
 drivers/staging/wfx/bus_sdio.c                                | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/wfx/Documentation/devicetree/bindings/net/wireless/siliabs,wfx.txt b/drivers/staging/wfx/Documentation/devicetree/bindings/net/wireless/siliabs,wfx.txt
index 52f97673da1e..ffec79c14786 100644
--- a/drivers/staging/wfx/Documentation/devicetree/bindings/net/wireless/siliabs,wfx.txt
+++ b/drivers/staging/wfx/Documentation/devicetree/bindings/net/wireless/siliabs,wfx.txt
@@ -45,7 +45,7 @@ case. Thus declaring WFxxx chip in device tree is strongly recommended (and may
 become mandatory in the future).
 
 Required properties:
- - compatible: Should be "silabs,wfx-sdio"
+ - compatible: Should be "silabs,wf200"
  - reg: Should be 1
 
 In addition, it is recommended to declare a mmc-pwrseq on SDIO host above WFx.
@@ -71,7 +71,7 @@ Example:
 	#size = <0>;
 
 	mmc@1 {
-		compatible = "silabs,wfx-sdio";
+		compatible = "silabs,wf200";
 		reg = <1>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&wfx_wakeup>;
diff --git a/drivers/staging/wfx/bus_sdio.c b/drivers/staging/wfx/bus_sdio.c
index 5450bd5e1b5d..dedc3ff58d3e 100644
--- a/drivers/staging/wfx/bus_sdio.c
+++ b/drivers/staging/wfx/bus_sdio.c
@@ -251,6 +251,7 @@ MODULE_DEVICE_TABLE(sdio, wfx_sdio_ids);
 #ifdef CONFIG_OF
 static const struct of_device_id wfx_sdio_of_match[] = {
 	{ .compatible = "silabs,wfx-sdio" },
+	{ .compatible = "silabs,wf200" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, wfx_sdio_of_match);
-- 
2.20.1

