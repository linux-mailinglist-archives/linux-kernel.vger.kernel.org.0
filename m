Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD2A52863B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 21:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387412AbfEWTC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 15:02:26 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:43272 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731261AbfEWTCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:02:25 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4E4A9C00F4;
        Thu, 23 May 2019 19:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1558638131; bh=aKeSNI4AwBP/qqtb9+WBKmlunFYD/hQqcP82Q/VliaM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=lA3BAAs4XQuj5hqQhgS87YGJ2iuq5HJDqSkG/4nC8sFKiGnzv81syMKMJ/Cjqkjp2
         JxPzOz1qbcMgW5c6XmQZdVP6hQ8bHilCz3zm9dGlynGevJhxL7ySlcNfy58hVZkiku
         WbTHarXafurdinua7qo6bi+8q27eGUf2/iI/K/1RWWuGq6FrjMuK0zsy6BN9hzhA5t
         VLsDPpoec7pUIXEe8QCgTE92mLpjgmiVSbERc/cwxXfLtvM9Zq9xQcZc6TgjkAcFKs
         KGHbY3vwkfcyiTGK54mcV0oFm8yj59bR07H7BNZvQQO50cqnsgsGzuY758/baJb9QU
         wMOqsh2WODRCQ==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 244A7A0097;
        Thu, 23 May 2019 19:02:24 +0000 (UTC)
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.104) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 23 May 2019 12:02:10 -0700
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.105) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.103) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 24 May 2019 00:32:19 +0530
Received: from [10.10.161.89] (10.10.161.89) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 24 May 2019 00:32:06 +0530
Subject: Re: [PATCH] ARC: Don't set CROSS_COMPILE in arch's Makefile
To:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        <linux-snps-arc@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh@kernel.org>
Newsgroups: gmane.linux.kernel,gmane.linux.kernel.arc
References: <20180916204757.31131-1-abrodkin@synopsys.com>
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
Openpgp: preference=signencrypt
Autocrypt: addr=vgupta@synopsys.com; keydata=
 mQINBFEffBMBEADIXSn0fEQcM8GPYFZyvBrY8456hGplRnLLFimPi/BBGFA24IR+B/Vh/EFk
 B5LAyKuPEEbR3WSVB1x7TovwEErPWKmhHFbyugdCKDv7qWVj7pOB+vqycTG3i16eixB69row
 lDkZ2RQyy1i/wOtHt8Kr69V9aMOIVIlBNjx5vNOjxfOLux3C0SRl1veA8sdkoSACY3McOqJ8
 zR8q1mZDRHCfz+aNxgmVIVFN2JY29zBNOeCzNL1b6ndjU73whH/1hd9YMx2Sp149T8MBpkuQ
 cFYUPYm8Mn0dQ5PHAide+D3iKCHMupX0ux1Y6g7Ym9jhVtxq3OdUI5I5vsED7NgV9c8++baM
 7j7ext5v0l8UeulHfj4LglTaJIvwbUrCGgtyS9haKlUHbmey/af1j0sTrGxZs1ky1cTX7yeF
 nSYs12GRiVZkh/Pf3nRLkjV+kH++ZtR1GZLqwamiYZhAHjo1Vzyl50JT9EuX07/XTyq/Bx6E
 dcJWr79ZphJ+mR2HrMdvZo3VSpXEgjROpYlD4GKUApFxW6RrZkvMzuR2bqi48FThXKhFXJBd
 JiTfiO8tpXaHg/yh/V9vNQqdu7KmZIuZ0EdeZHoXe+8lxoNyQPcPSj7LcmE6gONJR8ZqAzyk
 F5voeRIy005ZmJJ3VOH3Gw6Gz49LVy7Kz72yo1IPHZJNpSV5xwARAQABtCpWaW5lZXQgR3Vw
 dGEgKGFsaWFzKSA8dmd1cHRhQHN5bm9wc3lzLmNvbT6JAj4EEwECACgCGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheABQJbBYpwBQkLx0HcAAoJEGnX8d3iisJeChAQAMR2UVbJyydOv3aV
 jmqP47gVFq4Qml1weP5z6czl1I8n37bIhdW0/lV2Zll+yU1YGpMgdDTHiDqnGWi4pJeu4+c5
 xsI/VqkH6WWXpfruhDsbJ3IJQ46//jb79ogjm6VVeGlOOYxx/G/RUUXZ12+CMPQo7Bv+Jb+t
 NJnYXYMND2Dlr2TiRahFeeQo8uFbeEdJGDsSIbkOV0jzrYUAPeBwdN8N0eOB19KUgPqPAC4W
 HCg2LJ/o6/BImN7bhEFDFu7gTT0nqFVZNXlOw4UcGGpM3dq/qu8ZgRE0turY9SsjKsJYKvg4
 djAaOh7H9NJK72JOjUhXY/sMBwW5vnNwFyXCB5t4ZcNxStoxrMtyf35synJVinFy6wCzH3eJ
 XYNfFsv4gjF3l9VYmGEJeI8JG/ljYQVjsQxcrU1lf8lfARuNkleUL8Y3rtxn6eZVtAlJE8q2
 hBgu/RUj79BKnWEPFmxfKsaj8of+5wubTkP0I5tXh0akKZlVwQ3lbDdHxznejcVCwyjXBSny
 d0+qKIXX1eMh0/5sDYM06/B34rQyq9HZVVPRHdvsfwCU0s3G+5Fai02mK68okr8TECOzqZtG
 cuQmkAeegdY70Bpzfbwxo45WWQq8dSRURA7KDeY5LutMphQPIP2syqgIaiEatHgwetyVCOt6
 tf3ClCidHNaGky9KcNSQ
