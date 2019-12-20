Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20ACD1275DB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 07:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfLTGsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 01:48:38 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34606 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfLTGsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 01:48:37 -0500
Received: by mail-wm1-f65.google.com with SMTP id c127so1001670wme.1;
        Thu, 19 Dec 2019 22:48:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x5VYy9uCJgZvV/4DqhEVKEHsRsAj+gp4RvlZvP4LNXM=;
        b=XusmGr6mD8A/atVxCoD9FIgPAphpew3Xw0APtGmPxKKyGiAvPRsZWvc/Dd0ucfRh+m
         rdc2l/DCEt5r1gKCj3/ZVxvsZOijUqQ4uWsdUSzc8dcJ6e5oebnApP4wJgWtgdIi0eSV
         a5eQljqOhIB9e9zcJaIxYLfLvEJizeH2GfcvHBKU6EdUr+TmyTOoYMexFTpsYRYpOCd5
         AkXQZgOaPzSRcO+2BpPclV0S6zPlM0EAvKYLbJVmjnxtYpsMONU1HeSrIZcTdRgJKfTN
         NM08xDhHPz29MvW+DQW/MDmQRdXMx+2l6WDk/EZlD4Q9koRxozuqQLX5tMXkHnhHzMJG
         H8Iw==
X-Gm-Message-State: APjAAAVlAzpKvAxyaHlb4rAGZ4sU1Hw1SUWWfHgRW/c3ppBrTSM2YNzw
        gaftYrvXRXWXO3Uqoka2yM5sYjoW1br6HY9+mVs=
X-Google-Smtp-Source: APXvYqz+qnC9RYTeTZznuKgtJlRV9ibANez0kw/toiOT7bM0zDbsMnYpNiq/41HP4T3todHU8P7ZKgzuSlWWnnjHFks=
X-Received: by 2002:a7b:c757:: with SMTP id w23mr13377799wmk.166.1576824515159;
 Thu, 19 Dec 2019 22:48:35 -0800 (PST)
MIME-Version: 1.0
References: <20191217144828.2460-1-acme@kernel.org> <20191217144828.2460-7-acme@kernel.org>
In-Reply-To: <20191217144828.2460-7-acme@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 20 Dec 2019 15:48:23 +0900
Message-ID: <CAM9d7ciL-Qnm5v3Tn1rsrNzW3mTWx5HY6W5XBU1MKnLQ7YBdkw@mail.gmail.com>
Subject: Re: [PATCH 06/12] perf report/top: Add 'k' hotkey to zoom directly
 into the kernel map
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Tue, Dec 17, 2019 at 11:49 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> As a convenience, equivalent to pressing Enter in a line with a kernel
> symbol and then selecting "Zoom" into the kernel DSO.

We already have 'd' key for 'zoom into current dso'.
Do you really want 'k' for kernel specially?

>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Jin Yao <yao.jin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@intel.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lkml.kernel.org/n/tip-vbnlnrpyfvz9deqoobtc3dz7@git.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/ui/browsers/hists.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> index 8aba1aeea0eb..6dfdd8d5a743 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -18,7 +18,9 @@
>  #include "../../util/evlist.h"
>  #include "../../util/header.h"
>  #include "../../util/hist.h"
> +#include "../../util/machine.h"
>  #include "../../util/map.h"
> +#include "../../util/maps.h"
>  #include "../../util/symbol.h"
>  #include "../../util/map_symbol.h"
>  #include "../../util/branch.h"
> @@ -2566,7 +2568,7 @@ add_dso_opt(struct hist_browser *browser, struct popup_action *act,
>         if (!hists__has(browser->hists, dso) || map == NULL)
>                 return 0;
>
> -       if (asprintf(optstr, "Zoom %s %s DSO",
> +       if (asprintf(optstr, "Zoom %s %s DSO (use the 'k' hotkey to zoom directly into the kernel)",

Wouldn't it be better suggesting 'd' key instead?

Thanks
Namhyung


>                      browser->hists->dso_filter ? "out of" : "into",
>                      __map__is_kernel(map) ? "the Kernel" : map->dso->short_name) < 0)
>                 return 0;
> @@ -2936,6 +2938,7 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
>         "E             Expand all callchains\n"                         \
>         "F             Toggle percentage of filtered entries\n"         \
>         "H             Display column headers\n"                        \
> +       "k             Zoom into the kernel map\n"                      \
>         "L             Change percent limit\n"                          \
>         "m             Display context menu\n"                          \
>         "S             Zoom into current Processor Socket\n"            \
> @@ -3033,6 +3036,10 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
>                         actions->ms.map = map;
>                         do_zoom_dso(browser, actions);
>                         continue;
> +               case 'k':
> +                       if (browser->selection != NULL)
> +                               hists_browser__zoom_map(browser, browser->selection->maps->machine->vmlinux_map);
> +                       continue;
>                 case 'V':
>                         verbose = (verbose + 1) % 4;
>                         browser->show_dso = verbose > 0;
> --
> 2.21.0
>
