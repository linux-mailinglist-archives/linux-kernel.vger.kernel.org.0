Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37A2B58EF0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 02:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfF1AUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 20:20:35 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:53248 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfF1AUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 20:20:35 -0400
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x5S0KWp8006247
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 09:20:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x5S0KWp8006247
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1561681233;
        bh=FfFvbLeTvHF4J2LwiruUFDOUX+CzWNP8nToG0NC0n/A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fgy+EAjpY0arvlJS2FI4jL9MR2RyQ6vOAS0MAwmcJ9/x2WM+eiEycLIFdQurV/PZL
         ivE93M+9Qg3/7rwdHjDLM5ajljGKfK0Cf+U3/yhCS/uIsrM2maE3wHBsTJqjvYLFqs
         Yvw+tFOIOHQ2WlrE/iiQLJJ2LsDDgBvpRMZkJWVMQ8zRVNeiCgHxkljSCxnWXJGIJD
         AAau0ClHb3nAdiWbQCfzKwK4FdcxtfOsYveKEjdtEt8SdR7lbdT7BB7aGKw05KLTNL
         0obYY8xvmm4uXuTNBBqAJqnAdK8BbXATTl7YXetiIgqmhphiIed7Ru/r2BYeHq7Z1J
         3ZrBW417evXrw==
X-Nifty-SrcIP: [209.85.222.41]
Received: by mail-ua1-f41.google.com with SMTP id j21so1564735uap.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 17:20:32 -0700 (PDT)
X-Gm-Message-State: APjAAAVDT/Bv5Uv/BA9ugHB855GGT0hATv0v0271kP0QByKldjEatu/Y
        IeEFZ5/so+Gjoc5cgEzx+/3UFNUCRvbHmArRjEk=
X-Google-Smtp-Source: APXvYqwR/HSlTCsKLQPImh1GC7qYXUhUeq6IgNn8w7Lz+hVttmjew/lR9DdypS3GQAWDJD/nZ1m95iPbw+2kZwMZ1hY=
X-Received: by 2002:ab0:5ea6:: with SMTP id y38mr4493495uag.40.1561681231765;
 Thu, 27 Jun 2019 17:20:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190627212447.217059-1-ndesaulniers@google.com>
In-Reply-To: <20190627212447.217059-1-ndesaulniers@google.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 28 Jun 2019 09:19:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNASV6LxTsTnAdJbqxYecrj-TEZ5+j7bVvDPRkFDjjykXzQ@mail.gmail.com>
Message-ID: <CAK7LNASV6LxTsTnAdJbqxYecrj-TEZ5+j7bVvDPRkFDjjykXzQ@mail.gmail.com>
Subject: Re: [PATCH] .gitignore: ignore *.rej files
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Rob Herring <robh@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 6:25 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Such as those produced by the `patch` utility. We already ignore *.orig
> files, and there are currently no *.rej files in the tree at this time.
>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---


This reverts 1f5d3a6b6532e25a5cdf1f311956b2b03d343a48
so needs enough reason to do so.





-- 
Best Regards
Masahiro Yamada
