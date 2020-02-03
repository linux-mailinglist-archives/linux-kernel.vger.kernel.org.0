Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 909061512D7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 00:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgBCXRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 18:17:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53082 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbgBCXRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 18:17:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=tHWXelqy/znzMF/hisstsWcUWFHUWVNzpgrAR2EDFMA=; b=EiMNhEcFgvxPsuKN0FbRgn0l+6
        7LODD7RsE4kMvTYLZkM/h6YsDiPCWiO9pjhzGBrBUt5MZq80HOiIMI8EppjKtV/XoidTG1tu9Ofqx
        AHDc/AnEIyVBJdsQkmYFDe4avwCm+R+y+Atg/jbFx7rEaxiUNvZZBqnojCqtLMTB8MQ1GLSaXmBKQ
        ie7lI1Es4i1OjuhrgWG1wXwLqvPp50SNzZgmkMgwNkL9MOJ4ujO7W0qVk2pCKMZ7EaikHO60ii/G7
        T6jmAwPDhWTX4kNR7g3z/8JH9vuVXfW76yTgYY40tRfgevRJtMJkJS934BEndKGrAK869mlxGTpbg
        yZtkiDFw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iykyU-0005k5-R5; Mon, 03 Feb 2020 23:17:50 +0000
Subject: Re: [PATCH v2] x86/PCI: ensure to_pci_sysdata usage is available to
 !CONFIG_PCI
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, bhelgaas@google.com, x86@kernel.org,
        hch@lst.de
References: <20200203200942.GA130652@google.com>
 <20200203215306.172000-1-Jason@zx2c4.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <75592335-ccb7-7d89-0578-1362d27c3dca@infradead.org>
Date:   Mon, 3 Feb 2020 15:17:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203215306.172000-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/20 1:53 PM, Jason A. Donenfeld wrote:
> Recently, the helper to_pci_sysdata was added inside of the CONFIG_PCI
> guard, but it is used from inside of a CONFIG_NUMA guard, which does not
> require CONFIG_PCI. This breaks builds on !CONFIG_PCI machines. This
> commit makes that function available in all configurations.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Fixes: aad6aa0cd674 ("x86/PCI: Add to_pci_sysdata() helper")
> Cc: Christoph Hellwig <hch@lst.de>

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  arch/x86/include/asm/pci.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
> index 40ac1330adb2..7ccb338507e3 100644
> --- a/arch/x86/include/asm/pci.h
> +++ b/arch/x86/include/asm/pci.h
> @@ -33,13 +33,13 @@ extern int pci_routeirq;
>  extern int noioapicquirk;
>  extern int noioapicreroute;
>  
> -#ifdef CONFIG_PCI
> -
>  static inline struct pci_sysdata *to_pci_sysdata(const struct pci_bus *bus)
>  {
>  	return bus->sysdata;
>  }
>  
> +#ifdef CONFIG_PCI
> +
>  #ifdef CONFIG_PCI_DOMAINS
>  static inline int pci_domain_nr(struct pci_bus *bus)
>  {
> 


-- 
~Randy
