Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAEBC103C5A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 14:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731462AbfKTNnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 08:43:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:50912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730428AbfKTNnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:43:01 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF33922528;
        Wed, 20 Nov 2019 13:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257381;
        bh=tj7aREoePo3wiGev6ErJcVFF7svKLaNJ+I5fiiWs4hw=;
        h=From:To:Cc:Subject:Date:From;
        b=Bw64QoYr/t/QLbOTA7PZ3pCGnTvQ3DdsC3H5ObrDHvZvhYisTdrGoZ1I1TAc2caBT
         LHfnurBG8UTCmucj4UYBVBRfAEyvg1pVA347lcqn3EMu6sQeSWfEhnu7fo7RhydS+h
         TEIWXlc6cvJlRBxtuc2vHQ3FkBii1tRvFB5kq1JI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] drivers: base: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:42:56 +0800
Message-Id: <20191120134256.16186-1-krzk@kernel.org>
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
 drivers/base/firmware_loader/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmware_loader/Kconfig
index 33e6552ddbb6..5b24f3959255 100644
--- a/drivers/base/firmware_loader/Kconfig
+++ b/drivers/base/firmware_loader/Kconfig
@@ -148,7 +148,7 @@ config FW_LOADER_USER_HELPER_FALLBACK
 	  to be used for all firmware requests which explicitly do not disable a
 	  a fallback mechanism. Firmware calls which do prohibit a fallback
 	  mechanism is request_firmware_direct(). This option is kept for
-          backward compatibility purposes given this precise mechanism can also
+	  backward compatibility purposes given this precise mechanism can also
 	  be enabled by setting the proc sysctl value to true:
 
 	       /proc/sys/kernel/firmware_config/force_sysfs_fallback
-- 
2.17.1

