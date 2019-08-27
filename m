Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07B6F9F194
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 19:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbfH0R3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 13:29:42 -0400
Received: from gate.crashing.org ([63.228.1.57]:52705 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbfH0R3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 13:29:42 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x7RHTARD029788;
        Tue, 27 Aug 2019 12:29:10 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x7RHT9fb029787;
        Tue, 27 Aug 2019 12:29:09 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 27 Aug 2019 12:29:09 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] powerpc: cleanup hw_irq.h
Message-ID: <20190827172909.GA31406@gate.crashing.org>
References: <0f7e164afb5d1b022441559fe5a999bb6d3c0a23.1566893505.git.christophe.leroy@c-s.fr> <81f39fa06ae582f4a783d26abd2b310204eba8f4.1566893505.git.christophe.leroy@c-s.fr> <1566909844.x4jee1jjda.astroid@bobo.none>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566909844.x4jee1jjda.astroid@bobo.none>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 10:48:24PM +1000, Nicholas Piggin wrote:
> Christophe Leroy's on August 27, 2019 6:13 pm:
> > +#define wrtee(val)	asm volatile("wrtee %0" : : "r" (val) : "memory")
> > +#define wrteei(val)	asm volatile("wrteei %0" : : "i" (val) : "memory")
> 
> Can you implement just one macro that uses __builtin_constant_p to 
> select between the imm and reg versions? I forgot if there's some
> corner cases that prevent that working with inline asm i constraints.

static inline void wrtee(long val)
{
	asm volatile("wrtee%I0 %0" : : "n"(val) : "memory");
}

(This output modifier goes back to the dark ages, some 2.4 or something).


Segher
