Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A85E9F373
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 21:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731103AbfH0TsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 15:48:14 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41852 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbfH0TsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 15:48:14 -0400
Received: from zn.tnic (p200300EC2F0CD00054E9B179BF3AF377.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:d000:54e9:b179:bf3a:f377])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 990911EC064F;
        Tue, 27 Aug 2019 21:48:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1566935292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+4LADixq8mWqJfEDv1yl7V1aizzRb9Pm5FV9j3wgevQ=;
        b=c6RI1xNsuYFrlp8PpPT6F+ZJPywbIOirlc44EZPF1690WR4R/jBBBCRJzFTJqU81zL01nU
        RhSnCInCQBR4BPMIaNJt591vb2cQGcWIhBcyBvL6+owkE9b2KoSMXsSDtoORJceQsv3LEz
        DMhbendmCr151CBC44E/bb2uXRTszcM=
Date:   Tue, 27 Aug 2019 21:48:06 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas =?utf-8?Q?Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     linux-kernel@vger.kernel.org, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        dri-devel@lists.freedekstop.org, Doug Covelli <dcovelli@vmware.com>
Subject: Re: [PATCH v2 1/4] x86/vmware: Update platform detection code for
 VMCALL/VMMCALL hypercalls
Message-ID: <20190827194806.GJ29752@zn.tnic>
References: <20190823081316.28478-1-thomas_os@shipmail.org>
 <20190823081316.28478-2-thomas_os@shipmail.org>
 <20190827125636.GE29752@zn.tnic>
 <6bd6a477-17b1-20a3-79d6-9aee4f050244@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6bd6a477-17b1-20a3-79d6-9aee4f050244@shipmail.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 09:19:54PM +0200, Thomas Hellström (VMware) wrote:
> We *do* have checkpatch.pl in the workflow. In this case I figured the
> warnings actually didn't make sense. There are breaks present and
> -Wimplicit-fallthrough doesn't complain...

Oh, we have enabled that by default already:

  a035d552a93b ("Makefile: Globally enable fall-through warning")

I guess checkpatch wrongly complains here and I did trust its output
blindly. That ain't happening again, sorry about that.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
