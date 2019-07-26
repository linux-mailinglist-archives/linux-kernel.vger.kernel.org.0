Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 198E175DCD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 06:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbfGZE2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 00:28:24 -0400
Received: from foss.arm.com ([217.140.110.172]:37684 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbfGZE2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 00:28:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D942A337;
        Thu, 25 Jul 2019 21:28:23 -0700 (PDT)
Received: from [10.163.1.197] (unknown [10.163.1.197])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 387953F694;
        Thu, 25 Jul 2019 21:28:18 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [RFC] mm/pgtable/debug: Add test validating architecture page
 table helpers
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-mm@kvack.org, Mark Rutland <mark.rutland@arm.com>,
        x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Brown <Mark.Brown@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <Steven.Price@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <1564037723-26676-1-git-send-email-anshuman.khandual@arm.com>
 <1564037723-26676-2-git-send-email-anshuman.khandual@arm.com>
 <20190725170720.GB11545@arrakis.emea.arm.com>
Message-ID: <066e69dc-6ecc-6aba-0226-ba1d61ca0fa8@arm.com>
Date:   Fri, 26 Jul 2019 09:58:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190725170720.GB11545@arrakis.emea.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/25/2019 10:37 PM, Catalin Marinas wrote:
> On Thu, Jul 25, 2019 at 12:25:23PM +0530, Anshuman Khandual wrote:
>> +#if !defined(__PAGETABLE_PMD_FOLDED) && !defined(__ARCH_HAS_4LEVEL_HACK)
>> +static void pud_clear_tests(void)
>> +{
>> +	pud_t pud;
>> +
>> +	pud_clear(&pud);
>> +	WARN_ON(!pud_none(pud));
>> +}
> 
> For the clear tests, I think you should initialise the local variable to
> something non-zero rather than rely on whatever was on the stack. In
> case it fails, you have a more deterministic behaviour.

Sure, it makes sense, will change.
