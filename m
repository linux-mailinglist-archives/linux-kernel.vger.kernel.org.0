Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 167645F531
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 11:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbfGDJKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 05:10:16 -0400
Received: from host-88-217-225-28.customer.m-online.net ([88.217.225.28]:10798
        "EHLO mail.dev.tdt.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727140AbfGDJKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 05:10:15 -0400
Received: from feckert01.dev.tdt.de (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id 64B5D21592;
        Thu,  4 Jul 2019 09:02:30 +0000 (UTC)
From:   Florian Eckert <fe@dev.tdt.de>
To:     Eckert.Florian@googlemail.com, info@metux.net,
        dvhart@infradead.org, andy@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Eckert <fe@dev.tdt.de>
Subject: [PATCH 3/3] platform//x86/pcengines-apuv2: update gpio button definition
Date:   Thu,  4 Jul 2019 11:02:05 +0200
Message-Id: <20190704090205.19400-4-fe@dev.tdt.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190704090205.19400-1-fe@dev.tdt.de>
References: <20190704090205.19400-1-fe@dev.tdt.de>
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.dev.tdt.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Add the gpio number, so the button subsystem can find the right gpio.
* Change also the keycode from KEY_SETUP to KEY_RESTART, because it
  seems more expressive to me and in the Alix-Board, which is the
  predecessor, there isthis keycode defined too. I think this is also
  intended by Pcengines. Also many embedded systems defined in the kernel
  use this key code as well.

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 drivers/platform/x86/pcengines-apuv2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/pcengines-apuv2.c b/drivers/platform/x86/pcengines-apuv2.c
index d50a50e9d34c..370fd2686d59 100644
--- a/drivers/platform/x86/pcengines-apuv2.c
+++ b/drivers/platform/x86/pcengines-apuv2.c
@@ -116,7 +116,8 @@ struct gpiod_lookup_table gpios_led_table = {
 
 static struct gpio_keys_button apu2_keys_buttons[] = {
 	{
-		.code			= KEY_SETUP,
+		.code			= KEY_RESTART,
+		.gpio			= 508,
 		.active_low		= 1,
 		.desc			= "front button",
 		.type			= EV_KEY,
-- 
2.11.0

