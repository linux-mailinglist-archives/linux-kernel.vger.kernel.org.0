Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 996398226D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 18:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbfHEQcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 12:32:09 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39300 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbfHEQcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 12:32:09 -0400
Received: from zn.tnic (p200300EC2F065B00683A29B48F14DC99.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:5b00:683a:29b4:8f14:dc99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A405F1EC0C31;
        Mon,  5 Aug 2019 18:32:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565022728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=g+cTmbSEFfoz2KUZz+uvRnfYrlj//AwDFvYHV2OvsKQ=;
        b=YwSydi+q2UAgpz8CC6RgebD3zV7GEPqVPv5pRN0M6jox/WccOZt9CR/6wdUcBGgHFie+wH
        jGJIrKZSCnOA/4dXXVZ8d+KRrEUpIJO9cO/h4qAWyis7lZ28NvwoVi/AS9506pyVZldV3P
        1Z2Jbc3INpkKJPe/0i3ikL9HuH4XOog=
Date:   Mon, 5 Aug 2019 18:32:02 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Garnier <thgarnie@chromium.org>
Cc:     kernel-hardening@lists.openwall.com, kristen@linux.intel.com,
        keescook@chromium.org, Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 01/11] x86/crypto: Adapt assembly for PIE support
Message-ID: <20190805163202.GD18785@zn.tnic>
References: <20190730191303.206365-1-thgarnie@chromium.org>
 <20190730191303.206365-2-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190730191303.206365-2-thgarnie@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 12:12:45PM -0700, Thomas Garnier wrote:
> Change the assembly code to use only relative references of symbols for the
> kernel to be PIE compatible.
> 
> Position Independent Executable (PIE) support will allow to extend the
> KASLR randomization range below 0xffffffff80000000.

I believe in previous reviews I asked about why this sentence is being
replicated in every commit message and now it is still in every commit
message except in 2/11.

Why do you need it everywhere and not once in the 0th mail?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
