Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD817EC5B3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 16:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbfKAPiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 11:38:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:35338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbfKAPiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 11:38:09 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 647A520650;
        Fri,  1 Nov 2019 15:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572622688;
        bh=CWKBSlzC3l8GOMKMsRuzJu7Q5DBYLofyM+2KjYJ1O7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AFDC/YsTMMKoPnOc+deoFBI57qzVpVwDmw4T3C03qAFkP1i1ZeJU2STUEmPZao9nJ
         Jwtv96kklhsiKZgF4Jp6DGy85o9hX4WGzqJwSSKMKs52dmiP9k2JMkSTIQNa7dvnJl
         tSYqrlhzmV9dU8XwE325Mi2plbco5yF46dG8cyms=
Date:   Fri, 1 Nov 2019 15:38:04 +0000
From:   Will Deacon <will@kernel.org>
To:     Julien Grall <julien@xen.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, suzuki.poulose@arm.com,
        Julien Grall <julien.grall@arm.com>
Subject: Re: [PATCH] docs/arm64: cpu-feature-registers: Rewrite bitfields
 that don't follow [e, s]
Message-ID: <20191101153803.GC3287@willie-the-truck>
References: <20191101152022.8853-1-julien@xen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101152022.8853-1-julien@xen.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 03:20:22PM +0000, Julien Grall wrote:
> From: Julien Grall <julien.grall@arm.com>
> 
> Commit "docs/arm64: cpu-feature-registers: Documents missing visible
> fields" added bitfiels following the convention [s, e]. However, the

typo: bitfiels

> documentation is following [s, e] and so does the Arm ARM.

This should be [e, s], although I think you can spell it out as "end" and
"start" so people know what this is doing.

> 
> Rewrite the bitfields to match the format [e, s].
> 
> Signed-off-by: Julien Grall <julien.grall@arm.com>
> 
> ---
> 
> This is based on the branch for-next/elf-hwcap-docs from the tree
> arm64/linux.git.
> ---
>  Documentation/arm64/cpu-feature-registers.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/arm64/cpu-feature-registers.rst b/Documentation/arm64/cpu-feature-registers.rst
> index ffcf4e2c71ef..7c40e4581bae 100644
> --- a/Documentation/arm64/cpu-feature-registers.rst
> +++ b/Documentation/arm64/cpu-feature-registers.rst
> @@ -193,9 +193,9 @@ infrastructure:
>       +------------------------------+---------+---------+
>       | Name                         |  bits   | visible |
>       +------------------------------+---------+---------+
> -     | SB                           | [36-39] |    y    |
> +     | SB                           | [39-36] |    y    |
>       +------------------------------+---------+---------+
> -     | FRINTTS                      | [32-35] |    y    |
> +     | FRINTTS                      | [35-32] |    y    |
>       +------------------------------+---------+---------+
>       | GPI                          | [31-28] |    y    |
>       +------------------------------+---------+---------+

diff looks fine.

Will
