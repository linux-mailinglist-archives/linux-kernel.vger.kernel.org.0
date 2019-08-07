Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C107844C9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 08:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfHGGtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 02:49:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39396 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfHGGtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 02:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8XzFANeFVkzOZUR94mMC1EFRxz5Hc6MZ3ecmRUfViGM=; b=fszMVanhB2Xfl32e6HABfdgLV
        hRqR6JCzcFI70ZFExB3OEtsr6QQv4GF9Z5MUMgkPoboRZilwg8/h4O3TXLlVp03kKb4KaW/KmILEm
        KRVg1Tewtgu1uGOOMgRPtLfABJc3JiyZMgqDcqYyftfwP+xwcHUzev//+PDvLUNl3obDpqaWxdinL
        NoOLdblqDOFMkkPi+LNaqm3fWKOF3UMp40k4bq4LVJKVRqw5dySqJ24Kwq2og2jY0WytH3ZLhhhig
        a7LpDvOa5AGpbx7vf+0PIA/m+p7GHo9GGb5qB4kOVlR3qBizSFTXCHb1QAlhB80hB73G+LAuU2/9I
        LDKRu7NvQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hvFl1-0001xQ-N6; Wed, 07 Aug 2019 06:49:11 +0000
Date:   Tue, 6 Aug 2019 23:49:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-riscv@lists.infradead.org, atish.patra@wdc.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: kbuild: drop CONFIG_RISCV_ISA_C
Message-ID: <20190807064911.GB6942@infradead.org>
References: <alpine.DEB.2.21.9999.1908061929230.19468@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1908061929230.19468@viisi.sifive.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 07:30:24PM -0700, Paul Walmsley wrote:
> 
> The baseline ISA support requirement for the RISC-V Linux kernel
> mandates compressed instructions, so it doesn't make sense for
> compressed instruction support to be configurable.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
