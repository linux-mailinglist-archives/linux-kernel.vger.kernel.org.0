Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A08A4170642
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 18:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgBZRi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 12:38:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:54604 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbgBZRi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 12:38:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3B2F9AC66;
        Wed, 26 Feb 2020 17:38:55 +0000 (UTC)
Subject: Re: [PATCH V2 1/4] mm/vma: Add missing VMA flag readable name for
 VM_SYNC
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
References: <1582520593-30704-1-git-send-email-anshuman.khandual@arm.com>
 <1582520593-30704-2-git-send-email-anshuman.khandual@arm.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <c8a8960d-b979-9c93-c3f1-4d4233810919@suse.cz>
Date:   Wed, 26 Feb 2020 18:38:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1582520593-30704-2-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/20 6:03 AM, Anshuman Khandual wrote:
> This just adds the missing readable name for VM_SYNC.
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz

> ---
>  include/trace/events/mmflags.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
> index a1675d43777e..5fb752034386 100644
> --- a/include/trace/events/mmflags.h
> +++ b/include/trace/events/mmflags.h
> @@ -154,6 +154,7 @@ IF_HAVE_PG_IDLE(PG_idle,		"idle"		)
>  	{VM_ACCOUNT,			"account"	},		\
>  	{VM_NORESERVE,			"noreserve"	},		\
>  	{VM_HUGETLB,			"hugetlb"	},		\
> +	{VM_SYNC,			"sync"		},		\
>  	__VM_ARCH_SPECIFIC_1				,		\
>  	{VM_WIPEONFORK,			"wipeonfork"	},		\
>  	{VM_DONTDUMP,			"dontdump"	},		\
> 

