Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9257177A57
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 16:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbgCCPYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 10:24:21 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:58973 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgCCPYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 10:24:21 -0500
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 023FOAiB018878
        for <linux-kernel@vger.kernel.org>; Wed, 4 Mar 2020 00:24:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 023FOAiB018878
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1583249050;
        bh=fHJ6LKpn2NcjSEDGxLEy1LxyGgY1Hobk/cTjUJ8XOKg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NCBHrIN3mkJpXiH1qBKeKcnlH+w4rzDsA2F9B3o3YgAPsNbX8hjAmAb/It6y2fZ4N
         /j0byu2OshWWrmP0MFR1g/HA3/zcqUqHd+osfpLC5Vqq96DjBKw5cwjuRuLAYFq+LN
         DO6w3H6MCi+j94zY1z2BuSd3mc2e8i2NoYjOj8kypyyBQNgfQOYOyOeuUNaaUmTjKM
         1/e8M0GwYRZunA/a+YQqpXve1HHYaFmY5BMmIhVFjKN1TuaCKzDHugEeoND/I/Cyey
         xWTu3LmyP/egqrA/v/IlfTe0NgjP7L5QcCm+FFg0TrN39+axQ5lNKlU4JCHSdVZjDg
         r9Ry1Cr3p65oQ==
X-Nifty-SrcIP: [209.85.222.41]
Received: by mail-ua1-f41.google.com with SMTP id 1so1267092uao.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 07:24:10 -0800 (PST)
X-Gm-Message-State: ANhLgQ3Y+1M/3bMHqgez0FdwetzoRGqxn3S5ZpzUQlZpWX2luv5o0CZP
        ahNjbbNfgSjIG9Rwr5R6GdmGiDdPzqbZmjDxnrI=
X-Google-Smtp-Source: ADFU+vtvLhLcirXoWx2txj/10K/F2TY6syDia524qNBjHzydSe+n53+5ZAvAOTVCcJ5FCw0ZtBVUvYGcoDKwbFsGYzM=
X-Received: by 2002:a9f:32da:: with SMTP id f26mr1872157uac.40.1583249049570;
 Tue, 03 Mar 2020 07:24:09 -0800 (PST)
MIME-Version: 1.0
References: <20200226142608.19499-1-jeyu@kernel.org>
In-Reply-To: <20200226142608.19499-1-jeyu@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 4 Mar 2020 00:23:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ2=UvBSLc_MpZin1Em+O+aUbUXM9uLy-UWOiGj_5JrVg@mail.gmail.com>
Message-ID: <CAK7LNAQ2=UvBSLc_MpZin1Em+O+aUbUXM9uLy-UWOiGj_5JrVg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] modpost: rework and consolidate logging interface
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Matthias Maennich <maennich@google.com>,
        Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 11:26 PM Jessica Yu <jeyu@kernel.org> wrote:
>
> Rework modpost's logging interface by consolidating merror(), warn(),
> and fatal() to use a single function, modpost_log(). Introduce different
> logging levels (WARN, ERROR, FATAL) as well as a conditional warn
> (warn_unless()). The conditional warn is useful in determining whether
> to use merror() or warn() based on a condition. This reduces code
> duplication overall.
>
> Signed-off-by: Jessica Yu <jeyu@kernel.org>
> ---
> v2:
>   - modpost_log: initialize level to ""
>   - remove parens () from case labels
>
>  scripts/mod/modpost.c | 69 +++++++++++++++++++++++----------------------------
>  scripts/mod/modpost.h | 22 +++++++++++++---
>  2 files changed, 50 insertions(+), 41 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 7edfdb2f4497..3201a2ac5cc4 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -51,41 +51,37 @@ enum export {
>
>  #define MODULE_NAME_LEN (64 - sizeof(Elf_Addr))
>
> -#define PRINTF __attribute__ ((format (printf, 1, 2)))
> +#define PRINTF __attribute__ ((format (printf, 2, 3)))
>
> -PRINTF void fatal(const char *fmt, ...)
> +PRINTF void modpost_log(enum loglevel loglevel, const char *fmt, ...)
>  {
> +       char *level = "";
>         va_list arglist;
>
> -       fprintf(stderr, "FATAL: ");
> -
> -       va_start(arglist, fmt);
> -       vfprintf(stderr, fmt, arglist);
> -       va_end(arglist);
> -
> -       exit(1);
> -}
> -
> -PRINTF void warn(const char *fmt, ...)
> -{
> -       va_list arglist;
> +       switch(loglevel) {


One nit:

Please insert a space after 'switch'.

I see this checkpatch error:

ERROR: space required before the open parenthesis '('
#102: FILE: scripts/mod/modpost.c:61:
+ switch(loglevel) {




-- 
Best Regards
Masahiro Yamada
