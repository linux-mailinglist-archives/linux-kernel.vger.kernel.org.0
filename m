Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFBB91284C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 09:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfECG7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 02:59:14 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57731 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbfECG7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:59:13 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44wNKC6W6qz9sNy; Fri,  3 May 2019 16:59:11 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: a1ac2a9c4f98482e49305ab5551b7b32f9cac39b
X-Patchwork-Hint: ignore
In-Reply-To: <92e8f0bcec682e878796758e1efb88c172c7ffe4.1553778054.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/book3e: drop BUG_ON() in map_kernel_page()
Message-Id: <44wNKC6W6qz9sNy@ozlabs.org>
Date:   Fri,  3 May 2019 16:59:11 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-03-28 at 13:03:45 UTC, Christophe Leroy wrote:
> early_alloc_pgtable() never returns NULL as it panics on failure.
> 
> This patch drops the three BUG_ON() which check the non nullity
> of early_alloc_pgtable() returned value.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a1ac2a9c4f98482e49305ab5551b7b32

cheers
