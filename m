Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCB19167F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2019 14:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfHRMVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Aug 2019 08:21:03 -0400
Received: from gate.crashing.org ([63.228.1.57]:37001 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbfHRMVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 08:21:03 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x7ICKb2C002871;
        Sun, 18 Aug 2019 07:20:37 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x7ICKa2n002870;
        Sun, 18 Aug 2019 07:20:36 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sun, 18 Aug 2019 07:20:36 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH] powerpc: use __builtin_trap() in BUG/WARN macros.
Message-ID: <20190818122036.GW31406@gate.crashing.org>
References: <20190817183750.D3018106766@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190817183750.D3018106766@localhost.localdomain>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Sat, Aug 17, 2019 at 06:37:50PM +0000, Christophe Leroy wrote:
>  #define BUG() do {						\
> +	__builtin_trap();					\

GCC will optimise away all code after this, it knows it is unreachable.
But you want to keep that BUG_ENTRY stuff I think?

The same will happen with a BUG_ON if the compiler can prove your
condition is always true.

>  	__asm__ __volatile__(					\
> -		"1:	twi 31,0,0\n"				\
> +		"1:\n"						\
>  		_EMIT_BUG_ENTRY					\
>  		: : "i" (__FILE__), "i" (__LINE__),		\
>  		    "i" (0), "i"  (sizeof(struct bug_entry)));	\

(GCC wil generate a different trap btw; what is called "trap" as extended
mnemonic, that is, "tw 31,0,0", not the same thing as "twi", if that
matters for the exception handler).


Segher
