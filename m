Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7577B9721
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 20:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406437AbfITSVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 14:21:12 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38152 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405210AbfITSVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 14:21:11 -0400
Received: by mail-qt1-f195.google.com with SMTP id j31so9748998qta.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 11:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WFDzeGI58bQG3IzyXGnedWMPuSrlhIe2/vOJ6XltSkk=;
        b=o6qegZFAmF6uhRmCmzto86kve3XfyXmzkUzLrPhex8KM2Qcvo0EyVl5WW3KbHH8a7M
         azhphlZI5sAEVJAH0DTcehAxxchyeu4xuNTeDKK9nKNzPos3xxQGC4AVbAxUSGoXB/jr
         sSf7KqS4g89yU2RjhYIE5r6S9IVIBOaQAxP6eJ5vJw9v3plXgcz0Kwu5e3dlVB0Ejhun
         34vajiHQReseTiewoACWotNkfMthfJDMys5eacF6izv1lMy3DJnAAQHvB2wPoEumJdnu
         6zE6Gke8FZVne7INq6+9l6mazWXqQRpvOWERoLI0JHig54dzp4RkbCBImN6dQQ5bObVc
         G9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WFDzeGI58bQG3IzyXGnedWMPuSrlhIe2/vOJ6XltSkk=;
        b=kZ/pOJXdRGHxse2Q1629ZVWMMeo/2Yuzd0qTev4jgHx4nLe+t0Hhg5sZgSu2WaUo/2
         ADDfw1gVTfX9/K32vhoyrpxtkL3jRrJt2YQP/xoMO/yxFEPyRphxey1alty01M1Yrokt
         JrdJpje561bKRqE0yxsBzifXz1L35Wmk/Ooky0SY1aH3mWrd2O3dV3PcAzCxuTlqDFjg
         KYkFEsLkhpBd42PIWx6hDUClpN+FEF1FKj8+rwRThRdUusmdr2Z3ICEe6SEhRpKS7glJ
         xGQUy+pmrMPRveJ1+wEeGubKRlz1RIXJNdKxAu7wC+cJUGCLlCCBuCh37W0YGttD1OYG
         2vgw==
X-Gm-Message-State: APjAAAUJ2KwC/kr6G9rZInB/4MBdjyvK9h0wK+vvWP8KrY/EzUasdxUg
        efDLTvvQjbEWcW2nlKTHcyk=
X-Google-Smtp-Source: APXvYqzqnWAdv6pvS5fccCPb0O6/ymEAqxKea3t3NVp0xFlAA2SXVWellVZ17Tey5TDJP2iZwlybbg==
X-Received: by 2002:ac8:6b09:: with SMTP id w9mr4705176qts.31.1569003670835;
        Fri, 20 Sep 2019 11:21:10 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([2804:14d:1289:8121::1007])
        by smtp.gmail.com with ESMTPSA id a36sm1487043qtk.21.2019.09.20.11.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 11:21:10 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D291A40340; Fri, 20 Sep 2019 15:21:07 -0300 (-03)
Date:   Fri, 20 Sep 2019 15:21:07 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCHv2] perf tests: Fix static build test
Message-ID: <20190920182107.GB4865@kernel.org>
References: <20190905090924.GA1949@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905090924.GA1949@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 05, 2019 at 11:09:24AM +0200, Jiri Olsa escreveu:
> Disable the potentional shared library features,
> which breaks static build if they are enabled and
> detected: jvmti and vdso libraries.

Thanks, applied.

- Arnaldo
 
> Link: http://lkml.kernel.org/n/tip-ibdgg163291sx5m5xkojx5sq@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/tests/make | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> index 6b3afed5d910..c850d1664c56 100644
> --- a/tools/perf/tests/make
> +++ b/tools/perf/tests/make
> @@ -100,7 +100,7 @@ make_install_info   := install-info
>  make_install_pdf    := install-pdf
>  make_install_prefix       := install prefix=/tmp/krava
>  make_install_prefix_slash := install prefix=/tmp/krava/
> -make_static         := LDFLAGS=-static
> +make_static         := LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1
>  
>  # all the NO_* variable combined
>  make_minimal        := NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1
> -- 
> 2.21.0

-- 

- Arnaldo
