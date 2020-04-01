Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD7219A994
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 12:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732220AbgDAK2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 06:28:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728242AbgDAK2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 06:28:06 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AACD20678;
        Wed,  1 Apr 2020 10:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585736885;
        bh=ZGIFCj7egJvoPFEFYXQPBwun/lzoQ4tkiFuG/7SntGo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fnoHwQbV/Vrntb3eTwRTe1ELFyq1lZ0qBZBP5bKg8eVlicaVTKIGXwbAjsx8lRuu+
         sOtHc9u6WqP7rgTmSMlnHfIvg3h/WbQJgQYOFz/QmIsRhzOrngo9fDYFaTmpQJuoSz
         hI+E2NpYeLGgUxSuSCqMue/ercrKBbSVRoRX6cXo=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jJabL-00HTVP-97; Wed, 01 Apr 2020 11:28:03 +0100
Date:   Wed, 1 Apr 2020 11:27:57 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     <kvmarm@lists.cs.columbia.edu>, <eric.auger@redhat.com>,
        <andre.przywara@arm.com>, <james.morse@arm.com>,
        <julien.thierry.kdev@gmail.com>, <suzuki.poulose@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>
Subject: Re: [PATCH] KVM: arm64: vgic-v3: Clear pending bit in guest memory
 after synchronization
Message-ID: <20200401112757.6716cbf3@why>
In-Reply-To: <fe30a834-fdb0-e1ca-5e4a-0c7863236c5f@huawei.com>
References: <20200331031245.1562-1-yuzenghui@huawei.com>
        <20200331090709.17d2087d@why>
        <fe30a834-fdb0-e1ca-5e4a-0c7863236c5f@huawei.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, kvmarm@lists.cs.columbia.edu, eric.auger@redhat.com, andre.przywara@arm.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, wanghaibin.wang@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Mar 2020 17:11:37 +0800
Zenghui Yu <yuzenghui@huawei.com> wrote:

Hi Zenghui,

> Hi Marc,
> 
> On 2020/3/31 16:07, Marc Zyngier wrote:
> > Hi Zenghui,

[...]

> >>   > > I've been thinking about this, and I wonder why we don't simply clear  
> > the whole pending table instead of carefully wiping it one bit at a
> > time. My reasoning is that if a LPI isn't mapped, then it cannot be made
> > pending the first place.  
> 
> A writing to GICR_CTLR.EnableLPIs can happen in parallel with MAPTI/INT
> command sequence, where the new LPI is mapped to *this* vcpu and made
> pending, wrong? I think commit 7d8b44c54e0c had described it in detail.

I'm not sure this commit is relevant here. It describes how the
configuration is picked up by MAPTI, not how the pending bit got there
the first place.

> But thinking that we cache the pending bit in pending_latch (instead of
> writing the corresponding bit in guest memory) when a LPI is made
> pending, it seems to be safe to clear the whole pending table here.

Yes, and this is my worry. The spec is pretty vague about what the
behaviour of the redistributor is when something is set in the pending
table. At the moment, we treat these bits as if they had been generated
by a translation, but we do so inconsistently: we only pick these bits
up and generate a LPI if there is a mapping at the ITS level. If these
bits are relevant, we should forward a LPI to the CPU.

It feels we're in UNPREDICTIBLE land...

> 
> > 
> > And I think there is a similar issue in vgic_v3_lpi_sync_pending_status().
> > Why sync something back from the pending table when the LPI wasn't
> > mapped yet?  
> 
> vgic_v3_lpi_sync_pending_status() can be called on the ITE restore path:
> vgic_its_restore_ite/vgic_add_lpi/vgic_v3_lpi_sync_pending_status.
> We should rely on it to sync the pending bit from guest memory (which
> was saved on the source side).

The fact that we have *two* paths to restore pending bits is pretty
annoying. There is certainly some scope for simplification here.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
