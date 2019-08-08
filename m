Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1C485B15
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 08:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389082AbfHHGv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 02:51:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52340 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730903AbfHHGvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 02:51:55 -0400
Received: from p200300ddd71876597e7a91fffec98e25.dip0.t-ipconnect.de ([2003:dd:d718:7659:7e7a:91ff:fec9:8e25])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hvcGa-0001UH-CB; Thu, 08 Aug 2019 08:51:16 +0200
Date:   Thu, 8 Aug 2019 08:51:04 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Pingfan Liu <kernelfans@gmail.com>
cc:     Dave Young <dyoung@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, Qian Cai <cai@lca.pw>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Drake <drake@endlessm.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Eric Biederman <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        kexec@lists.infradead.org, Tony Luck <tony.luck@intel.com>,
        Xunlei Pang <xlpang@linux.alibaba.com>
Subject: Re: [PATCH 0/4] x86/mce: protect nr_cpus from rebooting by broadcast
 mce
In-Reply-To: <CAFgQCTs7XN3xBPt64jPNb4wCGAZRmYSjhPM=tgcLriVCEx+uDA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1908080850220.2882@nanos.tec.linutronix.de>
References: <1564995539-29609-1-git-send-email-kernelfans@gmail.com> <20190807025843.GA4776@dhcp-128-65.nay.redhat.com> <20190807075226.GA10392@mypc> <alpine.DEB.2.21.1908071504310.24014@nanos.tec.linutronix.de>
 <CAFgQCTs7XN3xBPt64jPNb4wCGAZRmYSjhPM=tgcLriVCEx+uDA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2019, Pingfan Liu wrote:
> On Wed, Aug 7, 2019 at 9:07 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> [...]
> > > > >
> > > > > *** Back ground ***
> > > > >
> > > > > On x86 it's required to have all logical CPUs set CR4.MCE=1. Otherwise, a
> > > > > broadcast MCE observing CR4.MCE=0b on any core will shutdown the machine.
> >
> > Pingfan, please trim your replies and remove the useless gunk after your answer.
> OK. I will.
> 
> Thanks,
>     Pingfan
> >
> > Thanks,
> >
> >         tglx
> 

First attempt to do so failed :)
