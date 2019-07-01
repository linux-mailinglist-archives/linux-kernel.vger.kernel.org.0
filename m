Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6963F5BD67
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2019 15:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbfGAN4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 09:56:35 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:43214 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbfGAN4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 09:56:35 -0400
Received: from ramsan ([84.194.98.4])
        by xavier.telenet-ops.be with bizsmtp
        id XRwY2000t05gfCL01RwYvt; Mon, 01 Jul 2019 15:56:33 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hhwnI-0007vo-So; Mon, 01 Jul 2019 15:56:32 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hhwnI-00065l-QJ; Mon, 01 Jul 2019 15:56:32 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] Documentation: ABI: iio: Add missing newline at end of file
Date:   Mon,  1 Jul 2019 15:56:31 +0200
Message-Id: <20190701135631.23376-1-geert+renesas@glider.be>
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
v2:
  - Split patches per maintainer.
---
 Documentation/ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.17.1

