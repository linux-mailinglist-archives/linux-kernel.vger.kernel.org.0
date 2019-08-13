Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 260408B1F5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 10:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbfHMIDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 04:03:32 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48728 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfHMIDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 04:03:32 -0400
Received: from zn.tnic (p200300EC2F0D240075AA4C13F769B7E7.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:2400:75aa:4c13:f769:b7e7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DB4771EC0716;
        Tue, 13 Aug 2019 10:03:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565683411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wl48/yP8ym+uAxlHWjHE76DYRPjIBsOyJqj9CuF2dDw=;
        b=HojvWsnu4z3l24NK1FunWmVH/LMCwJ92cMf1vgSxKUSF/ZcwW93/nsIVtHdOrjMXeNkNQK
        SVIAIhTkIFQhq2NH5Gc/obcuQIpikRgovZtLCpW8k/lCRubfAwIxiJax8kyWD1yudp4dO8
        8cqabak02k+wK7M22yAuYYxpNfnznP0=
Date:   Tue, 13 Aug 2019 10:04:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Isaku Yamahata <isaku.yamahata@gmail.com>
Cc:     "Kani, Toshi" <toshi.kani@hpe.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "fei1.li@intel.com" <fei1.li@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 0/3] x86/mtrr, pat: make PAT independent from MTRR
Message-ID: <20190813080416.GB16770@zn.tnic>
References: <cover.1565300606.git.isaku.yamahata@gmail.com>
 <20190809070647.GA2152@zn.tnic>
 <3355d77da5e094ad1d3149b9236cdd204486fd69.camel@hpe.com>
 <20190813074920.GA24196@private.email.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190813074920.GA24196@private.email.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 12:49:20AM -0700, Isaku Yamahata wrote:
> In addition to Xen, KVM+qemu can enable/disable MTRR, PAT independently.
> So user may want to disable MTRR to reduce attack surface.

No, no "user may want" etc vague formulations. Just because some virt
thing "can" do stuff doesn't mean we should change the kernel. What are
the clear benefits of your proposal, why should it go upstream and why
should it be exposed to everybody?

How is going to be used it and what would it bring?

Are there any downsides?

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
