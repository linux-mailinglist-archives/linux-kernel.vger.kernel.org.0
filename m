Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1306317B2EF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 01:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbgCFA2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 19:28:03 -0500
Received: from ozlabs.org ([203.11.71.1]:38271 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727178AbgCFA1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 19:27:54 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48YT3X0KXSz9sPJ; Fri,  6 Mar 2020 11:27:51 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 6453f9ed9d4e4b4cdf201bf34bf460c436bf50ea
In-Reply-To: <03c97f0f6b3790d164822563be80f2fd4713a955.1581932480.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/mm: Don't kmap_atomic() in pte_offset_map() on PPC32
Message-Id: <48YT3X0KXSz9sPJ@ozlabs.org>
Date:   Fri,  6 Mar 2020 11:27:51 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-02-17 at 09:41:35 UTC, Christophe Leroy wrote:
> On PPC32, pte_offset_map() does a kmap_atomic() in order to support
> page tables allocated in high memory, just like ARM and x86/32.
> 
> But since at least 2008 and commit 8054a3428fbe ("powerpc: Remove dead
> CONFIG_HIGHPTE"), page tables are never allocated in high memory.
> 
> When the page is in low mem, kmap_atomic() just returns the page
> address but still disable preemption and pagefault. And it is
> not an inlined function, so we suffer function call for no reason.
> 
> Make pte_offset_map() the same as pte_offset_kernel() and make
> pte_unmap() void, in the same way as PPC64 which doesn't have HIGHMEM.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6453f9ed9d4e4b4cdf201bf34bf460c436bf50ea

cheers
