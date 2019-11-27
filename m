Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB3410B615
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 19:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfK0Stn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 13:49:43 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:39167 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbfK0Stm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 13:49:42 -0500
Received: by mail-yw1-f65.google.com with SMTP id d80so8758898ywa.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 10:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r3ff0oEMPrKsvGQAQbzQJPKBhFAz5tFijRxx3moqVQc=;
        b=CVIt8cRX04Mpwo8iKytQDTLgZ0a9fsrDacYqFSEI3gly4KYkL5Nn0uBWeJprxRX5fA
         3oLvPsCJAYT2E9ky4tn+U0zcnjLd+VcGdTbviM4NWvxZI+feU9sn5sBva08ejwXxPdza
         TFCAPgRHxlO2qpBuAnyc96+47ney7GFcd/q3uea7j6sBcuU4WrHIbp1huKvfv1+tHFFC
         6d1ESunZEG9FFoU9r20XxC7hbuYw3Ena4aO0j17oPEypqhcqiSFClc9XF0abo+6gUNSx
         zIoQa+bCkJedHtlwqkXVVMgB5mL6VC2NJJ1/C41DfCSXoRizoDRLrSGOHRQF8ZFDE0lB
         d1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r3ff0oEMPrKsvGQAQbzQJPKBhFAz5tFijRxx3moqVQc=;
        b=XSxp2RiSJbKHTvtLg4dEGf7VMhd7D6pdZP+DWZ5/LzRe2z/N0BhRNh4EDAhQWSuUPc
         ZNWQ85DB+9IWHq29D7PhAvEiRoMUNKrca5iE8Q528F+4NEnE9m/5PF4Dkt0BWaGuBP77
         qIgUZH1jfQDIMBQpCKTvuG8bmucwBzJJMyPsb5v4QLSuQ5IUt7aLrTd/nmStwGYusLMg
         8qSjQaJ3E3lpCUa1iK5f/+7C4emYVIVNxF2eC3mhwDzKxcXgnQTbmQqX76a6MrIDFEfP
         1QaqzZwurR8i8XXICH3yQIVBRieAvVaTYm298YbKBsBi9Mb7fv+MLWjraGU5e5O3Gqfa
         xIfw==
X-Gm-Message-State: APjAAAX7x3GYQl6L31kevzuimmyRk5Yf49Kda6cWp3udKVTaw1qwJrqn
        tNO2R57a6kuQ0vWxKPZh8OTPhRq/BD9bxFb+l4pC9A==
X-Google-Smtp-Source: APXvYqzsMTnZLuyK9GuWs3tCsWCUrOAKxE6W3mzOd5tQm22PHAw+LVNBkVf1Q+ByMGIG76U78ZbnTthen2UxytsMsSw=
X-Received: by 2002:a81:4d89:: with SMTP id a131mr3907027ywb.159.1574880580894;
 Wed, 27 Nov 2019 10:49:40 -0800 (PST)
MIME-Version: 1.0
References: <20191126235913.41855-1-irogers@google.com> <20191127152328.GI22719@kernel.org>
 <20191127160558.GM22719@kernel.org>
In-Reply-To: <20191127160558.GM22719@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 27 Nov 2019 10:49:29 -0800
Message-ID: <CAP-5=fVhXvMFtGU18-TMt29BsuZNySZ8sPvj_3r7GGsfZLPvuA@mail.gmail.com>
Subject: Re: [PATCH] perf jit: move test functionality in to a test
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>, Leo Yan <leo.yan@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 8:06 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Wed, Nov 27, 2019 at 12:23:28PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Tue, Nov 26, 2019 at 03:59:13PM -0800, Ian Rogers escreveu:
> > > Adds a test for minimal jit_write_elf functionality.
> >
> > Thanks, tested and applied.
>
> Had to apply this to have it built in systems where HAVE_JITDUMP isn't
> defined:

Thanks for fixing this!
Ian

> diff --git a/tools/perf/tests/genelf.c b/tools/perf/tests/genelf.c
> index d392e9300881..28dfd17a6b9f 100644
> --- a/tools/perf/tests/genelf.c
> +++ b/tools/perf/tests/genelf.c
> @@ -17,16 +17,15 @@
>
>  #define TEMPL "/tmp/perf-test-XXXXXX"
>
> -static unsigned char x86_code[] = {
> -       0xBB, 0x2A, 0x00, 0x00, 0x00, /* movl $42, %ebx */
> -       0xB8, 0x01, 0x00, 0x00, 0x00, /* movl $1, %eax */
> -       0xCD, 0x80            /* int $0x80 */
> -};
> -
>  int test__jit_write_elf(struct test *test __maybe_unused,
>                         int subtest __maybe_unused)
>  {
>  #ifdef HAVE_JITDUMP
> +       static unsigned char x86_code[] = {
> +               0xBB, 0x2A, 0x00, 0x00, 0x00, /* movl $42, %ebx */
> +               0xB8, 0x01, 0x00, 0x00, 0x00, /* movl $1, %eax */
> +               0xCD, 0x80            /* int $0x80 */
> +       };
>         char path[PATH_MAX];
>         int fd, ret;
>
> @@ -48,6 +47,6 @@ int test__jit_write_elf(struct test *test __maybe_unused,
>
>         return ret ? TEST_FAIL : 0;
>  #else
> -       return TEST_SKIPPED;
> +       return TEST_SKIP;
>  #endif
>  }
>
>
