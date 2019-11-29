Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67BAF10D3D4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2019 11:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfK2KUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Nov 2019 05:20:00 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42795 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfK2KT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 05:19:59 -0500
Received: by mail-lj1-f194.google.com with SMTP id e28so7210688ljo.9;
        Fri, 29 Nov 2019 02:19:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YQ9NZqfEPBjz3KOdFZmTMVER3EPMPaak6R0HUkbsMbw=;
        b=oKPgCgbRr8T57X9c/Iq9osWj3YtMrR2v7/VT/uQIioL3DhkTaORhPyTVQXvAOAadu0
         wmXpOEFf4jnzNzBn4grJlC7M14SIeAyma8x8+ACkgeTk0chNkzUps/HUuQ2Opb49ILCX
         SUoVxuNMgE5sjEDMHpH6d6ktmBdWK2hYbXgoa2VWsq7+b/jPDh/9Y46bfq5RKVLjkcfO
         KkKWpp9h76s5e5cOX7jGROQDu6ftlvGjIIVOfNr/wziM76rMXchEEKgdmoVEpqCo8CEe
         XnVl7oCXEFamN8O94pLsIh7ISV5LFKvibI1Ht1S9+bLH2xI0Dh1kRCL4c4vZy19ORvB3
         lGcw==
X-Gm-Message-State: APjAAAUjm9QP28z8/z/ZeIOsQEL1Xlx66Rnox5EZhgrCofF+rFjLTCm5
        5h0rlrPMRUdUy0gwS4t8ARniGWOE
X-Google-Smtp-Source: APXvYqzJB4YmHHDLdWxGw/gxHtBIsdyjdqqfFfBq0afNUwu5NbJ0VZT2+sgpIvQC3mGQpJOi7q44FA==
X-Received: by 2002:a2e:8016:: with SMTP id j22mr989015ljg.24.1575022796898;
        Fri, 29 Nov 2019 02:19:56 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id g85sm9990868lfd.66.2019.11.29.02.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 02:19:54 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@xi.terra>)
        id 1iadNU-0002Yq-Hx; Fri, 29 Nov 2019 11:19:56 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 4/4] staging: gigaset: rename endpoint-descriptor identifier
Date:   Fri, 29 Nov 2019 11:17:53 +0100
Message-Id: <20191129101753.9721-5-johan@kernel.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191129101753.9721-1-johan@kernel.org>
References: <20191129101753.9721-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename an endpoint-descriptor pointer to shut up a checkpatch warning
about a line being over 80 columns, which is bound to generate a bunch
of clean up patches otherwise.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/staging/isdn/gigaset/usb-gigaset.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/isdn/gigaset/usb-gigaset.c b/drivers/staging/isdn/gigaset/usb-gigaset.c
index 6c07c8379711..d5fab2ea25b4 100644
--- a/drivers/staging/isdn/gigaset/usb-gigaset.c
+++ b/drivers/staging/isdn/gigaset/usb-gigaset.c
@@ -652,7 +652,7 @@ static int gigaset_probe(struct usb_interface *interface,
 	struct usb_host_interface *hostif = interface->cur_altsetting;
 	struct cardstate *cs = NULL;
 	struct usb_cardstate *ucs = NULL;
-	struct usb_endpoint_descriptor *endpoint;
+	struct usb_endpoint_descriptor *epd;
 	int buffer_size;
 
 	gig_dbg(DEBUG_ANY, "%s: Check if device matches ...", __func__);
@@ -703,17 +703,17 @@ static int gigaset_probe(struct usb_interface *interface,
 	/* save address of controller structure */
 	usb_set_intfdata(interface, cs);
 
-	endpoint = &hostif->endpoint[0].desc;
+	epd = &hostif->endpoint[0].desc;
 
-	if (!usb_endpoint_dir_out(endpoint) || !usb_endpoint_xfer_bulk(endpoint)) {
+	if (!usb_endpoint_dir_out(epd) || !usb_endpoint_xfer_bulk(epd)) {
 		dev_err(&interface->dev, "missing bulk-out endpoint\n");
 		retval = -ENODEV;
 		goto error;
 	}
 
-	buffer_size = le16_to_cpu(endpoint->wMaxPacketSize);
+	buffer_size = le16_to_cpu(epd->wMaxPacketSize);
 	ucs->bulk_out_size = buffer_size;
-	ucs->bulk_out_epnum = usb_endpoint_num(endpoint);
+	ucs->bulk_out_epnum = usb_endpoint_num(epd);
 	ucs->bulk_out_buffer = kmalloc(buffer_size, GFP_KERNEL);
 	if (!ucs->bulk_out_buffer) {
 		dev_err(cs->dev, "Couldn't allocate bulk_out_buffer\n");
@@ -728,9 +728,9 @@ static int gigaset_probe(struct usb_interface *interface,
 		goto error;
 	}
 
-	endpoint = &hostif->endpoint[1].desc;
+	epd = &hostif->endpoint[1].desc;
 
-	if (!usb_endpoint_dir_in(endpoint) || !usb_endpoint_xfer_int(endpoint)) {
+	if (!usb_endpoint_dir_in(epd) || !usb_endpoint_xfer_int(epd)) {
 		dev_err(&interface->dev, "missing int-in endpoint\n");
 		retval = -ENODEV;
 		goto error;
@@ -744,7 +744,7 @@ static int gigaset_probe(struct usb_interface *interface,
 		retval = -ENOMEM;
 		goto error;
 	}
-	buffer_size = le16_to_cpu(endpoint->wMaxPacketSize);
+	buffer_size = le16_to_cpu(epd->wMaxPacketSize);
 	ucs->rcvbuf_size = buffer_size;
 	ucs->rcvbuf = kmalloc(buffer_size, GFP_KERNEL);
 	if (!ucs->rcvbuf) {
@@ -754,10 +754,10 @@ static int gigaset_probe(struct usb_interface *interface,
 	}
 	/* Fill the interrupt urb and send it to the core */
 	usb_fill_int_urb(ucs->read_urb, udev,
-			 usb_rcvintpipe(udev, usb_endpoint_num(endpoint)),
+			 usb_rcvintpipe(udev, usb_endpoint_num(epd)),
 			 ucs->rcvbuf, buffer_size,
 			 gigaset_read_int_callback,
-			 cs, endpoint->bInterval);
+			 cs, epd->bInterval);
 
 	retval = usb_submit_urb(ucs->read_urb, GFP_KERNEL);
 	if (retval) {
-- 
2.24.0

