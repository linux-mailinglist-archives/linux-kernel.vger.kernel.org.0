Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA52F17BBE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 16:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbfEHOl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 10:41:27 -0400
Received: from gate.crashing.org ([63.228.1.57]:51974 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726592AbfEHOl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 10:41:26 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x48Ef0ZK007596;
        Wed, 8 May 2019 09:41:00 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x48Eexn8007593;
        Wed, 8 May 2019 09:40:59 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 8 May 2019 09:40:58 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: slightly improve cache helpers
Message-ID: <20190508144058.GI8599@gate.crashing.org>
References: <0b460a85319fb89dab2c5d1200ac69a3e1b7c1ef.1557235807.git.christophe.leroy@c-s.fr> <20190507151030.GF8599@gate.crashing.org> <720e7c77-3f5c-83f3-6013-36b265c1ba73@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <720e7c77-3f5c-83f3-6013-36b265c1ba73@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 06:53:30PM +0200, Christophe Leroy wrote:
> Le 07/05/2019 à 17:10, Segher Boessenkool a écrit :
> >On Tue, May 07, 2019 at 01:31:39PM +0000, Christophe Leroy wrote:
> >>Cache instructions (dcbz, dcbi, dcbf and dcbst) take two registers
> >>that are summed to obtain the target address. Using '%y0' argument
> >>gives GCC the opportunity to use both registers instead of only one
> >>with the second being forced to 0.
> >
> >That's not quite right.  Sorry if I didn't explain it properly.
> >
> >"m" allows all memory.  But this instruction only allows reg,reg and
> >0,reg addressing.  For that you need to use constraint "Z".
> 
> But gcc help 
> (https://gcc.gnu.org/onlinedocs/gcc/Machine-Constraints.html#Machine-Constraints) 
> says it is better to use 'm':

It says it *usually* is better to use "m".  What it really should say is
it is better to use "m" _when that is valid_.  It is not valid for the
cache block instructions.

I'll fix up the comment...  "es" is ancient, too, nowadays it is
equivalent to just "m" (and you need "m<>" to allow pre-modify addressing).

> Z
> 
>     Memory operand that is an indexed or indirect from a register (it 
> is usually better to use ‘m’ or ‘es’ in asm statements)
> 
> That's the reason why I used 'm', I thought it was equivalent.

Yeah, the manual text could be clearer.


Segher
