Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92FEB9A100
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 22:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393013AbfHVUTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 16:19:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35632 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391015AbfHVUTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 16:19:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BB6BB10576D9;
        Thu, 22 Aug 2019 20:19:06 +0000 (UTC)
Received: from treble (ovpn-121-55.rdu2.redhat.com [10.10.121.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C40425D713;
        Thu, 22 Aug 2019 20:19:05 +0000 (UTC)
Date:   Thu, 22 Aug 2019 15:19:03 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Raphael Gault <raphael.gault@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
        julien.thierry.kdev@gmail.com, raph.gault+kdev@gmail.com
Subject: Re: [RFC v4 16/18] arm64: crypto: Add exceptions for crypto object
 to prevent stack analysis
Message-ID: <20190822201903.srbxynoabrarnlyw@treble>
References: <20190816122403.14994-1-raphael.gault@arm.com>
 <20190816122403.14994-17-raphael.gault@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190816122403.14994-17-raphael.gault@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Thu, 22 Aug 2019 20:19:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 01:24:01PM +0100, Raphael Gault wrote:
> Some crypto modules contain `.word` of data in the .text section.
> Since objtool can't make the distinction between data and incorrect
> instruction, it gives a warning about the instruction beeing unknown
> and stops the analysis of the object file.
> 
> The exception can be removed if the data are moved to another section
> or if objtool is tweaked to handle this particular case.
> 
> Signed-off-by: Raphael Gault <raphael.gault@arm.com>

If the data can be moved to .rodata then I think that would be a much
better solution.

> ---
>  arch/arm64/crypto/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/crypto/Makefile b/arch/arm64/crypto/Makefile
> index 0435f2a0610e..e2a25919ebaa 100644
> --- a/arch/arm64/crypto/Makefile
> +++ b/arch/arm64/crypto/Makefile
> @@ -43,9 +43,11 @@ aes-neon-blk-y := aes-glue-neon.o aes-neon.o
>  
>  obj-$(CONFIG_CRYPTO_SHA256_ARM64) += sha256-arm64.o
>  sha256-arm64-y := sha256-glue.o sha256-core.o
> +OBJECT_FILES_NON_STANDARD_sha256-core.o := y
>  
>  obj-$(CONFIG_CRYPTO_SHA512_ARM64) += sha512-arm64.o
>  sha512-arm64-y := sha512-glue.o sha512-core.o
> +OBJECT_FILES_NON_STANDARD_sha512-core.o := y
>  
>  obj-$(CONFIG_CRYPTO_CHACHA20_NEON) += chacha-neon.o
>  chacha-neon-y := chacha-neon-core.o chacha-neon-glue.o
> @@ -58,6 +60,7 @@ aes-arm64-y := aes-cipher-core.o aes-cipher-glue.o
>  
>  obj-$(CONFIG_CRYPTO_AES_ARM64_BS) += aes-neon-bs.o
>  aes-neon-bs-y := aes-neonbs-core.o aes-neonbs-glue.o
> +OBJECT_FILES_NON_STANDARD_aes-neonbs-core.o := y
>  
>  CFLAGS_aes-glue-ce.o	:= -DUSE_V8_CRYPTO_EXTENSIONS
>  
> -- 
> 2.17.1
> 

-- 
Josh
