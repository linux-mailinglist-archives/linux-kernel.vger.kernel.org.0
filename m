Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C85118A339
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 20:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgCRTgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 15:36:19 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39804 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgCRTgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 15:36:18 -0400
Received: by mail-ot1-f66.google.com with SMTP id r2so11412236otn.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 12:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uda+iMofV5GkvRE1SZlfH6+SW7Xs8teDkSSH3D+9sKs=;
        b=yv+uZvrYzf6Khv+eUARfdsxAsNNV+o4HVZrthqWPr34r5CsKlYV7xwA4XcPekMVkqU
         KIwUoXd21BPcmwV24wKdK05pwLQAD4U86eMPZi/JtLfJ3CGuPTP6fFE9JvKgBR89OdXn
         B38O/6PO6yk4PeZ2WjEkpSGCe7AplgTSnN+4CSp8/n2YwSnGrfdK16kRMCCl6ctEUBsf
         vIMLmSEv+SUtjm871L2tfxpJWYCcNs1AGMs+WR30uTDS+0r3PhJ9FGq8sJcqBUpo1xPq
         swuZ6tzTwPayRla16w9HFrpS8n2SKrrPO5kYgK/TSo7D5TTL0ALY8q5vLgvdxW/Vyd8F
         6nfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uda+iMofV5GkvRE1SZlfH6+SW7Xs8teDkSSH3D+9sKs=;
        b=F6IB4d9cfxC90bMMEI7hVc/d2oADbHM+HWFOjrJLCn+8R5B/K5WiIokuY7AJxPVhKs
         ZbcxJO0YsdbDGGFJQiv7fLPFg99XTw8Rfr7Bejzv+pNdM8hXT+s0F+Mq+02FETyaQFxl
         Xks21k1PjWR90LMU6ghK2wlzQvwbXBPmA9wto3/7Rb322FhGPPV4fZlA7/N6kEbBahLh
         NZqh/pHe/YWW0zD50DZLDfu5wflcTsfuyB2jsHxqYw/XmFzKFvSEos/nqAlHCepm9/Qp
         rOsAfmzaIMTr24FGGFuvO7MjytKeEPS2dNRgnZuwZU49yPmKnjr1/L52VvtXLrGanuyy
         KDEw==
X-Gm-Message-State: ANhLgQ04iX702K42JffkMVkEFQQ8aPgekbrOAIJAwq5YEmRc4YgfGK1C
        0IGGrFa65n9wslaFScV+s4Ls8rrev9xDL2ud81dUQA==
X-Google-Smtp-Source: ADFU+vv9nGQkz22eRDGMlRyVLEaBlP8Cs0HMgI3co2gMxPYER4rNEUFuKjt+npWRqr1+H6zIdh9SrncrrpovzKBKoSg=
X-Received: by 2002:a9d:1920:: with SMTP id j32mr5024362ota.221.1584560177605;
 Wed, 18 Mar 2020 12:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200305054244.128950-1-john.stultz@linaro.org> <20200305063254.GC264362@yoga>
In-Reply-To: <20200305063254.GC264362@yoga>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 18 Mar 2020 12:36:06 -0700
Message-ID: <CALAqxLVot09nSfG1TXko1Tyut-B9DvMzKYDpof2Tw3fEsdS=rw@mail.gmail.com>
Subject: Re: [RFC][PATCH] soc: qcom: rpmpd: Allow RPMPD driver to be loaded as
 a module
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Todd Kjos <tkjos@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 4, 2020 at 10:32 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Wed 04 Mar 21:42 PST 2020, John Stultz wrote:
>
> > Allow the rpmpd driver to be loaded as a module.
> >
...
> > diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
> > index 2b1834c5609a..9c0834913f3f 100644
> > --- a/drivers/soc/qcom/rpmpd.c
> > +++ b/drivers/soc/qcom/rpmpd.c
> > @@ -5,6 +5,7 @@
> >  #include <linux/init.h>
> >  #include <linux/kernel.h>
> >  #include <linux/mutex.h>
> > +#include <linux/module.h>
> >  #include <linux/pm_domain.h>
> >  #include <linux/of.h>
> >  #include <linux/of_device.h>
> > @@ -226,6 +227,7 @@ static const struct of_device_id rpmpd_match_table[] = {
> >       { .compatible = "qcom,qcs404-rpmpd", .data = &qcs404_desc },
> >       { }
> >  };
> > +MODULE_DEVICE_TABLE(of, rpmpd_match_table);
> >
> >  static int rpmpd_send_enable(struct rpmpd *pd, bool enable)
> >  {
> > @@ -421,4 +423,5 @@ static int __init rpmpd_init(void)
> >  {
> >       return platform_driver_register(&rpmpd_driver);
> >  }
> > -core_initcall(rpmpd_init);
> > +module_init(rpmpd_init);
>
> Can't you keep this as core_initcall(), for the times when its builtin?

Sure!

> Additionally I believe you should add a call to unregister the driver,
> and drop the suppress_bind_attrs.

So, I sort of took the simple swing here as adding it as a module w/o
a unregister makes it a "permanent" module. It loads but cannot be
unloaded. I know this isn't ideal, but it's also a big improvement
over it being limited to it being required as a built-in.  I'll take a
look at it though to see if its workable to be removable.

> > +MODULE_LICENSE("GPL");
>
> "GPL v2" per the SPDX?

Ah. Thanks, fixed!

thanks again for the review
-john
