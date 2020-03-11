Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F97E180D09
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 01:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgCKA5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 20:57:23 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:57631 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbgCKA5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 20:57:23 -0400
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 02B0vDQv024703
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 09:57:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 02B0vDQv024703
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1583888234;
        bh=c3VjNILS40ihr8Lf3GHv5Wx2ttfcUbnKDvYe0s6Bf+Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X8Zmo+1ykBKnqZG/3nAb/Ka6h3qOH2C5kfgkTKPdcLXuOyKaiXELWBfHw7zUKYSUq
         bdl1dkxcATmLFxtblcYyfONZJPqEGWlXgKigL1dgxM5Yl3BQ4OE5RadL2znKrAd31T
         zvj7zl6Qx6/rPv7CUkJ3q2GCV/7EEFscsZ1GAvjBdnHemaCoBV+5oG28CQdBsjN+b/
         eu2Z0JPpO1Bs178sz/T2Ek7DN+hDyWci2JF/vCn5AgiBqiwxOvziZ0IhGO/iHsnuux
         qvotl+cm+m3rK1acS5hv73b3pl6cBhuV/LcV6riKBuWJU473oLzqcSP0A8eUUgzvgC
         7iM7VdwacXYzA==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id 7so232434vsr.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 17:57:14 -0700 (PDT)
X-Gm-Message-State: ANhLgQ3ztndMtaAO7VgdO/wyYB4QYEN7dRO0b5VVemqGrVm/AlEvFumA
        h/hic5eYLK2/bu/+Z7/hx9enIgM/QFP2bcWeLmw=
X-Google-Smtp-Source: ADFU+vtFy90SnqDry+ThCJkJam5qSpiXYMOP/Izi4GedU/kSx/liBwsQW9w7/b1Qi8ofBzhYzoQ21vPXAOq43l0f1dI=
X-Received: by 2002:a67:3201:: with SMTP id y1mr515179vsy.54.1583888232869;
 Tue, 10 Mar 2020 17:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200306160206.5609-1-jeyu@kernel.org> <CAK7LNARZ4VgaCa_TiDBG-99amBGTTXTQMs9LsK3nO4k+y-5KDQ@mail.gmail.com>
 <20200309095914.GA18870@linux-8ccs.fritz.box> <CAK7LNARf9CzZ8dcK5O5vxUoncpDdpzSZctd0YuKeWyfDG_cdwA@mail.gmail.com>
 <20200309103935.GB18870@linux-8ccs.fritz.box> <CAK7LNARpJ-FAvCUEH9rrNCiqx5LwRHmWospvRnT-ERQoEGjK-Q@mail.gmail.com>
 <20200309105812.GC18870@linux-8ccs.fritz.box> <CAK7LNAQqMGSkX4Coe+f49SbXT_jkG_Mm4XZ3EJei0_K7SEaLhg@mail.gmail.com>
 <20200310113158.GA4865@linux-8ccs.fritz.box>
In-Reply-To: <20200310113158.GA4865@linux-8ccs.fritz.box>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 11 Mar 2020 09:56:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNASxdRRcAQEAKV9rUovBF987dGJFPQ+ENomgps3byCNnNA@mail.gmail.com>
Message-ID: <CAK7LNASxdRRcAQEAKV9rUovBF987dGJFPQ+ENomgps3byCNnNA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] modpost: rework and consolidate logging interface
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Matthias Maennich <maennich@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lkp@01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 8:32 PM Jessica Yu <jeyu@kernel.org> wrote:
>
> +++ Masahiro Yamada [09/03/20 20:03 +0900]:
> >On Mon, Mar 9, 2020 at 7:58 PM Jessica Yu <jeyu@kernel.org> wrote:
> >>
> >> +++ Masahiro Yamada [09/03/20 19:49 +0900]:
> >> >On Mon, Mar 9, 2020 at 7:39 PM Jessica Yu <jeyu@kernel.org> wrote:
> >> >>
> >> >> Ah, sorry, I mean the kbuild 0-day bot errors. I am just realizing
> >> >> the 0-day bot emails are not CC'd to lkml. Here is the error I got
> >> >> from the bot:
> >> >>
> >> >> ---
> >> >>
> >> >> I love your patch! Yet something to improve:
> >> >>
> >> >> [auto build test ERROR on linus/master]
> >> >> [also build test ERROR on v5.6-rc4 next-20200306]
> >> >> [if your patch is applied to the wrong git tree, please drop us a note to help
> >> >> improve the system. BTW, we also suggest to use '--base' option to specify the
> >> >> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> >> >>
> >> >> url:    https://github.com/0day-ci/linux/commits/Jessica-Yu/modpost-rework-and-consolidate-logging-interface/20200307-052346
> >> >> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 30fe0d07fd7b27d41d9b31a224052cc4e910947a
> >> >> config: sh-randconfig-a001-20200306 (attached as .config)
> >> >> compiler: sh4-linux-gcc (GCC) 7.5.0
> >> >> reproduce:
> >> >>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >> >>         chmod +x ~/bin/make.cross
> >> >>         # save the attached .config to linux build tree
> >> >>         GCC_VERSION=7.5.0 make.cross ARCH=sh
> >> >>
> >> >> If you fix the issue, kindly add following tag
> >> >> Reported-by: kbuild test robot <lkp@intel.com>
> >> >>
> >> >> All errors (new ones prefixed by >>):
> >> >>
> >> >> >> ERROR: modpost: "adc_single" [arch/sh/boards/mach-hp6xx/hp6xx_apm.ko] undefined!
> >> >
> >> >
> >> >Indeed, this one is odd.
> >> >I have no idea...
> >>
> >> I've pushed the patches to a branch to let the kbuild bot run through its
> >> build tests again, and if I have extra time today I will try to
> >> reproduce this and let you know the results.
> >>
> >> Thanks,
> >>
> >> Jessica
> >
> >
> >Ah, Now I see.
> >
> >
> >Because you added "modpost:" prefix.
> >
> >
> >
> >The previous error message:
> >
> >ERROR: "adc_single" [arch/sh/boards/mach-hp6xx/hp6xx_apm.ko] undefined!
> >
> >
> >The new error message:
> >
> >ERROR: modpost: "adc_single" [arch/sh/boards/mach-hp6xx/hp6xx_apm.ko] undefined!
> >
> >
> >
> >So, the bot assumed it was a new error.
>
> Nice catch! Hm, I suppose we need to let the LKP folks know about the
> change in error message. CC'd LKP mailing list.


Both applied to linux-kbuild.




-- 
Best Regards
Masahiro Yamada
