Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C950F49D10
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 11:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbfFRJZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 05:25:50 -0400
Received: from foss.arm.com ([217.140.110.172]:59160 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728810AbfFRJZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 05:25:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E4EC344;
        Tue, 18 Jun 2019 02:25:49 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E40263F246;
        Tue, 18 Jun 2019 02:25:47 -0700 (PDT)
Date:   Tue, 18 Jun 2019 10:25:40 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Qian Cai <cai@lca.pw>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64/mm: don't initialize pgd_cache twice
Message-ID: <20190618092540.GA30899@fuggles.cambridge.arm.com>
References: <1560843149-13845-1-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560843149-13845-1-git-send-email-rppt@linux.ibm.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 10:32:29AM +0300, Mike Rapoport wrote:
> When PGD_SIZE != PAGE_SIZE, arm64 uses kmem_cache for allocation of PGD
> memory. That cache was initialized twice: first through
> pgtable_cache_init() alias and then as an override for weak
> pgd_cache_init().
> 
> Remove the alias from pgtable_cache_init() and keep the only pgd_cache
> initialization in pgd_cache_init().
> 
> Fixes: caa841360134 ("x86/mm: Initialize PGD cache during mm initialization")
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/arm64/include/asm/pgtable.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Thanks, Mike.

Will
