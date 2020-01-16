Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 727ED13DA17
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 13:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgAPMcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 07:32:45 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:34160 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgAPMcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 07:32:45 -0500
Received: by mail-pj1-f68.google.com with SMTP id s94so3067961pjc.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 04:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kUo0X8yHvUiQ3XC8YUK28eSRhJfh+ll6/ugw3Oe1M1Q=;
        b=UXGYA21K75xEOAp9SbB7v5zoXurF2mmymOQHAr9eF1MPCJbkIdpZJCFwmGK/PbF1wp
         3WEr3RIg4sPuTnZgnBnP2wU6A7oaZi7U9/1MWJ2XNGja8/bnvJit+7J+rNnoEAd5RpS0
         N3bBrBX9zHAxaS0fhfFVqoJhwBnNEMdxjHo9HA+ojExPH8BGpTMSLt/xjD+RcVBbbBqm
         KCLPIopPXLy6+OBdhWGe9dTohriLHaLOBItkWMzLzBRDckepLwa8mD3k0kFVsbRG8ATy
         UOmYJPp3RQ+1IxYyRTFwc10WLAOkCtMkdH6Q4es1NCzN9CP7rcd5kmZNIR7J+WXiPOw5
         s7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kUo0X8yHvUiQ3XC8YUK28eSRhJfh+ll6/ugw3Oe1M1Q=;
        b=KpmBLX6xYsgCIDkP0n3LYp+Iifv8bwfA7KkeTVCAYX/hieQpq8n3dsXopri46sSgpm
         0vRHGRlnY+f3Ap3EI5UckjdM6zLGaYsrEA7dfazdP3IOgC7+5N6AXK3+8FA4kxLVDMoX
         js6Fj1Luf+X50dHM5xPKHKva3cksVhRrJ6CJ+0aAvqdlhX/U7NSu13J9ztIXRPvEAdXf
         VQqcfULufo8NeuImcySPT6eZ9Mn0KtzFgeR2RZmF4tFLB0OTxuOA8VsVGKb4ZilrYcua
         UdKyj3krgAsawKnMh9+JybAgGsOTvjQiB0/Eji20WeV0EdMJ18lIrWKwhvDBY80P87EQ
         iQKg==
X-Gm-Message-State: APjAAAXAvqQDVnJUrPkqcHyH4Tdz0hl67a/3x+ogMpsJ0WdkXOs0SXcU
        NH0lBYRyE3LAsNvLGua0EtYasNX/rqYCJcT4/2RJrA==
X-Google-Smtp-Source: APXvYqzo6s5Kz2CMbOsjPisbrJmkPsSAS3hkofHAT/tWGW1QGiWe0lbbH+e7jgRPOsqBUfgmuXkb7TNhgofLg5M8PZY=
X-Received: by 2002:a17:90a:660b:: with SMTP id l11mr6404502pjj.47.1579177964411;
 Thu, 16 Jan 2020 04:32:44 -0800 (PST)
