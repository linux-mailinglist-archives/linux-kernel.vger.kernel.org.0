Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12D76D4746
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 20:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbfJKSPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 14:15:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33516 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbfJKSPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 14:15:44 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iIzRs-0008Gs-KC; Fri, 11 Oct 2019 20:15:32 +0200
Date:   Fri, 11 Oct 2019 20:15:32 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Wagner <dwagner@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 1/1] mm/vmalloc: remove preempt_disable/enable when do
 preloading
Message-ID: <20191011181532.nardqmokz7yxtsu3@linutronix.de>
References: <20191010223318.28115-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191010223318.28115-1-urezki@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-11 00:33:18 [+0200], Uladzislau Rezki (Sony) wrote:
> Get rid of preempt_disable() and preempt_enable() when the
> preload is done for splitting purpose. The reason is that
> calling spin_lock() with disabled preemtion is forbidden in
> CONFIG_PREEMPT_RT kernel.
> 
> Therefore, we do not guarantee that a CPU is preloaded, instead
> we minimize the case when it is not with this change.
> 
> For example i run the special test case that follows the preload
> pattern and path. 20 "unbind" threads run it and each does
> 1000000 allocations. Only 3.5 times among 1000000 a CPU was
> not preloaded. So it can happen but the number is negligible.
> 
> V1 -> V2:
>   - move __this_cpu_cmpxchg check when spin_lock is taken,
>     as proposed by Andrew Morton
>   - add more explanation in regard of preloading
>   - adjust and move some comments
> 
> Fixes: 82dd23e84be3 ("mm/vmalloc.c: preload a CPU with one object for split purpose")
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thank you.

Sebastian
