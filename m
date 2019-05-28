Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E59E2BC82
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 02:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfE1AqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 20:46:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35972 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbfE1AqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 20:46:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id a3so9865644pgb.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 17:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=iByH5cRdkrBlU0cWCYNL4Lwn5aV82NXZYp0iP2XtmzY=;
        b=lBxXRNMYOFCEom2dMcyQiJUOVpIkLoT2tAh7sb5qJ5bOohLO+bNISPUIw+OvXKpKoq
         CI7ulyPrFR1MfYBdwHyCg54Bg69ny/rD3474/QtVgmY5bJSPSFIC1pzGRsCvmjuzZTWl
         AHNzX97JCup841KDy4hyEVRgTeXoF5TWZp8e+yFUT2sAWOwKPqGMqh2Xa9mIcLXB6mfS
         +x4Vqi5rsLhLM0ujnpH7XtniTDpYuJ/xyW2J3h+R+xV+SEIsXQB1j5djFnQkzkN9P0Ff
         nh9IG02q3MyY9xh6zdSZbXqkcEug+nXsbblqOfFgU/R0hDw1zYtSnHQAPRdulPuNbsQY
         ZNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=iByH5cRdkrBlU0cWCYNL4Lwn5aV82NXZYp0iP2XtmzY=;
        b=UeNneWEZEa0+XKvVCxGUsORzlqj4UFhe2O5uwNnjzow9jfHDPZFL4xNKR2QlWwQ9Ko
         3LmkxvA1w9v20run13aBZ80gwE88yzujI03pKXzIZHm9h1cprCq4LmB5sBgm+MZyzCuA
         wcPrlEjSRwnF2de8fFOC21znuuq3BrWFI+eFD0OFQONcbzWMZYT6bSydpj/T7TCGUzPu
         3UZ65t3dZmw1934WQsYaoxcRlmvVuBVNAZcplabc54ojSYvFIoXpTrpbJQpWyTShY66W
         +dD867+P5fpDJOmVpzlL1wiAfUG/NumxPAuv1DbCJdRwJer3D897zaBAALfMIupBGX8D
         F9HA==
X-Gm-Message-State: APjAAAXfOOBkfcN43PFcIsaOnM2GJGrKOXa2R3SK7efXJzpSZbTDIopa
        YicpFn1BBpX/+wamK5LkkigKu9Fw
X-Google-Smtp-Source: APXvYqygVq7XUqI2HwHaWKnh1r6W9Hhj3+NiQsCCaNTVkp9JXotrql3EePYzwvpYc4B4Yv/CSYqUNA==
X-Received: by 2002:a62:81c1:: with SMTP id t184mr136612246pfd.221.1559004363670;
        Mon, 27 May 2019 17:46:03 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id x16sm11868577pff.30.2019.05.27.17.45.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 17:46:03 -0700 (PDT)
Date:   Tue, 28 May 2019 08:45:29 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com, nico@fluxnic.net,
        kilobyte@angband.pl, textshell@uchuujin.de, mpatocka@redhat.com,
        daniel.vetter@ffwll.ch
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3] vt: Fix a missing-check bug in con_init()
Message-ID: <20190528004529.GA12388@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function con_init(), the pointer variable vc_cons[currcons].d, vc and
vc->vc_screenbuf is allocated by kzalloc(). And they are used in the 
following codes. However, kzalloc() returns NULL when fails, and null 
pointer dereference may happen. And it will cause the kernel to crash. 
Therefore, we should check the return value and handle the error.

Further, since the allcoation is in a loop, we should free all the 
allocated memory in a loop.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
Reviewed-by: Nicolas Pitre <nico@fluxnic.net>
---
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index fdd12f8..d50f68f 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3350,10 +3350,14 @@ static int __init con_init(void)
 
 	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
 		vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data), GFP_NOWAIT);
+		if (!vc)
+			goto fail1;
 		INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
 		tty_port_init(&vc->port);
 		visual_init(vc, currcons, 1);
 		vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_NOWAIT);
+		if (!vc->vc_screenbuf)
+			goto fail2;
 		vc_init(vc, vc->vc_rows, vc->vc_cols,
 			currcons || !vc->vc_sw->con_save_screen);
 	}
@@ -3375,6 +3379,16 @@ static int __init con_init(void)
 	register_console(&vt_console_driver);
 #endif
 	return 0;
+fail1:
+	while (currcons > 0) {
+		currcons--;
+		kfree(vc_cons[currcons].d->vc_screenbuf);
+fail2:
+		kfree(vc_cons[currcons].d);
+		vc_cons[currcons].d = NULL;
+	}
+	console_unlock();
+	return -ENOMEM;
 }
 console_initcall(con_init);
 
---
