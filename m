Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE3CC17DE28
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 12:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgCILEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 07:04:21 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:42598 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgCILEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 07:04:21 -0400
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 029B3vSn024475
        for <linux-kernel@vger.kernel.org>; Mon, 9 Mar 2020 20:03:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 029B3vSn024475
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1583751838;
        bh=Ks9sp9EQLJDzVoH2+u0RaKh+p7zeLK6xGjpxTOBLSdI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nB873ZcqJZHAkM9YtGphB8pcyFAOJpy9/DiIkse/bG3D8+KIxKPVbv3hhtoEnilWy
         +gE7Bep1qfXKLjo6MktoRT40Rv71VcnTcaVitpczuEbyKyrQ/zSrECJgw7CPiahHxM
         Abzm8KAKhvqYCtU+DOwnd3kSp+B+v/b3HG00i+ptVKZrWrfr6ThuWPJCkiJr17VoZh
         kBUD3KrduGcbtEtIUJ/FYrXNx6MjVNO+gpnj1QNthskWroG9owcM8RXLGGxgJxHGAT
         VD5bZp/mbOT1LYD5qN/jQ4i4d93sSXf9kzWjRQ0TPljhMvGaNN8KOJ34zE3Mp6ytHa
         WbKYYEIpuaBsg==
X-Nifty-SrcIP: [209.85.221.173]
Received: by mail-vk1-f173.google.com with SMTP id t3so2370389vkm.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 04:03:58 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1dhLe4u2th5Tg1TskKLCi1/rGmuLTvKcI5b/PrdoslkSxdvba+
        jwhHGwNOoDXfuRdjrg23lOB0piPOXYHFEnL7bSU=
X-Google-Smtp-Source: ADFU+vtcxSNp40vLeWfo4k2CDeSW2GeUsdyGQ8UgVBa8T1sLPAyWt2w3e78iCMO/5kiro9asL78KKkjca64csWm740I=
X-Received: by 2002:a1f:2f4c:: with SMTP id v73mr8128304vkv.12.1583751836962;
 Mon, 09 Mar 2020 04:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200306160206.5609-1-jeyu@kernel.org> <CAK7LNARZ4VgaCa_TiDBG-99amBGTTXTQMs9LsK3nO4k+y-5KDQ@mail.gmail.com>
 <20200309095914.GA18870@linux-8ccs.fritz.box> <CAK7LNARf9CzZ8dcK5O5vxUoncpDdpzSZctd0YuKeWyfDG_cdwA@mail.gmail.com>
 <20200309103935.GB18870@linux-8ccs.fritz.box> <CAK7LNARpJ-FAvCUEH9rrNCiqx5LwRHmWospvRnT-ERQoEGjK-Q@mail.gmail.com>
 <20200309105812.GC18870@linux-8ccs.fritz.box>
In-Reply-To: <20200309105812.GC18870@linux-8ccs.fritz.box>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 9 Mar 2020 20:03:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQqMGSkX4Coe+f49SbXT_jkG_Mm4XZ3EJei0_K7SEaLhg@mail.gmail.com>
Message-ID: <CAK7LNAQqMGSkX4Coe+f49SbXT_jkG_Mm4XZ3EJei0_K7SEaLhg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] modpost: rework and consolidate logging interface
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Matthias Maennich <maennich@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 9, 2020 at 7:58 PM Jessica Yu <jeyu@kernel.org> wrote:
>
> +++ Masahiro Yamada [09/03/20 19:49 +0900]:
> >On Mon, Mar 9, 2020 at 7:39 PM Jessica Yu <jeyu@kernel.org> wrote:
> >>
> >> Ah, sorry, I mean the kbuild 0-day bot errors. I am just realizing
> >> the 0-day bot emails are not CC'd to lkml. Here is the error I got
> >> from the bot:
> >>
> >> ---
> >>
> >> I love your patch! Yet something to improve:
> >>
> >> [auto build test ERROR on linus/master]
> >> [also build test ERROR on v5.6-rc4 next-20200306]
> >> [if your patch is applied to the wrong git tree, please drop us a note to help
> >> improve the system. BTW, we also suggest to use '--base' option to specify the
> >> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> >>
> >> url:    https://github.com/0day-ci/linux/commits/Jessica-Yu/modpost-rework-and-consolidate-logging-interface/20200307-052346
> >> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 30fe0d07fd7b27d41d9b31a224052cc4e910947a
> >> config: sh-randconfig-a001-20200306 (attached as .config)
> >> compiler: sh4-linux-gcc (GCC) 7.5.0
> >> reproduce:
> >>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >>         chmod +x ~/bin/make.cross
> >>         # save the attached .config to linux build tree
> >>         GCC_VERSION=7.5.0 make.cross ARCH=sh
> >>
> >> If you fix the issue, kindly add following tag
> >> Reported-by: kbuild test robot <lkp@intel.com>
> >>
> >> All errors (new ones prefixed by >>):
> >>
> >> >> ERROR: modpost: "adc_single" [arch/sh/boards/mach-hp6xx/hp6xx_apm.ko] undefined!
> >
> >
> >Indeed, this one is odd.
> >I have no idea...
>
> I've pushed the patches to a branch to let the kbuild bot run through its
> build tests again, and if I have extra time today I will try to
> reproduce this and let you know the results.
>
> Thanks,
>
> Jessica


Ah, Now I see.


Because you added "modpost:" prefix.



The previous error message:

ERROR: "adc_single" [arch/sh/boards/mach-hp6xx/hp6xx_apm.ko] undefined!


The new error message:

ERROR: modpost: "adc_single" [arch/sh/boards/mach-hp6xx/hp6xx_apm.ko] undefined!



So, the bot assumed it was a new error.





-- 
Best Regards
Masahiro Yamada
