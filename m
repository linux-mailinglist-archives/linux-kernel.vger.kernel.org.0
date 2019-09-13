Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B46DB2108
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2019 15:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391732AbfIMNbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 09:31:37 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42726 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391723AbfIMNbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:31:31 -0400
Received: by mail-pf1-f195.google.com with SMTP id w22so18092030pfi.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 06:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version:content-transfer-encoding;
        bh=9ddMFiJu/sWzXjkexotIn9umjnAL30uzzTUAh4FEKTA=;
        b=LWRfw0GlPqtpTJMS8Lh6Tuv8esJSSzpd8D1rEOlAg3Bp085NgI1H/9zflEueRBXSuh
         NMaP+hDWL6zan6LOFFZljAeNOH9tFgC2x2/OpZciITy6ZRwgpAxIdC2uPzk0PydrnoKP
         m8tQ/OHGNKeJPSwUDMA8dQ4eqNPKSJBNqIGtvUYtcouOjTwFYdnRVCCHW0QeA3i+7HWP
         fzUCaXstUbBPtHUww/+vGG7bRbLAUHSiZvTGQhRB720lnW1DrZMDzE7QIO1qKGzcVfTi
         AnziJ3LVkMpclxhOv6qH76MhvuOa3aVcUXRFZyU3bf7iRvW7hgbWT7Paq6b7PR2E2Erf
         cU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=9ddMFiJu/sWzXjkexotIn9umjnAL30uzzTUAh4FEKTA=;
        b=QOA8SE+t9lYK9/0zSKpYzUyDtafnpeQfxtyWZTz9WhEgW18lCGvQp/QvI/6/xpbt7c
         2zL7xZOBkEM+UZFNdu0BJzZCP7vFbviTtfA+eWnoD2JFAC2rKQQQCrpJnjgkSxqVarCp
         s1S5UlohdjRHGFrEIKZOWDYEpAUahIuCUDh6e7lJFfLd4c0jnIt0U7JDuvsSEj3c31B1
         UdFC7yk0xF0bW9AtRz5nF1iFbngDZ2T+kZNaQS3Dab9rNpRCJG9P6io26p5wHPCO/k08
         faSnH4xj+BHG47rxLLeeG4xF++zFhoR6J0SP7OGXXrlVBGidtmdGzWDPBTqTpimtQJJl
         0Gqw==
X-Gm-Message-State: APjAAAVx7s5palESp7haFUWX5oV9wyb6AqrT5r5+Xa6tZmqN1e3Yd5q4
        oiRY4bFX7zgYbYuBeeobz58eFA==
X-Google-Smtp-Source: APXvYqweIKhJb64CFwQ0oERfJ9vPY2uyZJ1J4wrn4HgzGDyKTvZYRQWNVsqferrXgB82OV4RKcLYsA==
X-Received: by 2002:a63:6947:: with SMTP id e68mr43615810pgc.60.1568381491040;
        Fri, 13 Sep 2019 06:31:31 -0700 (PDT)
Received: from localhost ([49.207.57.15])
        by smtp.gmail.com with ESMTPSA id 127sm56901669pfw.6.2019.09.13.06.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 06:31:30 -0700 (PDT)
From:   Santosh Sivaraj <santosh@fossix.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/8] powerpc/vdso32: inline __get_datapage()
In-Reply-To: <a95c4a58-bc59-3e75-46db-414f6d0f1412@c-s.fr>
References: <cover.1566491310.git.christophe.leroy@c-s.fr> <194fb7bc973ef2ce43016c97dd32f2b2dcbae4e7.1566491310.git.christophe.leroy@c-s.fr> <87h864iiq9.fsf@santosiv.in.ibm.com> <a95c4a58-bc59-3e75-46db-414f6d0f1412@c-s.fr>
Date:   Fri, 13 Sep 2019 19:01:28 +0530
Message-ID: <87blvonwzz.fsf@santosiv.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Hi Santosh,
>
> Le 26/08/2019 =C3=A0 07:44, Santosh Sivaraj a =C3=A9crit=C2=A0:
>> Hi Christophe,
>>=20
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>=20
>>> __get_datapage() is only a few instructions to retrieve the
>>> address of the page where the kernel stores data to the VDSO.
>>>
>>> By inlining this function into its users, a bl/blr pair and
>>> a mflr/mtlr pair is avoided, plus a few reg moves.
>>>
>>> The improvement is noticeable (about 55 nsec/call on an 8xx)
>>>
>>> vdsotest before the patch:
>>> gettimeofday:    vdso: 731 nsec/call
>>> clock-gettime-realtime-coarse:    vdso: 668 nsec/call
>>> clock-gettime-monotonic-coarse:    vdso: 745 nsec/call
>>>
>>> vdsotest after the patch:
>>> gettimeofday:    vdso: 677 nsec/call
>>> clock-gettime-realtime-coarse:    vdso: 613 nsec/call
>>> clock-gettime-monotonic-coarse:    vdso: 690 nsec/call
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>> ---
>>>   arch/powerpc/kernel/vdso32/cacheflush.S   | 10 +++++-----
>>>   arch/powerpc/kernel/vdso32/datapage.S     | 29 ++++------------------=
-------
>>>   arch/powerpc/kernel/vdso32/datapage.h     | 11 +++++++++++
>>>   arch/powerpc/kernel/vdso32/gettimeofday.S | 13 ++++++-------
>>>   4 files changed, 26 insertions(+), 37 deletions(-)
>>>   create mode 100644 arch/powerpc/kernel/vdso32/datapage.h
>>=20
>> The datapage.h file should ideally be moved under include/asm, then we c=
an use
>> the same for powerpc64 too.
>
> I have a more ambitious project indeed.
>
> Most of the VDSO code is duplicated between vdso32 and vdso64. I'm=20
> aiming at merging everything into a single source code.
>
> This means we would have to generate vdso32.so and vdso64.so out of the=20
> same source files. Any idea on how to do that ? I'm not too good at=20
> creating Makefiles. I guess we would have everything in=20
> arch/powerpc/kernel/vdso/ and would have to build the objects twice,=20
> once in arch/powerpc/kernel/vdso32/ and once in arch/powerpc/kernel/vdso6=
4/

Should we need to build the objects twice? For 64 bit config it is going to=
 be
a 64 bit build else a 32 bit build. It should suffice to get the single sou=
rce
code compile for both, maybe with macros or (!)CONFIG_PPC64 conditional
compilation. Am I missing something when you say build twice?

Thanks,
Santosh
