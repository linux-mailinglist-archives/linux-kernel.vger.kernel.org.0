Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 593142034E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 12:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfEPKT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 06:19:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726363AbfEPKT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 06:19:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A2E1205ED;
        Thu, 16 May 2019 10:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558001996;
        bh=GNeZk44iUjZpvezqnuLxWMKIOov7x5+FAxK5yoRztyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cvujyhHb+Shb0guDQ9USF9pVhy8GIqVvT7ze92sQe7HWnl+yu6cTJorhjB3Kf6xpa
         qz0hoxpAOIvy3Y2rRf/DThinRBTO9QC+fWrTauvjXL0yGC88V9UmxWlZ7eC0mXwgkB
         /klQUdWkURbxFEXBkb5GYhprJW+AnaEvPeLRQXPw=
Date:   Thu, 16 May 2019 12:19:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Quentin Deslandes <quentin.deslandes@itdev.co.uk>
Cc:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Forest Bond <forest@alittletooquiet.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: vt6656: remove unused variable
Message-ID: <20190516101953.GA22358@kroah.com>
References: <20190516093046.1400-1-quentin.deslandes@itdev.co.uk>
 <20190516093951.GA19798@kroah.com>
 <20190516095035.GA1692@qd-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516095035.GA1692@qd-ubuntu>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 09:50:38AM +0000, Quentin Deslandes wrote:
> On Thu, May 16, 2019 at 11:39:51AM +0200, Greg Kroah-Hartman wrote:
> > On Thu, May 16, 2019 at 09:31:05AM +0000, Quentin Deslandes wrote:
> > > Fixed 'set but not used' warning message on a status variable. The
> > > called function returning the status code 'vnt_start_interrupt_urb()'
> > > clean up after itself and the caller function
> > > 'vnt_int_start_interrupt()' does not returns any value.
> > > 
> > > Signed-off-by: Quentin Deslandes <quentin.deslandes@itdev.co.uk>
> > > ---
> > >  drivers/staging/vt6656/int.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/staging/vt6656/int.c b/drivers/staging/vt6656/int.c
> > > index 504424b19fcf..ac30ce72db5a 100644
> > > --- a/drivers/staging/vt6656/int.c
> > > +++ b/drivers/staging/vt6656/int.c
> > > @@ -42,13 +42,12 @@ static const u8 fallback_rate1[5][5] = {
> > >  void vnt_int_start_interrupt(struct vnt_private *priv)
> > >  {
> > >  	unsigned long flags;
> > > -	int status;
> > >  
> > >  	dev_dbg(&priv->usb->dev, "---->Interrupt Polling Thread\n");
> > >  
> > >  	spin_lock_irqsave(&priv->lock, flags);
> > >  
> > > -	status = vnt_start_interrupt_urb(priv);
> > > +	vnt_start_interrupt_urb(priv);
> > 
> > Shouldn't you fix this by erroring out if this fails?  Why ignore the
> > errors?
> > 
> > thanks,
> > 
> > greg k-h
> 
> I could, however 'vnt_start_interrupt_urb()' already call 'dev_dbg()' if
> it fails. Nothing is done after this debug call except returning an
> error code.

Returning an error code is fine for that function.  But then you have to
do something with that error.

> 'vnt_int_start_interrupt()' should, IMHO, return a status code, but the
> original developer may have good reasons not to do so.

I think that is the real problem that needs to be fixed here, don't
paper over the issue by ignoring the return value.

thanks,

greg k-h
