Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92D2314F805
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Feb 2020 15:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgBAOHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Feb 2020 09:07:08 -0500
Received: from gate.crashing.org ([63.228.1.57]:47802 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbgBAOHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 09:07:08 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 011E6WZ9013963;
        Sat, 1 Feb 2020 08:06:32 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 011E6TK9013962;
        Sat, 1 Feb 2020 08:06:29 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sat, 1 Feb 2020 08:06:29 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/32s: Don't flush all TLBs when flushing one page
Message-ID: <20200201140629.GM22482@gate.crashing.org>
References: <e31c57eb5308a5a73a5c8232454c0dd9f65f6175.1580485014.git.christophe.leroy@c-s.fr> <20200131155150.GD22482@gate.crashing.org> <27cef66b-df5b-0baa-abac-5532e58bd055@c-s.fr> <20200131193833.GF22482@gate.crashing.org> <248a3cf3-1b5e-a6e1-ceec-0e3904d1cf51@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <248a3cf3-1b5e-a6e1-ceec-0e3904d1cf51@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 01, 2020 at 08:27:03AM +0100, Christophe Leroy wrote:
> Le 31/01/2020 � 20:38, Segher Boessenkool a �crit�:
> >On Fri, Jan 31, 2020 at 05:15:20PM +0100, Christophe Leroy wrote:
> >>Le 31/01/2020 � 16:51, Segher Boessenkool a �crit�:
> >>>On Fri, Jan 31, 2020 at 03:37:34PM +0000, Christophe Leroy wrote:
> >>>>When the range is a single page, do a page flush instead.
> >>>
> >>>>+	start &= PAGE_MASK;
> >>>>+	end = (end - 1) | ~PAGE_MASK;
> >>>>  	if (!Hash) {
> >>>>-		_tlbia();
> >>>>+		if (end - start == PAGE_SIZE)
> >>>>+			_tlbie(start);
> >>>>+		else
> >>>>+			_tlbia();
> >>>>  		return;
> >>>>  	}
> >>>
> >>>For just one page, you get  end - start == 0  actually?
> >>
> >>Oops, good catch.
> >>
> >>Indeed you don't get PAGE_SIZE but (PAGE_SIZE - 1) for just one page.
> >
> >You have all low bits masked off in both start and end, so you get zero.
> >You could make the condion read "if (start == end)?
> 
> No, in end the low bits are set, that's a BIT OR with ~PAGE_MASK, so it 
> sets all low bits to 1.

Oh, wow, yes, I cannot read apparently.

Maybe there are some ROUND_DOWN and ROUND_UP macros you could use?


Segher
