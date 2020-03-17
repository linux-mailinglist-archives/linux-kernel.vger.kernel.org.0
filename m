Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0F4A18829B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 12:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgCQLzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 07:55:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:33474 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgCQLzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:55:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1877FAC5B;
        Tue, 17 Mar 2020 11:55:02 +0000 (UTC)
Date:   Tue, 17 Mar 2020 12:55:01 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     tglx@linutronix.de, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC][PATCH 05/16] objtool: Optimize find_symbol_by_index()
In-Reply-To: <20200312135041.699859794@infradead.org>
Message-ID: <alpine.LSU.2.21.2003171253180.2339@pobox.suse.cz>
References: <20200312134107.700205216@infradead.org> <20200312135041.699859794@infradead.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> --- a/tools/objtool/elf.h
> +++ b/tools/objtool/elf.h
> @@ -27,7 +27,6 @@ struct section {
>  	struct list_head list;
>  	GElf_Shdr sh;
>  	struct list_head symbol_list;
> -	DECLARE_HASHTABLE(symbol_hash, 8);
>  	struct list_head rela_list;
>  	DECLARE_HASHTABLE(rela_hash, 16);
>  	struct section *base, *rela;
> @@ -71,7 +70,7 @@ struct elf {
>  	int fd;
>  	char *name;
>  	struct list_head sections;
> -	DECLARE_HASHTABLE(rela_hash, 16);
> +	DECLARE_HASHTABLE(symbol_hash, 20);
>  };

Not that it really matters, but what was rela_hash in struct elf for 
before this?

Miroslav
