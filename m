Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D05B742A6B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 17:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440052AbfFLPKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 11:10:38 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36650 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439907AbfFLPKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 11:10:37 -0400
Received: from zn.tnic (p200300EC2F0A6800329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:6800:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CB9571EC09C0;
        Wed, 12 Jun 2019 17:10:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560352236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5vgvKr0yj2ZHJzu6XBf8xEGzNqLaksW1SO4lqxw8S90=;
        b=iqYB5gjCfIS76EjmsEZ5Xhcz+/5fiigAoWXQCxKVusgsWllMn5vLNiGawGIkbooisTb6pF
        MTzgDzI161m3+ZJQYoQPwT2dV49WLwn+bJOjdUAWE25SNRQidoh7fOk2I55YNtU/6f4AaF
        doq9ON8uMNi0TmtzvtNfeIdnVzT2nts=
Date:   Wed, 12 Jun 2019 17:10:33 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Baoquan He <bhe@redhat.com>, Thomas.Lendacky@amd.com
Cc:     lijiang <lijiang@redhat.com>, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com,
        akpm@linux-foundation.org, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, x86@kernel.org,
        hpa@zytor.com, dyoung@redhat.com
Subject: Re: [PATCH 0/3 v11] add reserved e820 ranges to the kdump kernel
 e820 table
Message-ID: <20190612151033.GJ32652@zn.tnic>
References: <20190423013007.17838-1-lijiang@redhat.com>
 <12847a03-3226-0b29-97b5-04d404410147@redhat.com>
 <20190607174211.GN20269@zn.tnic>
 <20190608035451.GB26148@MiWiFi-R3L-srv>
 <20190608091030.GB32464@zn.tnic>
 <20190608100139.GC26148@MiWiFi-R3L-srv>
 <20190608100623.GA9138@zn.tnic>
 <20190608102659.GA9130@MiWiFi-R3L-srv>
 <20190610113747.GD5488@zn.tnic>
 <20190612015549.GI26148@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190612015549.GI26148@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 09:55:49AM +0800, Baoquan He wrote:
> With further investigation, the failure after applying Tom's patch is
> caused by OOM. When increase crashkernel reservation to 512M, kdump
> kernel can boot successfully. I noticed your crashkernel reservation is
> 256M, that will fail and stuck there very possibly.
> 
> So Tom's patch can fix the issue. We need further check why much more
> crashkernel memory is needed on those AMD boxes with sme support..

Yes, 256M for a kexec kernel sounds pretty much enough to me. So there's
something else at play here. I wonder if that workarea after _end, from
Tom's patch, needs so much room...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
