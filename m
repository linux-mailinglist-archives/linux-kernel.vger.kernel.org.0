Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18D7519AC1E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 14:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732645AbgDAMxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 08:53:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:57064 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732490AbgDAMxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 08:53:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D5D0CAC5F;
        Wed,  1 Apr 2020 12:53:42 +0000 (UTC)
Date:   Wed, 1 Apr 2020 14:53:42 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Julien Thierry <jthierry@redhat.com>
cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, raphael.gault@arm.com
Subject: Re: [PATCH v2 04/10] objtool: check: Ignore empty alternative
 groups
In-Reply-To: <20200327152847.15294-5-jthierry@redhat.com>
Message-ID: <alpine.LSU.2.21.2004011450100.15809@pobox.suse.cz>
References: <20200327152847.15294-1-jthierry@redhat.com> <20200327152847.15294-5-jthierry@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Mar 2020, Julien Thierry wrote:

> Atlernative section can contain entries for alternatives with no
> instructions. Objtool will currently crash when handling such an entry.
> 
> Just skip that entry, but still give a warning to discourage useless
> entries.
> 
> Signed-off-by: Julien Thierry <jthierry@redhat.com>
> ---
>  tools/objtool/check.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 74353b2c39ce..5c03460f1f07 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -904,6 +904,12 @@ static int add_special_section_alts(struct objtool_file *file)
>  		}
>  
>  		if (special_alt->group) {
> +			if (!special_alt->orig_len) {
> +				WARN_FUNC("empty alternative entry",
> +					  orig_insn->sec, orig_insn->offset);
> +				continue;
> +			}
> +
>  			ret = handle_group_alt(file, special_alt, orig_insn,
>  					       &new_insn);
>  			if (ret)

Probably the first time I am looking at alternatives handling in objtool, 
so I must be missing something, but is this even possible now? I mean 
get_alt_entry() in special.c sets alt->orig_len when alt->group is true 
(which means .alternatives section) to something which cannot be zero.

Is this a preparatory patch for arm64, where this could happen? If yes, it 
would be better to mention it in the changelog.

Miroslav
