Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B019D7BA5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 18:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388112AbfJOQbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 12:31:46 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35873 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729863AbfJOQbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 12:31:45 -0400
Received: by mail-pf1-f193.google.com with SMTP id y22so12823919pfr.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 09:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=R/3o/XlsOOzp8o/GwTjOQU5ZV/+2+cmOJM3GXTaUs38=;
        b=PlHEVmt3faXIse9r8F2InoYn9wNFsTyZmDEweesHLL79X0bLN9KDw4yqKSfZ8K0Wso
         OhCC4gHqpBFWCx4XXsfzL/SzSZxseW3lOYSJENyjLMt2QAm70v2yjFTnJS6VgCVqhFQS
         6xDruCJaLis82RTf9USZ+SArCgufRG3LPniSpTZVINSvTIv5OZUQSGvT1mBKDw7A15Ck
         c7ANFyfG0LuSXN96v0bzdv05cfWSYI0S7FPdaUB+r3vMZ3JxtH5dUSz2NLyMxFsTgnnr
         X21LOs69aWCuKs7iSr3GmrROg9CdoBi4QVfI8BFmYxF3vFLm6j8wRrk8oVUwugRyRTEM
         dgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=R/3o/XlsOOzp8o/GwTjOQU5ZV/+2+cmOJM3GXTaUs38=;
        b=Q8JNgr2RK+DXZqs7RO82QCxiDQxu4M36xbvSh1xnX1phwgbMh8InouutC96MsWOZWg
         i8cqBdGVQOpmzKcrQ+liN3JZaD4coDreM5IYjBN9gNKBuUsIyQwohjcsvZsTqPVSNrX1
         SXrM7x/6Sa/M8v8Lox/+goCvauUGwuRasWzxEiiuUlO8kMwspS32XDIV7SZQCRUIW/ql
         4DOnAE8R8rtjsk1xIBwPE5Q4xlf1gTndJe+SYtIKbZKIRmYWgPuV4+P4hryF2oZ/zqha
         7y4Ajt95NRh1WJTRn8bm3bl3CYK95Vkvtwejg+lDLNlCPXQZYccniz1FLhIwJGqueGRY
         veLg==
X-Gm-Message-State: APjAAAXc1OCePQ9YXxoqzydvh0dgz6ngIYb6Fx8zQGUcISHsvbXJp+Im
        FI6b6+CrDNA+Gc/6FT3d1l36IfnMxYD1og==
X-Google-Smtp-Source: APXvYqzd0YxjnbtrTaTbz2PWcm/PlKHSLmgN6HPVbZgpX62QjBYrHs6tcjOEivuJEXa0UVGTH3IqDw==
X-Received: by 2002:a63:778f:: with SMTP id s137mr20201937pgc.147.1571157104362;
        Tue, 15 Oct 2019 09:31:44 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id c26sm19933849pfo.173.2019.10.15.09.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 09:31:43 -0700 (PDT)
Date:   Tue, 15 Oct 2019 09:31:43 -0700 (PDT)
X-Google-Original-Date: Tue, 15 Oct 2019 09:31:40 PDT (-0700)
Subject:     Re: [PATCH] irqchip: Place CONFIG_SIFIVE_PLIC into the menu
In-Reply-To: <20191002144452.10178-1-j.neuschaefer@gmx.net>
CC:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        j.neuschaefer@gmx.net, tglx@linutronix.de, jason@lakedaemon.net,
        maz@kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     j.neuschaefer@gmx.net
Message-ID: <mhng-f196bb74-ed87-41c9-98b9-a8161e663313@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Oct 2019 07:44:52 PDT (-0700), j.neuschaefer@gmx.net wrote:
> Somehow CONFIG_SIFIVE_PLIC ended up outside of the "IRQ chip support"
> menu.
>
> Fixes: 8237f8bc4f6e ("irqchip: add a SiFive PLIC driver")
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  drivers/irqchip/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index ccbb8973a324..97f9c001d8ff 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -483,8 +483,6 @@ config TI_SCI_INTA_IRQCHIP
>  	  If you wish to use interrupt aggregator irq resources managed by the
>  	  TI System Controller, say Y here. Otherwise, say N.
>
> -endmenu
> -
>  config SIFIVE_PLIC
>  	bool "SiFive Platform-Level Interrupt Controller"
>  	depends on RISCV
> @@ -496,3 +494,5 @@ config SIFIVE_PLIC
>  	   interrupt sources are subordinate to the PLIC.
>
>  	   If you don't know what to do here, say Y.
> +
> +endmenu

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Acked-by: Palmer Dabbelt <palmer@sifive.com>

I'm assuming this is going through the irqchip tree.