Message-ID: <efe9e312-565f-ba47-135c-ad7108b1170c@synopsys.com>
Date:   Thu, 23 May 2019 12:02:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20180916204757.31131-1-abrodkin@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.10.161.89]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/18 1:47 PM, Alexey Brodkin wrote:
> There's not much sense in doing that because if user or
> his build-system didn't set CROSS_COMPILE we still may
> very well make incorrect guess.
> 
> But as it turned out setting CROSS_COMPILE is not as harmless
> as one may think: with recent changes that implemented automatic
> discovery of __host__ gcc features unconditional setup of
> CROSS_COMPILE leads to failures on execution of "make xxx_defconfig"
> with absent cross-compiler, for more info see [1].
> 
> Set CROSS_COMPILE as well gets in the way if we want only to build
> .dtb's (again with absent cross-compiler which is not really needed
> for building .dtb's), see [2].

@Alexey, can we revisit this (revert back partially). I'm getting sick of having
to specify the CROSS_COMPILE in my cmdline.

Will something along the lines fc2b47b55f17fd996f7a019 ("h8300: use
cc-cross-prefix instead of hardcoding h8300-unknown-linux-") work ?

---->
+ifeq ($(CROSS_COMPILE),)
+CROSS_COMPILE := $(call cc-cross-prefix, arc-linux-)
+endif



> 
> Note, we had to change LIBGCC assignment type from ":=" to "="
> so that is is resolved on its usage, otherwise if it is resolved
> at declaration time with missing CROSS_COMPILE we're getting this
> error message from host GCC:
> ------------------------->8-------------------------
> gcc: error: unrecognized command line option ‘-mmedium-calls’
> gcc: error: unrecognized command line option ‘-mno-sdata’; did you mean ‘-fno-stats’?
> ------------------------->8-------------------------
> 
> [1] http://lists.infradead.org/pipermail/linux-snps-arc/2018-September/004308.html
> [2] http://lists.infradead.org/pipermail/linux-snps-arc/2018-September/004320.html
> 
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Rob Herring <robh@kernel.org>
> ---
>  arch/arc/Makefile | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/arch/arc/Makefile b/arch/arc/Makefile
> index 99cce77ab98f..5f6b67917dc2 100644
> --- a/arch/arc/Makefile
> +++ b/arch/arc/Makefile
> @@ -6,14 +6,6 @@
>  # published by the Free Software Foundation.
>  #
>  
> -ifeq ($(CROSS_COMPILE),)
> -ifndef CONFIG_CPU_BIG_ENDIAN
> -CROSS_COMPILE := arc-linux-
> -else
> -CROSS_COMPILE := arceb-linux-
> -endif
> -endif
> -
>  KBUILD_DEFCONFIG := nsim_700_defconfig
>  
>  cflags-y	+= -fno-common -pipe -fno-builtin -mmedium-calls -D__linux__
> @@ -79,7 +71,7 @@ cflags-$(disable_small_data)		+= -mno-sdata -fcall-used-gp
>  cflags-$(CONFIG_CPU_BIG_ENDIAN)		+= -mbig-endian
>  ldflags-$(CONFIG_CPU_BIG_ENDIAN)	+= -EB
>  
> -LIBGCC	:= $(shell $(CC) $(cflags-y) --print-libgcc-file-name)
> +LIBGCC	= $(shell $(CC) $(cflags-y) --print-libgcc-file-name)
>  
>  # Modules with short calls might break for calls into builtin-kernel
>  KBUILD_CFLAGS_MODULE	+= -mlong-calls -mno-millicode
> 

