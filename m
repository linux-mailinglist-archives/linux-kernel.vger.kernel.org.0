Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 166456B063
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 22:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388728AbfGPUYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 16:24:39 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37653 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbfGPUYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 16:24:39 -0400
Received: by mail-pl1-f196.google.com with SMTP id b3so10695900plr.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 13:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tlgW7N5665To10UWUQBwQlj7I4LdVat1k1AQkv0K9Pc=;
        b=AwPuELhuts8lP4/v2w2PqvbmYvehX0wshVXA+4yqs560dvwt/VcjmUPDsGW9NmUrp3
         Ixiiht508/rfZ52L3VVuAygzyGtjIICJLDo/q9EGqY5+9HtHqZK8FQchWZ0AdUauZxv2
         SMtL9Erzsb1IXVbnepno+4OdCZ9pwZ4uBfZfq1C6PuMUPOYD/FbFhc/AujXk9HZf672E
         /vSWTLZUYPDq6jU7hGhgQDAIP8Aa2ptYeYU0T+XGHP9D10XbbGaol/wyeyMFrsq7aLg4
         Sy2GQuXB6ZtcMXypQxGvFWFdiy5nBMoIrWyHy5z6WGyvAaD0czSqe2MKz7PtjhOCxzZs
         Trog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tlgW7N5665To10UWUQBwQlj7I4LdVat1k1AQkv0K9Pc=;
        b=r0z2f/BXnKLxi/T+Svrp7H3LlxP9FTPJ/iqp7GxT0WWxkB3GrBfCp2Hh1RSmUFbJFS
         bzbqTiULwpTOq/6ZzvGpTJM4UxZlI31TrzHBavarb7BLxjX7KjL7eOe5ljGU6qT4Vei9
         CnScpqU/xrAMwnfeDEs1Pg9bdfkfvqSteTZ1xae/6hSNEuzFLmZ3tMe7nogA9p+7LbnR
         +Ij0oSOPAV2oF9v221EVdPIWF7K7TMtOVODbfpqoLVZbFeOUePTwx+dpK5KQrr1vDJU5
         hXBky8DTPamCwfr65T39lswT/gBMFa4QqgSDa2a8gTDiwrxpHOk9P554zU0mw3dELLbI
         EYgw==
X-Gm-Message-State: APjAAAUircrZKZwrpgxm2BhryKS0GqvxAGHQmgrIqueQcaQlxAWpWroY
        ucfRVKajUDZM4bnxbFma9elsyBxCOUrQV3dMIx9wHg==
X-Google-Smtp-Source: APXvYqxRj/dcOXQ6bzNuxwwngYnNOIRCEWeTsQRemz7Vzu/PiFlwYrBKgqFvsM1vmPNOacFsGJ62gbjVvb1C0oLgRFU=
X-Received: by 2002:a17:902:4aa3:: with SMTP id x32mr36572379pld.119.1563308678079;
 Tue, 16 Jul 2019 13:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2beBPP+KX4zTfSfFPwo+7ksWZLqZzpP9BJ80iPecg3zA@mail.gmail.com>
 <20190711172621.a7ab7jorolicid3z@treble> <CAK8P3a0iOMpMW-dXUY6g75HGC4mUe3P3=gv447WZOW8jmw2Vgg@mail.gmail.com>
 <CAG48ez3ipuPHLxbqqc50=Kn4QuoNczkd7VqEoLPVd3WWLk2s+Q@mail.gmail.com>
 <CAK8P3a2=SJQp7Jvyf+BX-7XsUr8bh6eBMo6ue2m8FW4aYf=PPw@mail.gmail.com>
 <CAK8P3a1_8kjzamn6_joBbZTO8NeGn0E3O+MZ+bcOQ0HkkRHXRQ@mail.gmail.com>
 <20190712135755.7qa4wxw3bfmwn5rp@treble> <CAK8P3a13QFN59o9xOMce6K64jGnz+Cf=o3R_ORMo7j-65F5i8A@mail.gmail.com>
 <20190712142928.gmt6gibikdjmkppm@treble> <CAKwvOdnOpgo9rEctZZR9Y9rEc60FCthbPtp62UsdMtkGDF5nUg@mail.gmail.com>
 <CAK8P3a0AGpvAOzSfER7iiaz=aLVMbxiVorTsh__yT4xxBOHSyw@mail.gmail.com>
In-Reply-To: <CAK8P3a0AGpvAOzSfER7iiaz=aLVMbxiVorTsh__yT4xxBOHSyw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 16 Jul 2019 13:24:26 -0700
Message-ID: <CAKwvOd=o16rtGOVm9DWhhqxed0OEW5NKt4Vt3y_6KCcbdU-dhQ@mail.gmail.com>
Subject: Re: objtool crashes on clang output (drivers/hwmon/pmbus/adm1275.o)
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 1:41 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Jul 12, 2019 at 6:59 PM 'Nick Desaulniers' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
> > > The issue still needs to get fixed in clang regardless.  There are other
> > > noreturn functions in the kernel and this problem could easily pop back
> > > up.
> >
> > Sure, thanks for the report.  Arnd, can you help us get a more minimal
> > test case to understand the issue better?
>
> I reduced it to this testcase:
>
> int a, b;
> void __reiserfs_panic(int, ...) __attribute__((noreturn));
> void balance_internal() {
>   if (a)
>     __reiserfs_panic(0, "", __func__, "", 2, __func__, a);
>   if (b)
>     __reiserfs_panic(0, "", __func__, "", 5, __func__, a, 0);
> }
>
> https://godbolt.org/z/Byfvmx

Is this the same issue as Josh pointed out?  IIUC, Josh pointed to a
jump destination that was past a `push %rbp`, and I don't see it in
your link.  (Or, did I miss it?)
-- 
Thanks,
~Nick Desaulniers
