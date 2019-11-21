Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 872F5104F7A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 10:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfKUJmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 04:42:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:43260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfKUJmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 04:42:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24ED920715;
        Thu, 21 Nov 2019 09:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574329338;
        bh=Fjo7LOSQOXDhexKCsF2boszIdLMNlYvIHWsD4fqz6xs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xZ3a6eT0PvdMaUPOnmVxID6Rj/TcDc76xJm0ufU3r3g6gamwfpukjqIFS0Vdip8Gq
         1lqa7oTCXKylryC0NDt92SHyIR9g6RbG/P8gREvk7sIf/AGfl+H1X5d6KXVET4fZRu
         VEHU999+5ASFS1DzbTEju09dDnwqedzeCdP9wtYQ=
Date:   Thu, 21 Nov 2019 10:42:15 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Angelo Dureghello <angelo.dureghello@timesys.com>
Cc:     Evgeniy Polyakov <zbr@ioremap.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] w1: new driver. DS2430 chip
Message-ID: <20191121094215.GA421330@kroah.com>
References: <20191019204015.61474-1-angelo.dureghello@timesys.com>
 <49814061574280989@sas2-7fadb031fd9b.qloud-c.yandex.net>
 <20191120205952.GA3113184@kroah.com>
 <CALJHbkDTNbjbCaVcwF8eSWpmpDptbkktZuvb-cxTOtGhB4iupw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALJHbkDTNbjbCaVcwF8eSWpmpDptbkktZuvb-cxTOtGhB4iupw@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 10:35:26AM +0100, Angelo Dureghello wrote:
> Hi Greg (and Evgeniy),
> 
> On Wed, Nov 20, 2019 at 9:59 PM gregkh@linuxfoundation.org
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Nov 20, 2019 at 11:16:29PM +0300, Evgeniy Polyakov wrote:
> > > Hi Angelo, Greg
> > >
> > > 19.10.2019, 23:38, "Angelo Dureghello" <angelo.dureghello@timesys.com>:
> > > > add support for ds2430, 1 page, 256bit (32bytes) eeprom
> > > > (family 0x14).
> > > >
> > > > Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
> > >
> > > Looks good to me.
> > > Greg, please pull it into your tree.
> > >
> > > Acked-by: Evgeniy Polyakov <zbr@ioremap.net>
> >
> > I don't have a copy of this anywhere :(
> >
> > Angelo, can you resend it and cc: me and add evgeniy's ack?
> >
> 
> this is he patch you applied to your char-misc-next branch, some days ago.
> 
> I added Evgeniy acked-by.
> 
> So you should revert/remove
> commit c6bf3842a34abe3ec2f5bc81754883689aea6c0d (patch)

Ah, no, I'm not going to revert it just for an ack, I'll just leave it
as-is, thanks.

greg k-h
