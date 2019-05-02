Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 446411248A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 00:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfEBWXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 18:23:25 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:37886 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfEBWXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 18:23:24 -0400
Received: by mail-it1-f195.google.com with SMTP id r85so6222665itc.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 15:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dSYZjz9ox8eSyXuEGjTFmNM2Zdzvymu+MNwGE2bPO90=;
        b=Sl5pHk5tbJUzK6yJj6IZ+5l6aziIB/LfUHsEAgmm+v67cmLZGve1Lh86XMKvhTB1+Z
         mhwLuNTlSA38rp1oUUzFlGq02ZZBPGFvZAYUUyR+KV98wIW/zDeKEhsJ/ldcJAsJ7D14
         aiLcuV2fMAzbV2fIiVIx57Obqj09vweAHTXhLe+hABCLk2rpRYUSdNbKge9h57x9+ycO
         i5Mj3dYjkPb7QFsUVsaCAKw0NjWuImwFHO77iL4JHQq1XVUHS/1FXwZ3EKdmrRqUV9ji
         S33L7V7YVNpqP0CAyxKUYg4BaUNkMvleF75Aqh20f5OxVx/qANYM8diFD/5Rx8TblHR2
         WiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dSYZjz9ox8eSyXuEGjTFmNM2Zdzvymu+MNwGE2bPO90=;
        b=Odas1fBXiIIW7R6RdzLYAKrPGwTtzt/T4EMScDI+ovPUlQyEXYoaZlHJkgsh5sgnz7
         zA/XEV0aLR28NTOw51gi/5Gmi1bk7jSLUIjQVShjCNykZViQ+jxRsmmyUy8NluiG/Ycz
         sjJxRd21NmAiK7TTz87AvJX71th3Bpj1n3VScmJJ6WYvVdoM2X24r7zlcUQPDqJuGQyY
         xV69axh/DjXBOwu5hapZ0jPS62OJXGMnUhIHyhjWG5iTN6kTq5EIDKMdTMkeT/JlGLSg
         06gCMSn7wE6zbN941R/y72YNVryx85BkkdjgpkcpWObO72yDfwjtmth1uq1yvYciKngi
         +Q0Q==
X-Gm-Message-State: APjAAAUmYptaRQeY8ONdg7r0lXzCF8tNEx4/rUQkCvhHUrGoqrI4Z1I8
        BCQPbviJE7KhrkKj/4gDK6aWOP/yIxsm+2aeRtQ=
X-Google-Smtp-Source: APXvYqxrnNbkPTtTubu0LAUgy8IjIDffIx6LnSR7Tc7h+95hxWWpEoQ5CTK1uBh89eV3NeguSVeEAoGae+fSmxuUGRo=
X-Received: by 2002:a24:4290:: with SMTP id i138mr4291887itb.129.1556835803976;
 Thu, 02 May 2019 15:23:23 -0700 (PDT)
MIME-Version: 1.0
References: <1556830342-32307-1-git-send-email-jsavitz@redhat.com> <1556830342-32307-3-git-send-email-jsavitz@redhat.com>
In-Reply-To: <1556830342-32307-3-git-send-email-jsavitz@redhat.com>
From:   Yury Norov <norov.maillist@gmail.com>
Date:   Thu, 2 May 2019 15:23:12 -0700
Message-ID: <CAJu-Uz5xVQGVirjJXpC4Nyg8HZ=pUXEq7rN1kZz2Zg3hnUf=AQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] prctl.2: Document the new PR_GET_TASK_SIZE option
To:     Joel Savitz <jsavitz@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Micah Morton <mortonm@chromium.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Jann Horn <jannh@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Rafael Aquini <aquini@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>, yury.norov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D1=87=D1=82, 2 =D0=BC=D0=B0=D1=8F 2019 =D0=B3. =D0=B2 13:52, Joel Savitz <=
jsavitz@redhat.com>:
>
> Add a short explanation of the new PR_GET_TASK_SIZE option for the benefi=
t
> of future generations.
>
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> ---
>  man2/prctl.2 | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/man2/prctl.2 b/man2/prctl.2
> index 06d8e13c7..35a6a3919 100644
> --- a/man2/prctl.2
> +++ b/man2/prctl.2
> @@ -49,6 +49,7 @@
>  .\" 2013-01-10 Kees Cook, document PR_SET_PTRACER
>  .\" 2012-02-04 Michael Kerrisk, document PR_{SET,GET}_CHILD_SUBREAPER
>  .\" 2014-11-10 Dave Hansen, document PR_MPX_{EN,DIS}ABLE_MANAGEMENT
> +.\" 2019-05-02 Joel Savitz, document PR_GET_TASK_SIZE
>  .\"
>  .\"
>  .TH PRCTL 2 2019-03-06 "Linux" "Linux Programmer's Manual"
> @@ -1375,6 +1376,14 @@ system call on Tru64).
>  for information on versions and architectures)
>  Return unaligned access control bits, in the location pointed to by
>  .IR "(unsigned int\ *) arg2" .
> +.TP
> +.B PR_GET_TASK_SIZE
> +Copy the value of TASK_SIZE to the userspace address in
> +.IR "(unsigned long\ *) arg2" .

This is a bad idea to use pointers to size-undefined types in interface bec=
ause
that way you have to introduce compat versions of interface functions.
I'd recommend you to use u64 or unsigned long long here.

The comment not clear for reader not familiar with kernel internals.
Can you rephrase
TASK_SIZE like 'the (next after) highest possible userspace address',
or similar?

For the updated version could you please CC to yury.norov@gmail.com?

> +Return
> +.B EFAULT
> +if this operation fails.
> +
>  .SH RETURN VALUE
>  On success,
>  .BR PR_GET_DUMPABLE ,
> --
> 2.18.1
>
