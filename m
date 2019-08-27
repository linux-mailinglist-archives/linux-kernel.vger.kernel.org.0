Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04B2F9DB8C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 04:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbfH0CMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 22:12:24 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:35597 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbfH0CMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 22:12:23 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46HXSj4x2Yz9s7T;
        Tue, 27 Aug 2019 12:12:21 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/time: use feature fixup in __USE_RTC() instead of cpu feature.
In-Reply-To: <60da7620a43dc29317a062f1d58dcfde8d32b258.camel@kernel.crashing.org>
References: <55c267ac6e0cd289970accfafbf9dda11a324c2e.1566802736.git.christophe.leroy@c-s.fr> <87blwc40i4.fsf@concordia.ellerman.id.au> <60da7620a43dc29317a062f1d58dcfde8d32b258.camel@kernel.crashing.org>
Date:   Tue, 27 Aug 2019 12:12:20 +1000
Message-ID: <87y2zf2w6z.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Mon, 2019-08-26 at 21:41 +1000, Michael Ellerman wrote:
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> > sched_clock(), used by printk(), calls __USE_RTC() to know
>> > whether to use realtime clock or timebase.
>> > 
>> > __USE_RTC() uses cpu_has_feature() which is initialised by
>> > machine_init(). Before machine_init(), __USE_RTC() returns true,
>> > leading to a program check exception on CPUs not having realtime
>> > clock.
>> > 
>> > In order to be able to use printk() earlier, use feature fixup.
>> > Feature fixups are applies in early_init(), enabling the use of
>> > printk() earlier.
>> > 
>> > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> > ---
>> >  arch/powerpc/include/asm/time.h | 9 ++++++++-
>> >  1 file changed, 8 insertions(+), 1 deletion(-)
>> 
>> The other option would be just to make this a compile time decision, eg.
>> add CONFIG_PPC_601 and use that to gate whether we use RTC.
>> 
>> Given how many 601 users there are, maybe 1?, I think that would be a
>> simpler option and avoids complicating the code / binary for everyone
>> else.
>
> Didn't we ditch 601 support years ago anyway ? We had workaround we
> threw out I think...

Paul said his still booted recently.

cheers
