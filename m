Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF0A18E223
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Mar 2020 15:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgCUOqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Mar 2020 10:46:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38824 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgCUOqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 10:46:36 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jFfOQ-0004Ys-C2; Sat, 21 Mar 2020 15:46:30 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id A798FFFC8D; Sat, 21 Mar 2020 15:46:29 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andi Kleen <andi@firstfloor.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH] x86/speculation: Allow overriding seccomp speculation disable
In-Reply-To: <20200312231222.81861-1-andi@firstfloor.org>
References: <20200312231222.81861-1-andi@firstfloor.org>
Date:   Sat, 21 Mar 2020 15:46:29 +0100
Message-ID: <87sgi1rcje.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <andi@firstfloor.org> writes:

Cc+: Seccomp maintainers ....

> From: Andi Kleen <ak@linux.intel.com>
>
> seccomp currently force enables the SSBD and IB mitigations,
> which disable certain features in the CPU to avoid speculation
> attacks at a performance penalty.
>
> This is a heuristic to detect applications that may run untrusted code
> (such as web browsers) and provide mitigation for them.
>
> At least for SSBD the mitigation is really only for side channel
> leaks inside processes.
>
> There are two cases when the heuristic has problems:
>
> - The seccomp user has a superior mitigation and doesn't need the
> CPU level disables. For example for a Web Browser this is using
> site isolation, which separates different sites in different
> processes, so side channel leaks inside a process are not
> of a concern.
>
> - Another case are seccomp users who don't run untrusted code,
> such as sshd, and don't really benefit from SSBD
>
> As currently implemented seccomp force enables the mitigation
> so it's not possible for processes to opt-in that they don't
> need mitigations (such as when they already use site isolation).
>
> In some cases we're seeing significant performance penalties
> of enabling the SSBD mitigation on web workloads.
>
> This patch changes the seccomp code to not force enable,

I'm sure I asked you to do

git grep "This patch" Documentation/process/

before.

> but merely enable, the SSBD and IB mitigations.
>
> This allows processes to use the PR_SET_SPECULATION prctl
> after running seccomp and reenable SSBD and/or IB
> if they don't need any extra mitigation.
>
> The effective default has not changed, it just allows
> processes to opt-out of the default.
>
> It's not clear to me what the use case for the force
> disable is anyways. Certainly if someone controls the process,
> and can run prctl(), they can leak data in all kinds of
> ways anyways, or just read the whole memory map.
>
> Longer term we probably need to discuss if the seccomp heuristic
> is still warranted and should be perhaps changed. It seemed
> like a good idea when these vulnerabilities were new, and
> no web browsers supported site isolation. But with site isolation
> widely deployed -- Chrome has it on by default, and as I understand
> it, Firefox is going to enable it by default soon. And other seccomp
> users (like sshd or systemd) probably don't really need it.
> Given that it's not clear the default heuristic is still a good
> idea.
>
> But anyways this patch doesn't change any defaults, just
> let's applications override it.

It changes the enforcement and I really want the seccomp people to have
a say here.

Thanks,

        tglx

> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  arch/x86/kernel/cpu/bugs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index ed54b3b21c39..f15ae9bfd7ad 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -1215,9 +1215,9 @@ int arch_prctl_spec_ctrl_set(struct task_struct *task, unsigned long which,
>  void arch_seccomp_spec_mitigate(struct task_struct *task)
>  {
>  	if (ssb_mode == SPEC_STORE_BYPASS_SECCOMP)
> -		ssb_prctl_set(task, PR_SPEC_FORCE_DISABLE);
> +		ssb_prctl_set(task, PR_SPEC_DISABLE);
>  	if (spectre_v2_user == SPECTRE_V2_USER_SECCOMP)
> -		ib_prctl_set(task, PR_SPEC_FORCE_DISABLE);
> +		ib_prctl_set(task, PR_SPEC_DISABLE);
>  }
>  #endif
>  
> -- 
> 2.24.1
