Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 855EA25A95
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 01:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfEUXDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 19:03:55 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39128 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbfEUXDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 19:03:55 -0400
Received: from cz.tnic (ip65-44-65-130.z65-44-65.customer.algx.net [65.44.65.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 986821EC0513;
        Wed, 22 May 2019 01:03:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1558479834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pLs8mJG8yjRVO9KTlyvBjTEAD8Qsf2DO8OLUOX9pAA8=;
        b=IEpXxZiqzeZ7nsaaim7JSOYtD7ZWSj9jUCv+8Lf0qR1wVel8BARKwTDmyToSk+IcDtnChv
        yGq0qZfcxiOoBOD1+BOGNQcOXwmzi1n7/9hyvdJzFvbSCmCHshpHl2KYM61QCO76ospCML
        hOd3lm5TpAy9J0HAw7HzVqOjAGchzHo=
Date:   Wed, 22 May 2019 01:04:21 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        j-nomura@ce.jp.nec.com, kasong@redhat.com,
        fanc.fnst@cn.fujitsu.com, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tglx@linutronix.de
Subject: Re: [PATCH v6 1/2] x86/kexec: Build identity mapping for EFI systab
 and ACPI tables
Message-ID: <20190521230421.GA2435@cz.tnic>
References: <20190429002318.GA25400@MiWiFi-R3L-srv>
 <20190429135536.GC2324@zn.tnic>
 <20190513014248.GA16774@MiWiFi-R3L-srv>
 <20190513070725.GA20105@zn.tnic>
 <20190513073254.GB16774@MiWiFi-R3L-srv>
 <20190513075006.GB20105@zn.tnic>
 <20190513080653.GD16774@MiWiFi-R3L-srv>
 <20190514032208.GA25875@dhcp-128-65.nay.redhat.com>
 <20190514033338.GA6612@MiWiFi-R3L-srv>
 <c640061a-a7c5-5bc3-87b6-0ee7af5a4b43@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c640061a-a7c5-5bc3-87b6-0ee7af5a4b43@netronome.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 02:53:52PM -0700, Dirk van der Merwe wrote:
> Where can I find the next-merge-window tree?
> 
> I can test against that too.

It'll appear soon in a tip branch. I'd appreciate if you tested that
instead - stay tuned...

Thx.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply. Srsly.
