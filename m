Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A677EB7758
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 12:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389294AbfISKZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Sep 2019 06:25:41 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:50943 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389206AbfISKZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 06:25:41 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 46YtKG6Krmz9sP3; Thu, 19 Sep 2019 20:25:38 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: ec5b705c48365549c483fab17d68d15d83bef265
In-Reply-To: <1566570120-16529-1-git-send-email-cai@lca.pw>
To:     Qian Cai <cai@lca.pw>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>,
        aneesh.kumar@linux.ibm.com, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm/radix: remove useless kernel messages
Message-Id: <46YtKG6Krmz9sP3@ozlabs.org>
Date:   Thu, 19 Sep 2019 20:25:38 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-23 at 14:22:00 UTC, Qian Cai wrote:
> Booting a POWER9 PowerNV system generates a few messages below with
> "____ptrval____" due to the pointers printed without a specifier
> extension (i.e unadorned %p) are hashed to prevent leaking information
> about the kernel memory layout.
> 
> radix-mmu: Initializing Radix MMU
> radix-mmu: Partition table (____ptrval____)
> radix-mmu: Mapped 0x0000000000000000-0x0000000040000000 with 1.00 GiB
> pages (exec)
> radix-mmu: Mapped 0x0000000040000000-0x0000002000000000 with 1.00 GiB
> pages
> radix-mmu: Mapped 0x0000200000000000-0x0000202000000000 with 1.00 GiB
> pages
> radix-mmu: Process table (____ptrval____) and radix root for kernel:
> (____ptrval____)
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ec5b705c48365549c483fab17d68d15d83bef265

cheers
