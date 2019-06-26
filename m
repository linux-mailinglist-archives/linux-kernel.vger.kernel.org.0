Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCF55561A8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 07:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfFZFTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 01:19:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45073 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfFZFTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 01:19:10 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hg0Ke-0003Ol-0w; Wed, 26 Jun 2019 07:18:56 +0200
Date:   Wed, 26 Jun 2019 07:18:49 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
cc:     Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the tip tree
In-Reply-To: <20190626093250.5c7cc243@canb.auug.org.au>
Message-ID: <alpine.DEB.2.21.1906260718370.32342@nanos.tec.linutronix.de>
References: <20190626093250.5c7cc243@canb.auug.org.au>
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

On Wed, 26 Jun 2019, Stephen Rothwell wrote:
> 
>   53d87b37a2a4 ("arm64: compat: No need for pre-ARMv7 barriers on an ARMv8 system")
>   b4b12aca00d5 ("arm64: vdso: Remove unnecessary asm-offsets.c definitions")
>   4d33ebb02c45 ("vdso: Remove superfluous #ifdef __KERNEL__ in vdso/datapage.h")
> 
> are missing a Signed-off-by from their committer.

Oops.
