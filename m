Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7724114CFA7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 18:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbgA2R2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 12:28:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53814 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbgA2R2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 12:28:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3Oplq6mzb4jC0odGhwVwCG/33biHrQv9cWy1ShY7fdA=; b=L1ZJvAtMfLi3lZhq5YMeKHHiw
        LYhZgHMQuPlQ+V1bMxm7L7hT3ZcDH2HURRiZdhBuGiF5pL1jFL49pIFvdBFLvVjcbGZK+E3oTzDL1
        XevrpuDJEhVaNClKbwqZJ/ghwF3risbBG9jAcL1EZJvSnScoVPLyX97eo6GVNy6Ux3BX2wJYltqLK
        Lh+/rvjkK8ewuAaeDrTiCV6qpfvAahY10rwVx6cozyTeT+XZYuhnF/ZMUFx2LapgeeFezzLw8aCf/
        GYgXY9Dc3dO4gpzoxXvR2Re5UpBBOPYEsUDEbUXygEvmYEBcgqErPlqXCiz7np+aNJL8Wrq0huXKR
        WJ9g2ZJmw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwr8N-0000UM-G3; Wed, 29 Jan 2020 17:28:11 +0000
Date:   Wed, 29 Jan 2020 09:28:11 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/28] ata: move ata_do_link_spd_horkage() to
 libata-core-sata.c
Message-ID: <20200129172811.GI12616@infradead.org>
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
 <CGME20200128133415eucas1p258c0d5c313e2ae42a05508b67eec16ef@eucas1p2.samsung.com>
 <20200128133343.29905-14-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128133343.29905-14-b.zolnierkie@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 02:33:28PM +0100, Bartlomiej Zolnierkiewicz wrote:
> * move ata_do_link_spd_horkage() to libata-core-sata.c
> 
> * add static inline for CONFIG_SATA_HOST=n case

Wouldn't it make more sense to stub out sata_scr_valid for the !SATA
case and just let the compiler optimize the function away now that it
can't be called in that case?
