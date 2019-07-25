Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA5A75166
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 16:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbfGYOj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 10:39:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53152 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfGYOj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:39:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=38kZYSDy3zC5/h/SWKUk1efaWYIuv6kOUF9lD42ddaQ=; b=SVrTjodeLNK7q0jCMYEkBveo4
        Zu8/xuN291RTd2NCB0e0+OKyqdrkLflFyiEomdig7SwNxjlQDVAFmlQ2jeu20983UVJf83F2NB1eA
        5GNZIlel3ONkkxUoEQSUm6JN7E1HklNo+yop3vUZEmV775yV+YPo6NKgu6tqVvjKADkkdeAlwDaXg
        qxc/MJUpLs89zfDsR86K96FcPpSsvxoeEJxChdYwnoF/UzBTxasoFp/jNygj7PyXRonQta/gM89q8
        fPQ7GNopogRdlK47Z+dQF7P0aVZ8Oq5puPimr1TAo1+SQaiNFVfNa2j0J3pcmRuzNBLX+Y7aLOjNj
        7aDrkIKmg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hqett-0001f5-5B; Thu, 25 Jul 2019 14:39:21 +0000
Date:   Thu, 25 Jul 2019 07:39:21 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <Mark.Brown@arm.com>,
        Steven Price <Steven.Price@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] mm/pgtable/debug: Add test validating architecture page
 table helpers
Message-ID: <20190725143920.GW363@bombadil.infradead.org>
References: <1564037723-26676-1-git-send-email-anshuman.khandual@arm.com>
 <1564037723-26676-2-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564037723-26676-2-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 12:25:23PM +0530, Anshuman Khandual wrote:
> This adds a test module which will validate architecture page table helpers
> and accessors regarding compliance with generic MM semantics expectations.
> This will help various architectures in validating changes to the existing
> page table helpers or addition of new ones.

I think this is a really good idea.

>  lib/Kconfig.debug       |  14 +++
>  lib/Makefile            |   1 +
>  lib/test_arch_pgtable.c | 290 ++++++++++++++++++++++++++++++++++++++++++++++++

Is this the right place for it?  I worry that lib/ is going to get overloaded
with test code, and this feels more like mm/ test code.

> +#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE
> +static void pmd_basic_tests(void)
> +{
> +	pmd_t pmd;
> +
> +	pmd = mk_pmd(page, prot);

But 'page' isn't necessarily PMD-aligned.  I don't think we can rely on
architectures doing the right thing if asked to make a PMD for a randomly
aligned page.

How about finding the physical address of something like kernel_init(),
and using the corresponding pte/pmd/pud/p4d/pgd that encompasses that
address?  It's also better to pass in the pfn/page rather than using global
variables to communicate to the test functions.

> +	/*
> +	 * A huge page does not point to next level page table
> +	 * entry. Hence this must qualify as pmd_bad().
> +	 */
> +	WARN_ON(!pmd_bad(pmd_mkhuge(pmd)));

I didn't know that rule.  This is helpful because it gives us somewhere
to document all these tricksy little rules.

> +#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> +static void pud_basic_tests(void)

Is this the right ifdef?

