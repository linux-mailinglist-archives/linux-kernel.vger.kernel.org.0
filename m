Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2348CB69FA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 19:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387543AbfIRRxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 13:53:18 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:44460 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387500AbfIRRxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 13:53:16 -0400
Received: by mail-qt1-f201.google.com with SMTP id h10so906193qtq.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 10:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=If4YHWCGBSP7JzXIJroo6+sBnmdEVgDVLiwCXHSsnXY=;
        b=oguUc+kb+4yrrWH0itSSontlpChAevcIUhBnlNdleoDtVUZEFYp2QPXq1c+yHoiLzh
         x3TCqnF9WrNtStcniUJIcTe1ErB0CNlRnCW5I7SqqHrUoMbTCz6ElEqPLjvKOy2AiELE
         pKbfPkilKavW+ujb8DGZnQjf1QA8flarS9hTOttDnBruHAk7QT6ZTL2W0pzDGZ3cmS5p
         d1FdamKEs1MS1JLVoKBJREpVJtVPJKPzWCExOq0KHNbV8tLNWe6iQPVxNcTCAi/K9Eac
         f6V4ZKcVt9CAIW9JeudEeHgqsRsGz1jgyv6zF5HNW/wGKXe4pUblbVCfN8ZnoApo3dfq
         IDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=If4YHWCGBSP7JzXIJroo6+sBnmdEVgDVLiwCXHSsnXY=;
        b=WiU36S0lKjyyLejiONdvvIMe4n/ZgkAYQUDP5EYuYWjYORoxtB9GTl1jORtKEoze/W
         hx4xt1El0dxJwVWE4wKm4q9DrlPm3V+ot9preBt2gZ1cacWmfzJMOo9emMn95g0kzOK6
         FKJvh3hHH8EYaG7HnyjQ9+4JI28aMu/k8UHHSbCLFnhNl1f+zFOAEdT72RfwJDA4j031
         wyWEJFbgGjlCblZO02DMoYYWLkxIWr+B17P5DbveItufklxZ/wuP22brujKZQRoAm8lc
         k3S/xK8/wyWh5xTbeXc0cXTb6kPHUylXRA6PMVyKbaVK+7WDILjt6HdqKOC6aZy0unyH
         Ykng==
X-Gm-Message-State: APjAAAU2ySAdb+h7KIGBaS8P5BVUor/k1nyeAzzdDw6aZZWDbVnr6Edm
        grdOtr7Mik+/GqUJUbmmU3gw7tpL6Gj/kEqObQ4EVjQkaDt+UMw3SeTG+LxoVTc1GXWaIXyOh/d
        8+uA58lvNCgE4u2mgrK2C+Tsqbb88FCZIQvXVSCjhOg572DIqUo8edMhKoUOGuoRMwtKBCjLihT
        g=
X-Google-Smtp-Source: APXvYqwc7ZdpqllO9sb4kSIzSYVq3NgZO3dQ81K5ff7/OICmmahBAZJxEWREpdQXIYjPCFH2JGSKEq2zLH+reA==
X-Received: by 2002:a37:8d6:: with SMTP id 205mr5340763qki.308.1568829193722;
 Wed, 18 Sep 2019 10:53:13 -0700 (PDT)
Date:   Wed, 18 Sep 2019 18:53:04 +0100
In-Reply-To: <20190917231031.81341-1-maennich@google.com>
Message-Id: <20190918175304.219849-1-maennich@google.com>
Mime-Version: 1.0
References: <20190917231031.81341-1-maennich@google.com>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
Subject: [PATCH v2] usb-storage: SCSI glue: use pr_fmt and pr_err
From:   Matthias Maennich <maennich@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, maennich@google.com,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        usb-storage@lists.one-eyed-alien.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow common practice and retire printk(KERN_ERR ...) in favor of
pr_fmt and dev_err().

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: usb-storage@lists.one-eyed-alien.net
Signed-off-by: Matthias Maennich <maennich@google.com>
---
 drivers/usb/storage/scsiglue.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
index 6737fab94959..afc4e3221369 100644
--- a/drivers/usb/storage/scsiglue.c
+++ b/drivers/usb/storage/scsiglue.c
@@ -28,6 +28,8 @@
  * status of a command.
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/blkdev.h>
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
@@ -379,8 +381,8 @@ static int queuecommand_lck(struct scsi_cmnd *srb,
 
 	/* check for state-transition errors */
 	if (us->srb != NULL) {
-		printk(KERN_ERR "usb-storage: Error in %s: us->srb = %p\n",
-			__func__, us->srb);
+		dev_err(&us->pusb_intf->dev,
+			"Error in %s: us->srb = %p\n", __func__, us->srb);
 		return SCSI_MLQUEUE_HOST_BUSY;
 	}
 
-- 
2.23.0.237.gc6a4ce50a0-goog

