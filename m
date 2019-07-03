Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACA75DA13
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 03:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfGCBAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 21:00:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49758 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbfGCBAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:00:36 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hiR5S-0008WV-Uk; Wed, 03 Jul 2019 00:17:19 +0200
Date:   Wed, 3 Jul 2019 00:17:17 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andi Kleen <andi@firstfloor.org>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] x86/fpu: Fix nofxsr regression
In-Reply-To: <20190702213958.33291-1-andi@firstfloor.org>
Message-ID: <alpine.DEB.2.21.1907030013130.1802@nanos.tec.linutronix.de>
References: <20190702213958.33291-1-andi@firstfloor.org>
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

On Tue, 2 Jul 2019, Andi Kleen wrote:
>  
> -	if (cmdline_find_option_bool(boot_command_line, "nofxsr")) {
> +	if (!IS_ENABLED(CONFIG_64BIT) &&
> +		cmdline_find_option_bool(boot_command_line, "nofxsr")) {
> +		fpu__xstate_clear_all_cpu_caps();
>  		setup_clear_cpu_cap(X86_FEATURE_FXSR);
>  		setup_clear_cpu_cap(X86_FEATURE_FXSR_OPT);
>  		setup_clear_cpu_cap(X86_FEATURE_XMM);

This is a mixture of disabling features explicitely and having the
dependencies in cpuid-deps. Even 2 of the existing ones are pointless
because clear(FXSR) already clears the other two.

Why not make XSAVE depend on XMM or whatever is the right dependency?

Thanks,

	tglx
