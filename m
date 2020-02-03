Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0361B1510C6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Feb 2020 21:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgBCUJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 15:09:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:58020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbgBCUJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 15:09:45 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ED6D2084E;
        Mon,  3 Feb 2020 20:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580760584;
        bh=znlkAqyHGE6UPoa/HZ68BRPZsU14gD2TcYQSc7T+WOI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pAY7gJar6we9UcfBlVoagB7aST3fxfZISNe4AQkVyOuE4lV4meMbzWQ+/H0ZqzCip
         MHizLyruNaATOpRjl5zZolP690B7jWNkeQjTfkjMZIDUpN1yCwkp6WaOJpuCEMN5vJ
         og9IHC5GnVAs1xKXQNLLdV45z0H1fGwbean2pmB8=
Date:   Mon, 3 Feb 2020 14:09:42 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, hch@lst.de
Subject: Re: [PATCH] x86/PCI: ensure to_pci_sysdata usage is guarded by
 CONFIG_PCI
Message-ID: <20200203200942.GA130652@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203181906.78264-1-Jason@zx2c4.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 07:19:06PM +0100, Jason A. Donenfeld wrote:
> Recently, the helper to_pci_sysdata was added inside of the CONFIG_PCI
> guard, but it is used from inside of a CONFIG_PCI_MSI_IRQ_DOMAIN guard,
> which does not require CONFIG_PCI.

AFAICT, CONFIG_PCI_MSI_IRQ_DOMAIN *does* require CONFIG_PCI.

Do you mean to_pci_sysdata() is used inside a *CONFIG_NUMA* guard by
__pcibus_to_node()?

The patch below makes __pcibus_to_node() available only when
CONFIG_PCI, when previously it was always available.  Maybe that's
fine, I dunno.

Another possibility would be to move the to_pci_sysdata() definition
outside of #ifdef CONFIG_PCI, just as the struct pci_sysdata is.  Then
we wouldn't have to change the availability of __pcibus_to_node().

> This breaks builds on !CONFIG_PCI
> machines. This commit fixes the ifdef to require CONFIG_PCI.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Fixes: aad6aa0cd674 ("x86/PCI: Add to_pci_sysdata() helper")
> Cc: Christoph Hellwig <hch@lst.de>
> ---
>  arch/x86/include/asm/pci.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
> index 40ac1330adb2..d8772b75236d 100644
> --- a/arch/x86/include/asm/pci.h
> +++ b/arch/x86/include/asm/pci.h
> @@ -119,7 +119,7 @@ void native_restore_msi_irqs(struct pci_dev *dev);
>  /* generic pci stuff */
>  #include <asm-generic/pci.h>
>  
> -#ifdef CONFIG_NUMA
> +#if defined(CONFIG_NUMA) && defined(CONFIG_PCI)
>  /* Returns the node based on pci bus */
>  static inline int __pcibus_to_node(const struct pci_bus *bus)
>  {
> -- 
> 2.25.0
> 
