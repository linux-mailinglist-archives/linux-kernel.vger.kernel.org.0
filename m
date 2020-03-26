Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE4D9193C3A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 10:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgCZJsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 05:48:53 -0400
Received: from verein.lst.de ([213.95.11.211]:44818 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727699AbgCZJsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 05:48:53 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 17CFB68BFE; Thu, 26 Mar 2020 10:48:50 +0100 (CET)
Date:   Thu, 26 Mar 2020 10:48:49 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/27] ata: optimize ata_scsi_rbuf[] size
Message-ID: <20200326094849.GD9596@lst.de>
References: <20200317144333.2904-1-b.zolnierkie@samsung.com> <CGME20200317144345eucas1p1e67d48caa8629fedb301e776e34dc0c1@eucas1p1.samsung.com> <20200317144333.2904-9-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317144333.2904-9-b.zolnierkie@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 03:43:14PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Currently the maximum required size of the ata_scsi_rbuf[] is
> 576 bytes in ata_scsiop_inq_89() so modify ATA_SCSI_RBUF_SIZE
> define accordingly.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

Btw, I wonder if we should switch this to a dynamic allocation, as
a lot of people are more concerned about kernel size footprint vs
dynamic allocations.
