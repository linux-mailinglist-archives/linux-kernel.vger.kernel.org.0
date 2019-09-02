Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14BBFA5CF8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 22:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfIBUP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 16:15:58 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45175 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbfIBUP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 16:15:57 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 2825B818DA; Mon,  2 Sep 2019 22:15:41 +0200 (CEST)
Date:   Mon, 2 Sep 2019 22:15:53 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     James Courtier-Dutton <james.dutton@gmail.com>
Cc:     Daniel Drake <drake@endlessm.com>,
        "Artem S. Tashkinov" <aros@gmx.com>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        linux@endlessm.com, hadess@hadess.net,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: Let's talk about the elephant in the room - the Linux kernel's
 inability to gracefully handle low memory pressure
Message-ID: <20190902201553.GA6546@bug>
References: <d9802b6a-949b-b327-c4a6-3dbca485ec20@gmx.com>
 <20190820064620.5119-1-drake@endlessm.com>
 <CAAMvbhH=ftMoh9eFVR3YgN9DVSLaN5tXa-vTsBocY8YuL0Rc1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAMvbhH=ftMoh9eFVR3YgN9DVSLaN5tXa-vTsBocY8YuL0Rc1A@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >
> > And if there is a meaningful way to make the kernel behave better, that would
> > obviously be of huge value too.
> >
> > Thanks
> > Daniel
> 
> Hi,
> 
> Is there a way for an application to be told that there is a memory
> pressure situation?
> For example, say I do a "make -j32"  and half way through the compile
> it hits a memory pressure situation.
> If make could have been told about it. It could give up on some of the
> parallel compiles, and instead proceed as if the user have typed "make
> -j4". It could then re-try the failed compile parts, that failed due
> to memory pressure.
> I know all applications won't be this clever, but providing a kernel
> API so that an application could do something about it, if the
> programmer of that application has thought about it.

Support is not really needed in many applications. It would be nice to
have for make and web browsers... And I suspect it is easy to do interface
becomes available.

Best regards,
								Pavel
