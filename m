Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D21C8A769
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 21:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfHLTmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 15:42:15 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41803 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfHLTmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 15:42:15 -0400
Received: by mail-lj1-f194.google.com with SMTP id d24so99365612ljg.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 12:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i9ag70mY/H+XzREddXT8m/GXsHt6XXH2r3/lGBLxgjQ=;
        b=ZRo1bNo+Aw7DiqwxJFn3dOhsQ/fbVTXH8r5yWiltl7XdssZ/k7B0Yz7F5FHLa/WdkS
         MeT+k+iNxhKOWiIKH9o5/D2tDHeeWPmSNDPkw5skE0iSvjSCpsUqe9K1out3ZZied9kc
         gNrTfUjruX87SkWqrLtPjiNb/QoE16r3csI4KMZERkYHTzqUJ7RydCIZBq09Qd2WRwqb
         gTagedY8bdHU7LMOADp8JxIY+PGeA1Qu6Pyh0hjfZcmbgeOzgu5bqQL2ddXmPBQYhXV0
         KuXQQmq/eYfGsLYe0vO7pvr0hYBW5f9fQI0FE/TzXU5vJmNZpIEeypVaGuZQOiY54giO
         7Xrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i9ag70mY/H+XzREddXT8m/GXsHt6XXH2r3/lGBLxgjQ=;
        b=dZcImyTHkcz5hzt+HMQAHBPkHt8d28CCQiTiqi08g5euuakSAxZvvZ1uj6VCEFLmys
         dhhahoVxUeftJd+L0MBxwDfMEtMtYG/Q0s/Krmc4LRCZnInoTcq9h8VwdEUTPzxgXZ1x
         7E7DStWTOV6fuN/9RtIqCvzPUUcjsu1AagTZ9x+Hcu2QIAraFEYrX9C8ZwUWr9Y6DaVB
         3IJjKYpnlvjp8xfq9bLlDCYs2wWOVu/a5rApG01TBJtEHHgkDT40yzigfy0xv160mJe1
         vcDyIct4Ex6fqFepRQdHRuupdQuJc42UB3VnlcAWVmTnAKXaNkzll44tws0nBehpINkV
         npKA==
X-Gm-Message-State: APjAAAUQDFuq9EIEhF2M17j72lhLbc/yzfNNGgEIHA2rHSOvCwMij0JF
        sGBWNeAI8u3Jl2AuNoQrXO4GTModEVkSZAmiKME=
X-Google-Smtp-Source: APXvYqwompkoD8EmgNEGCtq1PSOzsE9DbFEgjmLe9WsZMZf/8p/TnQjxnGKvuCVakhW7AbgT0g6kxogCgzWpuQO2qiU=
X-Received: by 2002:a2e:8059:: with SMTP id p25mr7751366ljg.120.1565638933507;
 Mon, 12 Aug 2019 12:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAM_iQpXvuYKn94WjJ9nSjzhk8DzYAvDmdgxsi6cc9CdBfkdTnw@mail.gmail.com>
 <20180223121456.GZ25201@hirez.programming.kicks-ass.net> <20180226203937.GA21543@tassilo.jf.intel.com>
 <CAKA=qzYOU-VtEC5p6djRNmVS0xGe=jpTd3ZgUr++1G3Jj1=PTg@mail.gmail.com>
 <alpine.DEB.2.21.1908121933310.7324@nanos.tec.linutronix.de>
 <CAKA=qzY=F-wj8YXhb-B7RahNceeab0rSA=06qBc8+7V-SyY-+Q@mail.gmail.com> <alpine.DEB.2.21.1908122133310.7324@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1908122133310.7324@nanos.tec.linutronix.de>
From:   Josh Hunt <joshhunt00@gmail.com>
Date:   Mon, 12 Aug 2019 12:42:02 -0700
Message-ID: <CAKA=qzYTax6ECQBChUrNWMRp5iY9F2SezMY2Ma_zmWxiDgjOSA@mail.gmail.com>
Subject: Re: Long standing kernel warning: perfevents: irq loop stuck!
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "Liang, Kan" <kan.liang@intel.com>, jolsa@redhat.com,
        bigeasy@linutronix.de, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 12:34 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, 12 Aug 2019, Josh Hunt wrote:
> > On Mon, Aug 12, 2019 at 10:55 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > >
> > > On Mon, 12 Aug 2019, Josh Hunt wrote:
> > > > Was there any progress made on debugging this issue? We are still
> > > > seeing it on 4.19.44:
> > >
> > > I haven't seen anyone looking at this.
> > >
> > > Can you please try the patch Ingo posted:
> > >
> > >   https://lore.kernel.org/lkml/20150501070226.GB18957@gmail.com/
> > >
> > > and if it fixes the issue decrease the value from 128 to the point where it
> > > comes back, i.e. 128 -> 64 -> 32 ...
> > >
> > > Thanks,
> > >
> > >         tglx
> >
> > I just checked the machines where this problem occurs and they're both
> > Nehalem boxes. I think Ingo's patch would only help Haswell machines.
> > Please let me know if I misread the patch or if what I'm seeing is a
> > different issue than the one Cong originally reported.
>
> Find the NHM hack below.
>
> Thanks,
>
>         tglx
>
> 8<----------------
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 648260b5f367..93c1a4f0e73e 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3572,6 +3572,11 @@ static u64 bdw_limit_period(struct perf_event *event, u64 left)
>         return left;
>  }
>
> +static u64 nhm_limit_period(struct perf_event *event, u64 left)
> +{
> +       return max(left, 128ULL);
> +}
> +
>  PMU_FORMAT_ATTR(event, "config:0-7"    );
>  PMU_FORMAT_ATTR(umask, "config:8-15"   );
>  PMU_FORMAT_ATTR(edge,  "config:18"     );
> @@ -4606,6 +4611,7 @@ __init int intel_pmu_init(void)
>                 x86_pmu.pebs_constraints = intel_nehalem_pebs_event_constraints;
>                 x86_pmu.enable_all = intel_pmu_nhm_enable_all;
>                 x86_pmu.extra_regs = intel_nehalem_extra_regs;
> +               x86_pmu.limit_period = nhm_limit_period;
>
>                 mem_attr = nhm_mem_events_attrs;
>
Thanks Thomas. Will try this and let you know.

-- 
Josh
