Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A204513C8CF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 17:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgAOQHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 11:07:55 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34809 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbgAOQHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 11:07:54 -0500
Received: by mail-qt1-f196.google.com with SMTP id 5so16218002qtz.1;
        Wed, 15 Jan 2020 08:07:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=46QQbf/7xY0XXnmz2tYswXMRkkq1sq4i40/0AAKflts=;
        b=iKcqODa4BncMFy9yf967yQiQ4e1hypZ35Kspvsn9615Df5ihLYfC+Tdhv9HbRxsNG6
         UL02ocGc692NeBS4c+vI6oDQOOgFSBACcaQK2fOITK8N9reH8U7US4ReD2OfPwUVMkty
         RI8VFOvYzEz/PTfIlewdardpsm7e62n4vID1mAGOgCLQTUoCYxUkr1FPhb6Jg5fF2o+U
         zwPu8Nalp/DvyF0Azf1r8rCr5SYyClR2v42p0mpWgHtTH0QSQNP7k715rTcjgEBORGKV
         Se7uJF6XTZyf72aH46Bfh3IYUWJNecqKpADz5RqxlMjrlRZA/+AwXUlkzI90/bVgydRD
         Gejg==
X-Gm-Message-State: APjAAAV4Zk51tATIwafKZxff9NMp0bdmoA/A1cvHGZ8aFZmxSvJ3qcxp
        b9V3WUOfahDzYnMpZckaFKj0YTAc
X-Google-Smtp-Source: APXvYqwzN9XlXgiCJOHOzppCDgjC104jsqTEEFdkqciOeSGlAPVe68Kr5Xf4J+iBvOBnPUweFUNeng==
X-Received: by 2002:aed:3fce:: with SMTP id w14mr4477223qth.0.1579104472892;
        Wed, 15 Jan 2020 08:07:52 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a14sm8606047qko.92.2020.01.15.08.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 08:07:52 -0800 (PST)
Date:   Wed, 15 Jan 2020 11:07:50 -0500
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH RESEND] sparc/console: kill off obsolete declarations
Message-ID: <20200115160749.GA3951901@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 09d3f3f0e02c ("sparc: Kill PROM console driver.") missed removing
the declarations of the deleted prom_con structure and prom_con_init
function from console.h. Kill them off now.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 include/linux/console.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index d09951d5a94e..f33016b3a401 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -101,7 +101,6 @@ extern const struct consw *conswitchp;
 extern const struct consw dummy_con;	/* dummy console buffer */
 extern const struct consw vga_con;	/* VGA text console */
 extern const struct consw newport_con;	/* SGI Newport console  */
-extern const struct consw prom_con;	/* SPARC PROM console */
 
 int con_is_bound(const struct consw *csw);
 int do_unregister_con_driver(const struct consw *csw);
@@ -201,7 +200,6 @@ extern void suspend_console(void);
 extern void resume_console(void);
 
 int mda_console_init(void);
-void prom_con_init(void);
 
 void vcs_make_sysfs(int index);
 void vcs_remove_sysfs(int index);
-- 
2.24.1

