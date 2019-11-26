Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01C8C10A584
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 21:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfKZUep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 15:34:45 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:45661 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfKZUep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 15:34:45 -0500
Received: by mail-io1-f66.google.com with SMTP id i11so11263782ioi.12;
        Tue, 26 Nov 2019 12:34:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eCiyINJIqZQ9+c/j9O3wV96E5XzkXxVGgIEzTJ6ccpU=;
        b=b9k89bAnLmb1qagKi1LUJu3LiGsnN1FMJYFfbWEm0B1GYoV/i4kYtOy1SjGBVDhJDo
         BMZyY+htPtUlrDiqHFLpyKPtIXFcQYnSM26NHGpR+/QGmvrdgIN4rUVk1EkzJNCjvMM0
         d186H016RdIo217/Bd3hDYz4jNiyPwvtKtwHrP0B2lxJkC8quUwPg7qK71o9MRmaUV7k
         D0yah3csd0n3emtYCzVopi8Yuj13CNWwBbRmXHB0Me8zR7cYsPNzFtaaUvZJpl2dVVmA
         f6csBLZzRewE3An2VS/xmWydcu0P6Iden6k6ZZ8pOyrVojbd2cp00SGOWg2Qi7zW3AlV
         GPNA==
X-Gm-Message-State: APjAAAXfT5DKO9PIWLIpDl1FIc2YIKt4DWj09knbdKC8NOVMCrR6ON6r
        CLVowSLYrDdeI9gIVNhrRw==
X-Google-Smtp-Source: APXvYqyNLRbXmRMw2om5THIIvUDL/2IP2aEwIaLwJGNOkUm6TYCHlgggxCi3KYF+cIwCDLGz2FM3sA==
X-Received: by 2002:a6b:f317:: with SMTP id m23mr17361728ioh.303.1574800484514;
        Tue, 26 Nov 2019 12:34:44 -0800 (PST)
Received: from localhost ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id k22sm2923474iot.34.2019.11.26.12.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 12:34:43 -0800 (PST)
Date:   Tue, 26 Nov 2019 13:34:42 -0700
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] libfdt: define INT32_MAX and UINT32_MAX in
 libfdt_env.h
Message-ID: <20191126203442.GA20537@bogus>
References: <20191113071202.11287-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113071202.11287-1-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 04:12:02PM +0900, Masahiro Yamada wrote:
> The DTC v1.5.1 added references to (U)INT32_MAX.
> 
> This is no problem for user-space programs since <stdint.h> defines
> (U)INT32_MAX along with (u)int32_t.
> 
> For the kernel space, libfdt_env.h needs to be adjusted before we
> pull in the changes.
> 
> In the kernel, we usually use s/u32 instead of (u)int32_t for the
> fixed-width types.
> 
> Accordingly, we already have S/U32_MAX for their max values.
> So, we should not add (U)INT32_MAX to <linux/limits.h> any more.
> 
> Instead, add them to the in-kernel libfdt_env.h to compile the
> latest libfdt.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> My initial plan was to change this in a series of 3 patches
> since it is clean, and reduces the code.
> 
> [1/3] https://lore.kernel.org/patchwork/patch/1147095/
> [2/3] https://lore.kernel.org/patchwork/patch/1147096/
> [3/3] https://lore.kernel.org/patchwork/patch/1147097/
> 
> 1/3 is stuck in the license bikeshed.
> 
> For 2/3, I have not been able to get Ack from Russell.
> 
> So, I chose a straight-forward fixup.
> 
> 
> Changes in v3:
>  - Resend as a single patch
> 
>  arch/arm/boot/compressed/libfdt_env.h | 4 +++-
>  arch/powerpc/boot/libfdt_env.h        | 2 ++
>  include/linux/libfdt_env.h            | 3 +++
>  3 files changed, 8 insertions(+), 1 deletion(-)

Applied.

Rob
