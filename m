Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A092B3A55
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 14:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732543AbfIPM3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 08:29:49 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59295 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732452AbfIPM3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 08:29:48 -0400
X-Greylist: delayed 309 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Sep 2019 08:29:47 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568636987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xuFZUsJJRGLuvev598sKrB52HnexJgaP+W91bQH5myw=;
        b=JQ9QXNTxTP7ss/agk+X/Ztcm3NCq7fd54eIldJV0Zem8CNQS0EEDr50qUubcy8qElmKcfH
        h5svejFxeEiYXX+lDspz4ym8093Y0BFqNgFEN2+cWV3rAZHtoR5G/Cg0TyiyFgM0G9olFO
        CrkW6uUyipEfl3EkiVkj/JtTJ6fowqU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-IKeH67IrPcSQHE4C7cC94g-1; Mon, 16 Sep 2019 08:23:32 -0400
Received: by mail-qk1-f200.google.com with SMTP id n135so41766540qke.23
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 05:23:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aFQYEXYlxKj3Sm3zW29/VoCLHuhuxmTHLOejlFqsxPw=;
        b=UoLC3SvmLych4f8OxjvMItvXX88T65phYLknXYk3MheyS2RpXLtGU7GZEjGAiW7Dhj
         wIOSu+cjxHP5Rs4TimvJtoVe7sLO9Yx/9nSAJAOXc58N9ajbGH2dwVFQAhR5/ytUAYkr
         /oxEnf8SnwStun8kq+geq1Hvr0NeVMyg6Zz2kf697E5Go+SkjY+gCK4xVTEHMb0AeEeY
         GfC0h/qVyUpGpB2PD5ipS9TMpeddzrl6g1ANLDaxEh//XddouHId+RYCnkxF8syKIo9m
         YEGRbJ/HLgbaGxaAqV+QOLBTWPh/krPww1aT5YBmnwS6LYGTyys5afPHMY96puiWhvyr
         0DyQ==
X-Gm-Message-State: APjAAAX4kXUyy8j8mxUtJAzWMmZajhtADJBFfJw8Ltw94PbV6OBnh2YJ
        UBM37osAZ3X0zQ8niQqX/geVDVBjqCoR1OVImUZqarO1aRxllsSmnH1mEoTJua4zIzuz5+A0k8l
        Ci1u4zbGVo2k/Mn/yGd/aVVGJ
X-Received: by 2002:a37:bcc6:: with SMTP id m189mr48798058qkf.436.1568636611756;
        Mon, 16 Sep 2019 05:23:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxDIGS3OQUOohOp1Ug/qVyEA/U4iNc6+2vozZatrm/x1j+LyqlIhVdzXycKw8RYr2Oc+YqI6g==
X-Received: by 2002:a37:bcc6:: with SMTP id m189mr48798037qkf.436.1568636611494;
        Mon, 16 Sep 2019 05:23:31 -0700 (PDT)
Received: from [192.168.1.157] (pool-96-235-39-235.pitbpa.fios.verizon.net. [96.235.39.235])
        by smtp.gmail.com with ESMTPSA id z5sm21437547qtb.49.2019.09.16.05.23.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2019 05:23:30 -0700 (PDT)
Subject: Re: [PATCH] arm64: use generic free_initrd_mem()
To:     Mike Rapoport <rppt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mike Rapoport <rppt@linux.ibm.com>
References: <1568618488-19055-1-git-send-email-rppt@kernel.org>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <0ba20aa4-d2dd-2263-6b5f-16a5c8a39f67@redhat.com>
Date:   Mon, 16 Sep 2019 08:23:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568618488-19055-1-git-send-email-rppt@kernel.org>
Content-Language: en-US
X-MC-Unique: IKeH67IrPcSQHE4C7cC94g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/19 8:21 AM, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
>=20
> arm64 calls memblock_free() for the initrd area in its implementation of
> free_initrd_mem(), but this call has no actual effect that late in the bo=
ot
> process. By the time initrd is freed, all the reserved memory is managed =
by
> the page allocator and the memblock.reserved is unused, so there is no
> point to update it.
>=20

People like to use memblock for keeping track of memory even if it has no
actual effect. We made this change explicitly (see 05c58752f9dc ("arm64: To=
 remove
initrd reserved area entry from memblock") That said, moving to the generic
APIs would be nice. Maybe we can find another place to update the accountin=
g?

> Without the memblock_free() call the only difference between arm64 and th=
e
> generic versions of free_initrd_mem() is the memory poisoning. Switching
> arm64 to the generic version will enable the poisoning.
>=20
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>=20
> I've boot tested it on qemu and I've checked that kexec works.
>=20
>   arch/arm64/mm/init.c | 8 --------
>   1 file changed, 8 deletions(-)
>=20
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index f3c7952..8ad2934 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -567,14 +567,6 @@ void free_initmem(void)
>   =09unmap_kernel_range((u64)__init_begin, (u64)(__init_end - __init_begi=
n));
>   }
>  =20
> -#ifdef CONFIG_BLK_DEV_INITRD
> -void __init free_initrd_mem(unsigned long start, unsigned long end)
> -{
> -=09free_reserved_area((void *)start, (void *)end, 0, "initrd");
> -=09memblock_free(__virt_to_phys(start), end - start);
> -}
> -#endif
> -
>   /*
>    * Dump out memory limit information on panic.
>    */
>=20

