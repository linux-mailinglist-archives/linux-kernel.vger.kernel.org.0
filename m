Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED780D8C95
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 11:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404214AbfJPJf0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Oct 2019 05:35:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49420 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391829AbfJPJf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:35:26 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iKfiF-0001cC-KN; Wed, 16 Oct 2019 11:35:23 +0200
Date:   Wed, 16 Oct 2019 11:35:23 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        tglx@linutronix.de, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 03/34] powerpc: Use CONFIG_PREEMPTION
Message-ID: <20191016093523.tukmwtouugecbll4@linutronix.de>
References: <20191015191821.11479-1-bigeasy@linutronix.de>
 <20191015191821.11479-4-bigeasy@linutronix.de>
 <156db456-af80-1f5e-6234-2e78283569b6@c-s.fr>
 <87d0ext4q3.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <87d0ext4q3.fsf@mpe.ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-16 20:33:08 [+1100], Michael Ellerman wrote:
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> > Le 15/10/2019 à 21:17, Sebastian Andrzej Siewior a écrit :
> >> From: Thomas Gleixner <tglx@linutronix.de>
> >> 
> >> CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
> >> Both PREEMPT and PREEMPT_RT require the same functionality which today
> >> depends on CONFIG_PREEMPT.
> >> 
> >> Switch the entry code over to use CONFIG_PREEMPTION. Add PREEMPT_RT
> >> output in __die().
> >
> > powerpc doesn't select ARCH_SUPPORTS_RT, so this change is useless as 
> > CONFIG_PREEMPT_RT cannot be selected.
> 
> Yeah I don't think there's any point adding the "_RT" to the __die()
> output until/if we ever start supporting PREEMPT_RT.

so jut the PREEMPT -> PREEMPTION  bits then?

> cheers

Sebastian
