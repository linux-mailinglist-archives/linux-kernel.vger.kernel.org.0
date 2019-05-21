Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4FE724643
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 05:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfEUDVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 23:21:31 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45284 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfEUDVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 23:21:31 -0400
Received: by mail-pl1-f196.google.com with SMTP id a5so7663188pls.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 20:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O+OVGIDc+UNF/2ytbliez6ZGSWBgtZ2HgS7OPBavs2I=;
        b=prHF7N2LXS2E+VuhsXJBEh0Ann0JkfxxI8Dj1AC8XgnVjN3p2RjP7j0kp4MeBfy0tr
         qDi1i0B8pimkDu8vsDCKlKKwa2C2YsxiguNL31UV6+2MUZs5bZfdgYXM8LxSlLbA7iBR
         i3HFdAPtptvWejVgfC00Lv2dNCRZcVKoWr2c9Pzw/3DRtdOXMDt4vBgBRczLTJJm0Spm
         5xd/SQjbjc3RQtCJXc/+dWxTOIQJOPrJE8BM06hFTTneIKfXLGH5QVW1m7Q13NpwYtA2
         HGgCHqsi0BnPDL7x/+A6JEEPn+bdAOsbcpNdgN8sKM+rX3qpyrBIFJS5bRWvWENiJAlS
         6s9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O+OVGIDc+UNF/2ytbliez6ZGSWBgtZ2HgS7OPBavs2I=;
        b=Y9b/EvBWuF2i0WoeGI9f92GP0OnC/F1V66oiS34gnBPGwa2pgEJ0VssbYXn82corAE
         Huoeg0tD/tV/x/YQUBIhHEXn1FA0gJ7aces8g6En10xe/odWsChekDnKV5ussaonjGCA
         sLorTWscdUKyQxKX9FKS0uO4FkXNOw2GGi6VHA0X5Zs0GYaIg/Yq5Yj2eSSFSN4p6DBW
         ndHPvhnCCIZlKgdHwS/p4U+Erc+BxnC9kvzs11Er3oQK3wxjmXwWCh923fj2T8toFgql
         3H86bwa3TyhMW/jKGixeJWNsTiYgMiaPMp1QStGkCJpchXvyeYLSq/7YkhylSB0ulGg7
         m2wg==
X-Gm-Message-State: APjAAAXEp77NotY/XoeNVxcXp5VxVScYU/zZYZ6h4uok7RoMeHH8gwHN
        RBp5a65Hk6DEq8grX5letaUbVHwo9xw=
X-Google-Smtp-Source: APXvYqxus0DnT4wQdq0vi70xsNnYiw+zzzzWDrbFCVqIiok3rQ/4gTKJe0Hy8I57zmBZCflDBGWARg==
X-Received: by 2002:a17:902:9b96:: with SMTP id y22mr38356264plp.124.1558408890485;
        Mon, 20 May 2019 20:21:30 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id v81sm37965914pfa.16.2019.05.20.20.21.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 20:21:29 -0700 (PDT)
Date:   Tue, 21 May 2019 11:21:18 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] vt: Fix a missing-check bug in drivers/tty/vt/vt.c
Message-ID: <20190521032118.GC5263@zhanggen-UX430UQ>
References: <20190521022940.GA4858@zhanggen-UX430UQ>
 <nycvar.YSQ.7.76.1905202242410.1558@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1905202242410.1558@knanqh.ubzr>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 10:55:40PM -0400, Nicolas Pitre wrote:
> As soon as you release the lock, another thread could come along and 
> start using the memory pointed by vc_cons[currcons].d you're about to 
> free here. This is unlikely for an initcall, but still.
> 
> You should consider this ordering instead:
> 
> err_vc_screenbuf:
> 	kfree(vc);
> 	vc_cons[currcons].d = NULL;
> err_vc:
> 	console_unlock();
> 	return -ENOMEM;
In function con_init(), the pointer variable vc_cons[currcons].d, vc and
vc->vc_screenbuf is allocated a memory space via kzalloc(). And they are
used in the following codes.
However, when there is a memory allocation error, kzalloc() can fail.
Thus null pointer (vc_cons[currcons].d, vc and vc->vc_screenbuf)
dereference may happen. And it will cause the kernel to crash. Therefore,
we should check return value and handle the error.
Further,the loop condition MIN_NR_CONSOLES is defined as 1 in
include/uapi/linux/vt.h and it is not changed. So there is no need to
unwind the loop.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>

---
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index fdd12f8..ea47eb3 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3350,10 +3350,14 @@ static int __init con_init(void)
 
 	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
 		vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data), GFP_NOWAIT);
+		if (!vc)
+			goto err_vc;
 		INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
 		tty_port_init(&vc->port);
 		visual_init(vc, currcons, 1);
 		vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_NOWAIT);
+		if (!vc->vc_screenbuf)
+			goto err_vc_screenbuf;
 		vc_init(vc, vc->vc_rows, vc->vc_cols,
 			currcons || !vc->vc_sw->con_save_screen);
 	}
@@ -3375,6 +3379,13 @@ static int __init con_init(void)
 	register_console(&vt_console_driver);
 #endif
 	return 0;
+err_vc_screenbuf:
+	kfree(vc);
+	vc_cons[currcons].d = NULL;
+err_vc:
+	console_unlock();
+	return -ENOMEM;
+
 }
 console_initcall(con_init);
---
