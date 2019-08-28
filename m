Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53C439F897
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 05:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfH1DHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 23:07:46 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:16571 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726178AbfH1DHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 23:07:46 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id x7S2s7NW017694;
        Wed, 28 Aug 2019 10:54:07 +0800 (GMT-8)
        (envelope-from nickhu@andestech.com)
Received: from andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Wed, 28 Aug 2019
 11:06:44 +0800
Date:   Wed, 28 Aug 2019 11:06:44 +0800
From:   Nick Hu <nickhu@andestech.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
CC:     Alan Quey-Liang =?utf-8?B?S2FvKOmrmOmtgeiJryk=?= 
        <alankao@andestech.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "green.hu@gmail.com" <green.hu@gmail.com>,
        "deanbo422@gmail.com" <deanbo422@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "glider@google.com" <glider@google.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "Anup.Patel@wdc.com" <Anup.Patel@wdc.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "alexios.zavras@intel.com" <alexios.zavras@intel.com>,
        "atish.patra@wdc.com" <atish.patra@wdc.com>,
        =?utf-8?B?6Zui6IG3Wm9uZyBab25nLVhpYW4gTGko5p2O5a6X5oayKQ==?= 
        <zong@andestech.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>
Subject: Re: [PATCH 1/2] riscv: Add memmove string operation.
Message-ID: <20190828030644.GA20064@andestech.com>
References: <cover.1565161957.git.nickhu@andestech.com>
 <a6c24ce01dc40da10d58fdd30bc3e1316035c832.1565161957.git.nickhu@andestech.com>
 <09d5108e-f0ba-13d3-be9e-119f49f6bd85@virtuozzo.com>
 <20190827090738.GA22972@andestech.com>
 <92dd5f5f-c8a2-53c3-4d61-44acc4366844@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <92dd5f5f-c8a2-53c3-4d61-44acc4366844@virtuozzo.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com x7S2s7NW017694
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Tue, Aug 27, 2019 at 05:33:11PM +0800, Andrey Ryabinin wrote:
> 
> 
> On 8/27/19 12:07 PM, Nick Hu wrote:
> > Hi Andrey
> > 
> > On Thu, Aug 22, 2019 at 11:59:02PM +0800, Andrey Ryabinin wrote:
> >> On 8/7/19 10:19 AM, Nick Hu wrote:
> >>> There are some features which need this string operation for compilation,
> >>> like KASAN. So the purpose of this porting is for the features like KASAN
> >>> which cannot be compiled without it.
> >>>
> >>
> >> Compilation error can be fixed by diff bellow (I didn't test it).
> >> If you don't need memmove very early (before kasan_early_init()) than arch-specific not-instrumented memmove()
> >> isn't necessary to have.
> >>
> >> ---
> >>  mm/kasan/common.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> >> index 6814d6d6a023..897f9520bab3 100644
> >> --- a/mm/kasan/common.c
> >> +++ b/mm/kasan/common.c
> >> @@ -107,6 +107,7 @@ void *memset(void *addr, int c, size_t len)
> >>  	return __memset(addr, c, len);
> >>  }
> >>  
> >> +#ifdef __HAVE_ARCH_MEMMOVE
> >>  #undef memmove
> >>  void *memmove(void *dest, const void *src, size_t len)
> >>  {
> >> @@ -115,6 +116,7 @@ void *memmove(void *dest, const void *src, size_t len)
> >>  
> >>  	return __memmove(dest, src, len);
> >>  }
> >> +#endif
> >>  
> >>  #undef memcpy
> >>  void *memcpy(void *dest, const void *src, size_t len)
> >> -- 
> >> 2.21.0
> >>
> >>
> >>
> > I have confirmed that the string operations are not used before kasan_early_init().
> > But I can't make sure whether other ARCHs would need it before kasan_early_init().
> > Do you have any idea to check that? Should I cc all other ARCH maintainers?
>  
> 
> This doesn't affect other ARCHes in any way. If other arches have their own not-instrumented
> memmove implementation (and they do), they will continue to be able to use it early.

I prefer Andrey's method since porting the generic string operations with newlib ones should
be a separated patch from KASAN.

Nick
