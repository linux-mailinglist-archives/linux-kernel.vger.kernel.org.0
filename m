Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E28C177A4C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 16:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbgCCPVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 10:21:45 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:41486 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729858AbgCCPVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 10:21:44 -0500
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 023FLf4K026892
        for <linux-kernel@vger.kernel.org>; Wed, 4 Mar 2020 00:21:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 023FLf4K026892
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1583248902;
        bh=p9DB0ijpMfvl4o7+zWnnvhhj5CGZsPZx44piU3AzeXQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N61o69reItR0LE/xd5KERMoDGzJxmCNQNPsoXJAg3daIWlLeTW0fKjrR6KwmUxCjH
         MJ28jwaQDh8taRMM0eORLqWa7iCix7+UrKGU3goJV7rhKK5gVje2fpmdM62IioJlAr
         A0mn2nUd881VzoaayMCo8Lowea8On0ZjQ36v+U4rCCE/80gTYl36btXH2h+12b4nsm
         fkQ1q3gpiEBruX8Wzt7pyFN/VweQdR3H2RE35PfUFV0XeszpdcZ2KzDLsWXFK06S6o
         tmGVHRmBWfHEnGBa0manKYuJ+kFgcD1X9VHJpnsPYTT0fAN+zMdmwAgdXS5FxM0KqP
         OBFfz97l8nSfg==
X-Nifty-SrcIP: [209.85.222.41]
Received: by mail-ua1-f41.google.com with SMTP id p2so1244236uao.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 07:21:41 -0800 (PST)
X-Gm-Message-State: ANhLgQ23el3W3F4/pCJEXm3KVFgxh6mRUMehYqCbNl/0GXpRM+/Fpk2R
        sjzOgaGRvuo+V4gZGk5mGw065SsMZviU9dSoXwM=
X-Google-Smtp-Source: ADFU+vtoM4NtLgY8UbV/3uoB5j/sLDyI9wWz+fsIMKsGNEGo8M0B9iF7h6VBukfJAHREWKh3upga5HuyC6xOMd3bktQ=
X-Received: by 2002:ab0:3485:: with SMTP id c5mr2862169uar.109.1583248900455;
 Tue, 03 Mar 2020 07:21:40 -0800 (PST)
MIME-Version: 1.0
References: <20200226142608.19499-1-jeyu@kernel.org> <20200226142608.19499-2-jeyu@kernel.org>
In-Reply-To: <20200226142608.19499-2-jeyu@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 4 Mar 2020 00:21:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNATD7MHY7UDAZW7VwgC27bfPZ=TGEUY7LpVzxRyuJA6jOQ@mail.gmail.com>
Message-ID: <CAK7LNATD7MHY7UDAZW7VwgC27bfPZ=TGEUY7LpVzxRyuJA6jOQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] modpost: return error if module is missing ns
 imports and MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=n
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
> Currently when CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=n, modpost only warns
> when a module is missing namespace imports. Under this configuration, such a module
> cannot be loaded into the kernel anyway, as the module loader would reject it.
> We might as well return a build error when a module is missing namespace imports
> under CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=n, so that the build
> warning does not go ignored/unnoticed.
>
> Signed-off-by: Jessica Yu <jeyu@kernel.org>
> ---


When you send v3, could you please fix the
following checkpatch warning and error?



WARNING: Possible unwrapped commit description (prefer a maximum 75
chars per line)
#59:
Currently when CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=n,
modpost only warns

ERROR: do not initialise statics to 0
#107: FILE: scripts/mod/modpost.c:43:
+static int allow_missing_ns_imports = 0;







