Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0493CE4A4D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 13:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503783AbfJYLrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 07:47:45 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:56354 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730504AbfJYLrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:47:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1572004041; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mz9JbxcWyvPWbx0nI2AEdeCSfmVBVosO5HLgE6B68I4=;
        b=HOt8Ncx2UqYCq9fg/D15nJ3f9LtDknGCgUfrYZXqHJzHa2dHHTgTnr1NZSd+eriPdk8Xyn
        eRAgc8JENIXZmRaDHuXSoCFyJrj5lu18lJcbvmvfdO22r8XZ3AMZ4JvmTT1Kkd3n2b8W9d
        t9+SYTvEpU6OB8qcnYR8e4Hnv0aC7+M=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        od@zcrc.me, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 4/6] usb: musb: jz4740: Drop dependency on NOP_USB_XCEIV
Date:   Fri, 25 Oct 2019 13:47:08 +0200
Message-Id: <20191025114710.13222-4-paul@crapouillou.net>
In-Reply-To: <20191025114710.13222-1-paul@crapouillou.net>
References: <20191025114710.13222-1-paul@crapouillou.net>
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
2.23.0

