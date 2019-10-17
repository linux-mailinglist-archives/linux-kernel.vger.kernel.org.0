Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E327DA5FA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 09:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407916AbfJQHJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 03:09:04 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:40819 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390955AbfJQHJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 03:09:03 -0400
Received: by mail-yb1-f194.google.com with SMTP id s7so378710ybq.7;
        Thu, 17 Oct 2019 00:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DSbs0/QEEgmADy+uvB3J9WS3y0uYupAbV9G4/iwiKTo=;
        b=LKlUZivU99zESLkGMI4JigSZDHVXf8KBTGUnS+U1uFPat0D3OT1MwJOwYZUWLm0I8P
         41kYKpLKDPZLs3S3PtA7ic/FpWRtuK31GovU6OdTLakp/FFghd4f0QeNAcC335X1DwIF
         opMr6lRO/YvMQJZAm7++BU5wj6k7YBXmgCRuQoGLm7rwVYgE/NKs/JPX6NEC4gzgyEVY
         +0Q2B2sGjs0DCNxNnSsbKT/wQZVPtw1uPD4oHYQm+ozDCHyqodf1D/WrA9k+JoWIje6A
         fO33TBNz4pLp+qIkBEWsKZw+RMEhpmh8ryTi2Of5HYyaAeP60Tq7is+U/jobPYV8tnZV
         yBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DSbs0/QEEgmADy+uvB3J9WS3y0uYupAbV9G4/iwiKTo=;
        b=sZxTZ+2KJCId99jNnlXaxqG3jcEnQExOy2B41hX17ap+kLB1H/h5HgkoTIOVqdbFZ8
         zlyBtgtn5CKmLvo9yokdCQ+q/A4ekc6reLegth3TJ6XvN+REN397XjJEZOGMzGkjDAGn
         kkygl2e8lSbE/IPKTSzvg1wY2sI1d6EITkLl2QbSoRlhKkyB4edh0bRxJ196fWat+iZQ
         PkAOIb+4+mPS0vTt54/78VXnL/+j3b4m0qhiWVO/OR+MDD8519C+NUGkCBMzx4hwI3yf
         dj3Q4tNnc64hQVQVQ7oe2K2ael/36orelFe5v860JPMZSAtmiYo2qabgpRpVqk8tCJm+
         DSXw==
X-Gm-Message-State: APjAAAWDXTugkJR539b9UQ21KZzs8XKTx5Wp1a+8RC3F5utCvuW0lxTA
        GMTyYmrj02o6blQM4NEw22RfPxEZ76Jh6M2LN1s=
X-Google-Smtp-Source: APXvYqwjLzRLqMjo02al4Z+VnHPSrn7zqUYHshfSiH2OnhimoSV01IJH6/02ZYbLhTr3tj67kX/r3rImnNB2kLiwcg8=
X-Received: by 2002:a5b:788:: with SMTP id b8mr1075528ybq.509.1571296142395;
 Thu, 17 Oct 2019 00:09:02 -0700 (PDT)
MIME-Version: 1.0
References: <1571218608-15933-1-git-send-email-gkulkarni@marvell.com>
 <1571218608-15933-3-git-send-email-gkulkarni@marvell.com> <b8e1a637-faf4-4567-7d3e-a4f13dfa1cf0@huawei.com>
In-Reply-To: <b8e1a637-faf4-4567-7d3e-a4f13dfa1cf0@huawei.com>
From:   Ganapatrao Kulkarni <gklkml16@gmail.com>
Date:   Thu, 17 Oct 2019 12:38:51 +0530
Message-ID: <CAKTKpr4QoTDjbSxO4CvSH2sNvmrTJKjxi+RZH4mYfyDaaN96Sw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] drivers/perf: Add CCPI2 PMU support in ThunderX2
 UNCORE driver.
To:     John Garry <john.garry@huawei.com>
Cc:     Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Jan Glauber <jglauber@marvell.com>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
        Robert Richter <rrichter@marvell.com>,
        "will@kernel.org" <will@kernel.org>,
        Zhangshaokun <zhangshaokun@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Wed, Oct 16, 2019 at 7:01 PM John Garry <john.garry@huawei.com> wrote:
>
>
> > +TX2_EVENT_ATTR(req_pktsent, CCPI2_EVENT_REQ_PKT_SENT);
> > +TX2_EVENT_ATTR(snoop_pktsent, CCPI2_EVENT_SNOOP_PKT_SENT);
> > +TX2_EVENT_ATTR(data_pktsent, CCPI2_EVENT_DATA_PKT_SENT);
> > +TX2_EVENT_ATTR(gic_pktsent, CCPI2_EVENT_GIC_PKT_SENT);
> > +
> > +static struct attribute *ccpi2_pmu_events_attrs[] = {
> > +     &tx2_pmu_event_attr_req_pktsent.attr.attr,
> > +     &tx2_pmu_event_attr_snoop_pktsent.attr.attr,
> > +     &tx2_pmu_event_attr_data_pktsent.attr.attr,
> > +     &tx2_pmu_event_attr_gic_pktsent.attr.attr,
> > +     NULL,
> > +};
>
> Hi Ganapatrao,
>
> Have you considered adding these as uncore pmu-events in the perf tool?
>
At the moment no, since the number of events exposed/listed are very few.

