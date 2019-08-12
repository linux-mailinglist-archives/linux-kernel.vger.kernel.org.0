Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACDC89F69
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 15:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbfHLNPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 09:15:08 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40203 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbfHLNPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 09:15:08 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 466btK49TZz9sN6; Mon, 12 Aug 2019 23:15:05 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: b9ee5e04fd77898208c51b1395fa0b5e8536f9b6
In-Reply-To: <bef479514f4c08329fa649f67735df8918bc0976.1565268248.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Chris Packham <Chris.Packham@alliedtelesis.co.nz>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/64e: drop stale call to smp_processor_id() which hangs SMP startup
Message-Id: <466btK49TZz9sN6@ozlabs.org>
Date:   Mon, 12 Aug 2019 23:15:05 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-08 at 12:48:26 UTC, Christophe Leroy wrote:
> Santa commit ebb9d30a6a74 ("powerpc/mm: any thread in one core can be
> the first to setup TLB1") removed the need to know the cpu_id in
> early_init_this_mmu(), but the call to smp_processor_id() which was
> marked __maybe_used remained.
> 
> Since commit ed1cd6deb013 ("powerpc: Activate
> CONFIG_THREAD_INFO_IN_TASK") thread_info cannot be reached before mmu
> is properly set up.
> 
> Drop this stale call to smp_processor_id() which make SMP hang
> when CONFIG_PREEMPT is set.
> 
> Reported-by: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
> Fixes: ebb9d30a6a74 ("powerpc/mm: any thread in one core can be the first to setup TLB1")
> Link: https://github.com/linuxppc/issues/issues/264
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: stable@vger.kernel.org

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/b9ee5e04fd77898208c51b1395fa0b5e8536f9b6

cheers
