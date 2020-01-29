Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCE614CFAA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 18:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbgA2R3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 12:29:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53848 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbgA2R3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 12:29:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=go3PPhlFlFB8RCk4Btk/36NAr12d6OBh6WpwQRFkuoc=; b=q0VBHX6gDEX+2GikgiRVZHs/V
        eBc1fpa6EF2NuB1E7pIZl//mk9MqK+ILSdNEXEJOYsiyxxVDbTibb4UCtiZGkB2CBmujvi/sJ5x9y
        tWXg1hM8DS3FVOJK6L6fPBuqjpFKw+DZONIWbyJUV8Y2xNKKYPYMNAZtY/hQvg0gFuF8d075+igot
        OsWz+Cw2TUUMh8jfPF8+ne2m87uDyniS+wawOTb9kLQ4lxgdTtLNHAx/gPtFFsr0YZPMXw8HisPEA
        rmrot+VCudv5pP6lyCCDkn4sUvOHnJzwdN+/g/RUfRkK+3GrCPepeRBHQpc0bh/3wsb2YeOHIia6d
        mdIUaS/Ag==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwr9s-0000YV-MJ; Wed, 29 Jan 2020 17:29:44 +0000
Date:   Wed, 29 Jan 2020 09:29:44 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/28] ata: move ata_dev_config_ncq*() to
 libata-core-sata.c
Message-ID: <20200129172944.GJ12616@infradead.org>
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
 <CGME20200128133415eucas1p1cd35ec3ee9783b76c1a32de63796ce30@eucas1p1.samsung.com>
 <20200128133343.29905-15-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128133343.29905-15-b.zolnierkie@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 02:33:29PM +0100, Bartlomiej Zolnierkiewicz wrote:
> * move ata_log_supported() to libata.h and make it inline
> 
> * move ata_dev_config_ncq*() to libata-core-sata.c
> 
> * add static inline version of ata_dev_config_ncq() for
>   CONFIG_SATA_HOST=n case

Wouldn't it be easier to throw in an IS_ENABLED() into the
ATA_FLAG_FPDMA_AUX before calling ata_dev_config_ncq_* and let the
compiler optimize out the functions?
