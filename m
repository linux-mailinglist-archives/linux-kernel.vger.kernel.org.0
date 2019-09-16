Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06D9DB36CD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 11:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731628AbfIPJDt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Sep 2019 05:03:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38532 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729075AbfIPJDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 05:03:48 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1i9mv2-0003uS-SE; Mon, 16 Sep 2019 11:03:36 +0200
Date:   Mon, 16 Sep 2019 11:03:36 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Qian Cai <cai@lca.pw>, peterz@infradead.org, mingo@redhat.com
Cc:     akpm@linux-foundation.org, tglx@linutronix.de, thgarnie@google.com,
        tytso@mit.edu, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, will@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org
Subject: Re: [PATCH] mm/slub: fix a deadlock in shuffle_freelist()
Message-ID: <20190916090336.2mugbds4rrwxh6uz@linutronix.de>
References: <1568392064-3052-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1568392064-3052-1-git-send-email-cai@lca.pw>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-13 12:27:44 [-0400], Qian Cai wrote:
…
> Chain exists of:
>   random_write_wait.lock --> &rq->lock --> batched_entropy_u32.lock
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(batched_entropy_u32.lock);
>                                lock(&rq->lock);
>                                lock(batched_entropy_u32.lock);
>   lock(random_write_wait.lock);

would this deadlock still occur if lockdep knew that
batched_entropy_u32.lock on CPU0 could be acquired at the same time
as CPU1 acquired its batched_entropy_u32.lock?

Sebastian
