Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9DD99FAB4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 08:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfH1Gmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 02:42:38 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46808 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbfH1Gmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 02:42:37 -0400
Received: from zn.tnic (p200300EC2F0A5300695CBFF1DBB4ADA1.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:5300:695c:bff1:dbb4:ada1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9F2F51EC0A9C;
        Wed, 28 Aug 2019 08:42:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1566974556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=q3SPVObGZs4wIn6VYQDUEo/svpxKkil+BKyip/LH4Ng=;
        b=LAGTZCbAMoDZ32+nudzNSSo+1vA2I9ouKsKgYn2PnmV2u1AxDuIkAR2Ej2dEci/roI750W
        lAgdfNenXYMDj/RoeoXvE7YIbFGrdRLWbUQaoKFRrn1dgQ+k0uWNM+S7pmiVdVdugPvZbu
        IpRxMZPJB37qx1fn/UpDzPsL7+bWMd4=
Date:   Wed, 28 Aug 2019 08:42:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Cao jin <caoj.fnst@cn.fujitsu.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH] x86/cpufeature: explicit comments for duplicate macro
Message-ID: <20190828064231.GB4920@zn.tnic>
References: <20190828061100.27032-1-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190828061100.27032-1-caoj.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 02:11:00PM +0800, Cao jin wrote:

For the future:

> Subject: Re: [PATCH] x86/cpufeature: explicit comments for duplicate macro

your subject needs to have a verb and start with a capital letter after
the subsystem/path prefix. In this case, something like this, for
example:

Subject: [PATCH] x86/cpufeature: Explain the macro duplication

> Help people to understand the author's intent of apparent duplication of
> BUILD_BUG_ON_ZERO(NCAPINTS != n), which is hard to detect by eyes.
> 
> CC: Dave Hansen <dave.hansen@intel.com>
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> ---
> Tried my best to describe it accurately, in case of any inaccuracy, feel
> free to rephrase.

Yap, I fixed it up.

Thanks!

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
