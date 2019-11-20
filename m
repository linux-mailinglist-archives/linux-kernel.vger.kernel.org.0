Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F41EE103C24
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 14:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731251AbfKTNlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 08:41:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:48850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729146AbfKTNlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:41:01 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07E9F22506;
        Wed, 20 Nov 2019 13:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257260;
        bh=7H0hDxFQSuoC/CUw3yrgP4s6eMs211OMo3Zuj/UprCA=;
        h=From:To:Cc:Subject:Date:From;
        b=SVmSepDAoZgeE/3T5OFiUPpPT87P8JG+GrWssLQT2vnYdObTUPshiGcpoWm42Hrh6
         swIM3HLZ0GATcFkpfVmlkSDkKMnwb/P59r77/4cNJEs6TxTHvOhxUTUSj0b3EUErF7
         m/2xGJgGXbvacWpWYxBuv4/nZdoHz/FHtp3JnAPg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] misc: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:40:56 +0800
Message-Id: <20191120134056.14677-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/misc/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 94b14abb5404..b93757efb058 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -338,14 +338,14 @@ config SENSORS_TSL2550
 	  will be called tsl2550.
 
 config SENSORS_BH1770
-         tristate "BH1770GLC / SFH7770 combined ALS - Proximity sensor"
-         depends on I2C
-         ---help---
-           Say Y here if you want to build a driver for BH1770GLC (ROHM) or
+	 tristate "BH1770GLC / SFH7770 combined ALS - Proximity sensor"
+	 depends on I2C
+	 ---help---
+	   Say Y here if you want to build a driver for BH1770GLC (ROHM) or
 	   SFH7770 (Osram) combined ambient light and proximity sensor chip.
 
-           To compile this driver as a module, choose M here: the
-           module will be called bh1770glc. If unsure, say N here.
+	   To compile this driver as a module, choose M here: the
+	   module will be called bh1770glc. If unsure, say N here.
 
 config SENSORS_APDS990X
 	 tristate "APDS990X combined als and proximity sensors"
@@ -450,8 +450,8 @@ config PCI_ENDPOINT_TEST
 	select CRC32
 	tristate "PCI Endpoint Test driver"
 	---help---
-           Enable this configuration option to enable the host side test driver
-           for PCI Endpoint.
+	   Enable this configuration option to enable the host side test driver
+	   for PCI Endpoint.
 
 config XILINX_SDFEC
 	tristate "Xilinx SDFEC 16"
-- 
2.17.1