>  scripts/Makefile.modpost | 15 ++++++++-------
>  scripts/mod/modpost.c    | 14 +++++++++++---
>  2 files changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> index b4d3f2d122ac..957eed6a17a5 100644
> --- a/scripts/Makefile.modpost
> +++ b/scripts/Makefile.modpost
> @@ -46,13 +46,14 @@ include scripts/Kbuild.include
>  kernelsymfile := $(objtree)/Module.symvers
>  modulesymfile := $(firstword $(KBUILD_EXTMOD))/Module.symvers
>
> -MODPOST = scripts/mod/modpost                                          \
> -       $(if $(CONFIG_MODVERSIONS),-m)                                  \
> -       $(if $(CONFIG_MODULE_SRCVERSION_ALL),-a)                        \
> -       $(if $(KBUILD_EXTMOD),-i,-o) $(kernelsymfile)                   \
> -       $(if $(KBUILD_EXTMOD),$(addprefix -e ,$(KBUILD_EXTRA_SYMBOLS))) \
> -       $(if $(KBUILD_EXTMOD),-o $(modulesymfile))                      \
> -       $(if $(CONFIG_SECTION_MISMATCH_WARN_ONLY),,-E)                  \
> +MODPOST = scripts/mod/modpost                                                          \
> +       $(if $(CONFIG_MODVERSIONS),-m)                                                  \
> +       $(if $(CONFIG_MODULE_SRCVERSION_ALL),-a)                                        \
> +       $(if $(KBUILD_EXTMOD),-i,-o) $(kernelsymfile)                                   \
> +       $(if $(KBUILD_EXTMOD),$(addprefix -e ,$(KBUILD_EXTRA_SYMBOLS)))                 \
> +       $(if $(KBUILD_EXTMOD),-o $(modulesymfile))                                      \
> +       $(if $(CONFIG_SECTION_MISMATCH_WARN_ONLY),,-E)                                  \
> +       $(if $(CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS)$(KBUILD_NSDEPS),-N)       \
>         $(if $(KBUILD_MODPOST_WARN),-w)
>
>  ifdef MODPOST_VMLINUX
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 3201a2ac5cc4..d164be63c2e3 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -39,6 +39,8 @@ static int sec_mismatch_count = 0;
>  static int sec_mismatch_fatal = 0;
>  /* ignore missing files */
>  static int ignore_missing_files;
> +/* If set to 1, only warn (instead of error) about missing ns imports */
> +static int allow_missing_ns_imports = 0;
>
>  enum export {
>         export_plain,      export_unused,     export_gpl,
> @@ -2209,8 +2211,11 @@ static int check_exports(struct module *mod)
>
>                 if (exp->namespace &&
>                     !module_imports_namespace(mod, exp->namespace)) {
> -                       warn("module %s uses symbol %s from namespace %s, but does not import it.\n",
> -                            basename, exp->name, exp->namespace);
> +                       warn_unless(!allow_missing_ns_imports,
> +                                   "module %s uses symbol %s from namespace %s, but does not import it.\n",
> +                                   basename, exp->name, exp->namespace);
> +                       if (!allow_missing_ns_imports)
> +                               err = 1;
>                         add_namespace(&mod->missing_namespaces, exp->namespace);
>                 }
>
> @@ -2553,7 +2558,7 @@ int main(int argc, char **argv)
>         struct ext_sym_list *extsym_iter;
>         struct ext_sym_list *extsym_start = NULL;
>
> -       while ((opt = getopt(argc, argv, "i:e:mnsT:o:awEd:")) != -1) {
> +       while ((opt = getopt(argc, argv, "i:e:mnsT:o:awENd:")) != -1) {
>                 switch (opt) {
>                 case 'i':
>                         kernel_read = optarg;
> @@ -2591,6 +2596,9 @@ int main(int argc, char **argv)
>                 case 'E':
>                         sec_mismatch_fatal = 1;
>                         break;
> +               case 'N':
> +                       allow_missing_ns_imports = 1;
> +                       break;
>                 case 'd':
>                         missing_namespace_deps = optarg;
>                         break;
> --
> 2.16.4
>


-- 
Best Regards
Masahiro Yamada
