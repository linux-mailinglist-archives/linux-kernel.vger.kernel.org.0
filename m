Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4120D193C44
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 10:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgCZJuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 05:50:10 -0400
Received: from verein.lst.de ([213.95.11.211]:44834 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727833AbgCZJuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 05:50:10 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3AFBD68BFE; Thu, 26 Mar 2020 10:50:08 +0100 (CET)
Date:   Thu, 26 Mar 2020 10:50:07 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 13/27] ata: add CONFIG_SATA_HOST=n version of
 ata_ncq_enabled()
Message-ID: <20200326095007.GG9596@lst.de>
References: <20200317144333.2904-1-b.zolnierkie@samsung.com> <CGME20200317144347eucas1p293ab462ec3d4990f380f9d652195cdb4@eucas1p2.samsung.com> <20200317144333.2904-14-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317144333.2904-14-b.zolnierkie@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 03:43:19PM +0100, Bartlomiej Zolnierkiewicz wrote:
> When CONFIG_SATA_HOST=n there are no NCQ capable host drivers
> built so it is safe to hardwire ata_ncq_enabled() to always
> return zero.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
