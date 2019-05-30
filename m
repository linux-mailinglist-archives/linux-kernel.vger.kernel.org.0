Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2638B2FBC6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 14:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfE3MzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 08:55:16 -0400
Received: from ozlabs.org ([203.11.71.1]:54985 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbfE3MzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 08:55:14 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45F6xX0mZdz9s5c;
        Thu, 30 May 2019 22:55:12 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Bhupesh Sharma <bhsharma@redhat.com>, linuxppc-dev@lists.ozlabs.org
Cc:     arnd@arndb.de, bhsharma@redhat.com, bhupesh.linux@gmail.com,
        benh@kernel.crashing.org, paulus@samba.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation/stackprotector: powerpc supports stack protector
In-Reply-To: <1559212177-7072-1-git-send-email-bhsharma@redhat.com>
References: <1559212177-7072-1-git-send-email-bhsharma@redhat.com>
Date:   Thu, 30 May 2019 22:55:10 +1000
Message-ID: <87v9xsnlu9.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bhupesh Sharma <bhsharma@redhat.com> writes:
> powerpc architecture (both 64-bit and 32-bit) supports stack protector
> mechanism since some time now [see commit 06ec27aea9fc ("powerpc/64:
> add stack protector support")].
>
> Update stackprotector arch support documentation to reflect the same.
>
> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> ---
>  Documentation/features/debug/stackprotector/arch-support.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/features/debug/stackprotector/arch-support.txt b/Documentation/features/debug/stackprotector/arch-support.txt
> index 9999ea521f3e..32bbdfc64c32 100644
> --- a/Documentation/features/debug/stackprotector/arch-support.txt
> +++ b/Documentation/features/debug/stackprotector/arch-support.txt
> @@ -22,7 +22,7 @@
>      |       nios2: | TODO |
>      |    openrisc: | TODO |
>      |      parisc: | TODO |
> -    |     powerpc: | TODO |
> +    |     powerpc: |  ok  |
>      |       riscv: | TODO |
>      |        s390: | TODO |
>      |          sh: |  ok  |
> -- 
> 2.7.4

Thanks.

This should probably go via the documentation tree?

Acked-by: Michael Ellerman <mpe@ellerman.id.au>


cheers
