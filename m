Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA2B8D847
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 18:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfHNQkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 12:40:33 -0400
Received: from foss.arm.com ([217.140.110.172]:57184 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbfHNQkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 12:40:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30B23344;
        Wed, 14 Aug 2019 09:40:32 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 805FA3F694;
        Wed, 14 Aug 2019 09:40:30 -0700 (PDT)
Date:   Wed, 14 Aug 2019 17:40:28 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, ak@linux.intel.com,
        akpm@linux-foundation.org, bigeasy@linutronix.de, bp@suse.de,
        davem@davemloft.net, hch@lst.de, kan.liang@intel.com,
        mingo@kernel.org, peterz@infradead.org, riel@surriel.com,
        will@kernel.org
Subject: Re: [PATCH 5/9] arm64: correctly check for ktrheads
Message-ID: <20190814164028.GC54611@arrakis.emea.arm.com>
References: <20190814104131.20190-1-mark.rutland@arm.com>
 <20190814104131.20190-6-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814104131.20190-6-mark.rutland@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 11:41:27AM +0100, Mark Rutland wrote:
> Since commit:
> 
>   6eb6c80187c55b7f ("arm64: kernel thread don't need to save fpsimd context.")
> 
> ... we skip saving the fpsimd state for kernel threads in
> arch_dup_task_struct(). We determine whether current is a kthread by
> looking at current->mm.
> 
> In general, a non-NULL current->mm doesn't imply that current is a
> kthread, as kthreads can install an mm via use_mm(), and so it's
> preferable to use is_kthread() to determine whether a thread is a
> kthread.
> 
> For consistency, let's use is_kthread() here.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
