Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74ABBC0DEF
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2019 00:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbfI0WTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 18:19:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45684 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfI0WTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 18:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zx+e/HBMDy+pcTz129757XHA4z/rLCqlyvbp+zo2Zzw=; b=mqHjHVUhSGtHit8G+XVlzX0uB
        InNrEDEiqe1Qwqw5CNAMNVvE7DbhokoEHJ/xwSZ6yFDkOAsfvSq+dDdUNxPEonOwzvotF46U5TZMh
        SAMviSbtF6Hdg4Ii2XF925Zl7WmY2nbfd+gfZPhcjZVgzRHBvo97jfTjWEjcznY2G2dUMoEnzVg0t
        n0yAhNaE9mCpVWBBD12U5Sr3jM1vpB96PQo4lFVyqcdsWZ6BxGepKQDbghJwdny02OZM5984FfY0g
        49o+0Nw+Ldddsz8lrQWyDWNQBgJXifiGcJj3Sf9NgsM3DpHfmoezh8CAwIR0xAUCEhCxflRY5bopq
        /TPY/VzgQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iDyaT-0001Ma-5y; Fri, 27 Sep 2019 22:19:41 +0000
Date:   Fri, 27 Sep 2019 15:19:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Alan Kao <alankao@andestech.com>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Gary Guo <gary@garyguo.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-riscv@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>
Subject: Re: [PATCH v2 1/3] RISC-V: Mark existing SBI as 0.1 SBI.
Message-ID: <20190927221941.GB4700@infradead.org>
References: <20190927000915.31781-1-atish.patra@wdc.com>
 <20190927000915.31781-2-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927000915.31781-2-atish.patra@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 05:09:13PM -0700, Atish Patra wrote:
> -#define SBI_CALL(which, arg0, arg1, arg2, arg3) ({		\
> +#define SBI_CALL(which, arg0, arg1, arg2, arg3) ({             \

Spurious whitespace change.
