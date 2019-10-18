Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6A9DCF31
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 21:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505948AbfJRTR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 15:17:56 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41525 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388138AbfJRTRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 15:17:55 -0400
Received: by mail-lj1-f193.google.com with SMTP id f5so7299097ljg.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 12:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gfI0AJSthc554vKx2lGALI0At1GBVKK3lR5urVM2u5o=;
        b=VgncGr5yjc//ouu/7v1mSUHDd6fZju6z/Ht4L7uJcHz8C5ZjHqzHf/QU+HEdUYxEO2
         0wbGYwcxszbE4giQskHtZ5f0P2usEjfcHedLpFS+fuP/DSwO6J6N7ZCr6xa/ushP5O/t
         SIhcZZVoAesRsxU+OQYIUywvth6XYUmMSzw1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gfI0AJSthc554vKx2lGALI0At1GBVKK3lR5urVM2u5o=;
        b=l0kCWVC1VWWIUa9n/BkDMDQTTA18N7atfCL77cVCsvoRhNlH5tT3yyZxu4jU5Hlt0U
         ETUCwFUAIePEFMSDVnhhVSlJSuE9jqELjcyvRXkS9m4ujVTemrHgWfa6RWT47tNu99iM
         4XxATepXRi9XzPGAmFxtWkSp9bY0A+glIEzPGH7soDgzhaCE3A/OzGnegNq9zMsbWOcS
         cLJADe2QpMlJSddYKE7GinqDZLtmv2+ed6sqbHzTs6GLIVIGDOwdtuPj1+B75mKCURzx
         +IYO7XFKHkA+SAKzHhdZ89Eb5RUOfJ12QDzvPib60w0J0Ln3VUxChOF8fkA2J9OpjA2d
         QnBQ==
X-Gm-Message-State: APjAAAWZz0MSrmUmcg4EJ+Yg5OUjZzzMbVdj3TfV/BxGuZVqcF137OGn
        hi8kmPLy0Nrzp7gmHx76xQ+X0aBC12g=
X-Google-Smtp-Source: APXvYqzRDk2Ndpvq2BX25IA5cqar/G5GbneAmsteBFeHpoBSFUocWcpsUCuuam2ccyE5TgSTzkKFbA==
X-Received: by 2002:a2e:1214:: with SMTP id t20mr7068307lje.191.1571426272164;
        Fri, 18 Oct 2019 12:17:52 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id m21sm2761335lfh.39.2019.10.18.12.17.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2019 12:17:51 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id v8so4929418lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 12:17:50 -0700 (PDT)
X-Received: by 2002:a19:f709:: with SMTP id z9mr7071645lfe.170.1571426270371;
 Fri, 18 Oct 2019 12:17:50 -0700 (PDT)
MIME-Version: 1.0
References: <20191017234348.wcbbo2njexn7ixpk@willie-the-truck>
 <CAHk-=wjPZYxiTs3F0Vbrd3kRizJGq-rQ_jqH1+8XR9Ai_kBoXg@mail.gmail.com> <20191018174153.slpmkvsz45hb6cts@willie-the-truck>
In-Reply-To: <20191018174153.slpmkvsz45hb6cts@willie-the-truck>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Oct 2019 12:17:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=whmtB98b8=YL2b8HzPKRadk2A9pL0aasmvgebhePrDP9w@mail.gmail.com>
Message-ID: <CAHk-=whmtB98b8=YL2b8HzPKRadk2A9pL0aasmvgebhePrDP9w@mail.gmail.com>
Subject: Re: [GIT PULL] arm64: Fixes for -rc4
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel Mailing List 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 10:42 AM Will Deacon <will@kernel.org> wrote:
>
> Thanks, that's helpful to know for next time. I guess I'm most surprised by
> the discrepancy between the shortlog and the diffstat, whereas I intuitively
> expected them to be generated in the same way.

So logs and diffs are fundamentally different.

A log is an operation on a _set_ of commits (that's the whole point -
you don't list the beginning and the end, you list all the commits in
between), while a diff is fundamentally an operation on two end-points
and shows the code difference between those two points.

And the summary versions of those operations (shortlog and diffstat)
are no different.

So as a set operation, "shortlog" has no issues with multiple merge
bases. Doing a shortlog is still just a set difference between your
commits and the upstream commits, and the number of merge bases is
irrelevant. "List all commits that I have, but upstream doesn't have"
is a very straightforward and natural set operation.

But as a "two endpoints" operation, diffstat has real problems any
time you have more than two endpoints - when you have multiple merge
bases, you fundamentally have more than two endpoints: you have all of
the merge bases, and then you have your end result.

What you doing the merge does is to turn the multiple merge bases into
just one point: the thing you merged against now becomes the common
merge point, and now you have a "two endpoints" for the diffstat: the
thing you merged against, and your end result are now the two points
that you can diff against.

But the shortlog is always correct, because it just doesn't even care
about that whole issue.

                Linus
