Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6E017441B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 05:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390129AbfGYDrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 23:47:19 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45083 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389014AbfGYDrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 23:47:18 -0400
Received: by mail-ot1-f68.google.com with SMTP id x21so11735298otq.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 20:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aMjIeeabzA2glm2FgNQ5GnaE3BxUhRtGgmqv9hcezQY=;
        b=wHXvEk5oHzm7Sws7eklMNmrftnJSG+btbxOyjYGAbrQL1qJy6zD4PObA+jWSEgMyRB
         aRrkrq80Z3SJ2TSDws4Rv5GRprZNDrWDLrJQ0wX3686kQIu2OCLvI9w87d8UHHgOg+0d
         GTePKHqwPknGA8PHhql/6tyfd3uPOh/2TEWx5qiFganq3CI2HM14/fLyaNDFJPivQgUE
         AJkjK8XC/qBav++WOcziu3XSxf9dhzyMLjLbq5mM7h/sbnUvptmXH0y5tOUiHyLN72sK
         xNtG93040FKsaE7cwu4XrwN/9ZyPqAIjdUosovdN6zX4Hoeb7KDzRbZ9hm/ScRQ2CIJ6
         NaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aMjIeeabzA2glm2FgNQ5GnaE3BxUhRtGgmqv9hcezQY=;
        b=XFuGXmB6fGTcZ+CBUxxkgPBvCUCh5haG27jad0CRd/3r/v8z6FbkfWrvhX84u5Jom6
         jttCWWXzP7nhsiNBeG8x9Y8RGKARKgRk0BsoclSjfFPZe6j5lq0Utxopn14Felop3HRI
         zlqTeZE/B6tnzkKr0WSb8krWzCex5cC+ekAACuo49QBjS2Zx1VEZ2FasrCZjkmc7MPDL
         hNvm8CNookvy10cQggkGxFS9XBxTYkKfRjTsbPgziETCuGdNtAQ1ei4X7iPPOeTn3u/P
         qYl545H1QAT+dZ6kxzIAD0mEX43T0SkVaWQJFdqRgT9qAFPh9ooTz9aqhWh6wZSkB439
         6l5g==
X-Gm-Message-State: APjAAAVctX2aG56U9s/sbfoKRhhxCbBH8b6ggEUOCcP94XmxZ1Caav9t
        HkuLbFAjTdx9ZsGxDWf8WzVciumN29+qgJFDrnaKVQ==
X-Google-Smtp-Source: APXvYqxwTxwYWp2aKQeTiODwLq0phPgcO3cP/jhc5NSj2PouBt+Yra1YiOWB/mjtrI5O3dhVxWWJpN8W09pU0uWM2zM=
X-Received: by 2002:a05:6830:160c:: with SMTP id g12mr7714792otr.231.1564026437377;
 Wed, 24 Jul 2019 20:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190717222340.137578-1-saravanak@google.com> <20190717222340.137578-3-saravanak@google.com>
 <20190723095316.t5ltprixxd5veuj7@vireshk-i7> <CAGETcx-r6fZH0xYea-YXyXDwe33pimtfNerLzzBn4UHT2qQVvA@mail.gmail.com>
 <20190725025849.y2xyxmqmgorrny6k@vireshk-i7>
