Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD5346FF55
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 14:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730234AbfGVMMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 08:12:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728413AbfGVMMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 08:12:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFCC42190D;
        Mon, 22 Jul 2019 12:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563797525;
        bh=qLldPsyd6yf9Fdsf6QSRwxLHpVsOjUD+VEFS6MJ1y4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dWnCDwmoAqmV22KdM2O5bWGr+S2fKb+oj7IzqcNdYX5aPQtjDFfTtXXc2385Pk5Rg
         JuOD5wvsDpJRguWWJoSqSqlV5IuQaaKeZNwOQZMNq3Nx7PEBlshRGWTWwzZz7cyqIr
         Zdf4TlZqDBExtgmKfb5UEcJjKyRoRGO1SxNNGkyg=
Date:   Mon, 22 Jul 2019 14:12:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mauro Rossi <issor.oruam@gmail.com>,
        Chih-Wei Huang <cwhuang@android-x86.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: fix build errors in paged buffer handling code
Message-ID: <20190722121202.GB31543@kroah.com>
References: <20190722055536.15342-1-tiwai@suse.de>
 <s5hzhl68es7.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hzhl68es7.wl-tiwai@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 01:55:20PM +0200, Takashi Iwai wrote:
> On Mon, 22 Jul 2019 07:55:36 +0200,
> Takashi Iwai wrote:
> > 
> > From: Mauro Rossi <issor.oruam@gmail.com>
> > 
> > fw_{grow,map}_paged_buf() need to be defined as static inline
> > when CONFIG_FW_LOADER_PAGED_BUF is not enabled,
> > infact fw_free_paged_buf() is also defined as static inline
> > when CONFIG_FW_LOADER_PAGED_BUF is not enabled.
> > 
> > Fixes the following mutiple definition building errors for Android kernel:
> > 
> > drivers/base/firmware_loader/fallback_efi.o: In function `fw_grow_paged_buf':
> > fallback_efi.c:(.text+0x0): multiple definition of `fw_grow_paged_buf'
> > drivers/base/firmware_loader/main.o:(.text+0x73b): first defined here
> > drivers/base/firmware_loader/fallback_efi.o: In function `fw_map_paged_buf':
> > fallback_efi.c:(.text+0xf): multiple definition of `fw_map_paged_buf'
> > drivers/base/firmware_loader/main.o:(.text+0x74a): first defined here
> > 
> > [ slightly corrected the patch description -- tiwai ]
> > 
> > Fixes: 5342e7093ff2 ("firmware: Factor out the paged buffer handling code")
> > Fixes: 82fd7a8142a1 ("firmware: Add support for loading compressed files")
> > Signed-off-by: Mauro Rossi <issor.oruam@gmail.com>
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> 
> Please discard this one.  It's missing the inline, as Mauro already
> suggested in another mail.
> 
> Will resubmit the revised one.  Sorry for inconvenience.

Ugh, I already applied it, if there is no code difference, can we just
leave what I have already committed in the tree?

thanks,

greg k-h
