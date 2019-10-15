Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A359D6C89
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 02:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfJOAkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 20:40:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:35428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbfJOAkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 20:40:47 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5718020663;
        Tue, 15 Oct 2019 00:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571100046;
        bh=Lrmoll/pF3oUfimztWipSNNRZNM5JU3Kg9wAkgeg81U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VQaNKe3LDR4djt9gdNK+YnNIG9wxxr7x92+xjobfCJ2roqQP9L4pUA0BBTLtkfXNS
         akiHuwg4zzzveZJGx8qolBBQfv3Bs70iqAcktG1dHzrOX7+++VDUpZ/gOvYTL25eOX
         kJuLebsM857ZU2dtCqNPz+Fa6cCJnCsC5ZI1OUHg=
Date:   Tue, 15 Oct 2019 01:40:42 +0100
From:   Will Deacon <will@kernel.org>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] random: inform about bootloader-provided randomness
Message-ID: <20191015004041.oijbe245is5rhev2@willie-the-truck>
References: <20191005113632.GA74715@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191005113632.GA74715@light.dominikbrodowski.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 05, 2019 at 01:36:32PM +0200, Dominik Brodowski wrote:
> Inform how many bits of randomness were provided by the bootloader,
> and whether we trust that input.
> 
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Will Deacon <will@kernel.org>
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index de434feb873a..673375e05c0d 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -2515,6 +2515,10 @@ EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
>   */
>  void add_bootloader_randomness(const void *buf, unsigned int size)
>  {
> +	pr_notice("random: adding %u bits of %sbootloader-provided randomness",
> +		size * 8,
> +		IS_ENABLED(CONFIG_RANDOM_TRUST_BOOTLOADER) ? "trusted " : "");
> +
>  	if (IS_ENABLED(CONFIG_RANDOM_TRUST_BOOTLOADER))
>  		add_hwgenerator_randomness(buf, size, size * 8);
>  	else

Looks fine to me:

Acked-by: Will Deacon <will@kernel.org>

Will
