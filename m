Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C30875518
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 19:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387738AbfGYRGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 13:06:17 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44620 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727530AbfGYRGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:06:17 -0400
Received: from nazgul.tnic (87-126-252-198.ip.btc-net.bg [87.126.252.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 209211EC02FF;
        Thu, 25 Jul 2019 19:06:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1564074374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w+jFzT2f4YGeZrmB1rH4+Ej+CuRW6q4gExi/M8QmW6w=;
        b=pZKEqbGPSX71PWGXI4/P61BNkGCy1p9/E/7KagLSnvhJ1hvdYOQr3VduXTJwAA4P/Om9By
        0Ga8vxrAQKnBOUuLjiC/90pZuCVz0ZL4iPHpgvb3Fz+E/VdAR4KDdLoyrHzOOiVm5iYstI
        Ps+xeqVPirDSThEh0Elw8chwb4pLB50=
Date:   Thu, 25 Jul 2019 19:06:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org,
        gustavo@embeddedor.com, torvalds@linux-foundation.org,
        acme@kernel.org, kan.liang@linux.intel.com, namhyung@kernel.org,
        jolsa@redhat.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, keescook@chromium.org,
        peterz@infradead.org
Cc:     linux-tip-commits@vger.kernel.org
Subject: Re: [tip:perf/urgent] perf/x86/intel: Mark expected switch
 fall-throughs
Message-ID: <20190725170613.GC27348@nazgul.tnic>
References: <20190624161913.GA32270@embeddedor>
 <tip-289a2d22b5b611d85030795802a710e9f520df29@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tip-289a2d22b5b611d85030795802a710e9f520df29@git.kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 09:27:10AM -0700, tip-bot for Gustavo A. R. Silva wrote:
> Commit-ID:  289a2d22b5b611d85030795802a710e9f520df29
> Gitweb:     https://git.kernel.org/tip/289a2d22b5b611d85030795802a710e9f520df29
> Author:     Gustavo A. R. Silva <gustavo@embeddedor.com>
> AuthorDate: Mon, 24 Jun 2019 11:19:13 -0500
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Thu, 25 Jul 2019 15:57:03 +0200
> 
> perf/x86/intel: Mark expected switch fall-throughs
> 
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warnings:

"This patch"

> 
>   arch/x86/events/intel/core.c: In function ‘intel_pmu_init’:
>   arch/x86/events/intel/core.c:4959:8: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   arch/x86/events/intel/core.c:5008:8: warning: this statement may fall through [-Wimplicit-fallthrough=]
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> This patch is part of the ongoing efforts to enable -Wimplicit-fallthrough.

Another "This patch"

I think it is clear about which patch the commit message is talking
about, without stating it explicitly.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
