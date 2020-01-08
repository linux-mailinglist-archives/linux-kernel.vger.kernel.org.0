Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0685133859
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 02:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgAHBSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 20:18:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49374 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgAHBSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 20:18:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wFeUtLqDdYfoqnLCIvPcr81nQOqlnYLhlf7CgTcrnRU=; b=A+B5sqPyBKp8iqaRhlI6QKCzh
        zUGSenX3ypX9Ieh3x7EHksAgO05rukUMrsrCezSPCvdIJdSjhYRa4CQIBBs1RpE4tSCa50N6q80SC
        vK7os45y2eIM34SJj7phNilcisdeV5qOJxjSpmeI5Bw0bblhJWGxPy4+oMqt999JzkI1zQaugl4L9
        WesFlBwRg9cbkWqrZ+kVcqippSgtyjYpUFvgodqZdYjk6zoYI+86pDztogbLEOg/Ad7LvOmFgvfvd
        juF22BUjoYYwwl4fDnNsKxgoByhTJSGwEfZ/8NNJtmguCf1GpKUtqppZMXQTmMONN2rPdqfVsiL95
        FThAOCmMA==;
Received: from [2601:1c0:6280:3f0::ed68]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iozzH-0000EC-PV; Wed, 08 Jan 2020 01:18:19 +0000
Subject: Re: [PATCH] x86/boot: fix cast to pointer compiler warning
To:     Edwin Zimmerman <edwin@211mainstreet.net>, x86@kernel.org,
        Matthew Garrett <mjg59@google.com>,
        linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Josh Boyer <jwboyer@redhat.com>
References: <8dd48f03-4d7c-25bb-2a2f-27461c0004ba@211mainstreet.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0be4cdcc-a1f8-36a9-69f2-bac02c8f9a9f@infradead.org>
Date:   Tue, 7 Jan 2020 17:18:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <8dd48f03-4d7c-25bb-2a2f-27461c0004ba@211mainstreet.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/20 9:38 PM, Edwin Zimmerman wrote:
> Fix cast-to-pointer compiler warning
> 
> arch/x86/boot/compressed/acpi.c: In function ‘get_acpi_srat_table’:
> arch/x86/boot/compressed/acpi.c:316:9: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> rsdp = (struct acpi_table_rsdp *)get_cmdline_acpi_rsdp();
>         ^
> Fixes: 41fa1ee9c6d6 ("acpi: Ignore acpi_rsdp kernel param when the kernel has been locked down")
> Signed-off-by: Edwin Zimmerman <edwin@211mainstreet.net>
> ---
> arch/x86/boot/compressed/acpi.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
> index 25019d42ae93..5d2568066d58 100644
> --- a/arch/x86/boot/compressed/acpi.c
> +++ b/arch/x86/boot/compressed/acpi.c
> @@ -313,7 +313,7 @@ static unsigned long get_acpi_srat_table(void)
> * stash this in boot params because the kernel itself may have
> * different ideas about whether to trust a command-line parameter.
> */
> - rsdp = (struct acpi_table_rsdp *)get_cmdline_acpi_rsdp();
> + rsdp = (struct acpi_table_rsdp *)(long)get_cmdline_acpi_rsdp();
> if (!rsdp)
> rsdp = (struct acpi_table_rsdp *)(long)
> 

Lots of whitespace damage.  Probably your email client or some
intermediary.

-- 
~Randy

