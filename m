Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 614381097D1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 03:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfKZC2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 21:28:19 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:54947 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbfKZC2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 21:28:19 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47MSW10MKdz9sPT;
        Tue, 26 Nov 2019 13:28:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1574735296;
        bh=bDpBpExv22RYZg9+7U2ew6DFKYXTfeM4Kl6AcYjAgzY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=FgztwZwNJDiZ7EM+Yr9+ALlLY8vEMT2mnd8WXWdEpCdnNkQw4xADD7XKzgrAvyTT6
         Cv8gvnycwfKKIrTHQap0Kk81nvKOZy4ya9O9B5p54sNMtFw6gB+KXD740JrhoRBVBb
         6596F6YHpp7MSRpyBiawhr2fkyofqG43h728IvxqU1zbTSj1FMKsCNqxnKsOUNtlmQ
         SnW8YYx/zorrarGVZl5iN4E3DNR8RtnqVkgL+HMW28EN0QoLZqjzZNbtfHCdxoh2d2
         emHH3FOjfo12nuIt9IUJuHvMDOUxHV3MfmfnjhuDRR71JXglFzeMO+YefJWdIkS+rF
         sfXYWJPnubq8Q==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Gustavo Walbon <gwalbon@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     benh@kernel.crashing.org, paulus@samba.org, diana.craciun@nxp.com,
        gwalbon@linux.ibm.com, jkosina@suse.cz, jpoimboe@redhat.com,
        geert+renesas@glider.be, cmr@informatik.wtf, yuehaibing@huawei.com,
        linux-kernel@vger.kernel.org, maurosr@linux.ibm.com
Subject: Re: [PATCH][v2] powerpc: Set right value of Speculation_Store_Bypass in /proc/<pid>/status
In-Reply-To: <20191123230235.11888-1-gwalbon@linux.ibm.com>
References: <20191123230235.11888-1-gwalbon@linux.ibm.com>
Date:   Tue, 26 Nov 2019 13:28:10 +1100
Message-ID: <87v9r79xs5.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gustavo Walbon <gwalbon@linux.ibm.com> writes:
> The issue has showed the value of status of Speculation_Store_Bypass in the
> /proc/<pid>/status as `unknown` for PowerPC systems.
>
> The patch fix the checking of the mitigation status of Speculation, and
> can be reported as "not vulnerable", "globally mitigated" or "vulnerable".
>
> Link: https://github.com/linuxppc/issues/issues/255
>
> Changelog:
> Rebase on v5.4-rc8
>
> Signed-off-by: Gustavo Walbon <gwalbon@linux.ibm.com>
> ---
>  arch/powerpc/kernel/security.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)

On further thoughts I don't think this logic (which I suggested) is
right >:(

I commented on the issue:

  I think my original suggestion on this was wrong.
  
  Our mitigation is not global, ie. it's a barrier that must be used in
  the right location. We have kernel code to insert the barrier on
  kernel entry/exit, but that doesn't protect userspace against itself
  (ie. sandboxes).
  
  There's no way to express that with the current values as far as I can
  see.
  
  I think all we can do for now is:
  
  if stf_enabled_flush_types == STF_BARRIER_NONE:
    return PR_SPEC_NOT_AFFECTED // "not vulnerable"
  else
    return PR_SPEC_ENABLE // "vulnerable"
  
  To express the situation properly we'd need another value, something
  like PR_SPEC_MITIGATION_AVAILABLE (??) which says that there is a
  mitigation available but it must be used. That still has the problem
  that it doesn't tell userspace what the mitigation is, userspace would
  have to know.

cheers

> diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
> index 7d4b2080a658..04e566026bbc 100644
> --- a/arch/powerpc/kernel/security.c
> +++ b/arch/powerpc/kernel/security.c
> @@ -14,7 +14,7 @@
>  #include <asm/debugfs.h>
>  #include <asm/security_features.h>
>  #include <asm/setup.h>
> -
> +#include <linux/prctl.h>
>  
>  u64 powerpc_security_features __read_mostly = SEC_FTR_DEFAULT;
>  
> @@ -344,6 +344,29 @@ ssize_t cpu_show_spec_store_bypass(struct device *dev, struct device_attribute *
>  	return sprintf(buf, "Vulnerable\n");
>  }
>  
> +static int ssb_prctl_get(struct task_struct *task)
> +{
> +	if (stf_barrier) {
> +		if (stf_enabled_flush_types == STF_BARRIER_NONE)
> +			return PR_SPEC_NOT_AFFECTED;
> +		else
> +			return PR_SPEC_DISABLE;
> +	} else
> +		return PR_SPEC_DISABLE_NOEXEC;
> +
> +	return -EINVAL;
> +}
> +
> +int arch_prctl_spec_ctrl_get(struct task_struct *task, unsigned long which)
> +{
> +	switch (which) {
> +	case PR_SPEC_STORE_BYPASS:
> +		return ssb_prctl_get(task);
> +	default:
> +		return -ENODEV;
> +	}
> +}
> +
>  #ifdef CONFIG_DEBUG_FS
>  static int stf_barrier_set(void *data, u64 val)
>  {
> -- 
> 2.19.1
