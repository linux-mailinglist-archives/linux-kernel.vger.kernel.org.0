Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7BD436F69
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 11:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfFFJFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 05:05:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37196 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbfFFJFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 05:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=orpYAEG8x2ltoEKU+NqGEcoAnQZCT+dPb51lkJtP4jk=; b=UBpXYhUhcQrIM5t8Yysd9WN9L
        fihMKKycwjuae2gT/PxWo7Zu8JTda5AVd1OM2qguDv472MEZ+cFZ0HK3jMgzvtN2n7ClbZ8BKndoL
        U93RUQo5GUcK3eqvlDAdTQf/1l8MPo+VvVfjig+ZfnimgkVfdU2ZJGfgMHOUIaS+DPCqBggJ3N+DS
        qfzXbABbxcdaqP+arIkjfHxG/+3SbYEmChg/5Fy1uzIqP1irA0T0iFdnkl3IMkkZCQjeRdPR98El4
        fXBsPsdRyrPA7tSsu412vvDOTa2dcE5QpcjMC88KhHw80nhwJnyLjQ8IkdwHhltzsSi2BlaRhfGrD
        +6U/fXBnA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYoKk-0005KD-CZ; Thu, 06 Jun 2019 09:05:18 +0000
Date:   Thu, 6 Jun 2019 02:05:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, marco@decred.org,
        me@carlosedp.com, joel@sing.id.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V: Break load reservations during switch_to
Message-ID: <20190606090518.GB1369@infradead.org>
References: <20190605231735.26581-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605231735.26581-1-palmer@sifive.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 04:17:35PM -0700, Palmer Dabbelt wrote:
>  	REG_S ra,  TASK_THREAD_RA_RA(a3)
> +	/*
> +	 * The Linux ABI allows programs to depend on load reservations being
> +	 * broken on context switches, but the ISA doesn't require that the
> +	 * hardware ever breaks a load reservation.  The only way to break a
> +	 * load reservation is with a store conditional, so we emit one here.
> +	 * Since nothing ever takes a load reservation on TASK_THREAD_RA_RA we
> +	 * know this will always fail, but just to be on the safe side this
> +	 * writes the same value that was unconditionally written by the
> +	 * previous instruction.
> +	 */
> +#if (TASK_THREAD_RA_RA != 0)

I don't think this check works as intended.  TASK_THREAD_RA_RA is a
parameterized macro, thus the above would never evaluate to 0. The
error message also is rather odd while we're at it.

> +#if (__riscv_xlen == 64)
> +	sc.d  x0, ra, 0(a3)
> +#else
> +	sc.w  x0, ra, 0(a3)
> +#endif

I'd rather add an macro ala REG_S to asm.h and distinguish between the
xlen variants there:

#define REG_SC		__REG_SEL(sc.d, sc.w)
