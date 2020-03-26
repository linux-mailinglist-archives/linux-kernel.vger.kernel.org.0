Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E210193C6D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 10:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgCZJ7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 05:59:06 -0400
Received: from verein.lst.de ([213.95.11.211]:44909 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727787AbgCZJ7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 05:59:05 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E93D368BFE; Thu, 26 Mar 2020 10:59:03 +0100 (CET)
Date:   Thu, 26 Mar 2020 10:59:03 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 23/27] ata: start separating SATA specific code from
 libata-scsi.c
Message-ID: <20200326095903.GQ9596@lst.de>
References: <20200317144333.2904-1-b.zolnierkie@samsung.com> <CGME20200317144352eucas1p1ddb279cb52e2ae6f5189878912581162@eucas1p1.samsung.com> <20200317144333.2904-24-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317144333.2904-24-b.zolnierkie@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 03:43:29PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Start separating SATA specific code from libata-scsi.c:
> 
> * un-static ata_scsi_find_dev()
> 
> * move following code to libata-sata.c:
>   - SATA only sysfs device attributes handling
>   - __ata_change_queue_depth()
>   - ata_scsi_change_queue_depth()
> 
> * cover with CONFIG_SATA_HOST ifdef SATA only sysfs device
>   attributes handling code and ATA_SHT_NCQ() macro in
>   <linux/libata.h>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
