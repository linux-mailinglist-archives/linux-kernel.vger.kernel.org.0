Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51CABB0D6D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 13:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731372AbfILLAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Sep 2019 07:00:19 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46072 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731357AbfILLAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 07:00:18 -0400
Received: by mail-ed1-f66.google.com with SMTP id f19so23500913eds.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 04:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i4n3cs5YIwHpBBnCvQbY3FnLMZHpwOIQycs63oVDiSc=;
        b=XU1ehr7BQ2UPg1KBuVQ5nl6L4OIYSyENUTpJxtu0PcESlZD1JDIDF/kfEGLVTwGTPP
         MxBuxnwufiCItM0eu2f6PGyyjzV27Q2cNWmrCI/fGkWv00JgM+mdZSN1lgpv2XIZF9yD
         Ti1WM/t84cLxXEP8DSXzi5NQKs0TYyJ79hQa7AZv9JgQdH0hTuNKnH8BEAiZ+ewccLLa
         vvU+d/v7/7I+eQ9LvIytn9jJr+WOd1sRRaRjF83QEr00IfWCJU2SCQ/EcoyWOdAh3E8X
         tFKZsg92QCTLtpzpNowjR1vbUr8LIL24WrcjhMNVcplThOrveFyd6bS7Oehx93UQGF8r
         wpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i4n3cs5YIwHpBBnCvQbY3FnLMZHpwOIQycs63oVDiSc=;
        b=Skpkg81mSKaeri7wnaPNyiIJip22+QYD80upVV7yC0zeH67mapNDzYxIlKe6TcUAV6
         6dgbb2BdEVLjrkQdPzSoPCPrxAaDFaVFO8YwLRVeUPS50v1c9joPmtXimFTQdeOqTad7
         8fpvMRwOQsflr6itFkRz5lJAQSQ9S4OKLsfM48lVFL2xE6Uqx3gi3ztoSbzYhWgdT028
         TzzkumuBGxAT0rbKjRg2fuOKoHIrQQHvnxuh9j2WSN2R03wBdnCD5pzy2RjH65L24PBR
         MC1CNr/UbzuT/mJ67JsyYt9Im8pbO/hVr9SCnnJ/r5fcB3AcoGa2LC2eM8HIb9y7c8Tt
         CphA==
X-Gm-Message-State: APjAAAXjTMLDhJvKitv6AyD8Ur8snKSquwCeA1U2wstcRISL9rrL+6Zb
        LEdYw8PGCJJ/p/yeyPfBTzQobA==
X-Google-Smtp-Source: APXvYqzn86bOsg/hOamx0ZM4X4jdcRXf0RIV/TYjmuJGR8c1qTMEHrx7GcnktNsAZCbZ5Sfr2/boLg==
X-Received: by 2002:a50:d084:: with SMTP id v4mr42151595edd.48.1568286015703;
        Thu, 12 Sep 2019 04:00:15 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id 60sm4730030edg.10.2019.09.12.04.00.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 04:00:14 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 379ED100B4A; Thu, 12 Sep 2019 14:00:16 +0300 (+03)
Date:   Thu, 12 Sep 2019 14:00:16 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Steven Price <Steven.Price@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Matthew Wilcox <willy@infradead.org>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Vineet Gupta <vgupta@synopsys.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-snps-arc@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/2] mm/pgtable/debug: Add test validating
 architecture page table helpers
Message-ID: <20190912110016.srrydg2krplscbgq@box>
References: <1568268173-31302-1-git-send-email-anshuman.khandual@arm.com>
 <1568268173-31302-3-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568268173-31302-3-git-send-email-anshuman.khandual@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 11:32:53AM +0530, Anshuman Khandual wrote:
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Anshuman Khandual <anshuman.khandual@arm.com>");
> +MODULE_DESCRIPTION("Test architecture page table helpers");

It's not module. Why?

BTW, I think we should make all code here __init (or it's variants) so it
can be discarded on boot. It has not use after that.

-- 
 Kirill A. Shutemov
