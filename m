Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEE092194D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 15:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbfEQNmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 09:42:06 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53278 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728365AbfEQNmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 09:42:06 -0400
Received: from zn.tnic (p200300EC2F0C5000C4DD38E37EE1A463.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:5000:c4dd:38e3:7ee1:a463])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 24EA81EC0874;
        Fri, 17 May 2019 15:42:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1558100525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kxqMwd6/M8Bnqd/BVW9JvtYKwei+gVc81c65tCa7ppU=;
        b=aaeXQ0d+gjQ6WkTkH3UBr33GYfNQ+ZFgNlQHWrnH1GRucfU1QdI7d9FhF0fSBe2lHpHDqw
        3yVDdrh4dt/NRQm1UMBNyHDdJbFvRxxFZ1AKtFmLNjmjMOQcVeFIni38muZW10bczdsqLk
        apgaOxDp11uLBdVwUwfrW2vjpKrNEU4=
Date:   Fri, 17 May 2019 15:41:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Young <dyoung@redhat.com>
Cc:     Baoquan He <bhe@redhat.com>, j-nomura@ce.jp.nec.com,
        kasong@redhat.com, fanc.fnst@cn.fujitsu.com, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tglx@linutronix.de
Subject: Re: [PATCH v6 1/2] x86/kexec: Build identity mapping for EFI systab
 and ACPI tables
Message-ID: <20190517134159.GA13482@zn.tnic>
References: <20190424092944.30481-1-bhe@redhat.com>
 <20190424092944.30481-2-bhe@redhat.com>
 <20190429002318.GA25400@MiWiFi-R3L-srv>
 <20190429135536.GC2324@zn.tnic>
 <20190513014248.GA16774@MiWiFi-R3L-srv>
 <20190513070725.GA20105@zn.tnic>
 <20190513073254.GB16774@MiWiFi-R3L-srv>
 <20190513075006.GB20105@zn.tnic>
 <20190513080653.GD16774@MiWiFi-R3L-srv>
 <20190514032208.GA25875@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190514032208.GA25875@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 11:22:08AM +0800, Dave Young wrote:
> Another thing is we can move the get rsdp after console_init, but that
> can be done later as separate patch.

https://lkml.kernel.org/r/20190417090247.GD20492@zn.tnic

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
