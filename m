Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF64D88B97
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2019 15:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfHJNhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Aug 2019 09:37:32 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35107 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfHJNhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 09:37:32 -0400
Received: by mail-lj1-f194.google.com with SMTP id l14so4633282lje.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2019 06:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XG8kvdJDi0ZVSDdV/5KfoB396VunAojnxIDpewRoEwE=;
        b=qSCsgRhquk5E4HGWnPrA+xbrAQU1hqhyV6ncrfrSuLcuQMIfp7GTm++sMkQxgfzFg0
         Xl7Fl3A+6UlbGXUMwexlYl5jqqCu7m0ehewDfDbXWrVyeEBISZi7YyiwzNGtMx9gCW17
         UlLZAe+jp2F4jqfh2tdQilL+i4ProbnHq/ccN8t0JQMETRQn/2+JxIiNXjrp6v4PG/qI
         pf6t5vBQbKIEGD2IXAJuDSFFdl0iueWw13C1bHWwzEPDzoCjL2UhXXOBdYn6/k3IWVc1
         TqEKJlrXU5PXzp5NC6n+nS0j6c7VEhMY/B/UwopdvANejPqMBG4ycTxYUhi5yAGWBEY/
         nkRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XG8kvdJDi0ZVSDdV/5KfoB396VunAojnxIDpewRoEwE=;
        b=Z3LPn09YSNuz+zNLTXSc5q4Naa9MvGdY6xmpdNw6+/frcZIzuZ136xcK10whMcFn1D
         MOaqv5hfoD9SqVviVOrDqJLOokbPsbg2i9Ry1WhXRD8O99fH76G2KH6xx44T+x/CEJFr
         5Mj2eH1vxo39SmPc2c+zimHXZAHjYXQs1kugtxk2bTOcREiwaULfwqDifP0//Jhb8e/M
         YWdJt4OXtbMPb6wX6Lx9DBNf2pt+MPYxhQQePIgdPnXYU8/Tp24NTZnXtsAjtf1XfORc
         x8AmP0rfygod1lhlQqeZH0EGNUPJ7+WakAEyqM4GXbS9R7rxar43/49SDad3Y47Xkhi8
         DH7w==
X-Gm-Message-State: APjAAAWVZHbHIgjMONv1Zq5s216gdcwY/L/WeJI4XVmRl20FQFEdTo0W
        VVOyJWPA9umzFXXXGh3T4qWnVhYe58GvyWxnBj0=
X-Google-Smtp-Source: APXvYqwMVOB9Q0AwO1G3o3WcjKsYtyiKbZ6jZjccrvIyucrnMtImx92YMEJhwWWhEJls4JfPQhenNVOXrIxEWzESDfQ=
X-Received: by 2002:a05:651c:d1:: with SMTP id 17mr14473577ljr.174.1565444250383;
 Sat, 10 Aug 2019 06:37:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdmNdvgv=+P1CU36fG+trETojmPEXSMmAmX2TY0e67X-Wg@mail.gmail.com>
In-Reply-To: <CAKwvOdmNdvgv=+P1CU36fG+trETojmPEXSMmAmX2TY0e67X-Wg@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 10 Aug 2019 15:37:18 +0200
Message-ID: <CANiq72mP9NbMXZrDcKMhWsC_rUnbjBYRLC-BpqA5st44FRSpUw@mail.gmail.com>
Subject: Re: checkpatch.pl should suggest __section
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Joe Perches <joe@perches.com>, LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2019 at 12:21 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Hi Joe,
> While debugging:
> https://github.com/ClangBuiltLinux/linux/issues/619
> we found a bunch of places where __section is not used but could be,
> and uses a string literal when it probably should not be.
>
> Just a thought that maybe checkpatch.pl could warn if
> `__attribute__((section` appeared in the added diff, and suggest
> __section? Then further warn to not use `""` for the section name?

+1 There are a few other attributes that should be renamed, too. It
has been on my TODO list for a while, but I decided to go first to add
support for the missing ones that we do not have (e.g. __nonnull), so
that at some point we could achieve a __attribute__-clean kernel.

But in the mean time, adding this to checkpatch.pl (and other
attributes if not there yet) is a great idea!

Cheers,
Miguel
