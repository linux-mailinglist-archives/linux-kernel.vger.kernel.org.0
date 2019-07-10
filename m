Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36ADC618C3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 03:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbfGHBTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Jul 2019 21:19:43 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:35115 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728042AbfGHBTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 21:19:35 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45hnfs0rpPz9sP6; Mon,  8 Jul 2019 11:19:32 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 22e9c88d486a0536d337d6e0973968be0a4cd4b2
In-Reply-To: <d6f628ffdeb9c7863da722a8f6ef2949e57bb360.1557824379.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Oliver O'Halloran <oohall@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] powerpc/64: reuse PPC32 static inline flush_dcache_range()
Message-Id: <45hnfs0rpPz9sP6@ozlabs.org>
Date:   Mon,  8 Jul 2019 11:19:32 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-05-14 at 09:05:16 UTC, Christophe Leroy wrote:
> This patch drops the assembly PPC64 version of flush_dcache_range()
> and re-uses the PPC32 static inline version.
> 
> With GCC 8.1, the following code is generated:
> 
> void flush_test(unsigned long start, unsigned long stop)
> {
> 	flush_dcache_range(start, stop);
> }
> 
> 0000000000000130 <.flush_test>:
>  130:	3d 22 00 00 	addis   r9,r2,0
> 			132: R_PPC64_TOC16_HA	.data+0x8
>  134:	81 09 00 00 	lwz     r8,0(r9)
> 			136: R_PPC64_TOC16_LO	.data+0x8
>  138:	3d 22 00 00 	addis   r9,r2,0
> 			13a: R_PPC64_TOC16_HA	.data+0xc
>  13c:	80 e9 00 00 	lwz     r7,0(r9)
> 			13e: R_PPC64_TOC16_LO	.data+0xc
>  140:	7d 48 00 d0 	neg     r10,r8
>  144:	7d 43 18 38 	and     r3,r10,r3
>  148:	7c 00 04 ac 	hwsync
>  14c:	4c 00 01 2c 	isync
>  150:	39 28 ff ff 	addi    r9,r8,-1
>  154:	7c 89 22 14 	add     r4,r9,r4
>  158:	7c 83 20 50 	subf    r4,r3,r4
>  15c:	7c 89 3c 37 	srd.    r9,r4,r7
>  160:	41 82 00 1c 	beq     17c <.flush_test+0x4c>
>  164:	7d 29 03 a6 	mtctr   r9
>  168:	60 00 00 00 	nop
>  16c:	60 00 00 00 	nop
>  170:	7c 00 18 ac 	dcbf    0,r3
>  174:	7c 63 42 14 	add     r3,r3,r8
>  178:	42 00 ff f8 	bdnz    170 <.flush_test+0x40>
>  17c:	7c 00 04 ac 	hwsync
>  180:	4c 00 01 2c 	isync
>  184:	4e 80 00 20 	blr
>  188:	60 00 00 00 	nop
>  18c:	60 00 00 00 	nop
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/22e9c88d486a0536d337d6e0973968be0a4cd4b2

cheers