In-Reply-To: <20190725025849.y2xyxmqmgorrny6k@vireshk-i7>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 24 Jul 2019 20:46:41 -0700
Message-ID: <CAGETcx8r3C_=Y0vSwqekCZPUeYkNQ6EOUDK4bUJksDHG6zPUjA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] OPP: Add function to look up required OPP's for a
 given OPP
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 7:58 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 23-07-19, 17:23, Saravana Kannan wrote:
> > On Tue, Jul 23, 2019 at 2:53 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 17-07-19, 15:23, Saravana Kannan wrote:
> > > > Add a function that allows looking up required OPPs given a source OPP
> > > > table, destination OPP table and the source OPP.
> > > >
> > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > ---
> > > >  drivers/opp/core.c     | 54 ++++++++++++++++++++++++++++++++++++++++++
> > > >  include/linux/pm_opp.h | 11 +++++++++
> > > >  2 files changed, 65 insertions(+)
> > > >
> > > > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > > > index 438fcd134d93..72c055a3f6b7 100644
> > > > --- a/drivers/opp/core.c
> > > > +++ b/drivers/opp/core.c
> > > > @@ -1883,6 +1883,60 @@ void dev_pm_opp_detach_genpd(struct opp_table *opp_table)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(dev_pm_opp_detach_genpd);
> > > >
> > > > +/**
> > > > + * dev_pm_opp_xlate_opp() - Find required OPP for src_table OPP.
> > > > + * @src_table: OPP table which has dst_table as one of its required OPP table.
> > > > + * @dst_table: Required OPP table of the src_table.
> > > > + * @pstate: OPP of the src_table.
> > >
> > > You should use @ before parameters in the comments as well ? Just like
> > > you did that below.
> >
> > And I should probably be deleting the @pstate phantom parameter :)
> >
> > > > + *
> > > > + * This function returns the OPP (present in @dst_table) pointed out by the
> > > > + * "required-opps" property of the OPP (present in @src_table).
> > > > + *
> > > > + * The callers are required to call dev_pm_opp_put() for the returned OPP after
> > > > + * use.
> > > > + *
> > > > + * Return: destination table OPP on success, otherwise NULL on errors.
> > > > + */
> > > > +struct dev_pm_opp *dev_pm_opp_xlate_opp(struct opp_table *src_table,
> > >
> > > Please name it dev_pm_opp_xlate_required_opp().
> >
> > Ok
> >
> > >
> > > > +                                     struct opp_table *dst_table,
> > > > +                                     struct dev_pm_opp *src_opp)
> > > > +{
> > > > +     struct dev_pm_opp *opp, *dest_opp = NULL;
> > > > +     int i;
> > > > +
> > > > +     if (!src_table || !dst_table || !src_opp)
> > > > +             return NULL;
> > > > +
> > > > +     for (i = 0; i < src_table->required_opp_count; i++) {
> > > > +             if (src_table->required_opp_tables[i]->np == dst_table->np)
> > >
> > > Why can't we just compare the table pointers instead ? Yeah, I know
> > > that's how I wrote that in the other xlate function, but I am confused
> > > now :)
> >
> > I almost said "not sure. Let me just compare pointers".
> > I think (not sure) it has to do with the same OPP table being used to
> > create multiple OPP table copies if the "shared OPP table" flag isn't
> > set?
> > Can you confirm if this makes sense? If so, I can add a comment patch
> > that adds comments to the existing code and then copies it into this
> > function in this patch.
>
> Right, that was the reason but we also need to fix ...

I know I gave that explanation but I'm still a bit confused by the
existing logic. If the same DT OPP table is used to create multiple in
memory OPP tables, how do you device which in memory OPP table is the
right one to point to?

>
> > > > +                     break;
> > > > +     }
> > > > +
> > > > +     if (unlikely(i == src_table->required_opp_count)) {
> > > > +             pr_err("%s: Couldn't find matching OPP table (%p: %p)\n",
> > > > +                    __func__, src_table, dst_table);
> > > > +             return NULL;
> > > > +     }
> > > > +
> > > > +     mutex_lock(&src_table->lock);
> > > > +
> > > > +     list_for_each_entry(opp, &src_table->opp_list, node) {
> > > > +             if (opp == src_opp) {
>
> ... this as well. We must be comparing node pointers here as well.

Not really, if an in memory OPP entry is not part of an in memory OPP
table list, I don't think it should be considered part of the OPP
table just because the node pointer is the same. I think that's
explicitly wrong and the above code is correct as is.

-Saravana
