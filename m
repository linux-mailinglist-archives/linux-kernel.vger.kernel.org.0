Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6517618EDAE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 02:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgCWBho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Mar 2020 21:37:44 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:54006 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726951AbgCWBho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 21:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584927462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tg3v//938qsYJhCGyEEV6MmGSlsR1D+MJVYdwSmyjYA=;
        b=KzeqrLYFzZyomZ47IFhe9qw8kWrRbmO1boxa1ry1uhwcVNXkmpnXIJQ/HUYXRGlztsRaQX
        dfkxjM59GzAA3UeHJ1l7G0W9HZ3PI4P/UreNR1G17broh9IolX9N8BF4EcoEHLomieO5ef
        Ixi5x9CLeFo6znWRMI8uwy1UsjmwV+Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-zCMmMiyGN_qvBj5Mdzb_LQ-1; Sun, 22 Mar 2020 21:37:38 -0400
X-MC-Unique: zCMmMiyGN_qvBj5Mdzb_LQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7F16800D4E;
        Mon, 23 Mar 2020 01:37:35 +0000 (UTC)
Received: from localhost (ovpn-12-35.pek2.redhat.com [10.72.12.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C114D19C4F;
        Mon, 23 Mar 2020 01:37:34 +0000 (UTC)
Date:   Mon, 23 Mar 2020 09:37:32 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, jhubbard@nvidia.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/memory: Drop pud_mknotpresent()
Message-ID: <20200323013732.GC3039@MiWiFi-R3L-srv>
References: <1584925542-13034-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584925542-13034-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23/20 at 06:35am, Anshuman Khandual wrote:
> There is an inconsistency between PMD and PUD based THP page table helpers
> like the following, as pud_present() does not test for _PAGE_PSE.
> 
> pmd_present(pmd_mknotpresent(pmd)) : True
> pud_present(pud_mknotpresent(pud)) : False
> 
> This drops pud_mknotpresent() as there are no current users. If/when needed
> back later, pud_present() will also have to fixed to accommodate _PAGE_PSE.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Kirill A. Shutemov <kirill@shutemov.name>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: x86@kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This has been build and boot tested on x86.
> 
> Changes in V2:
> 
> - Dropped pud_mknotpresent() instead per Kirill
> 
> Changes in V1: (https://patchwork.kernel.org/patch/11444529/)
> 
>  arch/x86/include/asm/pgtable.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 7e118660bbd9..d74dc560e3ab 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -595,12 +595,6 @@ static inline pmd_t pmd_mknotpresent(pmd_t pmd)
>  		      __pgprot(pmd_flags(pmd) & ~(_PAGE_PRESENT|_PAGE_PROTNONE)));
>  }
>  
> -static inline pud_t pud_mknotpresent(pud_t pud)
> -{
> -	return pfn_pud(pud_pfn(pud),
> -	      __pgprot(pud_flags(pud) & ~(_PAGE_PRESENT|_PAGE_PROTNONE)));
> -}
> -
>  static inline u64 flip_protnone_guard(u64 oldval, u64 val, u64 mask);
>  
>  static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)

Reviewed-by: Baoquan He <bhe@redhat.com>

