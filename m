Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 972E610B342
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 17:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfK0Qad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 11:30:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:35802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726909AbfK0Qac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 11:30:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFA8C2073F;
        Wed, 27 Nov 2019 16:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574872232;
        bh=nxepS9tOGQrY7ln1li49H4CBLPY6wGDihiGIoMsihUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tqbygzjWEl5BnrcdlwZHvMYzPL0QDpWHXVbNoz3S8XJlOOPdYjA50NMRfeydtZZ30
         NSdfbPkC4yFXuOM3WOpkZioqijYpg7ffirT93gQyclin+PpAmPRHvIDLfMLS141qwP
         BFwh31kPTiMeBnu2r4K75NBfMof+KqL1NHZvr0H8=
Date:   Wed, 27 Nov 2019 17:30:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Or Cohen <orcohen@paloaltonetworks.com>, textshell@uchuujin.de,
        Daniel Vetter <daniel.vetter@ffwll.ch>, sam@ravnborg.org,
        mpatocka@redhat.com, ghalat@redhat.com,
        linux-kernel@vger.kernel.org, jwilk@jwilk.net,
        Nadav Markus <nmarkus@paloaltonetworks.com>,
        syzkaller@googlegroups.com
Subject: Re: Bug report - slab-out-of-bounds in vcs_scr_readw
Message-ID: <20191127163030.GA3086596@kroah.com>
References: <nycvar.YSQ.7.76.1911041648280.30289@knanqh.ubzr>
 <CAM6JnLdrzCPOYyfTdmriFo7cRaGM4p2OEPd_0MHa3_WemamffA@mail.gmail.com>
 <nycvar.YSQ.7.76.1911041928030.30289@knanqh.ubzr>
 <c30fc539-68a8-65d7-226c-6f8e6fd8bdfb@suse.com>
 <CAM6JnLe88xf8hO0F=_Ni+irNt40+987tHmz9ZjppgxhnMnLxpw@mail.gmail.com>
 <a0550a96-a7db-60d7-c4ac-86be8c8dd275@suse.com>
 <nycvar.YSQ.7.76.1911051030580.30289@knanqh.ubzr>
 <nycvar.YSQ.7.76.1911261652290.8537@knanqh.ubzr>
 <20191127064507.GC1711684@kroah.com>
 <nycvar.YSQ.7.76.1911271121200.8537@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1911271121200.8537@knanqh.ubzr>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 11:24:52AM -0500, Nicolas Pitre wrote:
> On Wed, 27 Nov 2019, Greg KH wrote:
> 
> > On Tue, Nov 26, 2019 at 04:55:32PM -0500, Nicolas Pitre wrote:
> > > Greg, could you apply this please?
> > 
> > Yes, I will, but I don't seem to have it in my email archives anywhere,
> > was it burried in that long thread?
> 
> I've seen much longer threads than this one, but yes it was at its tail.
> Hence the direct ping.

Yeah, I dug it out, sorry about that, my fault.  All now queued up.

greg k-h
