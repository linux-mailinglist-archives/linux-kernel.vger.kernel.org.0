Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3D9193BD9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 10:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgCZJ3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 05:29:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgCZJ3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 05:29:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B534320714;
        Thu, 26 Mar 2020 09:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585214980;
        bh=UoGc8pPRQVbuOM6FxhZbGGEF/HGWRxriugGNyAa0F30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kHI7WdxeMAgK6glxwYzwiGGTtCyrbaQCRXUVjpnZCpQWY4ZGP0LLZnW/0x1Bl+MGy
         aWvVPfizsEoHkQMxI+9Mb4rSMD0lY+VQoiAtViUL7I+3iYyhrhmqxoe9Q0QCIlD3A9
         nYhGSerbYpKxB0NuW0mnczLup4F4f3t4QC8+FjHI=
Date:   Thu, 26 Mar 2020 10:29:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Qiujun Huang <hqjagain@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, anenbupt@gmail.com
Subject: Re: [PATCH] USB: io_edgeport: fix  slab-out-of-bounds Read in
 edge_interrupt_callback
Message-ID: <20200326092936.GA994882@kroah.com>
References: <1585122757-4528-1-git-send-email-hqjagain@gmail.com>
 <20200326081433.GA979574@kroah.com>
 <20200326082117.GC4899@localhost>
 <20200326091326.GD4899@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326091326.GD4899@localhost>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 10:13:26AM +0100, Johan Hovold wrote:
> On Thu, Mar 26, 2020 at 09:21:17AM +0100, Johan Hovold wrote:
> > On Thu, Mar 26, 2020 at 09:14:33AM +0100, Greg Kroah-Hartman wrote:
> > > On Wed, Mar 25, 2020 at 03:52:37PM +0800, Qiujun Huang wrote:
> > > > The boundary condition should be (length - 1) as we access data[position+1].
> > > > 
> > > > Reported-and-tested-by: syzbot+37ba33391ad5f3935bbd@syzkaller.appspotmail.com
> > > > Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> > > > ---
> > > >  drivers/usb/serial/io_edgeport.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
> > > > index 5737add..4cca0b8 100644
> > > > --- a/drivers/usb/serial/io_edgeport.c
> > > > +++ b/drivers/usb/serial/io_edgeport.c
> > > > @@ -710,7 +710,7 @@ static void edge_interrupt_callback(struct urb *urb)
> > > >  		/* grab the txcredits for the ports if available */
> > > >  		position = 2;
> > > >  		portNumber = 0;
> > > > -		while ((position < length) &&
> > > > +		while ((position < length - 1) &&
> > > >  				(portNumber < edge_serial->serial->num_ports)) {
> > > >  			txCredits = data[position] | (data[position+1] << 8);
> > > >  			if (txCredits) {
> > > > -- 
> > > > 1.8.3.1
> > > > 
> > > 
> > > Johan, any objection from me taking this in my tree now?
> > 
> > Just let me take a look at it first.
> >
> > Are sending another PR to Linus for 5.6? Otherwise I can include this
> > in my 5.7 PR to you. Will try to get it to you today.
> 
> This issue predates git so I'd add
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable <stable@vger.kernel.org>
> Acked-by: Johan Hovold <johan@kernel.org>
> 
> if you want to take it yourself. Just let me know, otherwise I'll
> include in my PR.

I'm not sending anything to Linus for 5.6, so putting it in your 5.7 PR
is fine.

thanks,

greg k-h
