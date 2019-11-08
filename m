Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74184F4153
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 08:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbfKHHZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 02:25:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53076 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfKHHZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 02:25:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aZt31Z8grhfzi23SdM9LJl0YetqCl+x1hzNaAJKV3DQ=; b=djxI05yKFzfYUWz690/pwh+FC
        z5SIzw0jVzWgu11u+rNRF0jHfjJ5w7Phs23jsGiHHDbf8T549WvTzDDFNydvMxOU0tSrUbgmNXmuM
        6p8sA1djPZH5tT0KHvBV3ecmQtuiD8bd8o0T/pN+a5ycRhtpdDEgMSI8VpASpH+1KFxKKApeKPUb7
        xtcCj0+19CPcnabzov9FxCkjfo+13G/6+StoFNqLc2Y5q5nBydbSg9oIJpmcIcn/tvMFHE77Dv1Tu
        cPYXUOF1gcYSoWPEbmpGVkZyyWfPE/Qk1D0eFrx8gDX6g9mIcPv9+q92znp8iODivmS0s3jA+UTFb
        IXmrRSkTA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSye3-0006ea-Gc; Fri, 08 Nov 2019 07:25:23 +0000
Date:   Thu, 7 Nov 2019 23:25:23 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Zong Li <zong.li@sifive.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        paul.walmsley@sifive.com, palmer@sifive.com, Anup.Patel@wdc.com
Subject: Re: [PATCH v2] riscv: Use PMD_SIZE to repalce PTE_PARENT_SIZE
Message-ID: <20191108072523.GA20338@infradead.org>
References: <1572920412-15661-1-git-send-email-zong.li@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572920412-15661-1-git-send-email-zong.li@sifive.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 06:20:12PM -0800, Zong Li wrote:
>  	uintptr_t map_size = PAGE_SIZE;
>  
> -	/* Upgrade to PMD/PGDIR mappings whenever possible */
> -	if (!(base & (PTE_PARENT_SIZE - 1)) &&
> -	    !(size & (PTE_PARENT_SIZE - 1)))
> -		map_size = PTE_PARENT_SIZE;
> +	/* Upgrade to PMD_SIZE mappings whenever possible */
> +	if (!(base & (PMD_SIZE - 1)) &&
> +	    !(size & (PMD_SIZE - 1)))
> +		map_size = PMD_SIZE;

The check easily fits onto a single line now.  Also the map_size
variable is rather pointless.  Why not:

	if ((base & (PMD_SIZE - 1) || (size & (PMD_SIZE - 1)))
		return PAGE_SIZE;
	return PMD_SIZE;
