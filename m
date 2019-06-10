Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA78C3B3A0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 13:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389244AbfFJLAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 07:00:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47396 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389191AbfFJLAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 07:00:02 -0400
Received: from zn.tnic (p200300EC2F052B0034A730CA72A5B0FA.dip0.t-ipconnect.de [IPv6:2003:ec:2f05:2b00:34a7:30ca:72a5:b0fa])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4712A1EC058B;
        Mon, 10 Jun 2019 13:00:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560164401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FC555KNrAhS1cR0wrwCpjlMJbDNukZRHSEEhasGGexY=;
        b=hCKsehiBG9CFOTjOcKeJGWY5UCgs92ssiLnOR8rX8TbcKbSVnmfICpW8x/XAwbR7YNBxEt
        ke3gXfra5ESRia4JuW8wRlT1B4d5a8T0Tzq/GwDsZWJrqRMBD7x2bPWykMkfbHV4jTjkNd
        aIkRWalire1+TYSOs8Xy9eBg9S8wWU8=
Date:   Mon, 10 Jun 2019 12:59:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kairui Song <kasong@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Dave Young <dyoung@redhat.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        kexec@lists.infradead.org
Subject: Re: [PATCH] x86/kexec: Add ACPI NVS region to the ident map
Message-ID: <20190610105959.GB5488@zn.tnic>
References: <20190610073617.19767-1-kasong@redhat.com>
 <20190610095150.GA5488@zn.tnic>
 <CACPcB9f-sussXaOuOau6=CD85pS2KhcsknpJDQH_aEkwvLfvVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACPcB9f-sussXaOuOau6=CD85pS2KhcsknpJDQH_aEkwvLfvVA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 06:18:50PM +0800, Kairui Song wrote:
> Hi Boris, unfortunately I don't have a real machine which only have
> the NVS region. I did fake the memmap to emulate such problem but
> can't really promise this will fix the real case. So just declare it
> won't break anything that is already working. And I'm asking Junichi
> to have a try as he reported this issue on the machines he has.

Yes, this is how you should do it. First you test on a real hardware -
if the issue is such that needs a real hardware to verify - and if it
passes, *then* you send the patch.

If you don't have access to the box, then ask someone who has.

But for the future, please do not send untested patches in a hurry,
hoping that they would work. This could cause more trouble than the
little time you might save speculating it'll all go fine.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
