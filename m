Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36373B47FE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 09:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392549AbfIQHQq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 Sep 2019 03:16:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40781 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730666AbfIQHQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 03:16:45 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iA7j1-0004ha-7O; Tue, 17 Sep 2019 09:16:35 +0200
Date:   Tue, 17 Sep 2019 09:16:35 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Qian Cai <cai@lca.pw>
Cc:     peterz@infradead.org, mingo@redhat.com, akpm@linux-foundation.org,
        tglx@linutronix.de, thgarnie@google.com, tytso@mit.edu,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        will@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org
Subject: Re: [PATCH] mm/slub: fix a deadlock in shuffle_freelist()
Message-ID: <20190917071634.c7i3i6jg676ejiw5@linutronix.de>
References: <1568392064-3052-1-git-send-email-cai@lca.pw>
 <20190916090336.2mugbds4rrwxh6uz@linutronix.de>
 <1568642487.5576.152.camel@lca.pw>
 <20190916195115.g4hj3j3wstofpsdr@linutronix.de>
 <1568669494.5576.157.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1568669494.5576.157.camel@lca.pw>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-16 17:31:34 [-0400], Qian Cai wrote:
…
> get_random_u64() is also busted.
…
> [  753.486588]  Possible unsafe locking scenario:
> 
> [  753.493890]        CPU0                    CPU1
> [  753.499108]        ----                    ----
> [  753.504324]   lock(batched_entropy_u64.lock);
> [  753.509372]                                lock(&(&zone->lock)->rlock);
> [  753.516675]                                lock(batched_entropy_u64.lock);
> [  753.524238]   lock(random_write_wait.lock);
> [  753.529113] 
>                 *** DEADLOCK ***

This is the same scenario as the previous one in regard to the
batched_entropy_….lock.

Sebastian
