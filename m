Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C320141116
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 19:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbgAQSr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 13:47:29 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44288 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727573AbgAQSr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 13:47:29 -0500
Received: from zn.tnic (p200300EC2F08DC0098C6A8393F59F989.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:dc00:98c6:a839:3f59:f989])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B9B8C1EC03F6;
        Fri, 17 Jan 2020 19:47:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579286847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Y2ZrufAmDTgI9TXivlSlbPcvv98I5hvXGSkhEsQnmuk=;
        b=OnvGup5BQQd1djQppGREI/Xmh13GQxmcxASd90ulRJpJ4ekUQ3Uq8EUm4A9yb8Zn7BG/57
        4Ggz1p7ip2pSLukVliRuFrXhHmSrDBwhREdT5DLkF3gIrRDfJOS6DJGTUJ+BqRgHCOqR6u
        HNyPYr6TR20k+Y/HPxAnPdXsx8lzXaQ=
Date:   Fri, 17 Jan 2020 19:47:20 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        DavidWang@zhaoxin.com, CooperYan@zhaoxin.com,
        QiyuanWang@zhaoxin.com, HerryYang@zhaoxin.com
Subject: Re: [PATCH] x86/cpu: remove redundant cpu_detect_cache_sizes
Message-ID: <20200117184720.GB31472@zn.tnic>
References: <1579075257-6985-1-git-send-email-TonyWWang-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1579075257-6985-1-git-send-email-TonyWWang-oc@zhaoxin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 04:00:57PM +0800, Tony W Wang-oc wrote:
> Before call cpu_detect_cache_sizes get l2size from CPUID.80000006,
> these CPUs have called init_intel_cacheinfo get l2size/l3size from
> CPUID.4.

Questions:

* Does CPUID(4) give the same result as CPUID(80000006) on those CPUs?

* cpu_detect_cache_sizes() sets c->x86_tlbsize while
init_intel_cacheinfo() would set it only when it calls the former
function - cpu_detect_cache_sizes() - at the end:

        if (!l2)
                cpu_detect_cache_sizes(c);

Does that happen on those CPUs?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
