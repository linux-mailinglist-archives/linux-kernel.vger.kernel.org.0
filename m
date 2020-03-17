Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBB2188385
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 13:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgCQMWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 08:22:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:48968 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbgCQMWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 08:22:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 34410B1B3;
        Tue, 17 Mar 2020 12:22:24 +0000 (UTC)
Date:   Tue, 17 Mar 2020 13:22:23 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     tglx@linutronix.de, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC][PATCH 08/16] Optimize find_section_by_name()
In-Reply-To: <20200312135041.875820323@infradead.org>
Message-ID: <alpine.LSU.2.21.2003171321170.2339@pobox.suse.cz>
References: <20200312134107.700205216@infradead.org> <20200312135041.875820323@infradead.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -193,6 +198,7 @@ static int read_sections(struct elf *elf
>  		sec->len = sec->sh.sh_size;
>  
>  		hash_add(elf->section_hash, &sec->hash, sec->idx);
> +		hash_add(elf->section_name_hash, &sec->name_hash, str_hash(sec->name));
>  	}

Don't you need to the same in elf_create_section()?

Miroslav
