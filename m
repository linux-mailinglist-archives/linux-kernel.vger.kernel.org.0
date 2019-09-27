Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3777C0DFA
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2019 00:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfI0WWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 18:22:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46372 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbfI0WWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 18:22:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Xp8lVCR/zoCk22RZfz2gGPbHi7Rcb0Qx619lCy+b0Gs=; b=IwuBkRcK3Lih/s4WK3OarBBH+
        N4dO3+mlSIy5qnYbAjTPqEspmeU0ClWcCCkC7apex6ugZzdgrtxLyauesC7drSl/Tw+EI+lREFzL4
        z8AEdIni6gxXcfkSgwvUoJwIC5CLBFnW+N8aSJN+RQifoPdWDnCg2JT6ocaZKSPg8U8hajuSqA0ND
        WXQ2ujsO1ozg2Jn+266IjuT2PEmSed3xC/+twC2Q40ON1maPFeQOGGsxpeaIVdZ8XsqhSoYneurq8
        uWX9bfDFfBB3fMJQapbdxPCkh0TILlWQ8eBkJEoj86FQjNiru7J+Nff4jvOvaZBs1GmpPRtqtk2Di
        r9uA02E0A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iDych-0002of-9D; Fri, 27 Sep 2019 22:21:59 +0000
Date:   Fri, 27 Sep 2019 15:21:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     torvalds@linux-foundation.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] RISC-V additional updates for v5.4-rc1
Message-ID: <20190927222159.GD4700@infradead.org>
References: <alpine.DEB.2.21.9999.1909271123370.17782@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1909271123370.17782@viisi.sifive.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 11:25:13AM -0700, Paul Walmsley wrote:
> Atish Patra (1):
>       RISC-V: Export kernel symbols for kvm

None of these have any current users, they should go in with the kvm
series once the virtualization spec has been finalized.
