Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81128199A42
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 17:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731097AbgCaPuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 11:50:09 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34253 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727703AbgCaPuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 11:50:08 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 02VFn8Y2024870;
        Tue, 31 Mar 2020 17:49:08 +0200
Date:   Tue, 31 Mar 2020 17:49:08 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Denis Efremov <efremov@linux.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Helge Deller <deller@gmx.de>, Ian Molton <spyro@f2s.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Richard Henderson <rth@twiddle.net>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>, x86@kernel.org
Subject: Re: [PATCH 00/23] Floppy driver cleanups
Message-ID: <20200331154908.GB24854@1wt.eu>
References: <20200331094054.24441-1-w@1wt.eu>
 <20200331101019.GA6299@infradead.org>
 <20200331110136.GB24562@1wt.eu>
 <20200331152812.GA16100@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331152812.GA16100@infradead.org>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 08:28:12AM -0700, Christoph Hellwig wrote:
> On Tue, Mar 31, 2020 at 01:01:36PM +0200, Willy Tarreau wrote:
> > I'm not sure what this implies regarding this code, to be honest. It's
> > very tricky and implements sort of a state machine using function pointers
> > within its interrupt handler so you never know exactly what accesses what,
> > and quite a part of it remains obscure to me :-/  I can accept to help, I
> > can even run tests since I still have running hardware, but I'd at least
> > need some guidance. And probably Denis would know better than me there.
> > Also I doubt we'd get sufficient testing on less common archs. While I
> > do have sparc64/parisc/alpha available, I haven't booted a recent kernel
> > on any of them for a while (2.4 used to be the last ones), and I'm not
> > sure it's reasonable to go into such changes without proper testing.
> 
> The basic change is that instead of using bio_data() or page_address
> all pages coming from the block layer need to be properly kmap()ed.
> I'll try to cook something up an will send it to Denis and you for
> review and testing.  The code things about sparc64/parisc/alpha is
> that they all don't have highmem, so these changes should be effective
> no-ops for them.

OK, thanks for the explanation!
Willy
