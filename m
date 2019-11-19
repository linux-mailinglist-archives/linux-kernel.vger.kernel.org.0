Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98EC3102F73
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 23:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfKSWms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 17:42:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54854 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfKSWms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 17:42:48 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iXCCf-0004lM-NB; Tue, 19 Nov 2019 23:42:33 +0100
Date:   Tue, 19 Nov 2019 23:42:32 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qais Yousef <qais.yousef@arm.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Nicholas Piggin <npiggin@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Eiichi Tsukata <devel@etsukata.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Nadav Amit <namit@vmware.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] smp: Create a new function to bringup nonboot cpus
 online
In-Reply-To: <20191030153837.18107-12-qais.yousef@arm.com>
Message-ID: <alpine.DEB.2.21.1911192337430.6731@nanos.tec.linutronix.de>
References: <20191030153837.18107-1-qais.yousef@arm.com> <20191030153837.18107-12-qais.yousef@arm.com>
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

On Wed, 30 Oct 2019, Qais Yousef wrote:
> +void smp_bringup_nonboot_cpus(unsigned int setup_max_cpus)
> +{
> +	unsigned int cpu;
> +
> +	/* FIXME: This should be done in userspace --RR */

This fixme is stale and should just go away.

> +	for_each_present_cpu(cpu) {
> +		if (num_online_cpus() >= setup_max_cpus)
> +			break;
> +		if (!cpu_online(cpu))
> +			cpu_up(cpu);
> +	}
> +}

Thanks,

	tglx
