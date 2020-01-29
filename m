Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1EEE14CF9A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 18:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgA2R0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 12:26:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52382 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbgA2R0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 12:26:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wGdZw2QRsCWsordCMEM3uzWJm3fPYO71wtDCnVZG7xc=; b=AbsbE6NHl2LjcSTXanzbg/ihE
        4QD55JyVUfzn4xAJW8rZLQjrramGL8QRImhyih5Er5zjrrQQjYT6QJtDjl4tqkJhYbCydZA9cauIP
        Tf8R2z6gBMLj4zrWB+Q4DC0Wf+9nF7BQMD6BXGyhB8QP/uIs5IgFwXpmgySMFk12IhJ+0km34tOJc
        Q61EknTmBOw6l9qZyYmgndJ+pGcUxbAX1OEI3UNm0QqbarYGzOw+mXigZrJTePRZDR1nOu9kylEIy
        nOnSRtKQaf6Ao8S2f2GZwbSvyqq5OeSTYSCY4frmcJKm4M41my+6X1WN0HdME4/rqFCqhxD0SFPrQ
        y884fFqDQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwr6U-00009O-8p; Wed, 29 Jan 2020 17:26:14 +0000
Date:   Wed, 29 Jan 2020 09:26:14 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/28] ata: start separating SATA specific code from
 libata-core.c
Message-ID: <20200129172614.GH12616@infradead.org>
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
 <CGME20200128133414eucas1p2baefeb1a492375b18bdf6cdfbd0db796@eucas1p2.samsung.com>
 <20200128133343.29905-13-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128133343.29905-13-b.zolnierkie@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 02:33:27PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Start separating SATA specific code from libata-core.c:
> 
> * move following functions to libata-core-sata.c:

Why not call this libata-sata.c?  If it is SATA specific it can't be
that core :)

> + *  libata-core-sata.c - SATA specific part of ATA helper library

No need for file names in top of file headers.

> +/*
> + * Core layer (SATA specific part) - drivers/ata/libata-core-sata.c
> + */
> +#ifdef CONFIG_SATA_HOST
> +extern int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
> +			     bool spm_wakeup);
> +extern int ata_slave_link_init(struct ata_port *ap);
> +extern void ata_tf_to_fis(const struct ata_taskfile *tf,
> +			  u8 pmp, int is_cmd, u8 *fis);
> +extern void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf);
>  extern bool sata_lpm_ignore_phy_events(struct ata_link *link);
> +#endif

No need for the ifdef.
