Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2896018A091
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 17:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgCRQg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 12:36:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:47204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbgCRQg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 12:36:58 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3CAF20752;
        Wed, 18 Mar 2020 16:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584549418;
        bh=QMhaJQsz8eetbzGX3XHrXvTePocblqmsCm1xGb7Mihg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jCpHoAF5EAJPk6vOJY+2nsOLtZmF/7nEj63BXFIcX4mBz4WO4rMUmN9wdeTuh8XkH
         RasmYFDbr9PyWGbcCPCzDPmyyLSQBuxVn6x+fl8+Uhg7oKIMKuPQWIK8yt/vOFTPp9
         Eo1pOhr2CnyyLEi5XVf2VsdAF/GjBOwz/R0Xyk50=
Date:   Wed, 18 Mar 2020 09:36:56 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 1/2] tty: fix compat TIOCGSERIAL leaking uninitialized
 memory
Message-ID: <20200318163656.GA2334@sol.localdomain>
References: <20200224181532.GA109047@gmail.com>
 <20200224182044.234553-1-ebiggers@kernel.org>
 <20200224182044.234553-2-ebiggers@kernel.org>
 <6294851f-50e5-eaaa-2182-1ad6ae7234b1@suse.com>
 <20200302212425.GB78660@gmail.com>
 <20200318120000.GA2528302@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318120000.GA2528302@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 01:00:00PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Mar 02, 2020 at 01:24:25PM -0800, Eric Biggers wrote:
> > On Tue, Feb 25, 2020 at 08:30:35AM +0100, Jiri Slaby wrote:
> > > On 24. 02. 20, 19:20, Eric Biggers wrote:
> > > > From: Eric Biggers <ebiggers@google.com>
> > > > 
> > > > Commit 77654350306a ("take compat TIOC[SG]SERIAL treatment into
> > > > tty_compat_ioctl()") changed the compat version of TIOCGSERIAL to start
> > > > copying a whole 'serial_struct32' to userspace rather than individual
> > > > fields, but failed to initialize all padding and fields -- namely the
> > > > hole after the 'iomem_reg_shift' field, and the 'reserved' field.
> > > > 
> > > > Fix this by initializing the struct to zero.
> > > > 
> > > > [v2: use sizeof, and convert the adjacent line for consistency.]
> > > > 
> > > > Reported-by: syzbot+8da9175e28eadcb203ce@syzkaller.appspotmail.com
> > > > Fixes: 77654350306a ("take compat TIOC[SG]SERIAL treatment into tty_compat_ioctl()")
> > > > Cc: <stable@vger.kernel.org> # v4.20+
> > > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > > 
> > > Acked-by: Jiri Slaby <jslaby@suse.cz>
> > > 
> > 
> > Thanks.  Greg, are you planning to take these patches?
> 
> Yes, sorry, they were not cc: linux-serial and fell through my initial
> filters, to go into my generic "to-review" bucket.  Will take them
> now...
> 

If people are supposed to send tty patches to linux-serial, then you need to add
it to MAINTAINERS:

$ ./scripts/get_maintainer.pl drivers/tty/
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:TTY LAYER)
Jiri Slaby <jslaby@suse.com> (supporter:TTY LAYER)
linux-kernel@vger.kernel.org (open list)
