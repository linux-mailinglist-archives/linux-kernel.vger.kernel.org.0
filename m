Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB414A80C6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 13:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbfIDLAv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Sep 2019 07:00:51 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:46328 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728961AbfIDLAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 07:00:51 -0400
Received: from bigeasy by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <bigeasy@linutronix.de>)
        id 1i5T1j-0002fS-0j; Wed, 04 Sep 2019 13:00:39 +0200
Date:   Wed, 4 Sep 2019 13:00:38 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        linux-crypto@vger.kernel.org, Matt Mackall <mpm@selenic.com>,
        Keerthy <j-keerthy@ti.com>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] random: Support freezable kthreads in
 add_hwgenerator_randomness()
Message-ID: <20190904110038.2bx25byitrejlteu@flow>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190822055519.GB3860@gondor.apana.org.au>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-22 15:55:19 [+1000], Herbert Xu wrote:
> Patch applied.  Thanks.
[ ff296293b3538 ("random: Support freezable kthreads in add_hwgenerator_randomness()") ]

and since kthread_freezable_should_stop() has might_sleep() in it, I get
this:

|: do not call blocking ops when !TASK_RUNNING; state=1 set at [<00000000349d1489>] prepare_to_wait_event+0x5a/0x180
|: WARNING: CPU: 0 PID: 828 at kernel/sched/core.c:6741 __might_sleep+0x6f/0x80
|: Modules linked in:
|:
|: CPU: 0 PID: 828 Comm: hwrng Not tainted 5.3.0-rc7-next-20190903+ #46
|: RIP: 0010:__might_sleep+0x6f/0x80
…
|: Call Trace:
|:  kthread_freezable_should_stop+0x1b/0x60
|:  add_hwgenerator_randomness+0xdd/0x130
|:  hwrng_fillfn+0xbf/0x120
|:  kthread+0x10c/0x140
|:  ret_from_fork+0x27/0x50

Sebastian
