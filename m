Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A01E7EE517
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 17:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbfKDQtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 11:49:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:38562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727989AbfKDQtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 11:49:22 -0500
Received: from localhost (host6-102.lan-isdn.imaginet.fr [195.68.6.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1ADE22084D;
        Mon,  4 Nov 2019 16:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572886161;
        bh=XDStLaB9lk66yP2fHyiSK2C5nhHNkuFFN93WRiHDWxU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dqmh+eJhR1MbFlFInIjpw0/+T7Vu1RrFei0iezF3KF89WyEkRTtBEjqpc9wZLRPUT
         NGjhD5uP7MkNtPvb7gb39HqIcCbAy5yt72zlo57gbIbjCZVfPdsc5zxq6Msd/lh2og
         nlEJHzLk2P+u2J+x2C1qfd+GeSZ3M2TGgHwXtZsY=
Date:   Mon, 4 Nov 2019 17:49:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jslaby@suse.com>
Cc:     Xiaoming Ni <nixiaoming@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty:n_gsm.c: destroy port by tty_port_destroy()
Message-ID: <20191104164919.GA2282079@kroah.com>
References: <1569317156-45850-1-git-send-email-nixiaoming@huawei.com>
 <1fd7d2eb-7497-254b-b40f-84bc4114f8a3@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fd7d2eb-7497-254b-b40f-84bc4114f8a3@suse.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 11:11:24AM +0100, Jiri Slaby wrote:
> On 24. 09. 19, 11:25, Xiaoming Ni wrote:
> > According to the comment of tty_port_destroy():
> >     When a port was initialized using tty_port_init, one has to destroy
> >     the port by tty_port_destroy();
> 
> It continues with a part saying:
>    Either indirectly by using tty_port refcounting
>    (tty_port_put) or directly if refcounting is not used.
> 
> > tty_port_init() is called in gsm_dlci_alloc()
> > so tty_port_destroy() needs to be called in gsm_dlci_free()
> > 
> > Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> > ---
> >  drivers/tty/n_gsm.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> > index 36a3eb4..3f5bcc9 100644
> > --- a/drivers/tty/n_gsm.c
> > +++ b/drivers/tty/n_gsm.c
> > @@ -1681,6 +1681,7 @@ static void gsm_dlci_free(struct tty_port *port)
> >  
> >  	del_timer_sync(&dlci->t1);
> >  	dlci->gsm->dlci[dlci->addr] = NULL;
> > +	tty_port_destroy(&dlci->port);
> 
> This is wrong. gsm_dlci_free is tty_port_operations->destruct, i.e.
> n_gsm uses tty_port refcounting and tty_port_destroy was called on this
> port in tty_port_destructor already.
> 
> Greg, please revert.

Now reverted.

sorry about that.

greg k-h
