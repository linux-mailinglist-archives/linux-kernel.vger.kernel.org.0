Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2D4D13C11A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 13:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbgAOMev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 07:34:51 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44926 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgAOMev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 07:34:51 -0500
Received: from zn.tnic (p200300EC2F0C7700ACD7CA379FB916C9.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:7700:acd7:ca37:9fb9:16c9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C7B211EC05B5;
        Wed, 15 Jan 2020 13:34:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579091689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ISu/5ZqTqKt9H9W/IxFDLlAUNO9UxR4JOVnwEmv76Uo=;
        b=Au7QOMtvkCkUjEddRgk88Jt9fNDXoeXHxSKfrs5+e/wo0jiN+bPQ0tf6hyzjmHjBsFulsd
        xaf3ZXfWAuQ3xEEVxE2+56AIApfOg2FaLTNllm2oz/sNuUdRha5MazpsQY0aAEsBJRPgAE
        7mhDnOCV/1knnVWqy4IWqo1H6wNbK48=
Date:   Wed, 15 Jan 2020 13:34:45 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cpu: Print "VMX disabled" error message iff KVM is
 enabled
Message-ID: <20200115123445.GC20975@zn.tnic>
References: <157899701402.1022.5566010856636345851.tip-bot2@tip-bot2>
 <20200114202545.20296-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200114202545.20296-1-sean.j.christopherson@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 12:25:45PM -0800, Sean Christopherson wrote:
> The Fixes: tag references the commit in tip/x86/cpu, obviously should be
> dropped if you can apply this as fixup instead of a patch on top.

Yeah, can't anymore as I've exposed it and Paolo might've used it to
rebase ontop. But not a big deal - I can simply queue it ontop.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
