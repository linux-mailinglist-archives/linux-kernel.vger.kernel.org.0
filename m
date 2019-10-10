Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1A80D2004
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 07:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732252AbfJJF3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 01:29:32 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32989 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfJJF3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 01:29:32 -0400
Received: by mail-pl1-f196.google.com with SMTP id d22so2220516pls.0;
        Wed, 09 Oct 2019 22:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ux0oG1N3RPh/ZQT3Rg4tacx00lUapXz9BDpB0CV0W4=;
        b=O2OVnJzNFrJ4T2mCO2MB48G0Ac2WW826iVZ4FxX5BR3EpPRSRpzRbzB+XLa98KIKmy
         PXZsCDZVW6f9jW6c0LpJ9b1rQ04RiZlYK1FWVx+bbq4dappg5kqZcu87EvlzpsAJTqv+
         fvI96b6MnAYXjMdVnkWOL1sznL95gFO7l6BV/OlEbchIlCKvufZeKkyCiw1B13oo1rac
         J+vWB9QYBgGFyw5Dy4R0eirHfEBpF5y7ujD88NOkcmnFJFf0PsPgLXo5s56YkZyW/O4i
         OA3e6D7AaAtJBwzybvI1BmlEYLsQITadG7H9bMlOdppegK4On8WWMOGvkjMs1wSoOkOK
         VwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ux0oG1N3RPh/ZQT3Rg4tacx00lUapXz9BDpB0CV0W4=;
        b=R3A+ULQDPXtpvexCUTmk5MVBvS+JVojknPkoK4lqujpqAzhhtUyfs9rpZJW8wQ0KyL
         mMUKf0F25zbjCjBY5l/86gnm7sdDm9QjngKQsmue+qbTn0s10W0gmOYESmPEUtvNyxGg
         Oa4syR2yh+z1SwQh5fViwsgjxUj9W5Phkoyr7yu9DofNHo9VnlaS8I/L/FXwExAo4IV+
         TGaArkZCmLuQ0B6YQriKMIUHH2BF5uA6e4quSQ1I+dFtd368v1MVpoDDKFCol06T7Tk9
         XH+MwgEwzPdbsppMisdWQVOFyxPx/0YO9yDit7Bsind84gBndmgUJCP8f4eRSyDwV03x
         QUig==
X-Gm-Message-State: APjAAAWZwwDagfeC8NxUrLhwSMSNRqBefWhDDnTuUBK2s9A6D73TGKnD
        oPKh+FrPa7x+7J6IqBCB4SPL08lhOECtdUiWc4c=
X-Google-Smtp-Source: APXvYqzv7mMh81TeLXJfwEeV8BIqtzZVWD0xJ38JFShd32ro1039ZqQR+74Cz3UwLuuXrwsi0d3U1aS/sCYUjZT4Zc8=
X-Received: by 2002:a17:902:9881:: with SMTP id s1mr7620856plp.18.1570685370251;
 Wed, 09 Oct 2019 22:29:30 -0700 (PDT)
MIME-Version: 1.0
References: <75f70e5e-9ece-d6d1-a2c5-2f3ad79b9ccb@web.de> <20191009110943.7ff3a08a@gandalf.local.home>
 <ce96b27e-5f7b-fca7-26ae-13729e886d46@web.de>
In-Reply-To: <ce96b27e-5f7b-fca7-26ae-13729e886d46@web.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Oct 2019 08:29:18 +0300
Message-ID: <CAHp75VdrUg6nBfYV-ZoiwWhu6caaQB8-FCSeQFH0GrBX33WhVg@mail.gmail.com>
Subject: Re: string.h: Mark 34 functions with __must_check
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        kernel-janitors@vger.kernel.org, kasan-dev@googlegroups.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 9, 2019 at 11:11 PM Markus Elfring <Markus.Elfring@web.de> wrote:
>
> > I'm curious. How many warnings showed up when you applied this patch?
>
> I suggest to take another look at six places in a specific source file
> (for example).
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/test_kasan.c?id=b92a953cb7f727c42a15ac2ea59bf3cf9c39370d#n595

The *test* word must have given you a clue that the code you a looking
at is not an ordinary one.

-- 
With Best Regards,
Andy Shevchenko
