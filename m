Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5C614AE70
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 04:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgA1DgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 22:36:23 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:58105 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgA1DgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 22:36:23 -0500
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 00S3a8iG024614
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 12:36:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 00S3a8iG024614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1580182569;
        bh=eC+RalRcYJOsb2glSpPrfoEwl78XbNMsbjScipj7Ivs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0LolEl4WWFYBzSGOLD27bxv78O4VaTwyzi4qqtQnyGmXKjjjzrTJ6+k1ZHO9CbH0Q
         dshQf3cw99U8eM0ZxNg1rQbTMSHHFgngER3YtMekPV1yj12dcNh1g3JY9n5F5As3Pg
         IOWhv8qhsw5gwvo2jFQ9y2ddY97NF01QTKfj9kao58zMsXc41FqxvROAFgl5FLLEqS
         4K06rni3rb7eANDFw7MSPEex34KRtW1gyaEsErDyhGbjjO7KXnOdUjU2lyuAWYKJl2
         SpnW78dkNPv66fzgx2Y0/jVxW7jOft2q8C8u2N4zjUBv1cLFMBtnct3UajpLUHBTg0
         86Txb9RXJdv4Q==
X-Nifty-SrcIP: [209.85.217.49]
Received: by mail-vs1-f49.google.com with SMTP id g23so7197165vsr.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 19:36:09 -0800 (PST)
X-Gm-Message-State: APjAAAVnTAzUgLLkyDoZdXVabV8ZveHr23V+w7uALqMfxwoTjrhHLWe8
        WXeOpcqq9R+PnHOmHa3iV9oGy3oL1gjEZWYuBKk=
X-Google-Smtp-Source: APXvYqyAmQuDKndIZ5O164SwuQ0FHDoq9mMWznY4cOKE3fDbg9yvMKvw6iDO5FYSb+bxzFstWXCWbj43Mn0I1XwPM0g=
X-Received: by 2002:a67:6485:: with SMTP id y127mr6276228vsb.54.1580182568057;
 Mon, 27 Jan 2020 19:36:08 -0800 (PST)
MIME-Version: 1.0
References: <1580161806-8037-1-git-send-email-gvrose8192@gmail.com>
In-Reply-To: <1580161806-8037-1-git-send-email-gvrose8192@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 28 Jan 2020 12:35:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQyh9CFgKd1DtAPFW8DuHNp1gn8YABuP8-LsF=hHK2DFw@mail.gmail.com>
Message-ID: <CAK7LNAQyh9CFgKd1DtAPFW8DuHNp1gn8YABuP8-LsF=hHK2DFw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Include external modules compile flags
To:     Greg Rose <gvrose8192@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dev@openvswitch.org, dsahern@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 6:50 AM Greg Rose <gvrose8192@gmail.com> wrote:
>
> Since this commit:
> 'commit 9b9a3f20cbe0 ("kbuild: split final module linking out into Makefile.modfinal")'
> at least one out-of-tree external kernel module build fails
> during the modfinal make phase because Makefile.modfinal does
> not include the ccflags-y variable from the exernal module's Kbuild.

ccflags-y is passed only for compiling C files in that directory.

It is not used for compiling *.mod.c
This is true for both in-kernel and external modules.

So, ccflags-y is not a good choice
for passing such flags that should be globally effective.


Maybe, KCFLAGS should work.


module:
       $(MAKE) KCFLAGS=...  M=$(PWD) -C /lib/modules/$(uname -r)/build modules



> Make sure to include the external kernel module's Kbuild so that the
> necessary command line flags from the external module are set.
>
> Reported-by: David Ahern <dsahern@gmail.com>
> CC: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Greg Rose <gvrose8192@gmail.com>
> ---
>  scripts/Makefile.modfinal | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> index 411c1e60..a645ba6 100644
> --- a/scripts/Makefile.modfinal
> +++ b/scripts/Makefile.modfinal
> @@ -21,6 +21,10 @@ __modfinal: $(modules)
>  modname = $(notdir $(@:.mod.o=))
>  part-of-module = y
>
> +# Include the module's Makefile to find KBUILD_EXTRA_SYMBOLS
> +include $(if $(wildcard $(KBUILD_EXTMOD)/Kbuild), \
> +             $(KBUILD_EXTMOD)/Kbuild)
> +
>  quiet_cmd_cc_o_c = CC [M]  $@
>        cmd_cc_o_c = $(CC) $(c_flags) -c -o $@ $<
>
> --
> 1.8.3.1
>


-- 
Best Regards
Masahiro Yamada
