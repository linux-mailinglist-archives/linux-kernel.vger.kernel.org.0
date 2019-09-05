Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEDAA977A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 02:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbfIEAGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 20:06:02 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37554 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbfIEAGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 20:06:02 -0400
Received: by mail-lf1-f67.google.com with SMTP id w67so438954lff.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 17:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UKFQLjmhKUsCsbQHzitLXQ7E0/G2C84MFI2s1l5ssbo=;
        b=PkpqjHV3cWlSkoLNkFq83xwqGXwh0qSy11RRVDSxEPQtR/mnEAKd4pAZpIQs4ADhV3
         hUGYlwsLaPIPUJcqsRLFumBCJpm3sieQmqTgqIRVIjNB2dzxD39NUHSHJOv2MZAoHura
         sJQl+WInqpQk8gCuIqYWbgDPKwBMf7DLJNGk85UuwSmsld/skzCbev15POmGrPRNLA6c
         6xhjqwvbEtREuww0dp6j65msVGqzI154Kb+No1dmCg1/vQI5hS1dEa/lOjaZmtJuODD0
         J5dNvTAyA7AuM+ehvzBNpY7yosVsZE0XP6Tzqam0vIQ/bHninz/aFeO5g+6G3w+GxxSq
         8/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UKFQLjmhKUsCsbQHzitLXQ7E0/G2C84MFI2s1l5ssbo=;
        b=H2taEFheRsoUp6kPzi0lP3u/eUm54+yCrX1kD7V388C9QgOrn+h448MOb0FZ1ub3Rr
         ylRlul6/R9Suhc58dwySkb2OByusVpQvlrNF9TWK8twRjluHhyzMKVYnF9DCkRpQzVES
         VbMnq7IhgSy/4KQo7w7n379aVsYNgscAWZef5lY2RBA85zEv4GrLQnAAwuNVPSTywyjV
         epA71/lYERVnQ1D0BPYNynvCczwzeiaAeF41Sse29C9pQCU/qOVbfbcLLZK1vvC8hHLg
         NTCjBIpnylMf9Tqd7MGS4hknSzWMmjGt5p39wgjVsHF4a504bi1qNjrbiqFkhZqa/N6Z
         WZ5Q==
X-Gm-Message-State: APjAAAXEzwcQZ6krtkcCQxn8SpDG9Al7UvG2Y7GiHuH5dx3CJZb8Lr8G
        vHjCZ34+EOdy8e0GhP5GYV5yxxZVfXtl9alTqblRQBX3
X-Google-Smtp-Source: APXvYqxwoT+YbK63CE4fWL5dszSDI22IQ15S8zuMrB1APRjFlTEzPpJZ68PLExfAE7IF3esMXLCmsGrBMGBZUIKuOYw=
X-Received: by 2002:ac2:4902:: with SMTP id n2mr449836lfi.0.1567641960000;
 Wed, 04 Sep 2019 17:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190904182949.GA22025@gmail.com> <6806d25a240cd80ebd265fcf5f02496852027bed.camel@perches.com>
In-Reply-To: <6806d25a240cd80ebd265fcf5f02496852027bed.camel@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 5 Sep 2019 02:05:49 +0200
Message-ID: <CANiq72nVtTa17pnOhKKjx6NY3eYjU5FcXcN4MxFJkwkwV3+ghQ@mail.gmail.com>
Subject: Re: [GIT PULL] clang-format for v5.3-rc8
To:     Joe Perches <joe@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 5, 2019 at 1:35 AM Joe Perches <joe@perches.com> wrote:
>
> It's a long, long list.
>
> $ git grep -P -h '^\s*#\s*define\s+\w*for_each\w*' | \
>   grep -P -oh '\w+for_each\w*' | sort | uniq | wc -l
> 491
>
> Isn't there some way to regexes or automate this?
>
> Maybe just:
> $ git grep -P -h '^\s*#\s*define\s+\w*for_each\w*' | \
>   grep -P -oh '\w+for_each\w*' | sort | uniq > somefile...

The command I use is in the file, I re-run it every once in a while.
Ideally we could run this somehow automatically every -rc (for
instance), e.g. Linus could have it in his release script or something
like that, or maybe at the end of the merge window.

Even being more idealistic, clang-format could somehow do this itself
keeping a cache somewhere.

Cheers,
Miguel
