Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87CEDCE4E5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 16:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbfJGOP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 10:15:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:48878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbfJGOP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:15:58 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF82F206BB;
        Mon,  7 Oct 2019 14:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570457757;
        bh=EQUjqeE9IjYrFNkRTWbqGmoBkeMX9I6aRT1drhyRgqY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bki4PB9aJwYSU3VoAmnqlp3fV08Wk1bpSBcbovgUpW2hPIO65aJri1O+4bn3RBwLv
         gzMxZg91QfLnpFyVXv+Fs/m0vpSh/ckUcllPTkt5+3OVFf185rpUeGuSuj8QJTLV36
         CQ/f87oQ4lMUnLLoNgC7+dT09ItZWBDE7YWgnSCQ=
Date:   Mon, 7 Oct 2019 15:15:53 +0100
From:   Will Deacon <will@kernel.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, ndesaulniers@google.com,
        catalin.marinas@arm.com, tglx@linutronix.de, luto@kernel.org
Subject: Re: [PATCH v5 0/6] arm64: vdso32: Address various issues
Message-ID: <20191007141552.tbk3n6hgpq4cgane@willie-the-truck>
References: <20191003174838.8872-1-vincenzo.frascino@arm.com>
 <20191007133106.j3gtsuatsw6hgllz@willie-the-truck>
 <a35ad8b6-fcd8-a681-b456-cc931f1e58cb@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a35ad8b6-fcd8-a681-b456-cc931f1e58cb@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 02:54:29PM +0100, Vincenzo Frascino wrote:
> On 07/10/2019 14:31, Will Deacon wrote:
> > On Thu, Oct 03, 2019 at 06:48:32PM +0100, Vincenzo Frascino wrote:
> >> This patch series is meant to address the various compilation issues
> >> reported recently for arm64 vdso32 [1].
> >>
> >> From v4, the series contains a cleanup of lib/vdso Kconfig as well since
> >> CROSS_COMPILE_COMPAT_VDSO is not required anymore by any architecture.
> > 
> > I've queued this up as fixes for 5.4, but I ended up making quite a few
> > additional changes to address some other issues and minor inconsistencies
> > I ran into. In particular, with my changes, you can now easily build the
> > kernel with clang but the compat vDSO with gcc. The header files still need
> > sorting out properly, but I think this is a decent starting point:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/fixes
> > 
> > Please have a look.
> > 
> 
> Thank you for letting me know, I will have a look.

Thanks.

> I see acked-by Catalin on the patches, did you post them in review somewhere? I
> could not find them. Sorry

I pushed them out to a temporary vdso branch on Friday and Catalin looked at
that. If you'd like me to post them as well, please let me know, although
I'm keen to get this stuff sorted out by -rc3 without disabling the compat
vDSO altogether (i.e. [1]). In other words, if you're ok with my changes on
top of yours then let's go for that, otherwise let's punt this to 5.5 and
try to fix the header mess at the same time.

Will

[1] https://lkml.kernel.org/r/20190925130926.50674-1-catalin.marinas@arm.com
