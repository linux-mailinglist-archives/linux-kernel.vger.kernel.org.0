Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15BED1287EC
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Dec 2019 08:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfLUHUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Dec 2019 02:20:17 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42925 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfLUHUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 02:20:16 -0500
Received: by mail-wr1-f66.google.com with SMTP id q6so11447593wro.9;
        Fri, 20 Dec 2019 23:20:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GywF7hpm0/dzsa2CyX8WxaKmTQoSpmQVCaCVcl0JsgY=;
        b=m1rWjIm1zv+TPHVG5luAzjJ4XV994PqEzgp1o+fRrqoNfGwuoJOoKqQWUp/LVaNdIZ
         y44qi/mmnpbQEnA3GNvbYjCoOVZVm6gkDdi3b/vF+bCzNOiPP3hV3ywvbTLds/NS9+np
         SOG5iwDgUsAQVxTgO+JtD44UXE6B2wXMkneInhd3+FrVVwebBRLrVclIJkQg6hxoD6PG
         0+2h+N+QT6BNqjWcwcBwwxeF4FuQ+XsQuqUbIgamIktaRPSWAqoapA9GoJkZdK1AHqeW
         a+vtTGQjcHMvoTcEngI4WBzuwMr5xA0E9kKcsVXru9f57ulupg4+h7+jnWzJzqv8SB3i
         ndzg==
X-Gm-Message-State: APjAAAWmnfMGwQIiWtZYfVk8GeipKWGB+gvv0twf1azr9bEKiUMJexqa
        OfXhNZ/rPRNI1VOknh174oZqaKvap3bB/tvDSyE=
X-Google-Smtp-Source: APXvYqxKsrgYjxgKHC9sN3K8piDF335qujBGar5nGxOQZTS0N0vJixeEXt3FncEoWGWYBmM7jcMarwqNv2JCV+33ruc=
X-Received: by 2002:adf:ef10:: with SMTP id e16mr18355776wro.336.1576912814619;
 Fri, 20 Dec 2019 23:20:14 -0800 (PST)
MIME-Version: 1.0
References: <20191217144828.2460-1-acme@kernel.org> <20191217144828.2460-7-acme@kernel.org>
 <CAM9d7ciL-Qnm5v3Tn1rsrNzW3mTWx5HY6W5XBU1MKnLQ7YBdkw@mail.gmail.com> <20191220121723.GC2032@kernel.org>
In-Reply-To: <20191220121723.GC2032@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 21 Dec 2019 16:20:02 +0900
Message-ID: <CAM9d7cih8nwWcCd4Pwf+5oYS4jYy9U_=7hY0f6T2R3e1kYDGsA@mail.gmail.com>
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

On Fri, Dec 20, 2019 at 9:17 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Dec 20, 2019 at 03:48:23PM +0900, Namhyung Kim escreveu:
> > On Tue, Dec 17, 2019 at 11:49 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > As a convenience, equivalent to pressing Enter in a line with a kernel
> > > symbol and then selecting "Zoom" into the kernel DSO.
>
> > We already have 'd' key for 'zoom into current dso'.
>
> Right, current DSO, 'k' is equivalent to:
>
> 1. Navigate to a kernel map entry
> 2. Press 'd'
>
> And also to:
>
> 1. Navigate to a kernel map entry
> 2. Press ENTER
> 3. Navigate to "Zoom into Kernel DSO"
> 4. Press ENTER
>
> One key versus 2 or four.
>
> > Do you really want 'k' for kernel specially?
>
> I thought kernel hackers would like the convenience, doing:
>
>   perf top + k
>
> To get the main kernel samples looks faster than:
>
>   perf top -e cycles:k
>
> And those are not even equivalent, as cycles:k will show everything in
> ring 0, while 'perf top + k' will show just what is in the kernel _and_
> in the main kernel map.

I'm fine with adding 'k' key itself, but I thought a bit strange when
it suggests kernel even with user DSOs.

Thanks
Namhyung
