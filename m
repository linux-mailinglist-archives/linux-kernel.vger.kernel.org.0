Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D94CF18C5B1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 04:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgCTDX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 23:23:26 -0400
Received: from foss.arm.com ([217.140.110.172]:43734 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbgCTDXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 23:23:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AB811FB;
        Thu, 19 Mar 2020 20:23:25 -0700 (PDT)
Received: from [10.163.1.20] (unknown [10.163.1.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8E883F85E;
        Thu, 19 Mar 2020 20:23:21 -0700 (PDT)
Subject: Re: [PATCH] x86/mm: Make pud_present() check _PAGE_PROTNONE and
 _PAGE_PSE as well
To:     linux-mm@kvack.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Dan Williams <dan.j.williams@intel.com>
References: <1584507679-11976-1-git-send-email-anshuman.khandual@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <c03165c8-6d44-49c2-2dad-a85759200718@arm.com>
Date:   Fri, 20 Mar 2020 08:53:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1584507679-11976-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/18/2020 10:31 AM, Anshuman Khandual wrote:
> pud_present() should also check _PAGE_PROTNONE and _PAGE_PSE bits like in
> case pmd_present(). This makes a PUD entry test positive for pud_present()
> after getting invalidated with pud_mknotpresent(), hence standardizing the
> semantics with PMD helpers.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: x86@kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> Even though pud_mknotpresent() is not used any where currently, there is
> a discrepancy between PMD and PUD.
> 
> WARN_ON(!pud_present(pud_mknotpresent(pud_mkhuge(pud)))) -> Fail
> WARN_ON(!pmd_present(pmd_mknotpresent(pmd_mkhuge(pmd)))) -> Pass
> 
> Though pud_mknotpresent() currently clears _PAGE_PROTNONE, pud_present()
> does not check it. This change fixes both inconsistencies.
> 
> This has been build and boot tested on x86.

Adding Kirill and Dan.

+Cc: Kirill A. Shutemov <kirill@shutemov.name>
+Cc: Dan Williams <dan.j.williams@intel.com>