> Some advantages I see:
> - perf list is not swamped with all these uncore events per PMU
> For the Hisi uncore events, we get 100s of events (>600 on the board I
> just tested, which is crazy)
> - can add more description in the JSON files
> - less stuff in the kernel
>
> > +
> >  static const struct attribute_group l3c_pmu_events_attr_group = {
> >       .name = "events",
> >       .attrs = l3c_pmu_events_attrs,
> > @@ -174,6 +240,11 @@ static const struct attribute_group dmc_pmu_events_attr_group = {
> >       .attrs = dmc_pmu_events_attrs,
> >  };
>
> [...]
>
> >               tx2_pmu->attr_groups = l3c_pmu_attr_groups;
> >               tx2_pmu->name = devm_kasprintf(dev, GFP_KERNEL,
> >                               "uncore_l3c_%d", tx2_pmu->node);
> > @@ -665,10 +846,13 @@ static struct tx2_uncore_pmu *tx2_uncore_pmu_init_dev(struct device *dev,
> >               tx2_pmu->stop_event = uncore_stop_event_l3c;
> >               break;
> >       case PMU_TYPE_DMC:
> > -             tx2_pmu->max_counters = TX2_PMU_MAX_COUNTERS;
> > +             tx2_pmu->max_counters = TX2_PMU_DMC_L3C_MAX_COUNTERS;
> > +             tx2_pmu->counters_mask = 0x3;
> >               tx2_pmu->prorate_factor = TX2_PMU_DMC_CHANNELS;
> >               tx2_pmu->max_events = DMC_EVENT_MAX;
> > +             tx2_pmu->events_mask = 0x1f;
> >               tx2_pmu->hrtimer_interval = TX2_PMU_HRTIMER_INTERVAL;
> > +             tx2_pmu->hrtimer_callback = tx2_hrtimer_callback;
> >               tx2_pmu->attr_groups = dmc_pmu_attr_groups;
> >               tx2_pmu->name = devm_kasprintf(dev, GFP_KERNEL,
> >                               "uncore_dmc_%d", tx2_pmu->node);
> > @@ -676,6 +860,21 @@ static struct tx2_uncore_pmu *tx2_uncore_pmu_init_dev(struct device *dev,
> >               tx2_pmu->start_event = uncore_start_event_dmc;
> >               tx2_pmu->stop_event = uncore_stop_event_dmc;
> >               break;
> > +     case PMU_TYPE_CCPI2:
> > +             /* CCPI2 has 8 counters */
> > +             tx2_pmu->max_counters = TX2_PMU_CCPI2_MAX_COUNTERS;
> > +             tx2_pmu->counters_mask = 0x7;
> > +             tx2_pmu->prorate_factor = 1;
> > +             tx2_pmu->max_events = CCPI2_EVENT_MAX;
> > +             tx2_pmu->events_mask = 0x1ff;
> > +             tx2_pmu->attr_groups = ccpi2_pmu_attr_groups;
> > +             tx2_pmu->name = devm_kasprintf(dev, GFP_KERNEL,
> > +                             "uncore_ccpi2_%d", tx2_pmu->node);
>
> Do you need to check this for name == NULL?
>
> > +             tx2_pmu->init_cntr_base = init_cntr_base_ccpi2;
> > +             tx2_pmu->start_event = uncore_start_event_ccpi2;
> > +             tx2_pmu->stop_event = uncore_stop_event_ccpi2;
> > +             tx2_pmu->hrtimer_callback = NULL;
> > +             break;
> >       case PMU_TYPE_INVALID:
> >               devm_kfree(dev, tx2_pmu);
> >               return NULL;
> > @@ -744,7 +943,9 @@ static int tx2_uncore_pmu_offline_cpu(unsigned int cpu,
> >       if (cpu != tx2_pmu->cpu)
> >               return 0;
> >
> > -     hrtimer_cancel(&tx2_pmu->hrtimer);
> > +     if (tx2_pmu->hrtimer_callback)
> > +             hrtimer_cancel(&tx2_pmu->hrtimer);
> > +
> >       cpumask_copy(&cpu_online_mask_temp, cpu_online_mask);
> >       cpumask_clear_cpu(cpu, &cpu_online_mask_temp);
> >       new_cpu = cpumask_any_and(
> >
>
> Thanks,
> John
>
>

Thanks,
Ganapat
