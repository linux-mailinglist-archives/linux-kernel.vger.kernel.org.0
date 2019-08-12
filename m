Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7508A1D9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 17:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfHLPDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 11:03:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38150 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfHLPDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 11:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=usnoDAbB2l1gvsnQq3fkxukL1V/wPhuDb8sH4VZSJCs=; b=GySprv52XAvesIHBNMZG+h0Yv
        DFo8Rx3ZbE29nsAOZ4p9+M33MeqAp1KEKH3E1rsKRFTZwVIMjvNP58xthWpLKFyo7e/XOOKoB3+S5
        8JHAqedNqYFiuCRnsUVMzr34ZGKvxrdJ0ycD5puduWfG/6BaaXJbf34mb7oCc4Gw78FaXr5kTdSVD
        BgIN7wIFpYOqsaOxo2rFT9Gc8LIDsKcgiGU1v2qnJvVjsKFlKlK0sWJRmL29E53dwcRsbiA+7iCjF
        /STIndZa1xgv7bfzPFwigIOW7qwIKKbIKdNmsv4S3hesMY4km8RkpKUQYhxIv8xSHjKMb/RhVNYvl
        I/oXOkGwA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hxBrQ-0006NF-Tz; Mon, 12 Aug 2019 15:03:48 +0000
Date:   Mon, 12 Aug 2019 08:03:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Charles Papon <charles.papon.90@gmail.com>
Cc:     Bin Meng <bmeng.cn@gmail.com>, Atish Patra <atish.patra@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH] riscv: kbuild: drop CONFIG_RISCV_ISA_C
Message-ID: <20190812150348.GH26897@infradead.org>
References: <alpine.DEB.2.21.9999.1908061929230.19468@viisi.sifive.com>
 <CAEUhbmVTM2OUnX-gnBZw5oqU+1MwdYkErrOnA3NGJKh5gxULng@mail.gmail.com>
 <CAMabmMJ3beMcs38Boe11qcsQvqY+9u=2OqA0vCSKdL=n-cK9GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMabmMJ3beMcs38Boe11qcsQvqY+9u=2OqA0vCSKdL=n-cK9GQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 02:18:53PM +0200, Charles Papon wrote:
> Please do not drop it.
> 
> Compressed instruction extension has some specific overhead in small
> RISC-V FPGA softcore, especialy in the ones which can't implement the
> register file read in a asynchronous manner because of the FPGA
> technology.
> What are reasons to enforce RVC ?

Because it it the unix platform baseline as stated in the patch.
