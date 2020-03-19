Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A84D718BF7D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 19:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbgCSSiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 14:38:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgCSSiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 14:38:03 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1849A20787;
        Thu, 19 Mar 2020 18:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584643083;
        bh=EbDQJIl0hkZJqlYCAUK0V7oBidFc1rqWCcQnEG+tmG0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YqrPWyawhOPX3wobShrUGlCj0Sr0s52Zez9zH5c2PmSayEOBmwJ4+mshlUP6DhnLw
         TA3y83J/Ycn+3TgNY3QKePsAXJKNICU6xAzTXNrtOgnKgP7rKTeic5n/MX/Y6U5hCE
         +L1gTUZ5C36Cd7MZd8CYoam4z6dEQL9p9kx/+AOw=
Date:   Thu, 19 Mar 2020 18:37:58 +0000
From:   Will Deacon <will@kernel.org>
To:     =?iso-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 0/3] clean up KPTI / SDEI trampoline data alignment
Message-ID: <20200319183758.GB27141@willie-the-truck>
References: <1938400.7m7sAWtiY1@basile.remlab.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1938400.7m7sAWtiY1@basile.remlab.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 11:12:56AM +0200, R�mi Denis-Courmont wrote:
> 	Hi,
> 
> The KPTI and SDE trampolines each load a pointer from the same fixmap data
> page. This reduces the data alignment to the useful value, and tries to
> clarify the assembler code.
> 
> Changes since v2:
> - Retain alignment even when SDEI is disabled to keep ld happy.
> 
> ----------------------------------------------------------------
> R�mi Denis-Courmont (3):
>       arm64: clean up trampoline vector loads
>       arm64/sdei: gather trampolines' .rodata
>       arm64: reduce trampoline data alignment

For the series:

Acked-by: Will Deacon <will@kernel.org>

[in future please don't drop acks from patches that haven't changed, cheers]

Will
