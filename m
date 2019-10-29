Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2C7E921B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 22:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbfJ2Vei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 17:34:38 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44005 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728549AbfJ2Vei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 17:34:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id 3so5817pfb.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 14:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=czQOnB8XGZh1drUQRgi49wj4hvdzWXuEnHlZa/FCwwU=;
        b=jJCcL1OzsUe+bTt3PewqduHXFL93EB/nCB4OSiHOVahR0Ylu4ChCUJH4ZGtQZSpHit
         y/K9Ro6QZlNcEtPfRnEWcEodVFKxVZYen8dfHq+uhuWXx4db3dLwXYNIzmfgTk3baazY
         O8GkJZ1Bkn6fMAfPcej6FxUcsb6rdVbnpzNwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=czQOnB8XGZh1drUQRgi49wj4hvdzWXuEnHlZa/FCwwU=;
        b=ZzUm/OGARdSc4TDhVdMWeKf1QYcW/OBwcNeTWRiYX3s8RO0zlS/EdOhWpXcN/ABeO9
         ZadidGfcGZGBOIKAa8x6WMPoZdB4khQXi1fTncCY7Gvat4LTSURwmIHrNJo3X6H0akXK
         xT5PYw+FEwg+K1uDvQQYw2t/VDlXSAtprg+mRtTLuy6zqNTOB+CmDQdOO+A6+pKeIIsW
         UmbUw7C+fcg1WhmcnCbMmz24h3F2e8oMBYOcsQzKYDHeIkCLUhOYWJZ3HONB/qlobe4B
         GkqnmohFybZpafAanA97L2wIpw/INffn0v3ATcm4q4vbXlb8stlYonStBarNoqZp+bhi
         HpJg==
X-Gm-Message-State: APjAAAWlqjXb+dwKXYFTVF+pdx9ox/orGO4ngRwhkeNf2ta1/nfHcjvI
        CYzxcI5QRL/LVcVq1StJl5PzTQ==
X-Google-Smtp-Source: APXvYqzDkl6Dlr2YTkZfRwU7n8Cd5bbpx8yPw330Hmh+iHEb7mfXtE+8pXQMv6X1a32OfqrVoZekEg==
X-Received: by 2002:a63:1c4:: with SMTP id 187mr30059349pgb.57.1572384877513;
        Tue, 29 Oct 2019 14:34:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q185sm57411pfc.153.2019.10.29.14.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 14:34:36 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Semmle Security Reports <security-reports@semmle.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] usb: core: Remove redundant vmap checks
Date:   Tue, 29 Oct 2019 14:34:23 -0700
Message-Id: <20191029213423.28949-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191029213423.28949-1-keescook@chromium.org>
References: <20191029213423.28949-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the vmap area checks are being performed in the DMA
infrastructure directly, there is no need to repeat them in USB.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/usb/core/hcd.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index f225eaa98ff8..281568d464f9 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1410,10 +1410,7 @@ int usb_hcd_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 		if (hcd->self.uses_pio_for_control)
 			return ret;
 		if (hcd_uses_dma(hcd)) {
-			if (is_vmalloc_addr(urb->setup_packet)) {
-				WARN_ONCE(1, "setup packet is not dma capable\n");
-				return -EAGAIN;
-			} else if (object_is_on_stack(urb->setup_packet)) {
+			if (object_is_on_stack(urb->setup_packet)) {
 				WARN_ONCE(1, "setup packet is on stack\n");
 				return -EAGAIN;
 			}
@@ -1479,9 +1476,6 @@ int usb_hcd_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 					ret = -EAGAIN;
 				else
 					urb->transfer_flags |= URB_DMA_MAP_PAGE;
-			} else if (is_vmalloc_addr(urb->transfer_buffer)) {
-				WARN_ONCE(1, "transfer buffer not dma capable\n");
-				ret = -EAGAIN;
 			} else if (object_is_on_stack(urb->transfer_buffer)) {
 				WARN_ONCE(1, "transfer buffer is on stack\n");
 				ret = -EAGAIN;
-- 
2.17.1

