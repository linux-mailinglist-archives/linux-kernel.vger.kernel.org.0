Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 870B814CFAE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 18:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbgA2Rat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 12:30:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53902 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbgA2Rat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 12:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=o+SfkqM7IwL8WIyIL0CKEGXCT3IYNXMJqubtS71yKOU=; b=Ylpz4k/wIU3Z71JJsr3QC/xXI
        W/vUYg+5VUig4ujgOriKJ3nM5g1O6FYia51jeMeeteqmgvKXSxCB9gCmWYnZz65N9Mz6cTFbGd0yJ
        s6fcjCIAlWCV1g3ZYU1elHYmUoKWO2YWVMFPwss4/56JFErTxgW78gDYSdPLG9CKlnvhvmthdrLCX
        CmcoZQdmeNsbiwT6lIT9uQRQB7hW6kSqwm4z3gtMkahWnIgUstMxLWF6CuvqequowTor9i6yO9JT/
        9ec1CH3QCQWTsrwI4aPk0Mhi6ePjiabDOoUxsmH/ErmyeD/71nYVh+jWyhS9MOwc8hZ5T/bb2IpwD
        lIFe+XvbA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwrAr-0001zx-Nu; Wed, 29 Jan 2020 17:30:45 +0000
Date:   Wed, 29 Jan 2020 09:30:45 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/28] ata: move sata_print_link_status() to
 libata-core-sata.c
Message-ID: <20200129173045.GK12616@infradead.org>
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
 <CGME20200128133415eucas1p12cc620dd5f19e6a26f1deeba083ea82f@eucas1p1.samsung.com>
 <20200128133343.29905-16-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128133343.29905-16-b.zolnierkie@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 02:33:30PM +0100, Bartlomiej Zolnierkiewicz wrote:
> * move sata_print_link_status() to libata-core-sata.c
> 
> * add static inline for CONFIG_SATA_HOST=n case

With the IS_ENABLED() in sata_scr_read the compile should be able to
just do this by itself - maybe with an inline thrown in for
sata_print_link_status if the compiler behaves stupidly.
