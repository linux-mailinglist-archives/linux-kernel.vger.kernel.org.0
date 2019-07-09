Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C96B63A32
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 19:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfGIRcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 13:32:43 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46121 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfGIRcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 13:32:42 -0400
Received: by mail-oi1-f196.google.com with SMTP id 65so15945826oid.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 10:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KzQBi+No8ph3UEJD2VAcK9TOC9/dG2woHn2ySVokkbA=;
        b=ETwRLHzWaCjexBzhMiLsQW5sSwoEpykycj/oT4Mm3+BM1ASKQYYp9nANFQkqIEo9VH
         fDTONrWhFj6eQq/YstmDB9znc9kMTXievTkLEmbVQlntYk7u3XniFCciHp17el38ptqW
         25B1nl6puEZ++ekvORfKaesjtzV/qytTztHR8ZJSV4pc8Cm1EXc6zeV1WyGwRInt/5cq
         8JvSqh2tLOnYlWU5GlJ4khR8pusZfQAYM2kvLpxqf6AhiMneDtfO3NxJwkvtkNzP8zhk
         fWqSI1zRZbkMxlL0Jfngnwz9XVqnajOomVwGhPQIXj0OJqCZ68P5diCOFJ3Oyd2ivn9X
         JUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KzQBi+No8ph3UEJD2VAcK9TOC9/dG2woHn2ySVokkbA=;
        b=ogUgd318bFOZ4+umYj6DlSCJd/yDil6hN87HrEkaxIk+5LRqD3gJIIEMF+xuz+9aGh
         9ynlHya6mv5YdhXgOEFB0Bfp17zLcxnIuq/MPTx1vFKstLjHCsXqsjguoGXJ8fOec9bc
         f2dZpX4Kvb62AkVtL2LaRyLEyA4FyDYk0mwTQU5SNtVK55LJgqe+bz0vEG8tQPM7WrQV
         IrEuaZY57rjN7476yc8JhUaJZKQ7DegNgoeUUYbcVFIDY9qOGZCJt0fPKfZ3be9WhTed
         DXhGuJzNc16siqcJhrbkExk6dfeuJsFqBMGqXx/mvJ4jRLEqeicpmjoH/yb8LWPHNJ5I
         iKfg==
X-Gm-Message-State: APjAAAWbFanBAicCBtusIr+pe0Sq+tJiVMP7ySJnPUDHMmHJskL7CFZr
        fOnm5Nv3wILpKc56V1uORRskAHTK79t5NANqUSg=
X-Google-Smtp-Source: APXvYqwA2y25ROEAfu3IQAf9dlBIx3F7JHdPH966F11KyaUMveWUzVZE3t4HxD5ee8XVUFBiT0C3hcmFwVf+LxNfuig=
X-Received: by 2002:a05:6808:6c5:: with SMTP id m5mr664260oih.89.1562693562016;
 Tue, 09 Jul 2019 10:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAHhAz+hVweYwjxFuwMw2Hsb74trWiwacH3Qdk=5c78e01==drw@mail.gmail.com>
 <CAHj3AV=v9ub2BYDZE_q3u9YEWbCLJaSNTVUC+z-nOVw-XQUziQ@mail.gmail.com>
In-Reply-To: <CAHj3AV=v9ub2BYDZE_q3u9YEWbCLJaSNTVUC+z-nOVw-XQUziQ@mail.gmail.com>
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Tue, 9 Jul 2019 23:02:30 +0530
Message-ID: <CAHhAz+gSnj8O+sM-939EqLvj_HL0BSQF4C452kn-GBxhyXODmw@mail.gmail.com>
Subject: Re: CONFIG_CC_STACKPROTECTOR_STRONG
To:     Denis Kirjanov <kirjanov@gmail.com>
Cc:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 9, 2019 at 10:56 PM Denis Kirjanov <kirjanov@gmail.com> wrote:
>
>
>
> On Tuesday, July 9, 2019, Muni Sekhar <munisekharrms@gmail.com> wrote:
>>
>> Hi All,
>>
>>
>> My Kernel is built with the following options:
>>
>>
>>
>> CONFIG_CC_STACKPROTECTOR=3Dy
>>
>> CONFIG_CC_STACKPROTECTOR_STRONG=3Dy
>>
>>
>>
>>
>>
>> We use out-of-tree kernel modules in our project and I need to measure t=
he performance of it by using a bit older gcc version 4.8.5.
>>
>>
>>
>> I can build the modules with gcc above 5 version, but when I try to use =
gcc version 4.8.5 I=E2=80=99m getting the following error:
>>
>>
>>
>> Makefile:693: Cannot use CONFIG_CC_STACKPROTECTOR_STRONG: -fstack-protec=
tor-strong not supported by compiler
>>
>>
>>
>> So it looks like gcc 4.8.5 does not support CONFIG_CC_STACKPROTECTOR_STR=
ONG option, but how to instruct gcc to ignore this one?
>>
>>
>>
>> In runtime, is it possible to instruct kernel to ignore =E2=80=9CCONFIG_=
CC_STACKPROTECTOR_STRONG=3Dy=E2=80=9D (without building the kernel) by usin=
g sysctl or any other method?
>>
>>
>
>
> Just disable it in your .config file

I disabled in /lib/modules/$(uname -r)/build/.config, but still get
that error. Does kernel needs to be recompiled?

CONFIG_CC_STACKPROTECTOR=3Dy
# CONFIG_CC_STACKPROTECTOR_NONE is not set
# CONFIG_CC_STACKPROTECTOR_REGULAR is not set
# CONFIG_CC_STACKPROTECTOR_STRONG is not set

>
>
>>
>> Any help is appreciated.
>>
>>
>>
>> --
>> Thanks,
>> Sekhar
>
>
>
> --
> Regards / Mit besten Gr=C3=BC=C3=9Fen,
> Denis
>


--=20
Thanks,
Sekhar
