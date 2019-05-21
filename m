Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A85EA24A64
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 10:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfEUIae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 04:30:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45067 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfEUIad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:30:33 -0400
Received: by mail-pf1-f193.google.com with SMTP id s11so8673608pfm.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 01:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=9qeftURaw9bNNJSJoi031v74IuX9clV0memLNOVE3Es=;
        b=uSPF/Pbyn+gaKgyHyihhk4/QO+kCcO9zv2D9HXhLuWw/IUkeMEokUMFdhM/3wSWCOA
         J2pEYb/1WHNiM4jKeduto620LmTNYagArXmPSlM5m7bk2nea32vh5GsQwcOvsVZdyste
         c/xbU6cC57XLLi2i8GDsQMRLP6ltxWBy3csXX5Y912vgu0dOySTbPwUZgaMuyx7gYKUs
         oHxV1FUbKkmRhbBl//I2PCXdq57SMkr0i7W64c57B6LLJRjUrLERnSRLh6KtVoL74L/A
         B3W/r0yovHT4X4bMg0XqO1J8tIMwOXwv8Zk4RQC3VXK35Ins0SH4rCYqmZ3zvHt2E23I
         2B8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=9qeftURaw9bNNJSJoi031v74IuX9clV0memLNOVE3Es=;
        b=Kqh/Sxy4TjH/PzWakmj4pxvPjNsR8MkfbMpAirZuVWLuF9jVC6Cj6Vi8QEvaAKQpvY
         m4ascN4ZYA8+azQ8DHB5dsCvsblZH3sxEwmMCylW5c3uLSN13WXrBUNViKm5naeJ9905
         7cvEsrzHrH4z+DVkigUaDupwgHnyH9KT9MgkkPnUc+opB92VZ+Tz26n7Ylk5Jj312Z5W
         sxpsld9givNN7xBa25uT4nP93UctcJQMv2VQEiL1XV8zHI6vAvdC3thS5Y71HaGhj8PA
         0SH5jABpvp1LVHeZjqdGrFxcRFl1XovsmGXRaLtNNCcvx51KQgReJg252RjBMiPqd6cQ
         VACQ==
X-Gm-Message-State: APjAAAV7W5MyrZN5Q/81zkOpPfI4pV3mNH9jY7auwuuxd9OPjxLoES22
        wrfCBSZc2lzSQ/4YxSlVJvw=
X-Google-Smtp-Source: APXvYqwJv3sGedoUxkeEEXQAFe2cXFj5WENmlGl/Gh4slQf5l2MmUIRJ2Ez6TcQz25p9kerktWjcCQ==
X-Received: by 2002:a63:27c3:: with SMTP id n186mr76908898pgn.189.1558427433316;
        Tue, 21 May 2019 01:30:33 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id t25sm33432031pfq.91.2019.05.21.01.30.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 01:30:32 -0700 (PDT)
Date:   Tue, 21 May 2019 16:30:17 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     songliubraving@fb.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] ip_sockglue: Fix a missing-check bug in
 net/ipv4/ip_sockglue.c
Message-ID: <20190521083017.GH5263@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function ip_ra_control(), the pointer new_ra is allocated a memory 
space via kmalloc(). And it is used in the following codes. However, 
when  there is a memory allocation error, kmalloc() fails. Thus null 
pointer dereference may happen. And it will cause the kernel to crash. 
Therefore, we should check the return value and handle the error.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>

---
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 82f341e..d445839 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -343,6 +343,8 @@ int ip_ra_control(struct sock *sk, unsigned char on,
 		return -EINVAL;
 
 	new_ra = on ? kmalloc(sizeof(*new_ra), GFP_KERNEL) : NULL;
+	if (!new_ra)
+		return -ENOMEM;
 
 	mutex_lock(&net->ipv4.ra_mutex);
 	for (rap = &net->ipv4.ra_chain;
