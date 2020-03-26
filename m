Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A59B5193C26
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 10:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgCZJpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 05:45:40 -0400
Received: from verein.lst.de ([213.95.11.211]:44786 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727780AbgCZJpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 05:45:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 602E068C65; Thu, 26 Mar 2020 10:45:35 +0100 (CET)
Date:   Thu, 26 Mar 2020 10:45:34 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/27] ata: expose ncq_enable_prio sysfs attribute
 only on NCQ capable hosts
Message-ID: <20200326094534.GA9596@lst.de>
References: <20200317144333.2904-1-b.zolnierkie@samsung.com> <CGME20200317144341eucas1p1b9caa7264b35b23e78fcaeb78d865255@eucas1p1.samsung.com> <20200317144333.2904-3-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317144333.2904-3-b.zolnierkie@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 03:43:08PM +0100, Bartlomiej Zolnierkiewicz wrote:
> There is no point in exposing ncq_enable_prio sysfs attribute for
> devices on PATA and non-NCQ capable SATA hosts so:
> 
> * remove dev_attr_ncq_prio_enable from ata_common_sdev_attrs[]
> 
> * add ata_ncq_sdev_attrs[]
> 
> * update ATA_NCQ_SHT() macro to use ata_ncq_sdev_attrs[]
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
