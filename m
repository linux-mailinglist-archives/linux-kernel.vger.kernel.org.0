Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9AE39BD4
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2019 10:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfFHI1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jun 2019 04:27:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39574 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfFHI1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 04:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Yao0WJuh4CHaqpXA8+u+LeKxnCdbXD2rQwXbMvmoggw=; b=ZJj422W2IANAVOdOtXVPmUUiA
        yBVK2wmt+l3lq0/qlzojVDJwnWACjoNzxvjb8rz13EnMHPN7vt9BQ8Dmhz1BTPb0HteIfNGtIzE/c
        j710ixUna+o0nXOsNaEb9gsLYEnmhrVV8ahNzhlBe8hgXhhLTmJRDIm89f64zHe4aPETzb4UKItGp
        fSfKvaOEbffjoPGhOWhsUEmssdDIBkrfVGgSRvLvVFnbKvk0Cbkq8UaldlXtxiORNbu9VcdMMse4H
        kbWHMRASEhSJxq2Z8Jis5tMXZ5zYo8TrrlzsBe21ryEnoU3/J6yCArkTJoyQKuyz8HUQdgM/O09LO
        deiSICKxA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hZWgt-0003p5-8Z; Sat, 08 Jun 2019 08:27:07 +0000
Date:   Sat, 8 Jun 2019 01:27:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Subject: Re: [PATCH] drivers/ata: cleanup creation of device sysfs attribute
Message-ID: <20190608082707.GB9613@infradead.org>
References: <155989288635.1536.11972713412534297217.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155989288635.1536.11972713412534297217.stgit@buzz>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 10:34:46AM +0300, Konstantin Khlebnikov wrote:
> This patch merges common ATA and AHCI specific attribute "sw_activity"
> into one group with ->is_visible() method which hides attributes if
> feature is not supported by hardware.
> 
> This allows to add all attributes in one place without exporting
> each piece for linking into another list in ahci module.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
