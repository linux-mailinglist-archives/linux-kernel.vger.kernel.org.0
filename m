Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 250AC12DE8E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jan 2020 11:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgAAKnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jan 2020 05:43:24 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:42996 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgAAKnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 05:43:24 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id C41E62005E4;
        Wed,  1 Jan 2020 10:43:22 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 2DB5D20085; Wed,  1 Jan 2020 11:43:13 +0100 (CET)
Date:   Wed, 1 Jan 2020 11:43:13 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, youling257@gmail.com
Subject: Re: [PATCH] early init: open /dev/console with O_LARGEFILE
Message-ID: <20200101104313.GA666771@light.dominikbrodowski.net>
References: <20191231150226.GA523748@light.dominikbrodowski.net>
 <20200101003017.GA116793@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200101003017.GA116793@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@youling 257: could you test the attached patch, please?

Thanks,
	Dominik

On Tue, Dec 31, 2019 at 07:30:19PM -0500, Arvind Sankar wrote:
> On Tue, Dec 31, 2019 at 04:02:26PM +0100, Dominik Brodowski wrote:
> > If force_o_largefile() is true, /dev/console used to be opened
> > with O_LARGEFILE. Retain that behaviour.
> > 
> 
> One other thing that used to happen is fsnotify_open() -- I don't know
> how that might affect this, but it seems like the only thing left that's
> different.

Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

diff --git a/init/main.c b/init/main.c
index d12777775cb0..3f4163046200 100644
--- a/init/main.c
+++ b/init/main.c
@@ -94,6 +94,7 @@
 #include <linux/jump_label.h>
 #include <linux/mem_encrypt.h>
 #include <linux/file.h>
+#include <linux/fsnotify.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -1166,6 +1167,7 @@ void console_on_rootfs(void)
 			  O_RDWR | (force_o_largefile() ? O_LARGEFILE : 0), 0);
 	if (IS_ERR(file))
 		goto err_out;
+	fsnotify_open(file);
 
 	/* create stdin/stdout/stderr, this should never fail */
 	for (i = 0; i < 3; i++) {
