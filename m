Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 001C0F3538
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 17:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388974AbfKGQ71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 11:59:27 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:14935 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387459AbfKGQ71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 11:59:27 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id xA7Gvqec015818;
        Thu, 7 Nov 2019 17:57:52 +0100
Date:   Thu, 7 Nov 2019 17:57:52 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     hpa@zytor.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [patch 5/9] x86/ioport: Reduce ioperm impact for sane usage
 further
Message-ID: <20191107165752.GD15642@1wt.eu>
References: <20191106202806.241007755@linutronix.de>
 <CAHk-=wjXcS--G3Wd8ZGEOdCNRAWPaUneyN1ryShQL-_yi1kvOA@mail.gmail.com>
 <20191107082541.GF30739@gmail.com>
 <20191107091704.GA15536@1wt.eu>
 <alpine.DEB.2.21.1911071058260.4256@nanos.tec.linutronix.de>
 <71DE81AC-3AD4-47B3-9CBA-A2C7841A3370@zytor.com>
 <20191107102756.GD15536@1wt.eu>
 <5AAEF116-EC9D-4C58-878F-9D27189E123A@zytor.com>
 <20191107125638.GB15642@1wt.eu>
 <87h83fd4a2.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h83fd4a2.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 10:45:09AM -0600, Eric W. Biederman wrote:
> Further a quick look shows that dosemu uses ioperm in a fine grained
> manner.  From memory it would allow a handful of ports to allow directly
> accessing a device and depended on the rest of the port accesses to be
> disallowed so it could trap and emulate them.
> 
> So yes I do believe making ioperm ioperm(all) will break userspace.

OK, and I must confess I almost forgot about dosemu, that's a good point!

Thanks,
Willy
