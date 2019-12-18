Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7FC6123E3A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 05:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfLREFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 23:05:15 -0500
Received: from ozlabs.org ([203.11.71.1]:52603 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbfLREFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 23:05:14 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47d1ck6pJpz9sR0; Wed, 18 Dec 2019 15:05:10 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 0601546f23fb70d84b807e73cfe8e789d054c98d
In-Reply-To: <56648921986a6b3e7315b1fbbf4684f21bd2dea8.1576310997.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/8xx: fix bogus __init on mmu_mapin_ram_chunk()
Message-Id: <47d1ck6pJpz9sR0@ozlabs.org>
Date:   Wed, 18 Dec 2019 15:05:10 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-12-14 at 08:10:29 UTC, Christophe Leroy wrote:
> Remove __init qualifier for mmu_mapin_ram_chunk() as it is called by
> mmu_mark_initmem_nx() and mmu_mark_rodata_ro() which are not __init
> functions.
> 
> At the same time, mark it static as it is only used in this file.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Fixes: a2227a277743 ("powerpc/32: Don't populate page tables for block mapped pages except on the 8xx")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/0601546f23fb70d84b807e73cfe8e789d054c98d

cheers
