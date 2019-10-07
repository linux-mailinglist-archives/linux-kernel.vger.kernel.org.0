Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7059CE3C0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 15:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbfJGNbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 09:31:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727734AbfJGNbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:31:12 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2572B2064A;
        Mon,  7 Oct 2019 13:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570455071;
        bh=SzbScYJPmELZRm1TdfBaiuYWfrUbV/b6oBF4qLoaKjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lYi4NjeYnQM0VYJEspUyZiqHyjHD5KXx4V1DrJZPljVcORJ078gFaWk196k3KKTg0
         kKhH4LbEkurvhUfNoDXb8BBUs4uWeg8dd6WlRzryvsZVWLLtyYyo0n/EsxTzTa3emf
         XUv0N3fmMAxwXcprlmKsuyLFwWz6S6c4VBb+bCeQ=
Date:   Mon, 7 Oct 2019 14:31:06 +0100
From:   Will Deacon <will@kernel.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, ndesaulniers@google.com,
        catalin.marinas@arm.com, tglx@linutronix.de, luto@kernel.org
Subject: Re: [PATCH v5 0/6] arm64: vdso32: Address various issues
Message-ID: <20191007133106.j3gtsuatsw6hgllz@willie-the-truck>
References: <20191003174838.8872-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003174838.8872-1-vincenzo.frascino@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincenzo,

On Thu, Oct 03, 2019 at 06:48:32PM +0100, Vincenzo Frascino wrote:
> This patch series is meant to address the various compilation issues
> reported recently for arm64 vdso32 [1].
> 
> From v4, the series contains a cleanup of lib/vdso Kconfig as well since
> CROSS_COMPILE_COMPAT_VDSO is not required anymore by any architecture.

I've queued this up as fixes for 5.4, but I ended up making quite a few
additional changes to address some other issues and minor inconsistencies
I ran into. In particular, with my changes, you can now easily build the
kernel with clang but the compat vDSO with gcc. The header files still need
sorting out properly, but I think this is a decent starting point:

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/fixes

Please have a look.

Will
