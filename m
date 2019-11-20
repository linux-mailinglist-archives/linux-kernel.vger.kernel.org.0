Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D541103BF8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 14:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbfKTNjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 08:39:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:46748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731104AbfKTNjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:39:11 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDFCC224FC;
        Wed, 20 Nov 2019 13:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257151;
        bh=e7qNNmsSecBU8hJ2XxG0kI51Dv6sbTVW7xZ1AeP3diU=;
        h=From:To:Cc:Subject:Date:From;
        b=G4mPsB4C3OxVOv8OFWCQ8Jf8WnA7vHVOuDtIOkuum+7Xx9EPVUYKIa3U463eGvOes
         xiGleVKSE3WUTBg9CX2JHqPesBh4a/ADFA8n0V4qwDy+lNSWGgnHOSg6XQuxHWo0Il
         FeGWFC22EKEcD5AgnWPKEPw86fgly99oeoG/ZCUw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Subject: [PATCH] staging: fwserial: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:39:07 +0800
Message-Id: <20191120133907.13483-1-krzk@kernel.org>
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
 drivers/staging/fwserial/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fwserial/Kconfig b/drivers/staging/fwserial/Kconfig
index 9543f8454af9..d21124a1a127 100644
--- a/drivers/staging/fwserial/Kconfig
+++ b/drivers/staging/fwserial/Kconfig
@@ -3,7 +3,7 @@ config FIREWIRE_SERIAL
        tristate "TTY over Firewire"
        depends on FIREWIRE && TTY
        help
-          This enables TTY over IEEE 1394, providing high-speed serial
+	  This enables TTY over IEEE 1394, providing high-speed serial
 	  connectivity to cabled peers. This driver implements a
 	  ad-hoc transport protocol and is currently limited to
 	  Linux-to-Linux communication.
@@ -17,7 +17,7 @@ config FWTTY_MAX_TOTAL_PORTS
        int "Maximum number of serial ports supported"
        default "64"
        help
-          Set this to the maximum number of serial ports you want the
+	  Set this to the maximum number of serial ports you want the
 	  firewire-serial driver to support.
 
 config FWTTY_MAX_CARD_PORTS
@@ -25,7 +25,7 @@ config FWTTY_MAX_CARD_PORTS
        range 0 FWTTY_MAX_TOTAL_PORTS
        default "32"
        help
-          Set this to the maximum number of serial ports each firewire
+	  Set this to the maximum number of serial ports each firewire
 	  adapter supports. The actual number of serial ports registered
 	  is set with the module parameter "ttys".
 
-- 
2.17.1

