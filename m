Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16A54BFED4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2019 08:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbfI0GGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 02:06:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34207 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfI0GGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 02:06:16 -0400
Received: by mail-pg1-f194.google.com with SMTP id y35so2893364pgl.1;
        Thu, 26 Sep 2019 23:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=shGlXP0a+d5dJlocGPNSuTbXMERJcBW0qglwv2DFJ40=;
        b=VtON5D6Gqgn7zsdje44tVNsQVPngdLZ6lnnnM8LsYVO6xfAnLS/iRzQsH38adFqUxk
         aENCUeM88uBg3G8vyB2KgpCogGxEkRZFO7MWT/np5uGMJ66qQwAgKJhfS92P4su7/rav
         Tnqs2EDkuC6Z2OLI1vmsaR3eKtfjoZhnwt/+kGxuh/0mbOXWk20xWnBizey0QgSEpjBd
         02WXhAFGyjKu4ZgzQUS6iF5b8pudy6tYqndJF2s7n8rVh5AARTMOioAVHDP08FGVI4dE
         rvvv85bYrofAYKJko4FUes90pgkWfHs4oD65KWFS6KH8wciqlQwPIdKhe0m1DeDTAJ0h
         dSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=shGlXP0a+d5dJlocGPNSuTbXMERJcBW0qglwv2DFJ40=;
        b=IPfgMT1QhxprKpKD+krV6Q+ap8Huv0eblEVRkV0jLhiZy1b9TFN6Oa26QMQVJj8hyL
         fWZQI6YMFzoJEocIHW57qNJRI+Sr2CRWeV6J710m/2pmxLqU2AbRnhGskQNk5W+Dgc+z
         7BTmda1+rVDcvb4hexfR9krHgzCaG6yKGgK3iAZxdEuxTIW30rmViAbW75+/Bk159z+f
         Y3U9hSPtdx/4NGu95coCqbs1y8bvPtgYtzZqOSu8qFZJUN1K08iznN70Pc6O77yitLdn
         82te/0U4tuN4uHyQrM8QHyyk+rygfujnwb4IZJph+vsvQb5kqWP09Fe6avUWN706u2gn
         5etg==
X-Gm-Message-State: APjAAAUB67zB1qrVzV2T6G1MCZD0w5FsRrjcDsbxLM4NUML+o4a60kIx
        /8yNi4v4YQjixrRGQWMhn/Gd9JKtHbUw1M2L3ss=
X-Google-Smtp-Source: APXvYqxkajbqm5jZ0Y8HTEc45NNxUMs7V+SguYx5MQ13HOLmS4W8m6F/rEYOQHo9u1my4ruqBn8QdFgHMirt2CEtLyw=
X-Received: by 2002:a62:c141:: with SMTP id i62mr2223521pfg.64.1569564375309;
 Thu, 26 Sep 2019 23:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190926192603.18647-1-gayatri.kammela@intel.com> <CAHp75Vcrp2ffDCE=tm2dwSEhwfPCPWGhb-Nw0v-7ga2y=_dL8w@mail.gmail.com>
In-Reply-To: <CAHp75Vcrp2ffDCE=tm2dwSEhwfPCPWGhb-Nw0v-7ga2y=_dL8w@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 27 Sep 2019 09:06:04 +0300
Message-ID: <CAHp75VfwpYLVn2qWBMK11eR3D5VwnGf7VeYE=cQfq_y78ct75A@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Add Tiger Lake/Elkhart Lake support to pmc_core driver
To:     Gayatri Kammela <gayatri.kammela@intel.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        charles.d.prestopine@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        "David E . Box" <david.e.box@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 9:01 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Sep 26, 2019 at 9:43 PM Gayatri Kammela
> <gayatri.kammela@intel.com> wrote:
>
> Thank you for the series, I'll comment them later.
>
> For now, check how to properly setup prefix for all patches. The Title
> all broken.
>

On top of that the fully inconsistent SoC naming through the existing
code / new additions.

I'm pretty sure you need to spell platforms as Tiger Lake, Elkhart
Lake and so on everywhere.

Fix this, but do not send new version till I look at the code here.

> > Patch 1: Cleans up termination lines
> > Patch 2: Refactor driver for ease of adding new SoCs
> > Patch 3: Refactor debugfs entry for PCH IPs power gating status
> > Patch 4: Add Tiger Lake legacy support to pmc_core
> > Patch 5: Add Elkhart Lake legacy support to pmc_core
> >
> > All the information regarding the PCH IPs and names of IPs will be available
> > in *future* Intel's Platform Controller Hub (PCH) External Design Specification
> > (EDS) document.
>
> When?

-- 
With Best Regards,
Andy Shevchenko
