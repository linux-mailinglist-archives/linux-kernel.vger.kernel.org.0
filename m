Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A63C43D080
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 17:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391746AbfFKPMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 11:12:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44898 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388333AbfFKPMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 11:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8Zz8IYaYi8X4JihDj2RJx4SBOxoW9ucRDrdaIchCcIk=; b=i+skrpj2uoU2UQ4AfrPKNef38
        erUaxvLiw4im5aV10NNsDVxucYXy6hKEFdh4A+aNWBKSTlAsTAhzZAJ4nYEObYLr/32g/H2keVITL
        +JEpxRG0WSSVKes0gfXTRvj2sK5ABuCdmfI2gvX+iAggXyOEVIixijcvcn4AUUkSfpSg7n7mVKtEB
        RCLXzVGjNANHKb2yS1ke1KF3M2Vwp4lTBBzzN6ifMBCzaQBDwWADtCZZCEWk29gD52SgOb1j3dTt4
        /YqOvrB6rBdTx5Dw6c3x4y+T7FhbAUhksAldvUM4SuEKkz4+pSENwTln1DkptagbXMTwozDS29HGT
        aG77ZEs6A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1haiS7-00010R-Ap; Tue, 11 Jun 2019 15:12:47 +0000
Date:   Tue, 11 Jun 2019 08:12:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH 8/8] habanalabs: enable 64-bit DMA mask in POWER9
Message-ID: <20190611151247.GA3110@infradead.org>
References: <20190611055045.15945-1-oded.gabbay@gmail.com>
 <20190611055045.15945-9-oded.gabbay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611055045.15945-9-oded.gabbay@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 08:50:45AM +0300, Oded Gabbay wrote:
> 2. The pci_set_dma_mask() is a generic Linux kernel call, so the driver
>    can't tell why it got an error when it tried to set the DMA mask to 48
>    bits. And upon such failure, the driver must fall-back to set the mask
>    to 32 bits.

In the current kernel pci_set_dma_mask only fails if the DMA mask is
to small to be supportable at all.  So you very obviously did not
actually test this against mainline.
