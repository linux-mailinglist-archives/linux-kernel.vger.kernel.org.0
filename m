Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E93E29A0B0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 22:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392521AbfHVUES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 16:04:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43686 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387767AbfHVUES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 16:04:18 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EBC9181F11;
        Thu, 22 Aug 2019 20:04:17 +0000 (UTC)
Received: from treble (ovpn-121-55.rdu2.redhat.com [10.10.121.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F3B3860CDA;
        Thu, 22 Aug 2019 20:04:16 +0000 (UTC)
Date:   Thu, 22 Aug 2019 15:04:15 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Raphael Gault <raphael.gault@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
        julien.thierry.kdev@gmail.com, raph.gault+kdev@gmail.com
Subject: Re: [RFC v4 08/18] objtool: Refactor switch-tables code to support
 other architectures
Message-ID: <20190822200415.t3hkjxf4m3lg5tgz@treble>
References: <20190816122403.14994-1-raphael.gault@arm.com>
 <20190816122403.14994-9-raphael.gault@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190816122403.14994-9-raphael.gault@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 22 Aug 2019 20:04:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 01:23:53PM +0100, Raphael Gault wrote:
> The way to identify switch-tables and retrieves all the data necessary
> to handle the different execution branches is not the same on all
> architecture. In order to be able to add other architecture support,
> this patch defines arch-dependent functions to process jump-tables.
> 
> Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> ---
>  tools/objtool/arch/arm64/arch_special.c | 15 ++++
>  tools/objtool/arch/arm64/decode.c       |  4 +-
>  tools/objtool/arch/x86/arch_special.c   | 79 ++++++++++++++++++++
>  tools/objtool/check.c                   | 95 +------------------------
>  tools/objtool/check.h                   |  7 ++
>  tools/objtool/special.h                 | 10 ++-
>  6 files changed, 114 insertions(+), 96 deletions(-)
> 
> diff --git a/tools/objtool/arch/arm64/arch_special.c b/tools/objtool/arch/arm64/arch_special.c
> index a21d28876317..17a8a06aac2a 100644
> --- a/tools/objtool/arch/arm64/arch_special.c
> +++ b/tools/objtool/arch/arm64/arch_special.c
> @@ -20,3 +20,18 @@ void arch_force_alt_path(unsigned short feature,
>  			 struct special_alt *alt)
>  {
>  }
> +
> +int arch_add_jump_table(struct objtool_file *file, struct instruction *insn,
> +			struct rela *table, struct rela *next_table)
> +{
> +	return 0;
> +}
> +
> +struct rela *arch_find_switch_table(struct objtool_file *file,
> +				  struct rela *text_rela,
> +				  struct section *rodata_sec,
> +				  unsigned long table_offset)
> +{
> +	file->ignore_unreachables = true;
> +	return NULL;
> +}

If this refactoring is done before adding arm64 support then you won't
need intermediate hacks like this.

-- 
Josh
