Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEB1118C57
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 16:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfLJPSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 10:18:06 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43205 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbfLJPSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 10:18:06 -0500
Received: by mail-vs1-f65.google.com with SMTP id x4so13282701vsx.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 07:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jcUnC0/SEm4HDTIw1YLkWhbNF7DV2HNNDkdfVlTygbE=;
        b=cSSUpZLtf+hCVZvTD7HbKKL/zq4Rkmgcb2lIlIkDlhoxjyGVl0vVSnKlyJSar8oMju
         kJKrdwjxQ132req2y4+nrrVfisVcDFp//Vza1JYfv88Pn0pawYqigZnVIjKe8hsBLtwo
         MCeVhuUG+FD6AVkT5efECIF5yoeCURQPE8pK5mLLWFQv5VUdlsUYexM/XG4pBnG0lMlj
         homajns2YyoPkCVbVSABDLsSQp/B9WvdKRwStVCpME0KK4gfjaFWk6c6Sp+tT9WhGfwd
         Wm0n+fvhFn2WYXhdCvCyA4aduw0ySOsjxw4ZHQ5FAt3egnPm7ELrA47hNqGA3SWWB7Yy
         x0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jcUnC0/SEm4HDTIw1YLkWhbNF7DV2HNNDkdfVlTygbE=;
        b=MGi5lCJR+xlNJ5qbuusPx+I5vH3nrGX8Jduddj68TAlz7MwugsQXP8NODVRPIqKd43
         XtSfiRCcUNvRAt1uW9SwPlvLKzvcJVsIILk83o15XivQ0EWPqAMDfVQW6HGgyiKW3tov
         YHFyfW3aMMfaMickzzGi1Ry/OUYva9sCl7boUhfSYeqs7br61d4rwRV10b9sSfAznyqv
         BHLv3N0nXF0cpMr6QN8ubsqOtC+jBb5dV5TubqVXcXg2za/EYRJkvZGlX19kiwIAvjLy
         dbU+4AqvW8zDkmBBVSDhuuuiDXLQ9odQboQeUyYWZbaTD9yQHDdl/VCCR7zrTxqaMI87
         K90w==
X-Gm-Message-State: APjAAAXAKHCP4WJvfPBkck6ePsGHCoCSZfrdi4G7qijM6rXn5owVt5DS
        e9nmUcOa/LTRC8Ws3kOK+ZU/Dh2IzNhGDYTnjGkgQQ==
X-Google-Smtp-Source: APXvYqxHTWP37WCrbgkX6nxMLdBw/0tPKoRg5nRin2f5LJXHzhcKcpphZKWgMGaQKXGnCPL9VoXyCSqg/WxqTmWfZqM=
X-Received: by 2002:a05:6102:5d1:: with SMTP id v17mr25314853vsf.200.1575991085086;
 Tue, 10 Dec 2019 07:18:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573456283.git.baolin.wang@linaro.org> <CAK8P3a1we9D5C2NOBww=cW-4L1PT3t0NnDRmknLwiLm652TmKg@mail.gmail.com>
 <CAMz4kuK9HEuGdhNqHO_qoy9jD=ccsPPhD_dKYwNRgQyWyYwqRA@mail.gmail.com>
 <CAK8P3a0rNhyxmUWLUV1js3FsuAESDOPX3E4b8ActtL4GRT4uTA@mail.gmail.com>
 <CADBw62pzV+5ZXBEbFvTQJ9essAd4cd7Xkz5j9AXB5rAQy0wLqA@mail.gmail.com>
 <CAMz4kuK_3q4JY1vNXe6zGHDNF8Ep-SkcUq6Z25r790VSz4+Bjw@mail.gmail.com>
 <CAK8P3a11vJb1riYseqPnF_5SuJA+YnYuGwC0XWx6_rk+eQ0Bmw@mail.gmail.com>
 <f88856aa-9175-2a93-3747-c98215cb79c3@suse.de> <20191127090023.GA23040@infradead.org>
 <CAK8P3a0gUWf_+ZmscuFanvPG=wN09ELL-JpByjJJM4Lo1FYmrQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0gUWf_+ZmscuFanvPG=wN09ELL-JpByjJJM4Lo1FYmrQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Dec 2019 16:17:28 +0100
Message-ID: <CAPDyKFoNAF1UUvzvEGxTS=yKJshVgHsXqXiCxno75=aasME4kw@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Add MMC software queue support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.de>,
        "(Exiting) Baolin Wang" <baolin.wang@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        linux-block <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Nov 2019 at 13:01, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Nov 27, 2019 at 10:00 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Tue, Nov 26, 2019 at 12:17:15PM +0100, Hannes Reinecke wrote:
> >  If requests are batched enough we could just drain
> > and switch every time an other partition access comes in.  Especially
> > so if people only use partitions for boot partitions and other rarely
> > used areas.
>
> We only support a single user partition plus up to two boot partitions that
> are accessed rarely, I don't think there is any reason to optimize switching
> between them.

I agree. However, let me just add some more information to this.

There are more partitions, like the RPMB for example. In regards to
partition switching, after serving a request to the RPMB partition, we
always switch back to the main user area. I think that is sufficient.

Also note that requests for the RPMB partitions are managed via
REQ_OP_DRV_IN|OUT.

>
> The only change that I think we need here is to change the partition switch
> from something that is done synchronously during ->queue_rq() to
> something that fits better into normal scheme of sending a cmd to
> the device, returning BLK_STS_RESOURCE from ->queue_rq.

You want to translate them to be managed similar to REQ_OP_DRV_IN|OUT, no?

I am just trying to understand what this would help us with, but I
don't get it, sorry.

I realize that I am joining the show a bit late, apologize for that.
But it seems like you are forgetting about re-tuning, urgent bkops,
card detect, SDIO combo cards, etc.

For example, re-tuning may be required because of a CRC error on the
previously sent transfer. Thus re-tuning must be done before serving
the next request.

Likewise, when the device signals urgent bkops status, we must not
serve any new request until the card has notified us that it is ready
with it's internal housekeeping operations.

> Possibly this could even be turned into a standard struct request that is
> added between two normal requests for different partitions at some
> point, if this simplifies the logic (I suspect it won't, but it may be worth
> a try).

Doing so, means re-tuning, bkops, etc, also needs to be managed in the
same way. Is this really the way to go?

Kind regards
Uffe
