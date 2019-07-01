Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85DC44EA2B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 16:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfFUOFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 10:05:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfFUOFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:05:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 896EF21537;
        Fri, 21 Jun 2019 14:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561125912;
        bh=I/o04BAnpehx7Y4sb1Piu3Pctnh+XRgLlNo8vMY7hVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=osVbRQG9Dzdt89VT1OYUQJ93QkJWRy0FpVKxriKhiy/4JCcrpJ05JuOtM1yvGG0oP
         le46bmUQoIVzacmxohhy7HVVAvIxTYM9igkFb6EBLtGN5F8xjI2oIu3zgFFkNWVlsg
         NclauCvRkhddfjK6EkvAT39Zr6g27m6hpRwbmRNQ=
Date:   Fri, 21 Jun 2019 16:05:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] lkdtm: remove redundant initialization of ret
Message-ID: <20190621140509.GB7011@kroah.com>
References: <20190614094311.24024-1-colin.king@canonical.com>
 <20190621140347.GA7011@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621140347.GA7011@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 04:03:47PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jun 14, 2019 at 10:43:11AM +0100, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > The variable ret is being initialized with the value -EINVAL however
> > this value is never read and ret is being re-assigned later on. Hence
> > the initialization is redundant and can be removed.
> > 
> > Addresses-Coverity: ("Unused value")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > Acked-by: Kees Cook <keescook@chromium.org>
> > ---
> >  drivers/misc/lkdtm/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
> > index bba093224813..92df35fdeab0 100644
> > --- a/drivers/misc/lkdtm/core.c
> > +++ b/drivers/misc/lkdtm/core.c
> > @@ -390,7 +390,7 @@ static int __init lkdtm_module_init(void)
> >  {
> >  	struct crashpoint *crashpoint = NULL;
> >  	const struct crashtype *crashtype = NULL;
> > -	int ret = -EINVAL;
> > +	int ret;
> >  	int i;
> >  
> >  	/* Neither or both of these need to be set */
> > -- 
> > 2.20.1
> > 
> 
> With this patch now applied, I get this build warning:
> drivers/misc/lkdtm/core.c: In function lkdtm_module_init:
> drivers/misc/lkdtm/core.c:467:9: warning: ret may be used uninitialized in this function [-Wmaybe-uninitialized]
>   return ret;
>          ^~~
> 
> So are you _sure_ it shouldn't be initialized?

In looking at the code in my tree, ret is used uninitialized with this
patch, so maybe coverity is wrong, or I don't have all of the needed
patches?

thanks,

greg k-h
