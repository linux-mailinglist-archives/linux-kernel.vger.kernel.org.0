Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B58C061306
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2019 23:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfGFVfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Jul 2019 17:35:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37180 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfGFVfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 17:35:22 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hjsL0-00064V-OD; Sat, 06 Jul 2019 23:35:18 +0200
Date:   Sat, 6 Jul 2019 23:35:12 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Gromm <christian.gromm@microchip.com>,
        tglx@linutronix.de
Subject: Re: [PATCH 4/7] staging: most: Use spinlock_t instead of struct
 spinlock
Message-ID: <20190706213512.xuyxgvcy7ntn474d@linutronix.de>
References: <20190704153803.12739-1-bigeasy@linutronix.de>
 <20190704153803.12739-5-bigeasy@linutronix.de>
 <20190706100253.GA20497@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190706100253.GA20497@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-06 12:02:53 [+0200], Greg Kroah-Hartman wrote:
> On Thu, Jul 04, 2019 at 05:38:00PM +0200, Sebastian Andrzej Siewior wrote:
> > For spinlocks the type spinlock_t should be used instead of "struct
> > spinlock".
> 
> Why?
> 
> > Use spinlock_t for spinlock's definition.
> 
> Why?  I agree it makes the code smaller, but why is this required?

I remember PeterZ pointing out to stick to the typedef and it is
probably better to stick with the typdef since we have it. It was like
that since it was first introduced (2.1.25 for i386).
We have a checkpatch warning for that [0]. 

This series has only 7 patches (excluding the powerpc bits) so almost
everyone else is using just the typdef.

[0] 88982fea52d01 ("checkpatch: warn when declaring "struct spinlock foo;"")
    from Dec 2012

> thanks,
> 
> greg k-h

Sebastian
