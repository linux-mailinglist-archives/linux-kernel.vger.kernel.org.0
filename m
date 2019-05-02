Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD03011831
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 13:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfEBLcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 07:32:52 -0400
Received: from ozlabs.org ([203.11.71.1]:57339 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbfEBLcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 07:32:52 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44vtRP40Qrz9s9T;
        Thu,  2 May 2019 21:32:49 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v1 3/4] powerpc/mm: Move book3s32 specifics in subdirectory mm/book3s64
In-Reply-To: <12c1ba4fc9e2e55ca44c5c57225669b296d48c74.1553853405.git.christophe.leroy@c-s.fr>
References: <cover.1553853405.git.christophe.leroy@c-s.fr> <12c1ba4fc9e2e55ca44c5c57225669b296d48c74.1553853405.git.christophe.leroy@c-s.fr>
Date:   Thu, 02 May 2019 21:32:49 +1000
Message-ID: <87tvedxfa6.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Several files in arch/powerpc/mm are only for book3S32. This patch
> creates a subdirectory for them.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/mm/Makefile                            | 3 +--
>  arch/powerpc/mm/book3s32/Makefile                   | 6 ++++++
>  arch/powerpc/mm/{ => book3s32}/hash_low_32.S        | 0
>  arch/powerpc/mm/{ => book3s32}/mmu_context_hash32.c | 0
>  arch/powerpc/mm/{ => book3s32}/ppc_mmu_32.c         | 0
>  arch/powerpc/mm/{ => book3s32}/tlb_hash32.c         | 0
>  6 files changed, 7 insertions(+), 2 deletions(-)
>  create mode 100644 arch/powerpc/mm/book3s32/Makefile
>  rename arch/powerpc/mm/{ => book3s32}/hash_low_32.S (100%)
>  rename arch/powerpc/mm/{ => book3s32}/mmu_context_hash32.c (100%)
>  rename arch/powerpc/mm/{ => book3s32}/ppc_mmu_32.c (100%)
>  rename arch/powerpc/mm/{ => book3s32}/tlb_hash32.c (100%)

I shortened them to:

  arch/powerpc/mm/{hash_low_32.S => book3s32/hash_low.S}
  arch/powerpc/mm/{ppc_mmu_32.c => book3s32/mmu.c}
  arch/powerpc/mm/{mmu_context_hash32.c => book3s32/mmu_context.c}
  arch/powerpc/mm/{tlb_hash32.c => book3s32/tlb.c}

cheers
