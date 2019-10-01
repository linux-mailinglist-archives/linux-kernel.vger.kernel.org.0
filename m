Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43F77C3599
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 15:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388419AbfJAN1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 09:27:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388261AbfJAN1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:27:10 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B89520842;
        Tue,  1 Oct 2019 13:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569936430;
        bh=sfei3fNmNvi6lTi6MMR5a3wHggKkRsIZ/qgKoTItACc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JwpnvP758agt5PqeUSvUvJuo7UAvnivP7LNCqdbn0vx6FUf0HvSz0QmWxM480PmDV
         7UwXRrNNCcVXTqrIQpvLYCvx9cYOtvop5xs2JLS6pgSGiYCI14sb+lPYkOpptXC9HL
         e7DZ23oDhuuOix0WQi8LBGnMLuTJFbbq+ZTvjmAI=
Date:   Tue, 1 Oct 2019 14:27:06 +0100
From:   Will Deacon <will@kernel.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, ndesaulniers@google.com,
        catalin.marinas@arm.com, tglx@linutronix.de
Subject: Re: [PATCH v3 0/5]arm64: vdso32: Address various issues
Message-ID: <20191001132705.fvwi5jbte4la7t7u@willie-the-truck>
References: <20190920142738.qlsjwguc6bpnez63@willie-the-truck>
 <20190926214342.34608-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926214342.34608-1-vincenzo.frascino@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 10:43:37PM +0100, Vincenzo Frascino wrote:
> this patch series is meant to address the various compilation issues you
> reported about arm64 vdso32.

Thanks, I've commented on the patches. Also, when you respin, please can
you drop the "As reported by Will Deacon ..." lines from the commit messages
and just add a Reported-by tag instead?

Thanks,

Will
