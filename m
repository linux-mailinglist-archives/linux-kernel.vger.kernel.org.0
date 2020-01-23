Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6781B1470A7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 19:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgAWSWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 13:22:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:37486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728139AbgAWSWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 13:22:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D60A121D7E;
        Thu, 23 Jan 2020 18:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579803724;
        bh=jVKvoKj30foxuIyQL8yHjuvo+jDCyIyEKi4AZ+rAkSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VDfqNulz4A2v0RctTtB4/KrOuFzYtARu4rzZrCN1ldDbdrInu0VhP4OGz2fdDK7Iu
         NSmleI1xSJTShAYwQnFhQ84akcLYxtoxBoejzepxCbh2kdN36P3SrG7EhMPWZzqK/B
         T28Z5DkxBTwIPuOnFlUK5IF4/Et15J3rZgKLt4KY=
Date:   Thu, 23 Jan 2020 19:22:02 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     "Daniel Baluta (OSS)" <daniel.baluta@oss.nxp.com>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "info@metux.net" <info@metux.net>,
        "ztuowen@gmail.com" <ztuowen@gmail.com>,
        "sergei.shtylyov@cogentembedded.com" 
        <sergei.shtylyov@cogentembedded.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH] lib: devres: Export devm_ioremap_resource_wc
Message-ID: <20200123182202.GA1941013@kroah.com>
References: <20200123154706.5831-1-daniel.baluta@oss.nxp.com>
 <20200123175658.GB1796501@kroah.com>
 <CAEnQRZAnfT0kBCmir+-cTkg+8bgO0pk+1S-rSfUVobf=Hzxz7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEnQRZAnfT0kBCmir+-cTkg+8bgO0pk+1S-rSfUVobf=Hzxz7g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 08:16:35PM +0200, Daniel Baluta wrote:
> On Thu, Jan 23, 2020 at 7:57 PM gregkh@linuxfoundation.org
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Jan 23, 2020 at 03:47:21PM +0000, Daniel Baluta (OSS) wrote:
> > > From: Daniel Baluta <daniel.baluta@nxp.com>
> > >
> > > So that modules can also use it.
> > >
> > > Fixes: b873af620e58863b ("lib: devres: provide devm_ioremap_resource_wc()")
> > > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > > ---
> > >  lib/devres.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/lib/devres.c b/lib/devres.c
> > > index 6ef51f159c54..7fe2bd75dfa3 100644
> > > --- a/lib/devres.c
> > > +++ b/lib/devres.c
> > > @@ -182,6 +182,7 @@ void __iomem *devm_ioremap_resource_wc(struct device *dev,
> > >  {
> > >       return __devm_ioremap_resource(dev, res, DEVM_IOREMAP_WC);
> > >  }
> > > +EXPORT_SYMBOL(devm_ioremap_resource_wc);
> >
> > EXPORT_SYMBOL_GPL() perhaps?
> >
> > What in-tree driver needs this?
> 
> I was experimenting with an out of tree driver and I also was using it wrong :D.
> Indeed looks like there is no real potential user so far in the kernel tree.

Great, we can drop it then :)

thanks,

greg k-h
