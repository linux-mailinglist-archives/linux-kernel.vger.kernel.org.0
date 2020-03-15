Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62557185E74
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Mar 2020 17:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbgCOQYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Mar 2020 12:24:31 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51258 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728628AbgCOQYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 12:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584289469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3melXqx5sVn7s0FyqhLjIrOfer6iodIv6e1Smo43uyI=;
        b=YAhv0JHlNgZnOPweiI+MtcvorZcJhzwKkVkstmSlvHBuT2RBG67TnNk7fQZK+2CM6pvNhd
        iDJC1uVvXrcKjfsKEFKH2TsqW2h8AHu/5DunUZmvt4zYJREJaNCU03yYY3FqavLeiFE56O
        rlCgEVZoNGGP45rzMIBIYAG/WqC3g88=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-ksQ35h9yPdiWAaQVfEkiww-1; Sun, 15 Mar 2020 12:24:28 -0400
X-MC-Unique: ksQ35h9yPdiWAaQVfEkiww-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D75813F5;
        Sun, 15 Mar 2020 16:24:27 +0000 (UTC)
Received: from treble (ovpn-120-135.rdu2.redhat.com [10.10.120.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 85F9F5C1B2;
        Sun, 15 Mar 2020 16:24:26 +0000 (UTC)
Date:   Sun, 15 Mar 2020 11:24:24 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC][PATCH 07/16] objtool: Optimize find_section_by_index()
Message-ID: <20200315162424.sh27zgjh3plronkc@treble>
References: <20200312134107.700205216@infradead.org>
 <20200312135041.817117618@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200312135041.817117618@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 02:41:14PM +0100, Peter Zijlstra wrote:
> In order to avoid a linear search (over 20k entries), add an
> section_hash to the elf object.
> 
> This reduces objtool on vmlinux.o from a few minutes to around 45
> seconds.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  tools/objtool/elf.c |    7 ++++++-
>  tools/objtool/elf.h |    2 ++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -38,7 +38,7 @@ static struct section *find_section_by_i
>  {
>  	struct section *sec;
>  
> -	list_for_each_entry(sec, &elf->sections, list)
> +	hash_for_each_possible(elf->section_hash, sec, hash, idx)
>  		if (sec->idx == idx)
>  			return sec;
>  
> @@ -191,6 +191,8 @@ static int read_sections(struct elf *elf
>  			}
>  		}
>  		sec->len = sec->sh.sh_size;
> +
> +		hash_add(elf->section_hash, &sec->hash, sec->idx);

Can you move the

  list_add_tail(&sec->list, &elf->sections);

down here so they're done at the same place?

>  	}
>  
>  	if (stats)
> @@ -430,6 +432,7 @@ struct elf *elf_read(const char *name, i
>  	memset(elf, 0, sizeof(*elf));
>  
>  	hash_init(elf->symbol_hash);
> +	hash_init(elf->section_hash);
>  	INIT_LIST_HEAD(&elf->sections);
>  
>  	elf->fd = open(name, flags);
> @@ -570,6 +573,8 @@ struct section *elf_create_section(struc
>  	shstrtab->len += strlen(name) + 1;
>  	shstrtab->changed = true;
>  
> +	hash_add(elf->section_hash, &sec->hash, sec->idx);
> +
>  	return sec;
>  }

Ditto

-- 
Josh

