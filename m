Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C96BF2BEB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 11:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387917AbfKGKOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 05:14:52 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:14650 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbfKGKOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 05:14:51 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id xA7ADvMK015622;
        Thu, 7 Nov 2019 11:13:57 +0100
Date:   Thu, 7 Nov 2019 11:13:57 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch 5/9] x86/ioport: Reduce ioperm impact for sane usage
 further
Message-ID: <20191107101357.GC15536@1wt.eu>
References: <20191106193459.581614484@linutronix.de>
 <20191106202806.241007755@linutronix.de>
 <CAHk-=wjXcS--G3Wd8ZGEOdCNRAWPaUneyN1ryShQL-_yi1kvOA@mail.gmail.com>
 <20191107082541.GF30739@gmail.com>
 <20191107091704.GA15536@1wt.eu>
 <alpine.DEB.2.21.1911071058260.4256@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1911071058260.4256@nanos.tec.linutronix.de>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 11:00:27AM +0100, Thomas Gleixner wrote:
> Changing ioperm(single port, port range) to be ioperm(all) is going to
> break a bunch of test cases which actually check whether the permission is
> restricted to a single I/O port or the requested port range.

But out of curiosity, are these solely test cases or things that real
applications do ? We could imagine having a sysctl entry to indicate
whether or not we want strict compatibility with older code in which
case we'd take the slow path, or a modernized behavior using only the
fast path. If we managed to deal with mmap_min_addr over time, I think
it should be manageable to deal with the rare applications using ioperm().

Willy
