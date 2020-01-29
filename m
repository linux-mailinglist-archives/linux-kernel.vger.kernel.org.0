Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E92414CF76
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 18:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbgA2RTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 12:19:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50752 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbgA2RTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 12:19:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=Gq1da/X9oVXYlp0nfWpkWLp4q
        HV/WqEkOL/vem+q/2IhTmxo/Xo044zhyTALWomr2AD0PK3b4pKMRz00i4/0CXVTKxlcNHgYxCYtFB
        Nx4TE1+WxQZMGRF2EkCQMVZHNdjQIUFJBmyhZ+PMEMDw35APSJLEPMQBAvQhrrn67Ixab4G+tk/hS
        XhWvW38+94FtQQD5tt8Uyha8jJBgvQCkDmsL3S3Wu+4NhWWEglZ3hfKRZmf8Hbrjij5NRsaOMbpoW
        F0TfuL0S9nsod9hxE+MSmDdFh+wTtad+UzjfPOYY3JF7l1791Qni4c9czRFvTpey2/CsiYGtUTIii
        4jZxkIVTQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwqzS-0004qY-Lf; Wed, 29 Jan 2020 17:18:58 +0000
Date:   Wed, 29 Jan 2020 09:18:58 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/28] ata: optimize struct ata_force_param size
Message-ID: <20200129171858.GD12616@infradead.org>
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
 <CGME20200128133412eucas1p1b1b4f025e4c0e6ae6e7a95e9832880dd@eucas1p1.samsung.com>
 <20200128133343.29905-8-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128133343.29905-8-b.zolnierkie@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
