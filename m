Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39A99A19AE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 14:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfH2MOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 08:14:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49957 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfH2MOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 08:14:05 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i3JJK-0002TT-9D; Thu, 29 Aug 2019 14:13:54 +0200
Date:   Thu, 29 Aug 2019 14:13:53 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, harry.pan@intel.com,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] x86/hpet: Disable HPET on Intel Coffe Lake
In-Reply-To: <20190829091232.15065-1-kai.heng.feng@canonical.com>
Message-ID: <alpine.DEB.2.21.1908291351510.1938@nanos.tec.linutronix.de>
References: <20190829091232.15065-1-kai.heng.feng@canonical.com>
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

On Thu, 29 Aug 2019, Kai-Heng Feng wrote:

> Some Coffee Lake platforms have skewed HPET timer once the SoCs entered
> PC10, and marked TSC as unstable clocksource as result.

So here you talk about Coffee Lake and in the patch you use KABYLAKE. 

> Harry Pan identified it's a firmware bug [1].
> 
> To prevent creating a circular dependency between HPET and TSC, let's
> disable HPET on affected platforms.
> 
> [1]: https://lore.kernel.org/lkml/20190516090651.1396-1-harry.pan@intel.com/
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=203183

Please use Link:// for reference not [1] and not Bugzilla:

> +static const struct x86_cpu_id hpet_blacklist[] __initconst = {
> +	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_KABYLAKE_MOBILE },
> +	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_KABYLAKE_DESKTOP },

So this disables HPET on all Kaby Lake variants not just on the affected
Coffee Lakes. I know that I rejected the initial patch with the random
stepping cutoff...

  https://lore.kernel.org/lkml/alpine.DEB.2.21.1904081403220.1748@nanos.tec.linutronix.de

In the other attempt to 'fix' this I asked for clarification, but silence
from Intel after this:

  https://lore.kernel.org/lkml/alpine.DEB.2.21.1905182015320.3019@nanos.tec.linutronix.de

Can Intel please provide some useful information about this finally?

Thanks,

	tglx



