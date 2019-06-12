Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A418425FE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 14:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731362AbfFLMgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 08:36:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728606AbfFLMgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:36:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86D5820874;
        Wed, 12 Jun 2019 12:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560342967;
        bh=3HOt9Y5a+Ju6nO9LGaOzbgHTq1M8TaQzr922dhQ5TnQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C11RJh7A4vZMWNXJuoazV3DYDx2qkdbblS3KcHXbH5hng0/TQ3s8E7oZgJ0MX0Nw4
         tGPsVAmB8hSwvRRm8o3pcTcXOohgwOMHW33yXdhv3INzovfPGLs45olc1lE+CHaoGm
         gze5n/2rwVKnAARiifQllQ/V91FNa4o3xJM1PTwY=
Date:   Wed, 12 Jun 2019 14:36:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     dvhart@infradead.org, andy@infradead.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] platform: x86: dell-laptop: no need to check return
 value of debugfs_create functions
Message-ID: <20190612123604.GB25718@kroah.com>
References: <20190612121258.19535-1-gregkh@linuxfoundation.org>
 <20190612121258.19535-3-gregkh@linuxfoundation.org>
 <20190612122105.miyyfkmae24kddwt@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190612122105.miyyfkmae24kddwt@pali>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 02:21:05PM +0200, Pali Rohár wrote:
> On Wednesday 12 June 2019 14:12:53 Greg Kroah-Hartman wrote:
> > When calling debugfs functions, there is no need to ever check the
> > return value.  The function can work or not, but the code logic should
> > never do something different based on this.
> > 
> > Cc: Matthew Garrett <mjg59@srcf.ucam.org>
> > Cc: "Pali Rohár" <pali.rohar@gmail.com>
> > Cc: Darren Hart <dvhart@infradead.org>
> > Cc: Andy Shevchenko <andy@infradead.org>
> > Cc: platform-driver-x86@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/platform/x86/dell-laptop.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell-laptop.c
> > index a561f653cf13..94a2f259031c 100644
> > --- a/drivers/platform/x86/dell-laptop.c
> > +++ b/drivers/platform/x86/dell-laptop.c
> > @@ -2176,9 +2176,8 @@ static int __init dell_init(void)
> >  	kbd_led_init(&platform_device->dev);
> >  
> >  	dell_laptop_dir = debugfs_create_dir("dell_laptop", NULL);
> > -	if (dell_laptop_dir != NULL)
> > -		debugfs_create_file("rfkill", 0444, dell_laptop_dir, NULL,
> > -				    &dell_debugfs_fops);
> > +	debugfs_create_file("rfkill", 0444, dell_laptop_dir, NULL,
> > +			    &dell_debugfs_fops);
> 
> Hi!
> 
> So... debugfs_create_dir() can return NULL, right?

Nope.

> And it is then OK to call
> debugfs_create_file("rfkill", 0444, dell_laptop_dir, ...) with
> dell_laptop_dir = NULL?

Yes.

> Where would be that "rfkill" file created?

The root of debugfs.

But, if debugfs_create_dir() return an error, and you pass that value
into debugfs_create_file() it will happily just return an error back
again, and move on.

So it is always safe to pass the return value of one debugfs call into
another, no need to check anything.  If the system is so messed up that
debugfs_create_dir() fails (i.e. you are out of memory), failing to
create a debugfs file is the least of your worries :)

And even then, no need to change your code logic, the functionality of
your code should never depend on if debugfs is working properly at the
moment or not.

thanks,

greg k-h
