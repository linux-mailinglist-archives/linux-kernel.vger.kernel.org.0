Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 797F1CB86A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 12:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387678AbfJDKgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 06:36:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfJDKgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 06:36:37 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E54D7215EA;
        Fri,  4 Oct 2019 10:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570185397;
        bh=rIudrNGjah/L0Jg56io6hWVEojz5fibU2TXQSNQLG4o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=deaqYMTwHkkS2pcpxPp6MFDeoZRdg1jAMQ9Ks/PvvG1SgrOnSpZXaPIZ/Mqz4/4sR
         53IbgRYk+B2YUlGXEhB6eQ6ogJKcC1flrwRXbnWHkxfnkQJtnHFRTCVURWPxdpbOZx
         O75aUjUg8u3hpJbhbvfoNQ2ML68N6uqDP4I7T99A=
Date:   Fri, 4 Oct 2019 11:36:33 +0100
From:   Will Deacon <will@kernel.org>
To:     Julien Grall <julien.grall@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, suzuki.poulose@arm.com, mark.brown@arm.com
Subject: Re: [PATCH 1/4] arm64: cpufeature: Effectively expose FRINT
 capability to userspace
Message-ID: <20191004103632.lnkyxq2h2owdf7c4@willie-the-truck>
References: <20191003111211.483-1-julien.grall@arm.com>
 <20191003111211.483-2-julien.grall@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003111211.483-2-julien.grall@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 12:12:08PM +0100, Julien Grall wrote:
> The HWCAP framework will detect a new capability based on the sanitized
> version of the ID registers.
> 
> Sanitization is based on a whitelist, so any field not described will end
> up to be zeroed.
> 
> At the moment, ID_AA64ISAR1_EL1.FRINTTS is not described in
> ftr_id_aa64isar1. This means the field will be zeroed and therefore the
> userspace will not be able to see the HWCAP even if the hardware
> supports the feature.
> 
> This can be fixed by describing the field in ftr_id_aa64isar1.
> 
> Fixes: ca9503fc9e98 ("arm64: Expose FRINT capabilities to userspace")
> Signed-off-by: Julien Grall <julien.grall@arm.com>
> Cc: mark.brown@arm.com
> ---
>  arch/arm64/kernel/cpufeature.c | 1 +
>  1 file changed, 1 insertion(+)

D'oh, we should've caught this in testing. Queued as a fix.

Will
