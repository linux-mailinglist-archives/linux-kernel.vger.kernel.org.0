Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11838BAC88
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 04:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391778AbfIWCZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Sep 2019 22:25:01 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34021 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389942AbfIWCZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 22:25:00 -0400
Received: by mail-pf1-f193.google.com with SMTP id b128so8195523pfa.1;
        Sun, 22 Sep 2019 19:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+hRV3PvqEAgfOnsE7U5CSmdgBj+kc3hqORfpzzvqnEI=;
        b=eqPXj1vohRUH7v65sepk/7m5P/sn13gC5QLljZajsGOmKmK4tb4pNVSJuyEg8Vdft1
         WeE6eMICoqR4ot6Ig2Ai1zwlu0rffjaPCBc2Bla6BeoZjGQ4+G+itLAfM6MnUZDjD77j
         fZ1D/LTlJhtCb8EmKF1IHfZxOsIvRCB31EoWkBUdi5V9L8oHj/yrnLWCXg4bxcCNJsHD
         MBlaEKugmo2kML3avt5VW2ZL+5X2ki96CESDTj8U4WJ3Sd0gHzmNzIa9WO/DfDNsexPy
         zDVDFlwzICeazdeT54O5hGNMCGKLVZM4pphRVhoPwiLv9/r9KoyfWrm1oA3Fh7DVKfmB
         Cllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+hRV3PvqEAgfOnsE7U5CSmdgBj+kc3hqORfpzzvqnEI=;
        b=TCXlau7B+tia0wkWLVn9Lqf/PqdKrqzJETzrrTZ9YuqLAKqRHbo8Js4IRBZ7JcJymN
         00ZNkTbTiIf/8nQNb3jRKZuh2xO+t4Sv2UWtsZt9SiZ2s2ukJqGzEYHtFBhaWWneJvNP
         LVKisYRyFfnIvQoq2QLhELh1N+GuWSzJjITpfSeNO4YIZppVJaCvL12ZJRrYZmRHnGU4
         m4aco66p34W+OXD8kXpO105waxsjky982vLyCajYMJ82f1i7NjkuXZYnGzAbdkbGm8yy
         x9C3iUYf/IUynguIQfVreF2xffLigevQRFJLrceLOLC3aQE8QlM8alDxx4U71+yb3fnj
         5nXQ==
X-Gm-Message-State: APjAAAVlbpKgCdKUds0hGN2wv68QkobEH0awOOwJgKZGc6FoPhsopMSM
        ibK9Y5S+q5frilq5kD8jUMA=
X-Google-Smtp-Source: APXvYqwIsSuUpy2R1+0gp2ahpvK4IFIHEoSTWpksEK04GIv0C7Ga+EhHp+joNIeLO9+gRWslf1zmNg==
X-Received: by 2002:a65:6550:: with SMTP id a16mr25351747pgw.115.1569205499830;
        Sun, 22 Sep 2019 19:24:59 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id u5sm11564283pfl.25.2019.09.22.19.24.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Sep 2019 19:24:59 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH V2 2/7] USB: serial: f81232: Add tx_empty function
Date:   Mon, 23 Sep 2019 10:24:44 +0800
Message-Id: <20190923022449.10952-3-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190923022449.10952-1-hpeter+linux_kernel@gmail.com>
References: <20190923022449.10952-1-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tx_empty() function for F81232.

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
 drivers/usb/serial/f81232.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index c07d376c743d..b42b3738a768 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -685,6 +685,23 @@ static void f81232_dtr_rts(struct usb_serial_port *port, int on)
 		f81232_set_mctrl(port, 0, TIOCM_DTR | TIOCM_RTS);
 }
 
+static bool f81232_tx_empty(struct usb_serial_port *port)
+{
+	int status;
+	u8 tmp;
+
+	status = f81232_get_register(port, LINE_STATUS_REGISTER, &tmp);
+	if (status) {
+		dev_err(&port->dev, "get LSR status failed: %d\n", status);
+		return false;
+	}
+
+	if ((tmp & UART_LSR_TEMT) != UART_LSR_TEMT)
+		return false;
+
+	return true;
+}
+
 static int f81232_carrier_raised(struct usb_serial_port *port)
 {
 	u8 msr;
@@ -820,6 +837,7 @@ static struct usb_serial_driver f81232_device = {
 	.tiocmget =		f81232_tiocmget,
 	.tiocmset =		f81232_tiocmset,
 	.tiocmiwait =		usb_serial_generic_tiocmiwait,
+	.tx_empty =		f81232_tx_empty,
 	.process_read_urb =	f81232_process_read_urb,
 	.read_int_callback =	f81232_read_int_callback,
 	.port_probe =		f81232_port_probe,
-- 
2.17.1

