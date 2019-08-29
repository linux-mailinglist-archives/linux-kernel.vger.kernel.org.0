Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6419DA2243
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 19:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfH2RaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 13:30:19 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34439 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbfH2RaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 13:30:19 -0400
Received: by mail-pf1-f193.google.com with SMTP id b24so2549448pfp.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 10:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9P0WfjoCbGsF0tCaY3AP3tO4MJYieVniooFn3hh+yRY=;
        b=R6DHywhlu0KnxK3bWoOttWC+abX6w+7G9ghMwCXGRYMvVBacXxaCDvEEaOrIDipSN8
         /GJy4+6HtLNdmt/Pc6RmJzqbl50J8FDDlHLjYworL1SBTQbobIZucCpjqHikuGWWULZv
         k7NGzCDng5CLqkj10dEAi1KHc/uMF5LtWUR3eU0B+mGF8fmSXUlOCLXogD1lsd3bIjEX
         DzjIq02pO8/cuzoSA5VG2Xqwq98VlxEl+a3DledCYCuurVZm6YI+vyyyUWJ5C4ptXG2e
         zMs2siK4erlxhMosre2ECcdbe19e55S9DNsLSYwQ8z8xbLh0/abOp3M3rRwekeBFEWBs
         eWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9P0WfjoCbGsF0tCaY3AP3tO4MJYieVniooFn3hh+yRY=;
        b=g7ZXvg4ZVP+rWpHj1BiOyuEapGOu/4W/tyJZ1H2oP+mqvS6O5vTjr0suwhpOIIdMSn
         3SKn7ankskK+IDmKO3DY3uEgfut8/tNRFXL5gK0TmwUMaOdHTK0g5Yisysqdi2O47BpT
         7UnuIO4DzxuxMAIl/LDsa6HqgiOWg0s6Exw45rzOiNroClXlq3n4fYMN2DFo1HRUomGZ
         ChMSbPbzHnWtAjUDqPw0YoNxA4FC+j3Dlxlzqu8b9iHTM8YB5JhRdoNJO8VAPiCNhdym
         S5CfxiKWjbNwbZg/7iPCsuZh+G/ysNzTeEjqITh36wntF+kwHpYFDfE4JCmcZLwwpHai
         gPdA==
X-Gm-Message-State: APjAAAXbXfGtwo0c56HVFV1t6mKM3+jle49qG+4feQzqSORYDY3np7Mk
        U9JvUopug6wWQy3QJxQ9Zja4c/rW5qOKhBJRqT3lj0crEf0=
X-Google-Smtp-Source: APXvYqwiXDAQvlk79yohuHj01mAp6kp0moEJ8mc8kjKdBi44BPXzEbkC+hlGqRbCYDApfshRC3Dhy9MbrwxGMDP405c=
X-Received: by 2002:a17:90a:9905:: with SMTP id b5mr8148612pjp.117.1567099818005;
 Thu, 29 Aug 2019 10:30:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190827003709.26950-1-skhan@linuxfoundation.org>
In-Reply-To: <20190827003709.26950-1-skhan@linuxfoundation.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 29 Aug 2019 10:30:06 -0700
Message-ID: <CAFd5g47jeZGqdhOUEOFGwHqHQ1O0=99Ce+bFhZ-7PCyFT1YO1Q@mail.gmail.com>
Subject: Re: [PATCH v2] doc: kselftest: update for clarity on running
 kselftests in CI rings
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     shuah <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dan.rue@linaro.org, anders.roxell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 5:37 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Update to add clarity and recommendations on running newer kselftests
> on older kernels vs. matching the kernel and kselftest revisions.
>
> The recommendation is "Match kernel revision and kselftest."
>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

One minor comment below.

> ---
> Changes since v1: Fixed "WARNING: Title underline too short."
>
>  Documentation/dev-tools/kselftest.rst | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
> index 25604904fa6e..308506c5e8fa 100644
> --- a/Documentation/dev-tools/kselftest.rst
> +++ b/Documentation/dev-tools/kselftest.rst
> @@ -12,6 +12,31 @@ write new tests using the framework on Kselftest wiki:
>
>  https://kselftest.wiki.kernel.org/
>
> +Recommendations on running kselftests in Continuous Integration test rings
> +==========================================================================
> +
> +It is recommended that users run Kselftest from the same release. Running
> +newer Kselftest on older kernels isn't recommended for the following
> +reasons:
> +
> +- Kselftest from mainline and linux-next might not be stable enough to run
> +  on stable kernels.
> +- Kselftests detect feature dependencies at run-time and skip tests if a
> +  feature and/or configuration they test aren't enabled. Running newer
> +  tests on older kernels could result in a few too many skipped/failed
> +  conditions. It becomes difficult to evaluate the results.
> +- Newer tests provide better coverage. However, users should make a judgement
> +  call on coverage vs. run to run consistency and being able to compare
> +  run to run results on older kernels.
> +
> +Recommendations:

I think this should be the "note" directive. You already have a list
of recommendations above; this seems like a TLDR section, or an
important note or tip.

> +
> +Match kernel revision and kselftest. Especially important for LTS and
> +Stable kernel Continuous Integration test rings.
> +
> +Hot-plug tests
> +==============
> +
>  On some systems, hot-plug tests could hang forever waiting for cpu and
>  memory to be ready to be offlined. A special hot-plug target is created
>  to run the full range of hot-plug tests. In default mode, hot-plug tests run
> --
> 2.20.1
>
