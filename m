Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37492BE6E2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2019 23:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393572AbfIYVGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 17:06:08 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35868 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393576AbfIYVFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 17:05:23 -0400
Received: by mail-pl1-f194.google.com with SMTP id f19so170984plr.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 14:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=gUT7L2UjxufsVBOfcfjfvQD60hO6N2xeQ8FpCxr2BGs=;
        b=lkvkK0eXSS0wUFMxVd1nEbRN60Km8P2uLg31anz8EGZOQiScuqdVSbRtbmWhz0bSKq
         o9NutbzfaatWRmcMY7/Jd/Ri0q1BSyjq3V56oavrMmm0rJUqv70M9UC8DYJsnUFkkJkQ
         S3tJfqeu4pdEbEjCBqa0kI62SqMDFTbxu9tM6KdI5/e5GaAJLzUHxgbdK859yqoHCnic
         J9817IQ7aaq/FSrCfKYeWfy7OCypfPB3lf39Kaul6IVANXn2Pwn2rHAvycXgRvtUUm8o
         Vli/CFZihYhgT/DYy4vgqJi6XPwc1IvmLj+HjaqRRhJqxqSSExt42m9eGCk98p9Do2Iq
         ZIpQ==
X-Gm-Message-State: APjAAAWHozh7cazbz7Glc8fq1HPO2ujrYcwA2bTIfh8cG/oevTn5mlbU
        rhS6JMu9D1ud2OfZwLSpugHdgA==
X-Google-Smtp-Source: APXvYqy3cdkMgg0isteeXigHPCd6gHDI1dxPmb1QD+beG2Jb9fWSTndwNiR0j1qEnTRyndocyS3IVQ==
X-Received: by 2002:a17:902:7085:: with SMTP id z5mr56136plk.57.1569445520447;
        Wed, 25 Sep 2019 14:05:20 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id l189sm486896pgd.46.2019.09.25.14.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 14:05:19 -0700 (PDT)
Date:   Wed, 25 Sep 2019 14:05:19 -0700 (PDT)
X-Google-Original-Date: Wed, 25 Sep 2019 13:56:27 PDT (-0700)
Subject:     Re: [PATCH 04/32] riscv: Use pr_warn instead of pr_warning
In-Reply-To: <20190920062544.180997-5-wangkefeng.wang@huawei.com>
CC:     joe@perches.com, akpm@linux-foundation.org, mingo@redhat.com,
        davem@davemloft.net, acme@redhat.com, apw@canonical.com,
        peterz@infradead.org, ast@kernel.org, daniel@iogearbox.net,
        Greg KH <gregkh@linuxfoundation.org>,
        sergey.senozhatsky@gmail.com, pmladek@suse.com,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        wangkefeng.wang@huawei.com,
        Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu
From:   Palmer Dabbelt <palmer@sifive.com>
To:     wangkefeng.wang@huawei.com
Message-ID: <mhng-77b10aea-889e-40f5-a698-b47d44ba606c@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Sep 2019 23:25:16 PDT (-0700), wangkefeng.wang@huawei.com wrote:
> As said in commit f2c2cbcc35d4 ("powerpc: Use pr_warn instead of
> pr_warning"), removing pr_warning so all logging messages use a
> consistent <prefix>_warn style. Let's do it.
>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/riscv/kernel/module.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
> index 70bb94ae61c5..b7401858d872 100644
> --- a/arch/riscv/kernel/module.c
> +++ b/arch/riscv/kernel/module.c
> @@ -315,8 +315,8 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
>  			/* Ignore unresolved weak symbol */
>  			if (ELF_ST_BIND(sym->st_info) == STB_WEAK)
>  				continue;
> -			pr_warning("%s: Unknown symbol %s\n",
> -				   me->name, strtab + sym->st_name);
> +			pr_warn("%s: Unknown symbol %s\n",
> +				me->name, strtab + sym->st_name);
>  			return -ENOENT;
>  		}

Acked-by: Palmer Dabbelt <palmer@sifive.com>

I'm assuming this is going in through some other tree, LMK if that's not the 
case.
