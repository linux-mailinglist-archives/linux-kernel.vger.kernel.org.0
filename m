Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE4CDA45F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 05:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395067AbfJQDpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 23:45:46 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:43189 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390324AbfJQDpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 23:45:45 -0400
Received: by mail-yb1-f193.google.com with SMTP id y204so256448yby.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 20:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qqAG5zLfngp0Y9W45g/OmRh5/iG/yT/9qLn4n6Unqk8=;
        b=v5afzdbrUk+KNxnH535CP89upFs4qZ6J7CXnNO8nPJh7CyQnlWeMPpvswJMs5Xdec2
         aR9L72byxia1HAt/xb4hmOpxMH4aDBjoIdFeE/6y060regR1g6f8GZhoXLhrE1W2r2KC
         mZrBvs7lTiXTKE9ZS7m6YGBBzEbfmanSkA01Nk4YUIqZlvxaYaMRJdc4LlucCPrpcVdE
         WPgYzAW2LxblMXrDdeLXRAToIZr3qi2tlW3c80TEbZhdooTqJFyGa4KFYEFCIIdfENFj
         vFHp4UqRY4dZmTdc5OeJPYvG1hNbES6417d2N1DqNaYT3YL233fjXijrHymLxkLOIH1e
         fNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qqAG5zLfngp0Y9W45g/OmRh5/iG/yT/9qLn4n6Unqk8=;
        b=R/PSllRtRRfP4toSZt1cI6pHccWq4Zx9tV36rbyDZJ1J5nQLxitpUK6pbaHRODui7f
         wYcP+BfUYq33ovyMkswXdsSqEk1ug48wXu63RvvD+evYSrSPen65/AepbUsgR/pvnKJy
         tggnnJAsfMLXxoediAUPedipfdG9bmErkDOypYf4pycPTyg6MzlycRPIYKedoCL0lQQv
         KBqQKmm/tvrhmONYvoZmJmszjVRrAlxOkwv3MNWpzzcSczJm0uXExY9XEhvZhJBDivWY
         5PzIbbcbV6JbhgU74nnXp2z7JGkGzkR220u8yhYaAszLUFkkwo7mgYpxc0HOPR3zj9L9
         uVJg==
X-Gm-Message-State: APjAAAX++Z6VS2lR5y63fAxHxqBIwX+P+eoP+EUMRe+l8kO9RGVK0FO9
        lc12zWu/j+GLXO1kJQm600wgwHQbanvBB27nkDbCXA==
X-Google-Smtp-Source: APXvYqwI7C8T+z1xB43hCUFEP5SPIEvBwe8hBhtXGvmI8gDBl6iM3l8J/5maNtLGeK4hpa4mpTiaJmYVPEtc+lPlCSo=
X-Received: by 2002:a25:c883:: with SMTP id y125mr751178ybf.358.1571283944468;
 Wed, 16 Oct 2019 20:45:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191016221148.F9CCD155@viggo.jf.intel.com>
In-Reply-To: <20191016221148.F9CCD155@viggo.jf.intel.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 16 Oct 2019 20:45:33 -0700
Message-ID: <CALvZod5wdToX6bx4Bnwx9AgrzY3xkmE0OMH61f88hKxeGX+tvA@mail.gmail.com>
Subject: Re: [PATCH 0/4] [RFC] Migrate Pages in lieu of discard
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Adams <jwadams@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 3:49 PM Dave Hansen <dave.hansen@linux.intel.com> wrote:
>
> We're starting to see systems with more and more kinds of memory such
> as Intel's implementation of persistent memory.
>
> Let's say you have a system with some DRAM and some persistent memory.
> Today, once DRAM fills up, reclaim will start and some of the DRAM
> contents will be thrown out.  Allocations will, at some point, start
> falling over to the slower persistent memory.
>
> That has two nasty properties.  First, the newer allocations can end
> up in the slower persistent memory.  Second, reclaimed data in DRAM
> are just discarded even if there are gobs of space in persistent
> memory that could be used.
>
> This set implements a solution to these problems.  At the end of the
> reclaim process in shrink_page_list() just before the last page
> refcount is dropped, the page is migrated to persistent memory instead
> of being dropped.
>
> While I've talked about a DRAM/PMEM pairing, this approach would
> function in any environment where memory tiers exist.
>
> This is not perfect.  It "strands" pages in slower memory and never
> brings them back to fast DRAM.  Other things need to be built to
> promote hot pages back to DRAM.
>
> This is part of a larger patch set.  If you want to apply these or
> play with them, I'd suggest using the tree from here.  It includes
> autonuma-based hot page promotion back to DRAM:
>
>         http://lkml.kernel.org/r/c3d6de4d-f7c3-b505-2e64-8ee5f70b2118@intel.com
>
> This is also all based on an upstream mechanism that allows
> persistent memory to be onlined and used as if it were volatile:
>
>         http://lkml.kernel.org/r/20190124231441.37A4A305@viggo.jf.intel.com

The memory cgroup part of the story is missing here. Since PMEM is
treated as slow DRAM, shouldn't its usage be accounted to the
corresponding memcg's memory/memsw counters and the migration should
not happen for memcg limit reclaim? Otherwise some jobs can hog the
whole PMEM.

Also what happens when PMEM is full? Can the memory migrated to PMEM
be reclaimed (or discarded)?

Shakeel
