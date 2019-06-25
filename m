Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43C1052176
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 06:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfFYEDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 00:03:17 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36875 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfFYEDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 00:03:17 -0400
Received: by mail-qk1-f194.google.com with SMTP id d15so11509127qkl.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 21:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FJ6vOhR8gsLZwxlKYHLPUZqtUgr4v4H6itA1sGGZ9Tk=;
        b=jdc1fzKwSnLWCxjoK/F97iKoVCwjrKexFSC5W4HkRjgPKaJ9dZBAeQ3tmG+z5EKoDs
         Yf7/WkSSy8D6GBT2FmwhplNm3hw3wyF8WXw04XghQDosOssxWf3eT5SnJlZZSUndDteR
         KT32Ui2g3sSzbzw7/XjMv45VaJ4jCjG1vMdv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FJ6vOhR8gsLZwxlKYHLPUZqtUgr4v4H6itA1sGGZ9Tk=;
        b=bn/xwrf4IydIvOW9POWOddw1R2BjOCimZUzJvYEZvzmU4u+NwzCbRJ7wnYfK5+1UKO
         nh9AANOTC2CO8OdxyrFww2A80ZPdGDFbCDPqDra0CNo9MYxWqGRnVL8h/HPGE4+EERFA
         DIzTV2aRGhpHuI9ziGVNoqwWxloYH8FRHfqlbd+vKnznzkCs4pqd3+jPLuqugl5Q5sKI
         T39DzH9/ecluSU1JWSgsgHoj87jXPAIjI/VIRikkpmyXnIjTMTF8RhWK7dipDHwjtNAp
         X9r7fPp1hPW/PhOEsXYroCHDw5Wgt16bO/+l0lJyqJGbV2UY0pa7JkFR1rUbCVnMR8ER
         Tj2w==
X-Gm-Message-State: APjAAAUM9Zzq0IRzAjs/cP2kDFD8glvgE1L96uNIisj0y/lgwj7tkGY2
        Co6G5Lq2N1KAIhO8miWz15BqHftbc6RTIhj3Kk4=
X-Google-Smtp-Source: APXvYqxZ6TRjZOlnmmH4bytr5/Tsq+O8wjOxumYNuuPJB734x6CCDZZty41MDJXzu2ORfw+MdY3DpoywinR2CxHcGyg=
X-Received: by 2002:a37:a1d6:: with SMTP id k205mr105761153qke.171.1561435395958;
 Mon, 24 Jun 2019 21:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190621071342.17897-1-malat@debian.org> <20190621195555.20615-1-malat@debian.org>
In-Reply-To: <20190621195555.20615-1-malat@debian.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 25 Jun 2019 04:03:04 +0000
Message-ID: <CACPK8XdM7eub41ig2MBxX7BJpAsVbuL4HO9VM_5bR5BuXEX89A@mail.gmail.com>
Subject: Re: [PATCH v2] lib/mpi: fix build with clang
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jun 2019 at 19:56, Mathieu Malaterre <malat@debian.org> wrote:
>
> Remove superfluous casts on output operands to avoid warnings on the
> following macros:
>
> * add_ssaaaa(sh, sl, ah, al, bh, bl)
> * sub_ddmmss(sh, sl, ah, al, bh, bl)
> * umul_ppmm(ph, pl, m0, m1)
>
> Special care has been taken to keep the diff as minimal as possible from
> the original header file `longlong.h` from gcc, only importing the
> minimal change to make the compilation with clang pass.


> Suggested-by: Joel Stanley <joel@jms.id.au>
> Cc: Segher Boessenkool <segher@kernel.crashing.org>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
> v2: Instead of passing compat flag to clang to behave as gcc, remove the superfluous cast

Thanks, I checked your patch against GCC's longlong.h and it looks good.

Reviewed-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel
