Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAAF8151A3B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 13:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgBDMBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 07:01:37 -0500
Received: from ozlabs.org ([203.11.71.1]:51413 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727148AbgBDMBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 07:01:36 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48BjwG5Y3xzB3wq; Tue,  4 Feb 2020 23:01:34 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 9933819099c4600b41a042f27a074470a43cf6b9
In-Reply-To: <6d02c3ae6ad77af34392e98117e44c2bf6d13ba1.1580121710.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/32s: Fix CPU wake-up from sleep mode
Message-Id: <48BjwG5Y3xzB3wq@ozlabs.org>
Date:   Tue,  4 Feb 2020 23:01:34 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-01-27 at 10:42:04 UTC, Christophe Leroy wrote:
> Commit f7354ccac844 ("powerpc/32: Remove CURRENT_THREAD_INFO and
> rename TI_CPU") broke the CPU wake-up from sleep mode (i.e. when
> _TLF_SLEEPING is set) by delaying the tovirt(r2, r2).
> 
> This is because r2 is not restored by fast_exception_return. It used
> to work (by chance ?) because CPU wake-up interrupt never comes from
> user, so r2 is expected to point to 'current' on return.
> 
> Commit e2fb9f544431 ("powerpc/32: Prepare for Kernel Userspace Access
> Protection") broke it even more by clobbering r0 which is not
> restored by fast_exception_return either.
> 
> Use r6 instead of r0. This is possible because r3-r6 are restored by
> fast_exception_return and only r3-r5 are used for exception arguments.
> 
> For r2 it could be converted back to virtual address, but stay on the
> safe side and restore it from the stack instead. It should be live
> in the cache at that moment, so loading from the stack should make
> no difference compared to converting it from phys to virt.
> 
> Fixes: f7354ccac844 ("powerpc/32: Remove CURRENT_THREAD_INFO and rename TI_CPU")
> Fixes: e2fb9f544431 ("powerpc/32: Prepare for Kernel Userspace Access Protection")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9933819099c4600b41a042f27a074470a43cf6b9

cheers
