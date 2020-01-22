Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CED2B144D01
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 09:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgAVIMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 03:12:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:45940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgAVIMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 03:12:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 181542253D;
        Wed, 22 Jan 2020 08:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579680727;
        bh=6D02fB/ORVNBlFCnxqx9b9CQszWcygA7uSglzQEb/xQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dp0AgDqLgwPPElizWGTDWJSiRgvVOQuAc/zWgUVlaoypafeLzeLfauukXzS2IjGeO
         ZZPhmaqr/G/HChws2nw9HGn0S/uqAX1gGKDF0xTlEmPy+3KNX3zNHcvx+b+YoAgVC2
         dBOnligizNSEyE3ij13rxCOQ5p0G2xKrJM94ioBA=
Date:   Wed, 22 Jan 2020 09:12:05 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Will Deacon <will@kernel.org>
Cc:     Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH] dynamic_debug: allow to work if debugfs is disabled
Message-ID: <20200122081205.GA2227985@kroah.com>
References: <20200122074343.GA2099098@kroah.com>
 <20200122080352.GA15354@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122080352.GA15354@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 08:03:53AM +0000, Will Deacon wrote:
> On Wed, Jan 22, 2020 at 08:43:43AM +0100, Greg Kroah-Hartman wrote:
> > With the realization that having debugfs enabled on "production" systems is
> > generally not a good idea, debugfs is being disabled from more and more
> > platforms over time.  However, the functionality of dynamic debugging still is
> > needed at times, and since it relies on debugfs for its user api, having
> > debugfs disabled also forces dynamic debug to be disabled.
> 
> Why is the dyndbg= command-line option not sufficient for these use-cases?

They want to enable things after booting, and changing the kernel
command line is not something you can do on many systems (i.e.
locked-down-bootloaders like embedded systems).

Also, the whole option is prevented to be booted if debugfs is not
enabled, so the command line wouldn't even work in that situation :)

> > To get around this, move the "control" file for dynamic_debug to procfs IFF
> > debugfs is disabled.  This lets people turn on debugging as needed at runtime
> > for individual driverfs and subsystems.
> 
> Hmm. If something called "dynamic_debug" is getting moved out of debugfs,
> this does raise the question as to what (if anything) should be left behind.
> I worry this is a bit of a slippery slope...

I totally agree, but dynamic_debug is independant of debugfs with the
exception of the control file itself.

> > Reported-by: many different companies
> > Cc: Jason Baron <jbaron@akamai.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  .../admin-guide/dynamic-debug-howto.rst         |  3 +++
> >  lib/Kconfig.debug                               |  2 +-
> >  lib/dynamic_debug.c                             | 17 ++++++++++++++---
> >  3 files changed, 18 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
> > index 252e5ef324e5..41f43a373a6a 100644
> > --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> > +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
> > @@ -54,6 +54,9 @@ If you make a mistake with the syntax, the write will fail thus::
> >  				<debugfs>/dynamic_debug/control
> >    -bash: echo: write error: Invalid argument
> >  
> > +Note, for systems without 'debugfs' enabled, the control file can be
> > +also found in ``/proc/dynamic_debug/control``.
> > +
> >  Viewing Dynamic Debug Behaviour
> >  ===============================
> >  
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 5ffe144c9794..01d4add8b963 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -98,7 +98,7 @@ config DYNAMIC_DEBUG
> >  	bool "Enable dynamic printk() support"
> >  	default n
> >  	depends on PRINTK
> > -	depends on DEBUG_FS
> > +	depends on (DEBUG_FS || PROC_FS)
> >  	help
> >  
> >  	  Compiles debug level messages into the kernel, which would noti
> 
> The help text here also needs updating, since it refers to debugfs.

Oops, missed that, thanks!

> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > index c60409138e13..077b2d6623ac 100644
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
> > @@ -993,13 +993,24 @@ static __initdata int ddebug_init_success;
> >  
> >  static int __init dynamic_debug_init_debugfs(void)
> >  {
> > -	struct dentry *dir;
> > +	struct dentry *debugfs_dir;
> > +	struct proc_dir_entry *procfs_dir;
> >  
> >  	if (!ddebug_init_success)
> >  		return -ENODEV;
> >  
> > -	dir = debugfs_create_dir("dynamic_debug", NULL);
> > -	debugfs_create_file("control", 0644, dir, NULL, &ddebug_proc_fops);
> > +	/* Create the control file in debugfs if it is enabled */
> > +	if (debugfs_initialized) {
> > +		debugfs_dir = debugfs_create_dir("dynamic_debug", NULL);
> > +		debugfs_create_file("control", 0644, debugfs_dir, NULL,
> > +				    &ddebug_proc_fops);
> > +		return 0;
> > +	}
> > +
> > +	/* No debugfs so put it in procfs instead */
> > +	procfs_dir = proc_mkdir("dynamic_debug", NULL);
> > +	if (procfs_dir)
> > +		proc_create("control", 0x644, procfs_dir, &ddebug_proc_fops);
> 
> Shouldn't this be octal rather than hex? Even then, I don't understand what
> use it is being able to read but not write to this file. Perhaps make it
> 0600 for /proc ?

Argh, my fault, fingers are used to typing hex.

You can read from the file to see what the current settings are, I was
just trying to mirror the debugfs permissions.

thanks,

greg k-h
