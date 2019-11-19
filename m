Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D42F102FA5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 00:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfKSXBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 18:01:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54881 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfKSXBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 18:01:30 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iXCUo-0005ZH-PJ; Wed, 20 Nov 2019 00:01:18 +0100
Date:   Wed, 20 Nov 2019 00:01:17 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qais Yousef <qais.yousef@arm.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Richard Fontana <rfontana@redhat.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] arm64: hibernate.c: create a new function to handle
 cpu_up(sleep_cpu)
In-Reply-To: <20191119225100.gqiiiwoyt3yntdoj@e107158-lin.cambridge.arm.com>
Message-ID: <alpine.DEB.2.21.1911192359530.6731@nanos.tec.linutronix.de>
References: <20191030153837.18107-1-qais.yousef@arm.com> <20191030153837.18107-2-qais.yousef@arm.com> <alpine.DEB.2.21.1911192326120.6731@nanos.tec.linutronix.de> <20191119225100.gqiiiwoyt3yntdoj@e107158-lin.cambridge.arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2019, Qais Yousef wrote:
> On 11/19/19 23:31, Thomas Gleixner wrote:
> > On Wed, 30 Oct 2019, Qais Yousef wrote:
> > >  
> > > +int hibernation_bringup_sleep_cpu(unsigned int sleep_cpu)
> > 
> > That function name is horrible. Aside of that I really have to ask how you
> > end up hibernating on an offline CPU?
> 
> James Morse can probably explain better.
> 
> But AFAIU we could sleep on any CPU, but on the next cold boot that CPU could
> become offline as a side effect of using maxcpus= for example.
> 
> How about bringup_hibernate_cpu() as a name? I could add the above as an
> explanation of why we need this call too.
> 
> It does seem to me that this is a generic problem that we might be able to
> handle generically, but I'm not sure how.

Don't know about other architectures, but x86 does not have that issue as
we force hibernation on CPU0 for historical reasons (Broken BIOSes etc.).

Thanks,

	tglx
