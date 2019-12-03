Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEAEF1104D8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 20:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfLCTOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 14:14:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:57616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfLCTOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 14:14:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75D3920674;
        Tue,  3 Dec 2019 19:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575400470;
        bh=TGlmWurXCkJiWDje6hWzvqeJdYkSUy0VCiAUGee7E0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KRdmDI9NvW0sIioszejrzsYshWcf1A4DO60HplKmFDSEh1UAXoMPr7u8j8MvgqdZ+
         Uge4rmd1e9EhqzeQyHJvVKw9cHMKeZhuNSm53hfMeA+gwVSTr6qwiFT4FFEQ4oJDnP
         ujhGyATRQSYuYRq/+AnZAHZCp8NQaCDGBNkqqXtQ=
Date:   Tue, 3 Dec 2019 20:14:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Daniel Axtens <dja@axtens.net>,
        Michael Neuling <mikey@neuling.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        Jiri Slaby <jslaby@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: tty crash in Linux 4.6
Message-ID: <20191203191428.GB2734645@kroah.com>
References: <573B5E4C.8030808@hurleysoftware.com>
 <alpine.LRH.2.02.1607071855150.19053@file01.intranet.prod.int.rdu2.redhat.com>
 <CAEjGV6zRghiCCMC1+-n+YPeA0Lrq=-vcvdoYpbwE4G=TXWzY3Q@mail.gmail.com>
 <87po3wusq1.fsf@linkitivity.dja.id.au>
 <20180322140554.GA3273@kroah.com>
 <alpine.LRH.2.02.1803270818150.30055@file01.intranet.prod.int.rdu2.redhat.com>
 <87k1td913u.fsf@linkitivity.dja.id.au>
 <d8ba132f-e174-2acc-e74c-4e9aed945c30@oracle.com>
 <20191116093614.GB408484@kroah.com>
 <alpine.LRH.2.02.1912031016030.6365@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.1912031016030.6365@file01.intranet.prod.int.rdu2.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 10:17:08AM -0500, Mikulas Patocka wrote:
> 
> 
> On Sat, 16 Nov 2019, Greg Kroah-Hartman wrote:
> 
> > On Fri, Nov 15, 2019 at 11:21:08AM -0800, Mike Kravetz wrote:
> > > On 4/11/18 9:09 AM, Daniel Axtens wrote:
> > > > Mikulas Patocka <mpatocka@redhat.com> writes:
> > > > 
> > > >> On Thu, 22 Mar 2018, Greg Kroah-Hartman wrote:
> > > >>
> > > >>> On Fri, Mar 23, 2018 at 12:48:06AM +1100, Daniel Axtens wrote:
> > > >>>> Hi,
> > > >>>>
> > > >>>>>> This patch works, I've had no tty crashes since applying it.
> > > >>>>>>
> > > >>>>>> I've seen that you haven't sent this patch yet to Linux-4.7-rc and
> > > >>>>>> Linux-4.6-stable. Will you? Or did you create a different patch?
> > > >>>>>
> > > >>>>> We are hitting this now on powerpc.  This patch never seemed to make
> > > >>>>> it upstream (drivers/tty/tty_ldisc.c hasn't been touched in 1 year).
> > > >>>>
> > > >>>> I seem to be hitting this too on a kernel that has the 4.6 changes
> > > >>>> backported to 4.4.
> > > >>>>
> > > >>>> Has there been any further progress on getting this accepted?
> > > >>>
> > > >>> Can you try applying 28b0f8a6962a ("tty: make n_tty_read() always abort
> > > >>> if hangup is in progress") to see if that helps out or not?
> > > > 
> > > > Sorry for the delay in getting the test results; as with Mikulas,
> > > > 28b0f8a6962a does not help.
> > > > 
> > > > Regards,
> > > > Daniel
> > > > 
> > > >>>
> > > >>> thanks,
> > > >>>
> > > >>> greg k-h
> > > >>
> > > >> It doesn't help. I get the same crash as before.
> > > >>
> > > >> Mikulas
> > > 
> > > Reviving a really old thread.
> > > 
> > > It looks like this patch never got merged.
> > 
> > I do not see a patch in this email, so I have no idea what you are
> > referring to, sorry.
> > 
> > > Did it get resolved in some other way?  I ask because we have a
> > > customer who seems to have hit this issue.
> > 
> > Can you try with the latest kernel to see if it is resolved or not?
> 
> I tested it on the kernel 5.4 and I couldn't reproduce the crash anymore.

Wonderful, please use that kernel then :)

thanks,

greg k-h
