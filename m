Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 292D6DC7E3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 16:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634282AbfJRO4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 10:56:09 -0400
Received: from mail-wr1-f73.google.com ([209.85.221.73]:37654 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbfJRO4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 10:56:07 -0400
Received: by mail-wr1-f73.google.com with SMTP id v7so858676wrf.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 07:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=yc/eud15jtn/68GNn5D6RpG4esICx8d3KE84rtJsHck=;
        b=DD4RNHCQEYgY4LPTbWF0bEzKJpj56iYSVfCGi1ZakRuOvBmPkCeTTXZ9q/SkW8cIUe
         CgjVN+PqHKS9AmkhTwxFW0xc4rfeCokgJ4Axa1SSaAbPSMG5TYkGLp6JxMzbpWAnscvq
         DAWdpivSmAHrr61L3t/2s+/cQfqljrgLtTQvgwBtmtzr4Zvl7hTBKYXKYNGap/wRDYI5
         1wG137HJ/Wy+rWeYjSTTmbyypl7QLpFfZwKa3zgKRQyqmQsbqsN5/VXdl1+VLnCmcufz
         KH3T510Qw/0dBnofaoT0FuGq2zAzuh9AyAQYRP9DjYDbIpBYBAEy/jrQsihtYxFikj8Y
         PIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=yc/eud15jtn/68GNn5D6RpG4esICx8d3KE84rtJsHck=;
        b=WltqE/946jy7Ckr7rSou8x+7vXTSGC5aPRx9fEYl+g2eSIk/OV6VNGeEpjbd7VXIjH
         LdCIulrCa5Q9GDSpn6JAdbuPWveFXUQnCBX7hMspeG2MUdw8h5oJYljO73Naf1wYVmFY
         VEuic7pPkRk72LLXkrFwYN6kttiFmJQBar+Z5J5NaqSGC9JBTpuQPUBYi3y0G5atBLRy
         cKNJ08ms7mbN2YOaBUYFF/NTc/SLVpDFCvyiHQD2PjenPtujmEp3pPWPHXU6vS9o8TMx
         0Zpeaz2kDZ9jCXay955wneKUaj8usddXjcTjEg/stbl0ShRshjcloihTTJc0k25rRmPq
         WdCQ==
X-Gm-Message-State: APjAAAX25j9eITRn0CpHsT9PHqoq5TpNElqwgwmKA1ZyMx3UQh00XBhT
        PJzoks4ife2NFb+TM2D0WwPUd66pPidQxG1a
X-Google-Smtp-Source: APXvYqxyyrELtJ6sDmBfP7yBYHlnJtgNogNsv+PAFdAKgnfpSGntk1T5IuEHltHnQI7E9E7kzLuIOUqT0dorLOup
X-Received: by 2002:a5d:4ace:: with SMTP id y14mr2449479wrs.131.1571410564846;
 Fri, 18 Oct 2019 07:56:04 -0700 (PDT)
Date:   Fri, 18 Oct 2019 16:55:56 +0200
Message-Id: <7a9d6e35873d52ec0ab1e6b9827d9299a1f4fb0d.1571409250.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH 1/2] USB: dummy-hcd: increase max number of devices to 32
From:   Andrey Konovalov <andreyknvl@google.com>
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "Jacky . Cao @ sony . com" <Jacky.Cao@sony.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch increases the maximum number of Dummy UDC/HCD devices to 32.
---
 drivers/usb/gadget/udc/dummy_hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index 3d499d93c083..a8f1e5707c14 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -2725,7 +2725,7 @@ static struct platform_driver dummy_hcd_driver = {
 };
 
 /*-------------------------------------------------------------------------*/
-#define MAX_NUM_UDC	2
+#define MAX_NUM_UDC	32
 static struct platform_device *the_udc_pdev[MAX_NUM_UDC];
 static struct platform_device *the_hcd_pdev[MAX_NUM_UDC];
 
-- 
2.23.0.866.gb869b98d4c-goog

