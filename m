Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C33E2291F0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 09:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389140AbfEXHmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 03:42:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388960AbfEXHmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 03:42:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DD20217F9;
        Fri, 24 May 2019 07:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558683754;
        bh=W3xRpy3DBCHBRWi5JRR2yOwXam58kwiXx6SKvIkiyE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jQezOaYqzv0VthgRDI02GtbedXKYChnnDmOd9CQAkqLJCcKW4pjcrABFzLyHDDldC
         x1DE4DeSmeobuChKHVudpRHr4Dhm3VXPINYQYi1qdOjIkoTf1ZXbOCgWT6fDuBub9z
         0DBSQ5sE98ti/VxhSeHI385KzJjDDxb4o8gI39Hk=
Date:   Fri, 24 May 2019 09:42:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: ks7010: Remove initialisation
Message-ID: <20190524074231.GA29172@kroah.com>
References: <20190524055602.3694-1-nishkadg.linux@gmail.com>
 <20190524065238.GA3600@kroah.com>
 <aae76db5-8768-d277-e527-9e166a02f46e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aae76db5-8768-d277-e527-9e166a02f46e@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 12:31:19PM +0530, Nishka Dasgupta wrote:
> On 24/05/19 12:22 PM, Greg KH wrote:
> > On Fri, May 24, 2019 at 11:26:02AM +0530, Nishka Dasgupta wrote:
> > > As the initial value of the return variable result is never used, it can
> > > be removed.
> > > Issue found with Coccinelle.
> > > 
> > > Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
> > > ---
> > >   drivers/staging/ks7010/ks7010_sdio.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Didn't you already send this?
> 
> I sent two patches about removing initialisation in ks7010 today, but I
> couldn't make it a patch series because the different files had different
> maintainers. I don't think I've sent this patch before, but it's possible I
> made a mistake because my local tree has not been the best organised lately.
> I apologise for the confusion.
> 

I saw two patches with the same subject line, if I messed up, please
resend.

> > And please run a spell-checker on your subject line when you resend
> > this :)
> 
> Is this about "initialise" (and now also "organised", "apologise", etc)? As
> far as I'm aware whether the word ends in "-ise"/"-ize" depends on local
> varieties of English, so I went with the variety I'm more used to. Should I
> stick with American/Canadian spelling variants (including "-or" over "-our"
> etc) from now on?

Ah, didn't realize that was a valid spelling, sorry.

greg k-h
