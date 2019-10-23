Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3774E0FA5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 03:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733066AbfJWBYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 21:24:39 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:40090 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbfJWBYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 21:24:39 -0400
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x9N1OGrk001511
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 10:24:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x9N1OGrk001511
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1571793857;
        bh=BtdIFLzjSF0M2qZMCrwtECZtdItHeicakXIfe0ZLK1g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tLZW+9iu20JkdNHoXZf6lFj5MjNtqWIes0I7cwWYXPnpkxxf22gevgi6ZJb+A76px
         H1BS1F1MPVXv2Vw7DSwI6RsKohohdrtRjDAHpdtr4Fm6WsiIA1atMbxBUkwcunJO3L
         MSY+8SO85sijFiv4VzNzzaj1aLIkZtCvf0rhgVRR0bU1Pkn7c9VzQyaCMPBUtlmUN5
         BvwbJMHoRhA+84Tw5JM8F5yj0V30ywqxHdFOjkp5wObu7zNiTerjyhexFMc1wj0VNP
         Q/Y/lPYn1BUcW7Bfqmc2r5kzL80eBN9xm0ciKBmq00znef+9P87bhSNX5ytwyvxI/X
         lFYzNA7hXbA2g==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id b123so12672825vsb.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 18:24:16 -0700 (PDT)
X-Gm-Message-State: APjAAAXHf64d8bGAYIG2wRkqOhjUTWH7EUAj0N/jFSan1HcPtFipNQfq
        k3tShHx4LHcq9Uxzw145JOnO2Z14xjoMhbrvTSU=
X-Google-Smtp-Source: APXvYqzQ7EbfRKHTdEDtX1IIUzO9qaHq6Jv9BvfMZFAFcz+7Zyy5R3MPoflIftEjT1ud6nWCH8ukcTG4yUDvI3oQwzs=
X-Received: by 2002:a67:ff86:: with SMTP id v6mr3902386vsq.181.1571793855568;
 Tue, 22 Oct 2019 18:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <20191021160419.28270-1-jeyu@kernel.org> <20191022110403.29715-1-jeyu@kernel.org>
In-Reply-To: <20191022110403.29715-1-jeyu@kernel.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 23 Oct 2019 10:23:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNATzCA-+-9Mp6GZcBk1UZnUdgoYHLkX0wVSHyJcRefyWEg@mail.gmail.com>
Message-ID: <CAK7LNATzCA-+-9Mp6GZcBk1UZnUdgoYHLkX0wVSHyJcRefyWEg@mail.gmail.com>
Subject: Re: [PATCH v3] scripts/nsdeps: use alternative sed delimiter
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Maennich <maennich@google.com>,
        David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 8:04 PM Jessica Yu <jeyu@kernel.org> wrote:
>
> When doing an out of tree build with O=, the nsdeps script constructs
> the absolute pathname of the module source file so that it can insert
> MODULE_IMPORT_NS statements in the right place. However, ${srctree}
> contains an unescaped path to the source tree, which, when used in a sed
> substitution, makes sed complain:
>
> ++ sed 's/[^ ]* *//home/jeyu/jeyu-linux\/&/g'
> sed: -e expression #1, char 12: unknown option to `s'
>
> The sed substitution command 's' ends prematurely with the forward
> slashes in the pathname, and sed errors out when it encounters the 'h',
> which is an invalid sed substitution option. To avoid escaping forward
> slashes ${srctree}, we can use '|' as an alternative delimiter for
> sed instead to avoid this error.
>
> Signed-off-by: Jessica Yu <jeyu@kernel.org>
> ---
>
> v3: don't need to escape '/' since we're using a different delimiter.
>
>  scripts/nsdeps | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/nsdeps b/scripts/nsdeps
> index 3754dac13b31..dda6fbac016e 100644
> --- a/scripts/nsdeps
> +++ b/scripts/nsdeps
> @@ -33,7 +33,7 @@ generate_deps() {
>         if [ ! -f "$ns_deps_file" ]; then return; fi
>         local mod_source_files=`cat $mod_file | sed -n 1p                      \
>                                               | sed -e 's/\.o/\.c/g'           \
> -                                             | sed "s/[^ ]* */${srctree}\/&/g"`
> +                                             | sed "s|[^ ]* *|${srctree}/&|g"`
>         for ns in `cat $ns_deps_file`; do
>                 echo "Adding namespace $ns to module $mod_name (if needed)."
>                 generate_deps_for_ns $ns $mod_source_files
> --
> 2.16.4
>

Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>

-- 
Best Regards
Masahiro Yamada
