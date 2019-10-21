Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81391DF0E9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 17:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbfJUPJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 11:09:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46724 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbfJUPJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 11:09:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id n15so3623148wrw.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 08:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zp9VnqgPtrlTb2NFdVTCEWXBIcY5L8PJrNgS2IiGKag=;
        b=WJZViscDoysM8f6XTnc0VOHxgQgwydl8n7xhNcNKEzEbFslAwa0s0D+/w4TBtHf6L3
         lib9o/evaBzAHQiZlWblNdokZLVktfz8Lw9jvgdzhKAyJh3SIEYaH+1LOWHSpRS82nwR
         q4naMKAGSAPGhcAFRbjK1K89AZHTRwOVGE1QZsCyBqdTw7KfpmSmx99t03P0d/Ie9aRd
         x+nsYPTrt4wfeEzQ1tudWrpFiXCcSXZ80YSRTlPjtmuCX0vusdUSCa+AfFiTGf7lPClQ
         116njWGADnowB3H5bzGpQ1JagGucI4LDbSP2pCSVcYeVhiIt57r9h/JcwyDOrhoz7NHa
         /o9A==
X-Gm-Message-State: APjAAAXOU2h8nxF9czYTAgEbHdoUh+PWBhoDgCMk7Su5XETPo8aELPFn
        gW4HAuPtp0ajaYMjfatx1tMeXnBmsyUGnQoLFoA=
X-Google-Smtp-Source: APXvYqxP5NzZQsxRudKUDOsXNqSU4xfwYr/ASY1UZRvA0COGEdIs1jtb6XNqaeiymU4sRLvgDv5gP8l7WMnZ3EF2Ti4=
X-Received: by 2002:adf:e2c5:: with SMTP id d5mr19467918wrj.283.1571670574752;
 Mon, 21 Oct 2019 08:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <20191018170718.3cc5013b@gandalf.local.home>
In-Reply-To: <20191018170718.3cc5013b@gandalf.local.home>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 22 Oct 2019 00:09:23 +0900
Message-ID: <CAM9d7chC4fNFj=Mc9d-4r59sEvcxt=0dBk=oiBbsAP0HxseXXg@mail.gmail.com>
Subject: Re: [PATCH] tools lib traceevent: Fix sign variable to return signed
 in eval_type_str()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        GwanYeong Kim <gy741.kim@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Sat, Oct 19, 2019 at 6:07 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
>
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
>
> Seems that the value returned by eval_type_str() were always unsigned, and
> never signed extended. Luckily, looking at all the trace events that
> actually have a signed value seldom (if ever) are negative, so this bug
> never showed its face, and if it has, nobody noticed it.
>
> Converted the sign variable to boolean while at it.
>
> Link: http://lkml.kernel.org/r/20191013134903.5f879ad1@gandalf.local.home
> Fixes: f7d82350e597d ("tools/events: Add files to create libtraceevent.a")
> Reported-by: GwanYeong Kim <gy741.kim@gmail.com>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks
Namhyung


> ---
>  tools/lib/traceevent/event-parse.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
> index d948475585ce..2b20063813ac 100644
> --- a/tools/lib/traceevent/event-parse.c
> +++ b/tools/lib/traceevent/event-parse.c
> @@ -2217,7 +2217,7 @@ static char *arg_eval (struct tep_print_arg *arg);
>  static unsigned long long
>  eval_type_str(unsigned long long val, const char *type, int pointer)
>  {
> -       int sign = 0;
> +       bool sign = true;
>         char *ref;
>         int len;
>
> @@ -2277,7 +2277,7 @@ eval_type_str(unsigned long long val, const char *type, int pointer)
>                 return (unsigned long long)(int)val & 0xffffffff;
>
>         if (strncmp(type, "unsigned ", 9) == 0) {
> -               sign = 0;
> +               sign = false;
>                 type += 9;
>         }
>
> --
> 2.20.1
>
