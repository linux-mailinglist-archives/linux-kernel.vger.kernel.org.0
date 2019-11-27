Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADE010B436
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 18:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfK0RP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 12:15:26 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49132 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbfK0RP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 12:15:26 -0500
Received: from zn.tnic (p200300EC2F0F3700B179EE70824CB5AB.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:3700:b179:ee70:824c:b5ab])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 83C011EC0216;
        Wed, 27 Nov 2019 18:15:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574874924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZbxT1l131RdmSE4pp2Dzv3aHl1v7KdYamPPaH2j1UAM=;
        b=c9xZ0VKvriN8ibKMm9M2FHbvy3I1iBcTLALfzv2AtOXlzZGNWWMYKxv2R1MHXNOW+77ubH
        1ixygd5p5crruEe6dsllqbXkPp9/jh7iDptV1BUDHWNAIqvOoXyAMv+aekWEPr1jH3JnWs
        kcRHrTGuS8WwJ8pTPixEZldHzXPlXA0=
Date:   Wed, 27 Nov 2019 18:15:16 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jules Irenge <jbi.octave@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        mingo@redhat.com
Subject: Re: [PATCH] cpu: microcode: Add comma to 0
Message-ID: <20191127171516.GC3812@zn.tnic>
References: <20191126221519.167145-1-jbi.octave@gmail.com>
 <20191127065436.GC52731@gmail.com>
 <20191127112613.GA3812@zn.tnic>
 <20191127165025.GA10957@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191127165025.GA10957@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 05:50:25PM +0100, Ingo Molnar wrote:
> Yeah, but the kernel isn't ISO C, and the hive mind has spoken in favor 
> of the shortest variant:
> 
>   dagon:~/tip> git grep '= { }' | wc -l
>   647
> 
>   dagon:~/tip> git grep '= { 0, }' | wc -l
>   231
> 
>   dagon:~/tip> git grep '= { NULL, }' | wc -l
>   38
> 
> :-)

Ok then, keeping it as is.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