MIME-Version: 1.0
References: <20200116012321.26254-1-keescook@chromium.org> <20200116012321.26254-7-keescook@chromium.org>
In-Reply-To: <20200116012321.26254-7-keescook@chromium.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 16 Jan 2020 13:32:33 +0100
Message-ID: <CAAeHK+x5pLce4Uig6O03YS6MrSJtu6FR9DbcTsjy29BbgEZM4A@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] ubsan: Include bug type in report header
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-hardening@lists.openwall.com,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 2:24 AM Kees Cook <keescook@chromium.org> wrote:
>
> When syzbot tries to figure out how to deduplicate bug reports, it
> prefers seeing a hint about a specific bug type (we can do better than
> just "UBSAN"). This lifts the handler reason into the UBSAN report line
> that includes the file path that tripped a check. Unfortunately, UBSAN
> does not provide function names.
>
> Suggested-by: Dmitry Vyukov <dvyukov@google.com>
> Link: https://lore.kernel.org/lkml/CACT4Y+bsLJ-wFx_TaXqax3JByUOWB3uk787LsyMVcfW6JzzGvg@mail.gmail.com
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  lib/ubsan.c | 36 +++++++++++++++---------------------
>  1 file changed, 15 insertions(+), 21 deletions(-)
>
> diff --git a/lib/ubsan.c b/lib/ubsan.c
> index 429663eef6a7..057d5375bfc6 100644
> --- a/lib/ubsan.c
> +++ b/lib/ubsan.c
> @@ -45,13 +45,6 @@ static bool was_reported(struct source_location *location)
>         return test_and_set_bit(REPORTED_BIT, &location->reported);
>  }
>
> -static void print_source_location(const char *prefix,
> -                               struct source_location *loc)
> -{
> -       pr_err("%s %s:%d:%d\n", prefix, loc->file_name,
> -               loc->line & LINE_MASK, loc->column & COLUMN_MASK);
> -}
> -
>  static bool suppress_report(struct source_location *loc)
>  {
>         return current->in_ubsan || was_reported(loc);
> @@ -140,13 +133,14 @@ static void val_to_string(char *str, size_t size, struct type_descriptor *type,
>         }
>  }
>
> -static void ubsan_prologue(struct source_location *location)
> +static void ubsan_prologue(struct source_location *loc, const char *reason)
>  {
>         current->in_ubsan++;
>
>         pr_err("========================================"
>                 "========================================\n");
> -       print_source_location("UBSAN: Undefined behaviour in", location);
> +       pr_err("UBSAN: %s in %s:%d:%d\n", reason, loc->file_name,
> +               loc->line & LINE_MASK, loc->column & COLUMN_MASK);
>  }
>
>  static void ubsan_epilogue(void)
> @@ -180,12 +174,12 @@ static void handle_overflow(struct overflow_data *data, void *lhs,
>         if (suppress_report(&data->location))
>                 return;
>
> -       ubsan_prologue(&data->location);
> +       ubsan_prologue(&data->location, type_is_signed(type) ?
> +                       "signed integer overflow" :
> +                       "unsigned integer overflow");
>
>         val_to_string(lhs_val_str, sizeof(lhs_val_str), type, lhs);
>         val_to_string(rhs_val_str, sizeof(rhs_val_str), type, rhs);
> -       pr_err("%s integer overflow:\n",
> -               type_is_signed(type) ? "signed" : "unsigned");
>         pr_err("%s %c %s cannot be represented in type %s\n",
>                 lhs_val_str,
>                 op,
> @@ -225,7 +219,7 @@ void __ubsan_handle_negate_overflow(struct overflow_data *data,
>         if (suppress_report(&data->location))
>                 return;
>
> -       ubsan_prologue(&data->location);
> +       ubsan_prologue(&data->location, "negation overflow");
>
>         val_to_string(old_val_str, sizeof(old_val_str), data->type, old_val);
>
> @@ -245,7 +239,7 @@ void __ubsan_handle_divrem_overflow(struct overflow_data *data,
>         if (suppress_report(&data->location))
>                 return;
>
> -       ubsan_prologue(&data->location);
> +       ubsan_prologue(&data->location, "division overflow");
>
>         val_to_string(rhs_val_str, sizeof(rhs_val_str), data->type, rhs);
>
> @@ -264,7 +258,7 @@ static void handle_null_ptr_deref(struct type_mismatch_data_common *data)
>         if (suppress_report(data->location))
>                 return;
>
> -       ubsan_prologue(data->location);
> +       ubsan_prologue(data->location, "NULL pointer dereference");

Not crucially important, but I think it makes sense to use the
single-word-with-hyphens bug type format like in KASAN here, e.g.
null-ptr-deref, misaligned-access, etc.


>
>         pr_err("%s null pointer of type %s\n",
>                 type_check_kinds[data->type_check_kind],
> @@ -279,7 +273,7 @@ static void handle_misaligned_access(struct type_mismatch_data_common *data,
>         if (suppress_report(data->location))
>                 return;
>
> -       ubsan_prologue(data->location);
> +       ubsan_prologue(data->location, "misaligned access");
>
>         pr_err("%s misaligned address %p for type %s\n",
>                 type_check_kinds[data->type_check_kind],
> @@ -295,7 +289,7 @@ static void handle_object_size_mismatch(struct type_mismatch_data_common *data,
>         if (suppress_report(data->location))
>                 return;
>
> -       ubsan_prologue(data->location);
> +       ubsan_prologue(data->location, "object size mismatch");
>         pr_err("%s address %p with insufficient space\n",
>                 type_check_kinds[data->type_check_kind],
>                 (void *) ptr);
> @@ -354,7 +348,7 @@ void __ubsan_handle_out_of_bounds(struct out_of_bounds_data *data, void *index)
>         if (suppress_report(&data->location))
>                 return;
>
> -       ubsan_prologue(&data->location);
> +       ubsan_prologue(&data->location, "array index out of bounds");
>
>         val_to_string(index_str, sizeof(index_str), data->index_type, index);
>         pr_err("index %s is out of range for type %s\n", index_str,
> @@ -375,7 +369,7 @@ void __ubsan_handle_shift_out_of_bounds(struct shift_out_of_bounds_data *data,
>         if (suppress_report(&data->location))
>                 goto out;
>
> -       ubsan_prologue(&data->location);
> +       ubsan_prologue(&data->location, "shift out of bounds");
>
>         val_to_string(rhs_str, sizeof(rhs_str), rhs_type, rhs);
>         val_to_string(lhs_str, sizeof(lhs_str), lhs_type, lhs);
> @@ -407,7 +401,7 @@ EXPORT_SYMBOL(__ubsan_handle_shift_out_of_bounds);
>
>  void __ubsan_handle_builtin_unreachable(struct unreachable_data *data)
>  {
> -       ubsan_prologue(&data->location);
> +       ubsan_prologue(&data->location, "unreachable");
>         pr_err("calling __builtin_unreachable()\n");
>         ubsan_epilogue();
>         panic("can't return from __builtin_unreachable()");
> @@ -422,7 +416,7 @@ void __ubsan_handle_load_invalid_value(struct invalid_value_data *data,
>         if (suppress_report(&data->location))
>                 return;
>
> -       ubsan_prologue(&data->location);
> +       ubsan_prologue(&data->location, "invalid load");
>
>         val_to_string(val_str, sizeof(val_str), data->type, val);
>
> --
> 2.20.1
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller/20200116012321.26254-7-keescook%40chromium.org.
