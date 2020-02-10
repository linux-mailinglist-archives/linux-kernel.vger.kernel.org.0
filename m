Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8D8C15732C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 12:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgBJLBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 06:01:44 -0500
Received: from ozlabs.org ([203.11.71.1]:45029 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbgBJLBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 06:01:44 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48GNJP0Cxwz9sP7;
        Mon, 10 Feb 2020 22:01:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1581332501;
        bh=PJQpp+82DbTtRtYpFA6iKQwKJ/YFQPhWyqk91A7RpFM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=I+3CIT97uU9eN2rACI2HGPBGIt5YdJcCu3JmWSUcLrqAke3ZaBnFwzXcF4moZBOtD
         3l33M5rqyE+U3GWzC69car4xZrQiExj+M+CbM3XsuykI/jifpdxSSaKNFYnIP7Kj6G
         FpoZl9RXUaM140vnDOHX+TmUzKL4SvkRLOGY2hueQATjBsm6WhFvr1wEiAVP529+OH
         O78MF45p885mczAWziqTzyJ7jdy5Q246/dfdf7cQISMO+n20pHgXySs7LDduzbliHf
         clCngKK97t9Woye+hhuWf4htUQeB5I1nWisLTOKXzhVaffPHjzIDiE9MJ9hz3Ll+xY
         b2jOw5KNOzDpA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Fangrui Song <maskray@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Fangrui Song <maskray@google.com>
Subject: Re: [PATCH] powerpc/vdso32: mark __kernel_datapage_offset as STV_PROTECTED
In-Reply-To: <20200205005054.k72fuikf6rwrgfe4@google.com>
References: <20200205005054.k72fuikf6rwrgfe4@google.com>
Date:   Mon, 10 Feb 2020 22:01:37 +1100
Message-ID: <87pnemzoxa.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fangrui Song <maskray@google.com> writes:
> A PC-relative relocation (R_PPC_REL16_LO in this case) referencing a
> preemptible symbol in a -shared link is not allowed.  GNU ld's powerpc
> port is permissive and allows it [1], but lld will report an error after
> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?id=ec0895f08f99515194e9fcfe1338becf6f759d38
>
> Make the symbol protected so that it is non-preemptible but still
> exported.

"preemptible" means something different to me, and I assume we're not
using it to mean the same thing.

Can you explain it using small words that a kernel developer can
understand? :)

cheers

> [1]: https://sourceware.org/bugzilla/show_bug.cgi?id=25500
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/851
> Signed-off-by: Fangrui Song <maskray@google.com>

> ---
>  arch/powerpc/kernel/vdso32/datapage.S | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/vdso32/datapage.S b/arch/powerpc/kernel/vdso32/datapage.S
> index 217bb630f8f9..2831a8676365 100644
> --- a/arch/powerpc/kernel/vdso32/datapage.S
> +++ b/arch/powerpc/kernel/vdso32/datapage.S
> @@ -13,7 +13,8 @@
>  #include <asm/vdso_datapage.h>
>  
>  	.text
> -	.global	__kernel_datapage_offset;
> +	.global	__kernel_datapage_offset
> +	.protected	__kernel_datapage_offset
>  __kernel_datapage_offset:
>  	.long	0
>  
> -- 
> 2.25.0.341.g760bfbb309-goog
