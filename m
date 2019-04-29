Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC88E1A5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 13:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbfD2LzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 07:55:10 -0400
Received: from gate.crashing.org ([63.228.1.57]:36468 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727710AbfD2LzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 07:55:09 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x3TBsWU9018817;
        Mon, 29 Apr 2019 06:54:32 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x3TBsV00018809;
        Mon, 29 Apr 2019 06:54:31 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 29 Apr 2019 06:54:31 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] powerpc/module32: Use symbolic instructions names.
Message-ID: <20190429115431.GN8599@gate.crashing.org>
References: <23167861f6095456b4ba3b52c55a514201ca738f.1556534520.git.christophe.leroy@c-s.fr> <14f88b27ff94f2d5a07a8cbc33ec75e2f8af9cf9.1556534520.git.christophe.leroy@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14f88b27ff94f2d5a07a8cbc33ec75e2f8af9cf9.1556534520.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 10:43:27AM +0000, Christophe Leroy wrote:
> To increase readability/maintainability, replace hard coded
> instructions values by symbolic names.

> +	/* lis r12,sym@ha */
> +#define ENTRY_JMP0(sym)	(PPC_INST_ADDIS | __PPC_RT(R12) | PPC_HA(sym))
> +	/* addi r12,r12,sym@l */
> +#define ENTRY_JMP1(sym)	(PPC_INST_ADDI | __PPC_RT(R12) | __PPC_RA(R12) | PPC_LO(sym))

Those aren't "jump" instructions though, as the name suggests...  And you
only have names for the first two of the four insns.  ("2" and "3" were
still available ;-) )

> -	entry->jump[0] = 0x3d800000+((val+0x8000)>>16); /* lis r12,sym@ha */
> -	entry->jump[1] = 0x398c0000 + (val&0xffff);     /* addi r12,r12,sym@l*/
> -	entry->jump[2] = 0x7d8903a6;                    /* mtctr r12 */
> -	entry->jump[3] = 0x4e800420;			/* bctr */
> +	entry->jump[0] = ENTRY_JMP0(val);
> +	entry->jump[1] = ENTRY_JMP1(val);
> +	entry->jump[2] = PPC_INST_MTCTR | __PPC_RS(R12);
> +	entry->jump[3] = PPC_INST_BCTR;

Deleting the comment here is not an improvement imo.


Segher
