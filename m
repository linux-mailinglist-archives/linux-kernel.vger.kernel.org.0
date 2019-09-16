Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77586B3B20
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 15:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733084AbfIPNRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 09:17:09 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35654 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732956AbfIPNRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 09:17:07 -0400
Received: by mail-lf1-f68.google.com with SMTP id w6so27469333lfl.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 06:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WE01PYWdyxr4h6bZhIeuaYXDwfnO68aEYViDjXA5Z/w=;
        b=Fo3C57H7kYgxpkxIGqG9Z33KQSPOoLI/a/kJBRMpKMzYg+JIHEcbAzDUieM675lUuN
         fvT2C3YQFnxin6m3vTJl6mp7vc1f4ForS6QvNlJYSjMAB6lQV1N/6ofAIDBdA3as6qz1
         9uTIPHryJv5STnfKsvNFreF2sAUR6LeugZ9Rb2vCTY1tslyWocN+dX9xWnTIEFGyeBtM
         2enC9xMNPqtlEKOgJMEoxjqLdgtydotjMw/yaAk5J3pexIvTieuOKYE+1Wp3e5lstU+K
         9aPChAjmsG59s6R3fkjboG1Q0wVSl0VRNx5XbpdnY/dLnhQIRj+buOsp5STZptZLxMVd
         zFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WE01PYWdyxr4h6bZhIeuaYXDwfnO68aEYViDjXA5Z/w=;
        b=TcMNd5FnxMHWwmk9f+94MNcK/FGdzePIRjkJTgSr3bqJpWewN2sqCFZzvUlgWFBtzy
         gmlD/rX8zgQBtFXIiVWgGtO97BYMUBgjpyn6wp8IA+WZurNGot4+CQeL3P91kbZXkjaa
         Mw00X5OJNGXpOJ70IX/aR3O58umAHCV2IuFiVRUVWshR7eg4B4Q6b3mx55hYB4VsnUvp
         6rf0r0Jpdwc2PU9sBEqQ+e/A/aw2NlyEmce9RI3f1k3cG+P9QyupvNPMF9Qco6ZkI37e
         fcfdI4rAge6lO8ysvusdmV5rnvfXz7ENzKOtDJqJ9hXrZim+rF1+gh4JzCjsmF8pIaiE
         vIQg==
X-Gm-Message-State: APjAAAXibWXn/8AB46Gf9BpjZufBvozL915RoYXvFR7ermwIL6H4cL7G
        GdrzVbu6fbA49t4Bdgl+SB1cGAnpQxTvMOwEhBL4zg==
X-Google-Smtp-Source: APXvYqwWsdK1cBGRz7DTrqNlMqHivjewvyhfcb6uk0n1wBa/xvfX9UCWrPkb+jAASYCu+V8qjPSivpTdxciXQ5GrP/M=
X-Received: by 2002:ac2:5464:: with SMTP id e4mr1086374lfn.102.1568639825697;
 Mon, 16 Sep 2019 06:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190916014535.GU4352@sirena.co.uk>
In-Reply-To: <20190916014535.GU4352@sirena.co.uk>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Mon, 16 Sep 2019 15:16:54 +0200
Message-ID: <CADYN=9JntrniMnmEMd9igVSovEQjLV9q006cCATLHWrtBhWWHQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the kselftest tree with the tpmdd tree
To:     Mark Brown <broonie@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Petr Vorel <pvorel@suse.cz>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Sep 2019 at 03:45, Mark Brown <broonie@kernel.org> wrote:
>
> Hi all,

Hi,

>
> Today's linux-next merge of the kselftest tree got a conflict in:
>
>   tools/testing/selftests/tpm2/Makefile
>
> between commit:
>
>   3fb2179b0f3553a ("selftests/tpm2: Add the missing TEST_FILES assignment")
>
> from the tpmdd tree and commit:
>
>   d04e26067d13f01 ("selftests: tpm2: install python files")
>
> from the kselftest tree.

If I re-read the Documentation/dev-tools/kselftest.rst
I think the patch from the kselftest tree should be dropped.

I saw that I didn't send an email to the tpm maintainers or the tpm
list when I sent the
patch, I'm sorry.


Cheers,
Anders

>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> diff --cc tools/testing/selftests/tpm2/Makefile
> index bf401f725eef8,1a5db1eb8ed51..0000000000000
> --- a/tools/testing/selftests/tpm2/Makefile
> +++ b/tools/testing/selftests/tpm2/Makefile
> @@@ -2,4 -2,4 +2,5 @@@
>   include ../lib.mk
>
>   TEST_PROGS := test_smoke.sh test_space.sh
>  +TEST_FILES := tpm2.py tpm2_tests.py
> + TEST_PROGS_EXTENDED := tpm2.py tpm2_tests.py
