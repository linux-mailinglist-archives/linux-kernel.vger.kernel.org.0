Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 910E8108B3D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 10:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfKYJ5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 04:57:34 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:38615 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbfKYJ5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 04:57:33 -0500
Received: by mail-ua1-f65.google.com with SMTP id u99so4194823uau.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 01:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=npyab8aYxxLux0JRUK733Ht60e/4IF75r/XvwUY4q5g=;
        b=T5u1pfET1qVIZvkqwn861rrzWt3JpgaSvmbMndh+kJZaj53GP6XSkmxMDLU89RiaG5
         vfUqEWUgP482GU1cMbMwT1tc23cpnLcMLbs+LNDTSRx8hUPXe25ABb5tWWfUVXWVspxH
         NKJqHYPnk2KqHt6ZEm08wz7G+OpKEtO74t3LReEVJNX5PCLsmVX9wG0q40vvkjexXeSI
         jbSfljXWA3Alqar5gzCfqLpIg/3q3kFAupuvXGbaf8Sy4RVsNDhShpBHBXOa9gOu8TUN
         1kadBoO1A4FTVVi57u4XFCStR0WFCGTn9Q2X0FuoqlsYgPEWutl00lDmd53WgbKyLltd
         MX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=npyab8aYxxLux0JRUK733Ht60e/4IF75r/XvwUY4q5g=;
        b=OUa6s815aPgfuTi2JBsP0OUkJxpd3UibDxFoUZdBQib/COis7DvK/ls4SSFkP6/2O2
         vDb9HE3+DR2Z3G/j1urACT9WwOoUR+a5LHJ9WXEWdBv74+jSMqrwagCZ/fKOEGw1qexh
         bgSZWKEnvNcQklBNGXD3AYoP8GneODIn2cc1a7RUgfJV8NzNnkKPjaGzCPhKpueoeuqq
         q+DdMlIMmcMt9Rf+T7G69TD7EzhCs4HV98gruz/SREHnKaJ4VHcK6VrnjvQOuhEDTn7I
         n1CrCsOk0TSmas3oq34sLoLt0pUyTUQIIP9t5TYtvCZjSLgl2Wh1aRZGC7af65oYetU3
         oFzg==
X-Gm-Message-State: APjAAAU0sY2cyP6PKIOD05fJEJqtWBbW+fvJ03Hh9nLkdWaWH3JvmjZu
        QFdfqSTwnYtzqp0vQwMYtkh9wZd5Jl3Am8kxMEFiqg==
X-Google-Smtp-Source: APXvYqxWUuUDQt4N5TOS0389vJ3GuxnBsBigoWwOYjK0gHgDpi6Ynu7sMULHtzGCWGKYiJZPi+o3brmFyk0kTjg/uJQ=
X-Received: by 2002:a9f:3f46:: with SMTP id i6mr17435451uaj.60.1574675850866;
 Mon, 25 Nov 2019 01:57:30 -0800 (PST)
MIME-Version: 1.0
References: <20191123154303.2202-1-f.fainelli@gmail.com>
In-Reply-To: <20191123154303.2202-1-f.fainelli@gmail.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Mon, 25 Nov 2019 15:27:19 +0530
Message-ID: <CAHLCerPKQSLrgybYhhFDxjXu56BD+iAyz1OYF14rTbjotEkD7g@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: thermal: Eduardo's email is bouncing
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, eduval@amazon.com,
        Linux PM list <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 23, 2019 at 9:13 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> The last two emails to Eduardo were returned with:
>
> 452 4.2.2 The email account that you tried to reach is over quota.
> Please direct the recipient to
> https://support.google.com/mail/?p=OverQuotaTemp j17sor626162wrq.49 -
> gsmtp

Right, I've been seeing the same for the last week for all my postings.

Rui, will you please send the pull request to Linus for 5.5 (and going
forward) with all the contents of thermal/next[1]? Otherwise, the
thermal soc patches will unnecessarily miss the merge window. They've
been baking in linux-next for a while.

> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

[1] https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/log/?h=thermal/next



> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e4f170d8bc29..84e8bdae4beb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16085,7 +16085,6 @@ F:      drivers/media/radio/radio-raremono.c
>
>  THERMAL
>  M:     Zhang Rui <rui.zhang@intel.com>
> -M:     Eduardo Valentin <edubezval@gmail.com>
>  R:     Daniel Lezcano <daniel.lezcano@linaro.org>
>  R:     Amit Kucheria <amit.kucheria@verdurent.com>
>  L:     linux-pm@vger.kernel.org
> --
> 2.17.1
>
