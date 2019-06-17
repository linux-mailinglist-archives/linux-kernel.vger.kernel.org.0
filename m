Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 973C448576
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 16:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbfFQObC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 10:31:02 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:54304 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfFQObB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:31:01 -0400
Received: from ramsan ([84.194.111.163])
        by andre.telenet-ops.be with bizsmtp
        id RqWz200013XaVaC01qWzED; Mon, 17 Jun 2019 16:30:59 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hcsew-0002HQ-VP; Mon, 17 Jun 2019 16:30:58 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hcsew-00014s-TH; Mon, 17 Jun 2019 16:30:58 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] Documentation: ABI: Add missing newline at end of file
Date:   Mon, 17 Jun 2019 16:30:57 +0200
Message-Id: <20190617143057.4096-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"git diff" says:

    \ No newline at end of file

after modifying the files.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32 | 2 +-
 Documentation/ABI/testing/sysfs-power                   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32 b/Documentation/ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32
index da9822309f0757bd..0e66ae9b0071e80b 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32
+++ b/Documentation/ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32
@@ -13,4 +13,4 @@ Description:
 			error on writing
 		If DFSDM input is SPI Slave:
 			Reading returns value previously set.
-			Writing value before starting conversions.
\ No newline at end of file
+			Writing value before starting conversions.
diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
index 18b7dc929234f625..3c51303550118474 100644
--- a/Documentation/ABI/testing/sysfs-power
+++ b/Documentation/ABI/testing/sysfs-power
@@ -300,4 +300,4 @@ Description:
 		attempt.
 
 		Using this sysfs file will override any values that were
-		set using the kernel command line for disk offset.
\ No newline at end of file
+		set using the kernel command line for disk offset.
-- 
2.17.1

