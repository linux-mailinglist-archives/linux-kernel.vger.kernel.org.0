Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E01F0C2462
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2019 17:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732067AbfI3Pen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Sep 2019 11:34:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:44792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727508AbfI3Pem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 11:34:42 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5AA120815;
        Mon, 30 Sep 2019 15:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569857682;
        bh=dh8MId5t8DVUeOU3OX/W3m9Vy+7RlrdAA9s6eGZznGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N0XqWdQTs246eEuhXf6R0AkLtqFzW8Q3jwlTgxIZiMwTYbQRmB7lbT1+mJpEcZHPK
         Q/RrotNDuWGCNKuTmZ7HTn0TBmIOUaf568izduqQPXsLMI5Lo4f/lv2WwzU3flEgyx
         WaVLdCGVNPY1jmzdlQQ1jhzhuMViRq47KKh+27Cw=
Date:   Mon, 30 Sep 2019 16:34:37 +0100
From:   Will Deacon <will@kernel.org>
To:     Candle Sun <candlesea@gmail.com>
Cc:     mark.rutland@arm.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Candle Sun <candle.sun@unisoc.com>,
        Nianfu Bai <nianfu.bai@unisoc.com>
Subject: Re: [RESEND PATCH] ARM/hw_breakpoint: add ARMv8.1/ARMv8.2 debug
 architecutre versions support in enable_monitor_mode()
Message-ID: <20190930153437.ocatny7u4z3oj7k2@willie-the-truck>
References: <1569483508-18768-1-git-send-email-candlesea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569483508-18768-1-git-send-email-candlesea@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 03:38:28PM +0800, Candle Sun wrote:
> From: Candle Sun <candle.sun@unisoc.com>
> 
> When ARMv8.1/ARMv8.2 cores are used in AArch32 mode,
> arch_hw_breakpoint_init() in arch/arm/kernel/hw_breakpoint.c will be used.
> 
> From ARMv8 specification, different debug architecture versions defined:
> * 0110 ARMv8, v8 Debug architecture.
> * 0111 ARMv8.1, v8 Debug architecture, with Virtualization Host Extensions.
> * 1000 ARMv8.2, v8.2 Debug architecture.
> 
> So missing ARMv8.1/ARMv8.2 cases will cause enable_monitor_mode() function
> returns -ENODEV, and arch_hw_breakpoint_init() will fail.
> 
> Signed-off-by: Candle Sun <candle.sun@unisoc.com>
> Signed-off-by: Nianfu Bai <nianfu.bai@unisoc.com>
> ---
>  arch/arm/include/asm/hw_breakpoint.h | 2 ++
>  arch/arm/kernel/hw_breakpoint.c      | 2 ++
>  2 files changed, 4 insertions(+)

How did you test this?

Will
