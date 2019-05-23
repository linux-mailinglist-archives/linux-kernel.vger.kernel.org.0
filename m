Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F156C27483
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 04:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbfEWCjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 22:39:08 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41139 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfEWCjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 22:39:07 -0400
Received: by mail-pl1-f196.google.com with SMTP id f12so1985706plt.8;
        Wed, 22 May 2019 19:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=XeFlFWw61JofilTs9ih/NQ02dCASKl1n6cWqz6/+ogs=;
        b=XkhqGDiaRbQB/JoWWIb3ZtwGo6mgeC1ka1Xxe9Uf+j0yYT0arBII+Q3+NPUw3e/pMX
         rY7PZU6v/7aeqgZZJImaVabVzmX1mHf4DxR/EdIuApMN9tuFRylTXNfbx6XsQDNxXWx1
         MQ3RU+83pS08GZL5yo2R17re7v+1h4rWEOp4uVLUelx55Pl253go6BSc7ZKHxFxjfbzf
         5SyJrBpa1MSDgP65YibZ96jB7+cLtH7hW4d3yfj3wLJGfzGWNtqOXlKrDhI0VNzlXdQ0
         wxPMCVavLd+KqRyDdL5ZeQtYkRS5gK2YbK/7KsZQqyCFac4jiQKmupIAv6UUlviEChP5
         53mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XeFlFWw61JofilTs9ih/NQ02dCASKl1n6cWqz6/+ogs=;
        b=li8cGFcFT8TmCfXyaQpZIp6vW6ktsJa43BDSFGqSodFyzMh8s48hv47BcLWSkvoFi+
         vqp4S3qpTvcY3ssjZ9qT5Ec+ntXA3sVB1Fk4pFdueM+IWXpET728VPANvYbmISiVONpE
         psBvc6zuZT+iZ/OndB8o5hNuM5XURFKvm12q8h+baL3dbOhgRDcY+HpeCyrgdlZYHNQp
         QFKAqUdd7tupH5dXciYU138Q3Hx81HMEA3X92KK5YgOupVWoMqzjpWGWTSW+u5rJgFB6
         7lZUl6x94N/WveVi2tsblM5NKnwo0VNHfjvSwjwGHgLat4BaKBE8hh7HxWnki0rxPsdh
         IviA==
X-Gm-Message-State: APjAAAXdoeDh17l0Azj+jcdWNd9W1ZINp9dBtDGIvbGcahyPwvRau2yg
        xhlpHy+XaBDs3FrMzanDmRs=
X-Google-Smtp-Source: APXvYqylhrIxYyfJbmxLV+wjUJ+riM7GvaXwAG0WHVTIWQ9R7+nNngeogLVeAPwcpjLOULlKMX9BEQ==
X-Received: by 2002:a17:902:3103:: with SMTP id w3mr19279282plb.187.1558579147085;
        Wed, 22 May 2019 19:39:07 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id d15sm78095232pfm.186.2019.05.22.19.39.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 19:39:06 -0700 (PDT)
Date:   Thu, 23 May 2019 10:38:55 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sg: Fix a double-fetch bug in drivers/scsi/sg.c
Message-ID: <20190523023855.GA17852@zhanggen-UX430UQ>
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
