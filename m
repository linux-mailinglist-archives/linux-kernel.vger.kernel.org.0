Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E970751D2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 16:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388579AbfGYOwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 10:52:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387646AbfGYOwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:52:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B4E421734;
        Thu, 25 Jul 2019 14:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564066372;
        bh=UiAPxBMDA0i/iMkH2fdA0nFfj4Rn3c8p0jAXHIvZ0og=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qI7UPyLJQ98A3zSspuu8RTVksaDq1QaMKEkkw7btW+Aj4OCcSqpUxLcys6FN/ctNf
         ZxrqUa+qWaSzdtNjYKLdto+bbh0+HjEuSAbH4vhDNqyhcp92mdZ7sGuW6Ucol5y1Ds
         zmVnX+Gywp1MH4/lE9cQ3GEbGP6Cb/cQusPgDVmo=
Date:   Thu, 25 Jul 2019 16:52:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Disable procfs debugging by default
Message-ID: <20190725145249.GA32271@kroah.com>
References: <20190718092522.17748-1-kai.heng.feng@canonical.com>
 <20190725075503.GA16693@kroah.com>
 <83A2CB3F-B0C4-43C6-A3A6-B6E8B440BECC@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83A2CB3F-B0C4-43C6-A3A6-B6E8B440BECC@canonical.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 10:48:42PM +0800, Kai-Heng Feng wrote:
> at 15:55, Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Thu, Jul 18, 2019 at 05:25:22PM +0800, Kai-Heng Feng wrote:
> > > The procfs provides many useful information for debugging, but it may be
> > > too much for normal usage, routines like proc_get_sec_info() reports
> > > various security related information.
> > > 
> > > So disable it by defaultl.
> > > 
> > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > ---
> > >  drivers/staging/rtl8723bs/include/autoconf.h | 4 ----
> > >  1 file changed, 4 deletions(-)
> > > 
> > > diff --git a/drivers/staging/rtl8723bs/include/autoconf.h
> > > b/drivers/staging/rtl8723bs/include/autoconf.h
> > > index 196aca3aed7b..8f4c1e734473 100644
> > > --- a/drivers/staging/rtl8723bs/include/autoconf.h
> > > +++ b/drivers/staging/rtl8723bs/include/autoconf.h
> > > @@ -57,9 +57,5 @@
> > >  #define DBG	0	/*  for ODM & BTCOEX debug */
> > >  #endif /*  !DEBUG */
> > > 
> > > -#ifdef CONFIG_PROC_FS
> > > -#define PROC_DEBUG
> > > -#endif
> > 
> > What?  Why?  If you are going to do this, then rip out all of the code
> > as well.
> 
> Or make it a Kconfig option? Which one do you think is better?

No new config options please.

> > And are you _sure_ you want to do this?
> 
> Yes. The procfs of rtl8723bs is useful to Realtek to decode but not to
> others.

If no one else needs this, then rip out all of the code that uses it,
not just the single #define.

thanks,

greg k-h
