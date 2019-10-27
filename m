Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57B09E610A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2019 06:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfJ0FsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Oct 2019 01:48:17 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:13490 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725935AbfJ0FsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 01:48:17 -0400
X-IronPort-AV: E=Sophos;i="5.68,235,1569276000"; 
   d="scan'208";a="408548235"
Received: from ip-121.net-89-2-166.rev.numericable.fr (HELO hadrien) ([89.2.166.121])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Oct 2019 06:47:55 +0100
Date:   Sun, 27 Oct 2019 06:47:55 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Joe Perches <joe@perches.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <error27@gmail.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] kernel: sys.c: Avoid copying possible padding bytes in
 copy_to_user
In-Reply-To: <dfa331c00881d61c8ee51577a082d8bebd61805c.camel@perches.com>
Message-ID: <alpine.DEB.2.21.1910270644590.3186@hadrien>
References: <dfa331c00881d61c8ee51577a082d8bebd61805c.camel@perches.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 26 Oct 2019, Joe Perches wrote:

> Initialization is not guaranteed to zero padding bytes so
> use an explicit memset instead to avoid leaking any kernel
> content in any possible padding bytes.

Here is an extract of an email that I sent to Kees at one point that left
me unsure about what should be done about these situations:

From Kees:

    The only way to correctly handle this is:

    memset(&instance, 0, sizeof(instance));
    instance.one = 1;

From me:

Actually, this document:

https://wiki.sei.cmu.edu/confluence/display/c/DCL39-C.+Avoid+information+leakage+when+passing+a+structure+across+a+trust+boundary

says that memset is a "noncompliant solution".  They suggest declaring the
structure as packed, as well as some other more unpleasant solutions.
Their point is that 1 will be sitting in a register, and the assignment at
least might copy the upper bytes of the register into the padding space.

-------------------------

Is the memset solution nevertheless what is always wanted in the kernel
when there is padding?

thanks,
julia
