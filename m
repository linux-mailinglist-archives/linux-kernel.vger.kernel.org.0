Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA6171F54
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 20:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391524AbfGWSbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 14:31:10 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43098 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfGWSbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 14:31:10 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so19822008pgv.10;
        Tue, 23 Jul 2019 11:31:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=46tdGvqvoqxUIPeOgCWCop/dIrP81hhCst66zWIrm18=;
        b=SDVTRIP1/O4vq28biyYxsADrCl2a61VQk7ivQNBMLIPv0W3YBIWihiV28+y5YSXpIK
         LMsZkvnJsTD7eYI2nePCEmu0DMmWVz1Innsg4QV6NBKhEKeyqtZ5/qxvt7T3KeM97vBP
         YJQHXIb3Dift3KIjicfx5QWbVBS5OGu6Vvz2cBW2N9cyMxU3f9fQxwQOKGlgkD4ZA1sZ
         /fxVrMgS2Mt0BgpDx5opfhgehCGAhXPOPzFeibo/lZzvbjNBqppE1LuC4/8yOysz91dM
         nlggWGeACuHV2oS4cFUx2y3iihZZikR3twsw3YuOA1Y5w3g3ByQzqgRa0wTA8SQI+RHf
         Yg6g==
X-Gm-Message-State: APjAAAXk3M/9HIURQtF6BNDQHvf+sNkNWuhrt1gv3mhSy+WZ3KjKqzbK
        MokRYbfzBjVDX5NO0hK2Jjg=
X-Google-Smtp-Source: APXvYqxo1DzIE0Lf6y7298mhooH13TsAceAasGh822+s662eZYiSCxHuKtu/K9AIM0ZUgGMR0qZCOw==
X-Received: by 2002:a17:90a:d151:: with SMTP id t17mr82706672pjw.60.1563906669597;
        Tue, 23 Jul 2019 11:31:09 -0700 (PDT)
Received: from dennisz-mbp ([2620:10d:c091:500::cff2])
        by smtp.gmail.com with ESMTPSA id r1sm41232037pgv.70.2019.07.23.11.31.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 11:31:08 -0700 (PDT)
Date:   Tue, 23 Jul 2019 14:31:06 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     dennis@kernel.org, tj@kernel.org, cl@linux.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] percpu: Fix a typo
Message-ID: <20190723183106.GA85597@dennisz-mbp>
References: <20190721095633.10979-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190721095633.10979-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2019 at 11:56:33AM +0200, Christophe JAILLET wrote:
> s/perpcu/percpu/
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  mm/percpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 9821241fdede..febf7c7c888e 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -2220,7 +2220,7 @@ static void pcpu_dump_alloc_info(const char *lvl,
>   * @base_addr: mapped address
>   *
>   * Initialize the first percpu chunk which contains the kernel static
> - * perpcu area.  This function is to be called from arch percpu area
> + * percpu area.  This function is to be called from arch percpu area
>   * setup path.
>   *
>   * @ai contains all information necessary to initialize the first
> -- 
> 2.20.1
> 

Applied to for-5.4 with a slightly more descriptive title.

Thanks,
Dennis
