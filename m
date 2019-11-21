Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A12181052FF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 14:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfKUN25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 08:28:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:48688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbfKUN24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 08:28:56 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DE222070B;
        Thu, 21 Nov 2019 13:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574342935;
        bh=KDXZLoZXII0XBYiXxrDn8rRTuxKp5hQffiXRs1dksfI=;
        h=From:To:Cc:Subject:Date:From;
        b=rHHWHGGMDd8c5KD9Vxi2iNLjJlNUZiFZPr2FpoQlumnebSp0HyNhcz5VhLZ/swDTf
         IN/XxtfUi5pCIG7qM1NBXhED54nhmve7ic9DLnspvYZea6ti6+CUi2mdNcmgzl2nQa
         +QT0ajVcd0GayhN1cqY5hDvO+cNwp9SdvfsAt+a8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Subject: [PATCH] staging: fwserial: Fix Kconfig indentation (seven spaces)
Date:   Thu, 21 Nov 2019 21:28:51 +0800
Message-Id: <20191121132851.29072-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from seven spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^       /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/staging/fwserial/Kconfig | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/fwserial/Kconfig b/drivers/staging/fwserial/Kconfig
index d21124a1a127..6964aac2a7ed 100644
--- a/drivers/staging/fwserial/Kconfig
+++ b/drivers/staging/fwserial/Kconfig
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 config FIREWIRE_SERIAL
-       tristate "TTY over Firewire"
-       depends on FIREWIRE && TTY
-       help
+	tristate "TTY over Firewire"
+	depends on FIREWIRE && TTY
+	help
 	  This enables TTY over IEEE 1394, providing high-speed serial
 	  connectivity to cabled peers. This driver implements a
 	  ad-hoc transport protocol and is currently limited to
@@ -14,17 +14,17 @@ config FIREWIRE_SERIAL
 if FIREWIRE_SERIAL
 
 config FWTTY_MAX_TOTAL_PORTS
-       int "Maximum number of serial ports supported"
-       default "64"
-       help
+	int "Maximum number of serial ports supported"
+	default "64"
+	help
 	  Set this to the maximum number of serial ports you want the
 	  firewire-serial driver to support.
 
 config FWTTY_MAX_CARD_PORTS
-       int "Maximum number of serial ports supported per adapter"
-       range 0 FWTTY_MAX_TOTAL_PORTS
-       default "32"
-       help
+	int "Maximum number of serial ports supported per adapter"
+	range 0 FWTTY_MAX_TOTAL_PORTS
+	default "32"
+	help
 	  Set this to the maximum number of serial ports each firewire
 	  adapter supports. The actual number of serial ports registered
 	  is set with the module parameter "ttys".
-- 
2.17.1

