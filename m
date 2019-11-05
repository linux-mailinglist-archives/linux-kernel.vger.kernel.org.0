Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44BCDEFA6A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 11:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388124AbfKEKGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 05:06:04 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40795 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730571AbfKEKGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 05:06:03 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iRvib-0000Jf-I3; Tue, 05 Nov 2019 11:05:45 +0100
Date:   Tue, 5 Nov 2019 11:05:45 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arjan van de Ven <arjan@linux.intel.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] smpboot: reuse timer calibration
In-Reply-To: <20191029143547.GO4114@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1911051103280.17054@nanos.tec.linutronix.de>
References: <ebb16cf3-128d-2515-a98a-a58db0c1f963@molgen.mpg.de> <20191029143547.GO4114@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2019, Peter Zijlstra wrote:
> On Tue, Oct 29, 2019 at 03:19:57PM +0100, Paul Menzel wrote:
> > From: Arjan van de Ven <arjan@linux.intel.com>
> > Date: Wed, 11 Feb 2015 17:28:14 -0600
> > 
> > NO point recalibrating for known-constant tsc ...
> > saves 200ms+ of boot time.
> > 
> > Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > ---
> > 
> > Arjan, can your Signed-off-by line be added? On what device, did you test
> > this?
> 
> This patch makes no sense what so ever given the current function, also
> it hard codes 0 as being the BSP.
> 
> All of this for platforms (!constant_tsc) that barely exist anymore.

And it's only an issue on multi-socket systems with !constant_tsc, which
are even more rare.

Thanks,

	tglx

