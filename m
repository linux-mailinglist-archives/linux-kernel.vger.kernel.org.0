Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC58E30636
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 03:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfEaB1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 21:27:20 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39646 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfEaB1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 21:27:19 -0400
Received: by mail-pf1-f196.google.com with SMTP id j2so5086569pfe.6;
        Thu, 30 May 2019 18:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=XeFlFWw61JofilTs9ih/NQ02dCASKl1n6cWqz6/+ogs=;
        b=HAug/j4v3u1vNp4tcIUHDMtYDOYLfl+rcQaw1ds5LnTjomrRmIVt3PbpFA9cEcMyaO
         qbSG9n2rN71i1U8bfQZle2+UMHzOlrXZSdQQ/aA8L2KWIeJutyOMK/JF08ozNoKl8KPb
         mdtLp9uTERKqWNkEt00lWSZzZxRawZOCbWky7MnRDnM8CmIwy6jUb4INCoSkdkSps+0q
         5FZvOtMYh0N4xP1RbezuVPoJE6EUYo0WM61qBNkJ68Epn6yDL9AkgcyYiWydnlRgUYCO
         xWVylqqwgmI2V+fNS8k+HSka+MuOytk1RpLS5Pof2a4+vgdKjVCSJLPgAWRk9M0Iw/K4
         GNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XeFlFWw61JofilTs9ih/NQ02dCASKl1n6cWqz6/+ogs=;
        b=IJ9ezWEvwMg8J84NcOFP/mlFOJwYPA5BRcBj+NYhNK13VBxmKryoplNBF89AR6CfpK
         yv9SyjmkfSB/Fa/p225DzUeYEOR5+KXiFqGFNrlt5Lo5D1YSQ8rTReFDoW/lZn3/bvLT
         M5OZKvE4MJ3jeXvUzYlGIDWMqSVNoQ2U7Su0yLpYU9qs5nkeMkeVMXX0uy+UA6RNruUN
         N3rmFWrDMhStoUWUR+v9lOmjdVQ79wZuv64hxj/idpQgS71Bgib1S3ttoK8KZFLsJLto
         Wb/HkZ4DSSw07gqpGjEfGohF+zI5mIvPqY3JEw6AW7mypKybEyPvUHmWXcFC8Ia0Yldb
         iFOw==
X-Gm-Message-State: APjAAAWs+PwMb2AKnpNV22HQ39i2zA8Tb9EFoX8H4vpER5WvZ+xKpLjY
        4id/pHAvhFNfut5HPHWNz+fzNKoJ
X-Google-Smtp-Source: APXvYqxEoyKAl2d8qaVyyHGKZXscLKU/6aAkpjSIDbhmuUuvZcj/GOYdylmamysxzlodu0z4QY60fw==
X-Received: by 2002:a63:31d8:: with SMTP id x207mr5975490pgx.403.1559266039075;
        Thu, 30 May 2019 18:27:19 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id j2sm5258949pfb.157.2019.05.30.18.27.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 18:27:18 -0700 (PDT)
Date:   Fri, 31 May 2019 09:27:04 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     dgilbert@interlog.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sg: fix a double-fetch bug in sg_write()
Message-ID: <20190531012704.GA4541@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sg_write(), the opcode of the command is fetched the first time from 
the userspace by __get_user(). Then the whole command, the opcode 
included, is fetched again from userspace by __copy_from_user(). 
However, a malicious user can change the opcode between the two fetches.
This can cause inconsistent data and potential errors as cmnd is used in
the following codes.

Thus we should check opcode between the two fetches to prevent this.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
---
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index d3f1531..a2971b8 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -694,6 +694,8 @@ sg_write(struct file *filp, const char __user *buf, size_t count, loff_t * ppos)
 	hp->flags = input_size;	/* structure abuse ... */
 	hp->pack_id = old_hdr.pack_id;
 	hp->usr_ptr = NULL;
+	if (opcode != cmnd[0])
+		return -EINVAL;
 	if (__copy_from_user(cmnd, buf, cmd_size))
 		return -EFAULT;
 	/*
---
