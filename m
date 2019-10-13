Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86253D56FC
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2019 19:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbfJMRP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Oct 2019 13:15:28 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:43628 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728839AbfJMRP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 13:15:28 -0400
Received: by mail-yb1-f193.google.com with SMTP id y204so4718843yby.10;
        Sun, 13 Oct 2019 10:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gflEvZAdlyCc3lXLfYTtPLGbYV/+oYzt0UfZcGg1SRc=;
        b=DFsPt8BzI4LOt34+GKO4D1RtpzCwr4ftOt/zQlrzs8hfl4A+eFtHEudqIZHR8G+/n7
         oqWP/LWM0CjJoCgNoVK0X+Rqw6kKfntZ9D67fGM54XkdTt9SgvjPc/5z2tGi+i9udlMc
         rqgygl73MTquALDXMS5H634MdCg2Pua6T5L7EHRVCpqcV7HMlHD4dt1atCpAlUkunX67
         HcQIwwzjqEealsCKIYDr90Gt2wt1fSQvNJvXRY0qXFKf+MeWkPmO+hnRR55hdcePJlLq
         rNQeBFFU7HkJiUEaLDYFja4yrU9a4nMJPNzMpLzbkC5Y5igN9G2ko54KjBQVF5XEEiV6
         Ee0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gflEvZAdlyCc3lXLfYTtPLGbYV/+oYzt0UfZcGg1SRc=;
        b=smhHuwQ9YKV3+VTmoM76euCHBYfI+vh6DGkws5v1uhegl3x6MBn9yyKxMKSKsNvSWB
         I9YIX1EG+P5fH467jZUAs8/F8z/KmthNUuoquot5+BZfEy4QtJOX/LH6TVBUVk97EbyD
         dIqzAzdkMvZdaX27XdgFnF5hUzLDDTTFH0Zem0gXacajd+19O2CTgyYKY+NdJefAQrnk
         rR0k1Rt1/rHaJckHvgRNLq3hMd36gW0e+zrWLfEhXURExiQyAAvh3q5StzxkRxDDz4b0
         twqMnDqYBTMjbFEfl79WOMT0DSh/vV4GummwJ5qjES/a4jXxmDqZBqdPpTTCVSRLi4iE
         xsww==
X-Gm-Message-State: APjAAAW86y9rw/ry0pmXHK0VgiXaJLs9AfthH8E9mxWr+dBfV0XYRChP
        eSVAV2/5d8UE4QKrVsvt5yA3PnXhbtbdpfi7A9WLrg==
X-Google-Smtp-Source: APXvYqyoqY6djIDs11lNlZUqHE2uaqTuE1ISh1U5NTd/2aKUiibYIuXB+JkUurqHKYtLENb3M6EjLhTYEPoyTC736lc=
X-Received: by 2002:a25:7909:: with SMTP id u9mr18735821ybc.33.1570986926762;
 Sun, 13 Oct 2019 10:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190830125436.16959-1-ganapat@localhost.localdomain>
In-Reply-To: <20190830125436.16959-1-ganapat@localhost.localdomain>
From:   Ganapatrao Kulkarni <gklkml16@gmail.com>
Date:   Sun, 13 Oct 2019 22:45:15 +0530
Message-ID: <CAKTKpr43RyG0fTp3nOQP--F80JYD1aCHEU5TJNZCK8LPCLfswQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Add CCPI2 PMU support
To:     linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
        Robert Richter <rrichter@marvell.com>,
        Jan Glauber <jglauber@marvell.com>,
        Ganapatrao Kulkarni <gkulkarni@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will, Mark,

On Fri, Aug 30, 2019 at 6:24 PM ganapat <gklkml16@gmail.com> wrote:
>
> From: Ganapatrao Kulkarni <gkulkarni@marvell.com>
>
> Add Cavium Coherent Processor Interconnect (CCPI2) PMU
> support in ThunderX2 Uncore driver.
>
> v5:
>         Fixed minor bug of v4 (timer callback fuction
>         was getting initialized to NULL for all PMUs).
>
> v4:
>         Update with review comments [2].
>         Changed Counter read to 2 word read since single dword read is misbhehaving(hw issue).
>
> [2] https://lkml.org/lkml/2019/7/23/231
>
> v3: Rebased to 5.3-rc1
>
> v2: Updated with review comments [1]
>
> [1] https://lkml.org/lkml/2019/6/14/965
>
> v1: initial patch
>
>
> Ganapatrao Kulkarni (2):
>   Documentation: perf: Update documentation for ThunderX2 PMU uncore
>     driver
>   drivers/perf: Add CCPI2 PMU support in ThunderX2 UNCORE driver.
>
>  .../admin-guide/perf/thunderx2-pmu.rst        |  20 +-
>  drivers/perf/thunderx2_pmu.c                  | 267 +++++++++++++++---
>  2 files changed, 245 insertions(+), 42 deletions(-)
>
> --
> 2.17.1
>

Any comments on this patchset?

Thanks,
Ganapat
