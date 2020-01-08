Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92825133DFE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 10:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbgAHJLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 04:11:41 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:40681 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgAHJLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 04:11:40 -0500
Received: by mail-il1-f196.google.com with SMTP id c4so2060833ilo.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 01:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HiScsc8fYkbMip54VqKL4tItZafxLw4MyIS0lizry60=;
        b=XPYFISJsNDUzYgwHeEMoJFqlPEIiLTOBdTkvNyofwoadgg/GUV/dDo1HHFG3rUUVkp
         wndVlaq1ZtGafLRqRBJNLLYxiLp1cpf57VYhuAjAGfOeITYvXdi1JnEatb+XfPt71e3k
         Do7g4faVMKhvLJdXsMbKxdXORFt6EQj12G23q5dtKKDj6F8yzJHo/CjgUCwNQrK5/Srq
         F7+W6ZQEwHSsw9y4Zlf84uWURfaQaomQgZ8FmNbXvO4hwzJF034AfGoopr4KHctaSIyn
         Ri4VpBWP8C+4X9AboNil+3eAUcRs/lIkLXn0/7U7igKwh/C4sFETUNdz5hxa0kzo7W1z
         8QAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HiScsc8fYkbMip54VqKL4tItZafxLw4MyIS0lizry60=;
        b=mUDcM1gqHlQ+uS158Kilvc+8dRkPm9Xq1mcsHlsoJzZ/JpDsNhZc3tL5beyJ2oXjYj
         Gkom+RADZllbH6a4d6CtzCdkwf77Z86jmO1b443iVT/WEPQqr/HIxSvrWBxFfpT3hjd1
         oiXhNhCyyH6EdAJQUBUCgyOebuMSTFEjKvufB7GeDELEH3a6AEIXJSS0Oxx7ol6bzaIS
         Ey2K1qxejuhiwKVxHpmfCEc4noU2DoM9E+zxYO5yDaJoq1nmaLvZ6IvikQKHl4JvNgI2
         OmZZwWjxVZtpg8MuNsb0K+WgfmxHF7M62VP7gHF5AYlVyH9oOOU8+XoQcH5GvAQEW1kP
         PHZg==
X-Gm-Message-State: APjAAAWlhVmphuefVdYh55S/IYLKDcl1VsWmdWAIQm07f0DjmH7EIYy3
        n9HQ3D5Vzx+RdlBzlJxKo7dWcnHwPMuOAmUZ+w==
X-Google-Smtp-Source: APXvYqycqsG0eMrRQQGBh8EYG3fuXU0BazufSoKErRf07lrU8ZdhdySYieu7jsFtB3vh/beU3vTCT06uZwGlWu61IUU=
X-Received: by 2002:a92:d98e:: with SMTP id r14mr2738722iln.15.1578474699660;
 Wed, 08 Jan 2020 01:11:39 -0800 (PST)
MIME-Version: 1.0
References: <20191217104637.5509-1-david@redhat.com> <c9be027b-a2a4-44b7-1eda-83a8fd0bf87a@redhat.com>
In-Reply-To: <c9be027b-a2a4-44b7-1eda-83a8fd0bf87a@redhat.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Wed, 8 Jan 2020 17:11:28 +0800
Message-ID: <CAFgQCTvp0rFo2TQqp1M1k3x5OPi-ND5LMFVv8WirHL6M4mHcUg@mail.gmail.com>
Subject: Re: [PATCH v1] mm/memory_hotplug: Don't free usage map when removing
 a re-added early section
To:     David Hildenbrand <david@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Dan Williams <dan.j.williams@intel.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Pingfan Liu <piliu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 8, 2020 at 4:24 PM David Hildenbrand <david@redhat.com> wrote:
>
>
> We have another reproducer that is used more frequently than memtrace :)
>
> Using Dynamic Memory under a Power DLAPR can trigger it easily.
> Triggering removal (I assume after previously removed+re-added) of
> memory from the HMC GUI can crash the kernel with the same call trace
> and is fixed by this patch.
>
> CCing Pingfan who verified that this patch fixes the issue - maybe he
> wants to provide a Tested-by:
Yes, this patch fixes the hot remove+add+remove bug on POWERVM, which
can be reproduced by dlpar.

Tested-by: Pingfan Liu <piliu@redhat.com>
>
> @Andrew, any chance we can get this upstream soon-ish? Thanks!
>
> --
> Thanks,
>
> David / dhildenb
>
