Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 821DACB342
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 04:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731656AbfJDCVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Oct 2019 22:21:38 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:34329 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731547AbfJDCVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 22:21:38 -0400
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x942LF7H020759;
        Fri, 4 Oct 2019 11:21:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x942LF7H020759
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1570155676;
        bh=yQV8E+kYwQMqXpPK+bnNslq9E1FcMlOvqPOfvzXa82A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rzFof5MN93kg6B9qyakuN+x8ondTZdGexUwDVqE8V7LBMlb2+vF1MbnJD/p2N3hqP
         LaUZ5tlB1xX0HWD8N++M0eyCLVnEX4xvUhmSvtLil+HKfeOGmiL94W5mmfyRGsCO+c
         E/iKLLO0m4SA19LgGbYf04X3Ardwp7eJe5iecnhkkDqiTN3SWT9zggyLHw2LmaHL/1
         /K/uutfXMLM/kR0BESbIrWrmTJnRbjEULZVVx9aSs5ILirWs71XkEW6sX0OufbZI5u
         jyWAruRqi09kD2MVdBwmLh4uCBtCRJ0CUWjn+EDGa1dSrVGgvQa7asiM3+hZAnj+jG
         BCSGjyFuSXkiw==
X-Nifty-SrcIP: [209.85.217.51]
Received: by mail-vs1-f51.google.com with SMTP id p13so3136277vsr.4;
        Thu, 03 Oct 2019 19:21:16 -0700 (PDT)
X-Gm-Message-State: APjAAAWTEJ8k+Wn/nx57H+MrfcAueHa4+sAW302zLcCzILsDU4c/fdkE
        jAgpVjvT5Gi3smPXkeBiMd2MKzf1gFPM4EIJKws=
X-Google-Smtp-Source: APXvYqwfAPtBQ7UpkFqr3WbJqWqYxUja7ofO70RoTDKEQ6FFsmYA7fc6EDiVC3CKneNFLGfDT/wakBUsCJnqJjMrEfo=
X-Received: by 2002:a67:ec09:: with SMTP id d9mr6793354vso.215.1570155675023;
 Thu, 03 Oct 2019 19:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190728164643.16335-1-yamada.masahiro@socionext.com>
 <CAK7LNATbahbn4W_71F8dZynXNb7Kbr5ZHb7mTV2_4oZok5AK=w@mail.gmail.com> <yq18sq1s22t.fsf@oracle.com>
In-Reply-To: <yq18sq1s22t.fsf@oracle.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 4 Oct 2019 11:20:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ2gkWNgLfsdkFzo1_ySq=0JN616vfLpvBc38kezCz+YQ@mail.gmail.com>
Message-ID: <CAK7LNAQ2gkWNgLfsdkFzo1_ySq=0JN616vfLpvBc38kezCz+YQ@mail.gmail.com>
Subject: Re: [PATCH] scsi: ch: add include guard to chio.h
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Fri, Oct 4, 2019 at 10:59 AM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Masahiro,
>
> >> Add a header include guard just in case.
>
> Fine with me. Is it going through your tree or should I pick it up?



Could you please apply it to your tree?

Thanks.

-- 
Best Regards
Masahiro Yamada
