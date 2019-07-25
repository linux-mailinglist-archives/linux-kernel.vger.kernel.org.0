Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E53DD7538E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 18:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbfGYQJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 12:09:11 -0400
Received: from foss.arm.com ([217.140.110.172]:60288 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbfGYQJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:09:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20645174E;
        Thu, 25 Jul 2019 09:09:10 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BCDE3F71A;
        Thu, 25 Jul 2019 09:09:08 -0700 (PDT)
Date:   Thu, 25 Jul 2019 17:08:59 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Daniel Axtens <dja@axtens.net>
Cc:     Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH 1/2] kernel/fork: Add support for stack-end guard page
Message-ID: <20190725160859.GA22830@lakrids.cambridge.arm.com>
References: <20190719132818.40258-1-elver@google.com>
 <20190723164115.GB56959@lakrids.cambridge.arm.com>
 <CACT4Y+Y47_030eX-JiE1hFCyP5RiuTCSLZNKpTjuHwA5jQJ3+w@mail.gmail.com>
 <20190724112101.GB2624@lakrids.cambridge.arm.com>
 <CACT4Y+Zai+4VwNXS_a417M2m0DbtNhjTVdYga178ZDkvNnP4CQ@mail.gmail.com>
 <20190725101458.GC14347@lakrids.cambridge.arm.com>
 <87r26egn8t.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r26egn8t.fsf@dja-thinkpad.axtens.net>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 01:14:26AM +1000, Daniel Axtens wrote:
> Mark Rutland <mark.rutland@arm.com> writes:
> > On Thu, Jul 25, 2019 at 09:53:08AM +0200, Dmitry Vyukov wrote:
> >> FTR, Daniel just mailed:
> >> 
> >> [PATCH 0/3] kasan: support backing vmalloc space with real shadow memory
> >> https://groups.google.com/forum/#!topic/kasan-dev/YuwLGJYPB4I
> >> Which presumably will supersede this.
> >
> > Neat!
> >
> > I'll try to follow that, (and thanks for the Cc there), but I'm not on
> > any of the lists it went to. IMO it would be nice if subsequent versions
> > would be Cc'd to LKML, if that's possible. :)
> 
> Will do - apologies for the oversight.

Nothing to apologize for, and thanks in advance!

Mark.
