Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3B23D6C84
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 02:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfJOAfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 20:35:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46994 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfJOAfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 20:35:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id o18so21571424wrv.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 17:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=H0h0q5lLAzUoy9cBuMGbtr54Sbs+2ULezMokzPte9Nk=;
        b=MfONyGZofmCabL6fJTkC2fhGIH6ZMJGt18S/2DunfwsZk8iALKO6fKMzMK1wBBxwDT
         4Wwgjq7z6y514JIzd6ursodrjsz4JIPpjoHzid6BXk1OiNB91YQhXzOtCR3m1D4B/bEi
         m/OLggIwgS7jbxafvBJ1qge2DsO0OgdZiQA2kGQ82Z41HUytg687APpt5G9iTKbAzBT7
         ovAfp1PQrbx26nfkYz92hOCjOPHp7jviLFjgY4ZPoRsKB43kAYXcqzxn5fglyIBFgWou
         gkVrZR1Eo0xklA4Ohh7syOt35Q3JHIaLJyQbtJAuaInpdkIW6+U2/Xc/SFYbazhqIjZ9
         ddFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=H0h0q5lLAzUoy9cBuMGbtr54Sbs+2ULezMokzPte9Nk=;
        b=ia5w7MyK4pT3VuIxe1GO69KMGLnXfCSZ1DD2nUz5pZaeeumyRxTrM76GglP0BZnNLi
         T6WUMAVjdfLvyn+0aM4JCWEs6yZHkSJ7w5O6r0cI4o/yfuDnq5AM+1PdY+t3Ro+2ioh0
         DRmOHiLjrYdlUn9o4gAAtPX+zsu73FKQwGGunbbSER+aqHNOykDaYFpY2uwM521qidCk
         NgzCw5qBIISq39bFSNvvvhIbuGn/x7eFznlV3xgmgBgHGu0j9zsXwuMDudMMfDUcTYgG
         cGQwHwZivLomjU0KbDyo5aBalThn6ObzDmF3LSCQ/bEVlQSUSdJm9tm2mXp7znv66j1a
         eAWQ==
X-Gm-Message-State: APjAAAU9932YBN95GnlkO4rUcIwU3+61cgshw7OZ35pB1JAFOjG1iyWo
        0zuIUDuXr+L2+ZusDi5QFshBnnelP6mi+eqXPYAauw==
X-Google-Smtp-Source: APXvYqxEX3SYjNJfI6yi6MEZQ8vr4TFxHExnBZdxKMDhkZPuIBdr1tddY6kUH54fS4X8OzRY6nmyX9t9LleNqelmOoQ=
X-Received: by 2002:a5d:5408:: with SMTP id g8mr11690221wrv.202.1571099704654;
 Mon, 14 Oct 2019 17:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <20191015003303.61293-1-irogers@google.com>
In-Reply-To: <20191015003303.61293-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 14 Oct 2019 17:34:52 -0700
Message-ID: <CAP-5=fWZ3GvQH1gpPebmrqvR9+YYipoEAN-2eLr9XEDDJJD_OQ@mail.gmail.com>
Subject: Re: [PATCH 15/15] perf annotate: ensure objdump argv is NULL terminated
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies, resending with the correct patch number.

On Mon, Oct 14, 2019 at 5:33 PM Ian Rogers <irogers@google.com> wrote:
>
> Provide null termination.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/annotate.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index f7c620e0099b..a9089e64046d 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -1921,6 +1921,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
>                 NULL, /* Will be the objdump command to run. */
>                 "--",
>                 NULL, /* Will be the symfs path. */
> +               NULL,
>         };
>         struct child_process objdump_process;
>         int err = dso__disassemble_filename(dso, symfs_filename, sizeof(symfs_filename));
> --
> 2.23.0.700.g56cf767bdb-goog
>
