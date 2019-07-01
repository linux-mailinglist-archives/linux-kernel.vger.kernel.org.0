Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8812420E34
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 19:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbfEPRte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 13:49:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:56682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726956AbfEPRte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 13:49:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 799A320818;
        Thu, 16 May 2019 17:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558028973;
        bh=decCPVJq4sFXSSaGYODONKx6td/Up+NRhyNGO6otSDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OupcOnC/D5jcim3o1Js5A/ylBeqyLSB5YCMZMLvQPgOfgEF36+DetZPXqKgAuOfl9
         5dXFEY8qgG8T+VHu6lK3IQanBgcoFA2mNzmeoC5sIi5yky8SwzihYXYW0JoCYvVcRa
         9SMwfaaM7uUjxJKz1DnNH5zMNFSkrdTi/N0p6dbI=
Date:   Thu, 16 May 2019 19:49:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Naveen Kumar Parna <parna.naveenkumar@gmail.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] bsr: "foo * bar" should be "foo *bar"
Message-ID: <20190516174930.GA28323@kroah.com>
References: <20190515134310.27269-1-parna.naveenkumar@gmail.com>
 <20190515151358.GD23599@kroah.com>
 <CAKXhv7ew=956XWh0O=KFiKOM8XNKiZtNfjQEFunKaL_C9EPTFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKXhv7ew=956XWh0O=KFiKOM8XNKiZtNfjQEFunKaL_C9EPTFg@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 11:11:21PM +0530, Naveen Kumar Parna wrote:
> On Wed, 15 May, 2019, 8:44 PM Greg KH, <gregkh@linuxfoundation.org> wrote:
> 
> > On Wed, May 15, 2019 at 07:13:10PM +0530, parna.naveenkumar@gmail.com
> > wrote:
> > > From: Naveen Kumar Parna <parna.naveenkumar@gmail.com>
> > >
> > > Fixed the checkpatch error. Used "foo *bar" instead of "foo * bar"
> > >
> > > Signed-off-by: Naveen Kumar Parna <parna.naveenkumar@gmail.com>
> > > ---
> > >  drivers/char/bsr.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Where is patch 1/2 of this series?
> >
> It does not has corresponding 1/2 patch. By mistake I used
> wrong argument to 'git format-patch' command.

Ok, thanks, now dropped.  Please fix up and resend properly.

As I said before, the bar for cleanup patches outside of
drivers/staging/ is much higher :)

thanks,

greg k-h
