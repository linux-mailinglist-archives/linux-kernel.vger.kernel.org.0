Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0B49118EA6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 18:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfLJRLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 12:11:39 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:44624 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbfLJRLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 12:11:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1575997878; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w+txNi/pYeqM1mpQB8/AX6Hxb3BX/V5ke30lPYgYocI=;
        b=Vogc2pyk8QBcfgQvLLZoXRZTSQ6kTZYU+8WvhsF5PI+Ag3xx0Pw9ZzAyU64wt4MXg4Yl6T
        Xg48fTRxcYqObLQ0z2nqQUXfbUcJgg2mmlbtbeoYljm3SIdXGWie9Djs1T/OcnVJj23sny
        fN+4E3rUFMBmJdal3K3OMT8kJe7KcWE=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     od@zcrc.me, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 4/7] usb: musb: jz4740: Drop dependency on NOP_USB_XCEIV
Date:   Tue, 10 Dec 2019 18:11:07 +0100
Message-Id: <20191210171110.62141-4-paul@crapouillou.net>
In-Reply-To: <20191210171110.62141-1-paul@crapouillou.net>
References: <20191210171110.62141-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver does not depend directly on the NOP transceiver. It can
compile and work just fine without it.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: New patch
    v3: Rebase on 5.5-rc1

 drivers/usb/musb/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index 210e4844c92a..56ccba3c8444 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -111,7 +111,6 @@ config USB_MUSB_UX500
 
 config USB_MUSB_JZ4740
 	tristate "JZ4740"
-	depends on NOP_USB_XCEIV
 	depends on MIPS || COMPILE_TEST
 	depends on USB_MUSB_GADGET
 	depends on USB=n || USB_OTG_BLACKLIST_HUB
-- 
2.24.0

