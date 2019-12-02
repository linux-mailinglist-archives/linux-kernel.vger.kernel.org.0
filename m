Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A400510E731
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 09:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfLBI4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 03:56:33 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37644 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbfLBI42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 03:56:28 -0500
Received: by mail-lf1-f65.google.com with SMTP id b15so3049592lfc.4;
        Mon, 02 Dec 2019 00:56:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vgj7PGsaCd+QK5EW8HOwKnXzkNAAF8dwOAUSS+ipPTs=;
        b=PNgHJcIW8jJKPg6G2bATiMVfrM72WsUyXXSeDtgQTOW+Ht8xe8avDe+QXC6/LQgJ4U
         5Y6q+/1U0Bq5sVj0bArHQKT8/jTy3sRYlX5zzV0yEZODore/WUuzQRqbCu7hPdAs3ePj
         zaqsMG5U29burTfItEsnE/JjsMVT81KYdm7cQV4R9COKVNgR+e5/AcV3XDu3E7/ImE/S
         UhV6YGAhe3dXhEvRtPo+JmJMi1Kou39mwBdbM4Wi3jf9yq/v0pHIWJOZW3qHTYxlpfW4
         HxbkDhfKP3aIxCpNP2Xzw693dc9eG4U1TgI2kg93/I6spK+uvnpRlSU/Y1B8BZ3ANijK
         nCug==
X-Gm-Message-State: APjAAAVw/BRMne9qv+yjASDyqQy0RT3W1hZV1zGdbPY5j54CGZFd5hr/
        T1vlGE67jP5WWzu5ST2AYVU=
X-Google-Smtp-Source: APXvYqwjI7A2nNfjVQ/adXNCF5IUWlHXA/tLmM97n2/NNaRd1GaOCFHc8A1kKyESx/7NfA4ZkO2/Pw==
X-Received: by 2002:ac2:5462:: with SMTP id e2mr33337163lfn.181.1575276986428;
        Mon, 02 Dec 2019 00:56:26 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id e7sm14595995lja.5.2019.12.02.00.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 00:56:25 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@xi.terra>)
        id 1ibhVM-0003KA-45; Mon, 02 Dec 2019 09:56:28 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 3/3] staging: gigaset: add endpoint-type sanity check
Date:   Mon,  2 Dec 2019 09:56:10 +0100
Message-Id: <20191202085610.12719-4-johan@kernel.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191202085610.12719-1-johan@kernel.org>
References: <20191202085610.12719-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing endpoint-type sanity checks to probe.

This specifically prevents a warning in USB core on URB submission when
fuzzing USB descriptors.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/staging/isdn/gigaset/usb-gigaset.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/staging/isdn/gigaset/usb-gigaset.c b/drivers/staging/isdn/gigaset/usb-gigaset.c
index a84722d83bc6..a20c0bfa68f3 100644
--- a/drivers/staging/isdn/gigaset/usb-gigaset.c
+++ b/drivers/staging/isdn/gigaset/usb-gigaset.c
@@ -705,6 +705,12 @@ static int gigaset_probe(struct usb_interface *interface,
 
 	endpoint = &hostif->endpoint[0].desc;
 
+	if (!usb_endpoint_is_bulk_out(endpoint)) {
+		dev_err(&interface->dev, "missing bulk-out endpoint\n");
+		retval = -ENODEV;
+		goto error;
+	}
+
 	buffer_size = le16_to_cpu(endpoint->wMaxPacketSize);
 	ucs->bulk_out_size = buffer_size;
 	ucs->bulk_out_epnum = usb_endpoint_num(endpoint);
@@ -724,6 +730,12 @@ static int gigaset_probe(struct usb_interface *interface,
 
 	endpoint = &hostif->endpoint[1].desc;
 
+	if (!usb_endpoint_is_int_in(endpoint)) {
+		dev_err(&interface->dev, "missing int-in endpoint\n");
+		retval = -ENODEV;
+		goto error;
+	}
+
 	ucs->busy = 0;
 
 	ucs->read_urb = usb_alloc_urb(0, GFP_KERNEL);
-- 
2.24.0

