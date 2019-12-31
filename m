Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5342212D6DD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Dec 2019 08:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfLaHqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Dec 2019 02:46:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:55988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfLaHqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 02:46:44 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF34A206DB;
        Tue, 31 Dec 2019 07:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577778403;
        bh=LlUfwcv1pTf8jpIiUZGTPpmx804xmSqBFSN1v6Uy1RM=;
        h=From:To:Subject:Date:From;
        b=tyce9aCCEC65oYSkprzOrXM0DmNq4MQcyD7qfKD9wI0293+jQm7lvy4jp5XtqSwAK
         em862RQwI1oB4HKoqalHsUDPef4GgR9xnDlRTYWRtNnUHA9FRgCRxRAS2hzbQBCREE
         qmgH+qEDKUP/yRMraXlk1+csQZKvqgOHxIy/x3Fw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: host: Do not compile test deprecated USB_OCTEON_EHCI
Date:   Tue, 31 Dec 2019 08:46:32 +0100
Message-Id: <1577778392-570-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB_OCTEON_EHCI is deprecated and only selects proper driver so
there is no need to compile test it.  Since it selects
USB_EHCI_BIG_ENDIAN_MMIO it causes compilation failures on certain big
endian architectures (e.g. m68k):

    In file included from drivers/usb/host/ehci-mxc.c:19:0:
    drivers/usb/host/ehci.h: In function ‘ehci_readl’:
    drivers/usb/host/ehci.h:743:3: error:
        implicit declaration of function ‘readl_be’ [-Werror=implicit-function-declaration]

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/usb/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index da14a3d16b57..803023fcb3fe 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -309,7 +309,7 @@ config USB_EHCI_HCD_PLATFORM
 
 config USB_OCTEON_EHCI
 	bool "Octeon on-chip EHCI support (DEPRECATED)"
-	depends on CAVIUM_OCTEON_SOC || COMPILE_TEST
+	depends on CAVIUM_OCTEON_SOC
 	select USB_EHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
 	select USB_EHCI_HCD_PLATFORM
 	help
-- 
2.7.4

