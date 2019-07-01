Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5331C4FBA5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2019 14:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfFWMmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jun 2019 08:42:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33352 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfFWMmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 08:42:45 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hf1pT-0000ul-3D; Sun, 23 Jun 2019 14:42:43 +0200
Date:   Sun, 23 Jun 2019 14:42:42 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86/vdso: Give the [ph]vclock_page declarations real
 types
In-Reply-To: <6920c5188f8658001af1fc56fd35b815706d300c.1561241273.git.luto@kernel.org>
Message-ID: <alpine.DEB.2.21.1906231441500.32342@nanos.tec.linutronix.de>
References: <6920c5188f8658001af1fc56fd35b815706d300c.1561241273.git.luto@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jun 2019, Andy Lutomirski wrote:

> Clean up the vDSO code a bit by giving pvclock_page and hvclock_page
> their actual types instead of u8[PAGE_SIZE].  This shouldn't
> materially affect the generated code.
> 
> Heavily based on a patch from Linus.
> 
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

So either this wants a

From: Linus line

or this tag should be:

Originally-by: Linus ...

Hmm?

Thanks,

	tglx
