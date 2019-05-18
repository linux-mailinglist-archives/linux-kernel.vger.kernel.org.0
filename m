Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3175F222BC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2019 11:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbfERJrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 May 2019 05:47:25 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51948 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbfERJrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:47:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AE37341;
        Sat, 18 May 2019 02:47:24 -0700 (PDT)
Received: from mbp (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D64A3F703;
        Sat, 18 May 2019 02:47:23 -0700 (PDT)
Date:   Sat, 18 May 2019 10:47:20 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@gmail.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kmemleak: fix check for softirq context
Message-ID: <20190518094719.gyvhbdrwmcv4diax@mbp>
References: <20190517171507.96046-1-dvyukov@gmail.com>
 <20190517143746.2157a759f65b4cbc73321124@linux-foundation.org>
 <CACT4Y+aee_Kvezo8zeD77RwBi2-Csd9cE8vtGCmaTGYxr=iK5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aee_Kvezo8zeD77RwBi2-Csd9cE8vtGCmaTGYxr=iK5A@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 18, 2019 at 09:10:59AM +0200, Dmitry Vyukov wrote:
> On Fri, May 17, 2019 at 11:37 PM Andrew Morton
> <akpm@linux-foundation.org> wrote:
> > On Fri, 17 May 2019 19:15:07 +0200 Dmitry Vyukov <dvyukov@gmail.com> wrote:
> >
> > > From: Dmitry Vyukov <dvyukov@google.com>
> > >
> > > in_softirq() is a wrong predicate to check if we are in a softirq context.
> > > It also returns true if we have BH disabled, so objects are falsely
> > > stamped with "softirq" comm. The correct predicate is in_serving_softirq().
> > >
> > > ...
> > >
> > > --- a/mm/kmemleak.c
> > > +++ b/mm/kmemleak.c
> > > @@ -588,7 +588,7 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
> > >       if (in_irq()) {
> > >               object->pid = 0;
> > >               strncpy(object->comm, "hardirq", sizeof(object->comm));
> > > -     } else if (in_softirq()) {
> > > +     } else if (in_serving_softirq()) {
> > >               object->pid = 0;
> > >               strncpy(object->comm, "softirq", sizeof(object->comm));
> > >       } else {
> >
> > What are the user-visible runtime effects of this change?
> 
> If user does cat from /sys/kernel/debug/kmemleak previously they would
> see this, which is clearly wrong, this is system call context (see the
> comm):

Indeed, with your patch you get the correct output.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks.

-- 
Catalin
