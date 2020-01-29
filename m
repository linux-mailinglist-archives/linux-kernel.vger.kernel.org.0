Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D35814CF65
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 18:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbgA2RP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 12:15:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50658 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbgA2RP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 12:15:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=CEWHazp5xHBcxAVze0MrINc2z
        9cmh8ULtMrfQ3fuvnHbbWlORsqkUBsa7M9tz27WO6vmGGl+56FTf9K2LAUaQOtokWJodBuUwk1Njt
        +jvUgT9NL+MA/UAJ7D4nfSwpaMMeTU/9achd2f2R5fgYFqp9tYSvG9k7Y8V50W4k04MqfYVIiil3k
        tCRdkLlL7PjjXdqgZKfAC3YmZR6vOZAI8+bL6xMd+UTnHaIXuC7jEdFYxiqpwHtn3Q6iZNGKe4EzJ
        QJpACCut5THxlDxT5xywJ+wFK/yJnVP1BL1aptQke7RPzzkncLsIq+NXRmW1JHDp0n+uKQhxiigX8
        7T1iiT77A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwqwU-0004Wu-Td; Wed, 29 Jan 2020 17:15:54 +0000
Date:   Wed, 29 Jan 2020 09:15:54 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/28] ata: simplify ata_scsiop_inq_89()
Message-ID: <20200129171554.GA12616@infradead.org>
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
 <CGME20200128133412eucas1p258499338146481964e4c26ad3f1cbf14@eucas1p2.samsung.com>
 <20200128133343.29905-6-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128133343.29905-6-b.zolnierkie@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
