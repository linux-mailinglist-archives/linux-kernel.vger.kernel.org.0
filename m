Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A35D496C79
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 00:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731077AbfHTWhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 18:37:15 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40676 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730983AbfHTWhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 18:37:15 -0400
Received: by mail-oi1-f195.google.com with SMTP id h21so121914oie.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 15:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v3PNIe6PlFx6XUGmIctyG3Xxp0nI64KtXff/8z9lYQw=;
        b=DrMO+Id3/F6kfiS8kA+XkmRwzKxg84gILs8dNH6dLLLovzZ/vvF83WQIo4xhkoeqV6
         3RBYncd/vUDzwp+CNY3VcPvIk4uU+c7YhMIYp/jOBMZIpHYZCw2M5qSNBnH0of+4OBQL
         XEScg+qnDqv1hG7QczO1oMYMvRb/ywFsl4n1D3Mn5PBoZos0Mf12KTnJB3kK2vuILj1q
         FspaYSPNM9Cuuhn4p40bqZxiBRQHihLsa+6CehfCd4cRXA/DwtPcIr2EtTw2rZXz294p
         CNHOT7IAuaNf5uttOcH7GkGHx1imDt89gkwkiMZvaQudFRv79OF3FkpvQO/gJXkNATWH
         c/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v3PNIe6PlFx6XUGmIctyG3Xxp0nI64KtXff/8z9lYQw=;
        b=Biljc6F3zUpFtP7CLTOamwYd6oArW+DRDSPl93a+Tth8eOR7MUY0gd467WsbiCSdkg
         J1Yoo/s1VB7WXsFK7ILoFTa6GiG3sQJjy4XF+t1IyWbwAoJkQ591MVxe/prXoTYnVPN5
         3pbNkotSHj2cUdW/D7aIO98dakwYKHP5gY+hhLWgzcpG3BADpEXEGV1bt1Kf68et5M/6
         MWvbuR9S5+IJ64V1onQOc+UA0H/rre0F/9ya0pX2lTURTkDW7+ppe5zxltVCQMUptmX8
         NCeIhNtNbmpyv+2at1oRPlxn7/V8qYiE2TPJJg4g+s5OgBaceNZOeind3y8O9ex5WdQe
         v1tg==
X-Gm-Message-State: APjAAAWvV+dSUVYt4Z2gsBCeQwQN38HxmSNwDVykLkzS+RUnyaEkGa9+
        7A/VYPhBJzPZaDY8tlokAIeIxisHXsKULYky2rmKsg==
X-Google-Smtp-Source: APXvYqz2R7/xK6d8AdXQAHLRwx7/BghrV4Nihx4FfF+VjmtffTiIbV+eNuYPOpVHE5wR2OKjyJRlAEmjWGHrDqWiu3Q=
X-Received: by 2002:aca:cc81:: with SMTP id c123mr1785858oig.30.1566340634069;
 Tue, 20 Aug 2019 15:37:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190807223111.230846-1-saravanak@google.com> <20190807223111.230846-3-saravanak@google.com>
 <20190820061300.wa2dirylb7fztsem@vireshk-i7> <CAGETcx9BV9qj17LY30vgAaLtz+3rXt_CPpu4wB_AQCC5M7qOdA@mail.gmail.com>
In-Reply-To: <CAGETcx9BV9qj17LY30vgAaLtz+3rXt_CPpu4wB_AQCC5M7qOdA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 20 Aug 2019 15:36:38 -0700
Message-ID: <CAGETcx-xQika2MgTgA3Gft3u2_uXgvoYThXwEpW_G03QTEh-yQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] OPP: Add support for bandwidth OPP tables
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        David Dai <daidavid1@codeaurora.org>, adharmap@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 3:27 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Mon, Aug 19, 2019 at 11:13 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 07-08-19, 15:31, Saravana Kannan wrote:

> > > +     ret = of_property_read_u32(np, "opp-peak-kBps", &bw);
> > > +     if (ret)
> > > +             return ret;
> > > +     new_opp->rate = (unsigned long) bw;
> > > +
> > > +     ret = of_property_read_u32(np, "opp-avg-kBps", &bw);
> > > +     if (!ret)
> > > +             new_opp->avg_bw = (unsigned long) bw;
> >
> > If none of opp-hz/level/peak-kBps are available, print error message here
> > itself..
>
> But you don't print any error for opp-level today. Seems like it's optional?
>
> >
> > > +
> > > +     return 0;
> >
> > You are returning 0 on failure as well here.
>
> Thanks.

Wait, no. This is not actually a failure. opp-avg-kBps is optional. So
returning 0 is the right thing to do. If the mandatory properties
aren't present an error is returned before you get to th end.

-Saravana
