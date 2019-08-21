Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46C05977FD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 13:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfHULgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 07:36:01 -0400
Received: from smtp.duncanthrax.net ([89.31.1.170]:40874 "EHLO
        smtp.duncanthrax.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfHULgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 07:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=duncanthrax.net; s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date;
        bh=X5zvVv9Ieb3EMIG3hCtybIcz0q5uCNQZMNTgaJo6mF0=; b=DTHJPH74Sg5X+iehiEG8Atemrx
        96iyXlm6ilfsmZZ/wM6zn5kdVX4pv1mfY4uIK1BZ2393mIkkrDcEjZNyLsS9/P9R2PbeZ9WhRjEdV
        nOkED+o36BiRXnFIoBhetGMOL70Ht9URPJkXvC/paanc4JqRTsUQXfjyeup4za6dWdZo=;
Received: from [2001:470:70c5:1111:5054:ff:febf:83e1] (helo=stackframe.org)
        by smtp.eurescom.eu with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.86_2)
        (envelope-from <svens@stackframe.org>)
        id 1i0Ou8-0006r9-Mg; Wed, 21 Aug 2019 13:35:52 +0200
Date:   Wed, 21 Aug 2019 13:35:51 +0200
From:   Sven Schnelle <svens@stackframe.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kprobes/parisc: remove arch_kprobe_on_func_entry()
Message-ID: <20190821113551.GB14547@stackframe.org>
References: <20190821174533.5736ca90@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821174533.5736ca90@xhacker.debian>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:56:40AM +0000, Jisheng Zhang wrote:
> The common kprobes provides a weak implementation of
> arch_kprobe_on_func_entry(). The parisc version is the same as the
> common version, so remove it.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Acked-by: Sven Schnelle <svens@stackframe.org>

> ---
>  arch/parisc/kernel/kprobes.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/parisc/kernel/kprobes.c b/arch/parisc/kernel/kprobes.c
> index 5d7f2692ac5a..77ec51818916 100644
> --- a/arch/parisc/kernel/kprobes.c
> +++ b/arch/parisc/kernel/kprobes.c
> @@ -281,10 +281,6 @@ int __kprobes arch_trampoline_kprobe(struct kprobe *p)
>  {
>  	return p->addr == trampoline_p.addr;
>  }
> -bool arch_kprobe_on_func_entry(unsigned long offset)
> -{
> -	return !offset;
> -}
>  
>  int __init arch_init_kprobes(void)
>  {
> -- 
> 2.23.0.rc1
> 
