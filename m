Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12931180292
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 16:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgCJP4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 11:56:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:30835 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbgCJP4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 11:56:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 08:56:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,537,1574150400"; 
   d="scan'208";a="441348845"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by fmsmga005.fm.intel.com with ESMTP; 10 Mar 2020 08:56:34 -0700
Date:   Tue, 10 Mar 2020 23:55:16 +0800
From:   Philip Li <philip.li@intel.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Matthias Maennich <maennich@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lkp@01.org
Subject: Re: [LKP] Re: [PATCH v3 1/2] modpost: rework and consolidate logging
 interface
Message-ID: <20200310155516.GC22995@intel.com>
References: <20200306160206.5609-1-jeyu@kernel.org>
 <CAK7LNARZ4VgaCa_TiDBG-99amBGTTXTQMs9LsK3nO4k+y-5KDQ@mail.gmail.com>
 <20200309095914.GA18870@linux-8ccs.fritz.box>
 <CAK7LNARf9CzZ8dcK5O5vxUoncpDdpzSZctd0YuKeWyfDG_cdwA@mail.gmail.com>
 <20200309103935.GB18870@linux-8ccs.fritz.box>
 <CAK7LNARpJ-FAvCUEH9rrNCiqx5LwRHmWospvRnT-ERQoEGjK-Q@mail.gmail.com>
 <20200309105812.GC18870@linux-8ccs.fritz.box>
 <CAK7LNAQqMGSkX4Coe+f49SbXT_jkG_Mm4XZ3EJei0_K7SEaLhg@mail.gmail.com>
 <20200310113158.GA4865@linux-8ccs.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310113158.GA4865@linux-8ccs.fritz.box>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 12:32:00PM +0100, Jessica Yu wrote:
> +++ Masahiro Yamada [09/03/20 20:03 +0900]:
> > On Mon, Mar 9, 2020 at 7:58 PM Jessica Yu <jeyu@kernel.org> wrote:
> > > 
> > > +++ Masahiro Yamada [09/03/20 19:49 +0900]:
> > > >On Mon, Mar 9, 2020 at 7:39 PM Jessica Yu <jeyu@kernel.org> wrote:
> > > >>
> > > >> Ah, sorry, I mean the kbuild 0-day bot errors. I am just realizing
> > > >> the 0-day bot emails are not CC'd to lkml. Here is the error I got
> > > >> from the bot:
> > > >>
> > > >> ---
> > > >>
> > > >> I love your patch! Yet something to improve:
> > > >>
> > > >> [auto build test ERROR on linus/master]
> > > >> [also build test ERROR on v5.6-rc4 next-20200306]
> > > >> [if your patch is applied to the wrong git tree, please drop us a note to help
> > > >> improve the system. BTW, we also suggest to use '--base' option to specify the
> > > >> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> > > >>
> > > >> url:    https://github.com/0day-ci/linux/commits/Jessica-Yu/modpost-rework-and-consolidate-logging-interface/20200307-052346
> > > >> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 30fe0d07fd7b27d41d9b31a224052cc4e910947a
> > > >> config: sh-randconfig-a001-20200306 (attached as .config)
> > > >> compiler: sh4-linux-gcc (GCC) 7.5.0
> > > >> reproduce:
> > > >>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > > >>         chmod +x ~/bin/make.cross
> > > >>         # save the attached .config to linux build tree
> > > >>         GCC_VERSION=7.5.0 make.cross ARCH=sh
> > > >>
> > > >> If you fix the issue, kindly add following tag
> > > >> Reported-by: kbuild test robot <lkp@intel.com>
> > > >>
> > > >> All errors (new ones prefixed by >>):
> > > >>
> > > >> >> ERROR: modpost: "adc_single" [arch/sh/boards/mach-hp6xx/hp6xx_apm.ko] undefined!
> > > >
> > > >
> > > >Indeed, this one is odd.
> > > >I have no idea...
> > > 
> > > I've pushed the patches to a branch to let the kbuild bot run through its
> > > build tests again, and if I have extra time today I will try to
> > > reproduce this and let you know the results.
> > > 
> > > Thanks,
> > > 
> > > Jessica
> > 
> > 
> > Ah, Now I see.
> > 
> > 
> > Because you added "modpost:" prefix.
> > 
> > 
> > 
> > The previous error message:
> > 
> > ERROR: "adc_single" [arch/sh/boards/mach-hp6xx/hp6xx_apm.ko] undefined!
> > 
> > 
> > The new error message:
> > 
> > ERROR: modpost: "adc_single" [arch/sh/boards/mach-hp6xx/hp6xx_apm.ko] undefined!
> > 
> > 
> > 
> > So, the bot assumed it was a new error.
> 
> Nice catch! Hm, I suppose we need to let the LKP folks know about the
> change in error message. CC'd LKP mailing list.
Thanks for the info, we will look into this to handle the
changed error.

> 
> Jessica
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org
