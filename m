Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4D6E8885C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2019 07:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbfHJFZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Aug 2019 01:25:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57966 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfHJFZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 01:25:24 -0400
Received: from p200300ddd71876457e7a91fffec98e25.dip0.t-ipconnect.de ([2003:dd:d718:7645:7e7a:91ff:fec9:8e25])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hwJsK-0001gl-Ea; Sat, 10 Aug 2019 07:25:08 +0200
Date:   Sat, 10 Aug 2019 07:25:02 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/umwait: Fix error handling in umwait_init()
In-Reply-To: <1565401237-60936-1-git-send-email-fenghua.yu@intel.com>
Message-ID: <alpine.DEB.2.21.1908100718580.21433@nanos.tec.linutronix.de>
References: <1565401237-60936-1-git-send-email-fenghua.yu@intel.com>
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

On Fri, 9 Aug 2019, Fenghua Yu wrote:
> +/*
> + * The CPU hotplug callback sets the control MSR to the original control
> + * value.
> + */
> +static int umwait_cpu_offline(unsigned int cpu)
> +{
> +	/*
> +	 * This code is protected by the CPU hotplug already and
> +	 * orig_umwait_control_cached is never changed after it caches
> +	 * the original control MSR value in umwait_init(). So there
> +	 * is no race condition here.
> +	 */
> +	wrmsr(MSR_IA32_UMWAIT_CONTROL, orig_umwait_control_cached, 0);

Even my brain compiler emits an error here.

Thanks,

	tglx
