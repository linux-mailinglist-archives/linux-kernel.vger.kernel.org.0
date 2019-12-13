Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8BFA11E56A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 15:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfLMOPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 09:15:52 -0500
Received: from mail.skyhub.de ([5.9.137.197]:35800 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727444AbfLMOPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 09:15:52 -0500
Received: from zn.tnic (p200300EC2F0A5A0019677E6F46B493BB.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:5a00:1967:7e6f:46b4:93bb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 187591EC014A;
        Fri, 13 Dec 2019 15:15:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1576246551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3NrpyLsdGpjnrpXHUCOJYaX4M12sVqeC8Ylwrt+/qOU=;
        b=ZU+7E//mo8qAtFVAC7zGNuf35D5oDZUa67ku4yOGXDi7Qh2F2sv2wDpXYCQEeDW6KvJugN
        /qIlxqq/yWbFaQlsmGCmtmkjl1nKKep/38khDmkCGQ+4cUVo8tVhaya/deQR5th0UtVaO+
        LsZ687SizwSt6gV/Gcg4LbO+O55v+Ao=
Date:   Fri, 13 Dec 2019 15:15:43 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] x86/mm/KASLR: Adjust the padding size for the
 direct mapping.
Message-ID: <20191213141543.GA25899@zn.tnic>
References: <20191115144917.28469-1-msys.mizuma@gmail.com>
 <20191115144917.28469-5-msys.mizuma@gmail.com>
 <20191212201916.GL4991@zn.tnic>
 <20191213132850.GG28917@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191213132850.GG28917@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 09:28:50PM +0800, Baoquan He wrote:
> In Documentation/x86/x86_64/mm.rst, the physical memory regions mapping
> with page_offset is called as the direct mapping of physical memory.

The fact that it happens to compute the *first* region's size, which
*happens* to be the direct mapping of all physical memory is immaterial
here.

It is actually causing more confusion in an already complex piece of
code. You can call this function just as well

  calc_region_size()

which won't confuse readers. Because all you care about here is the
region's size - not which region it is.

> kernel_randomize_memory() is invoked much earlier than
> acpi_table_parse_srat().

And? What are we going to do about that?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
