Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 255E9193C69
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 10:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgCZJ6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 05:58:21 -0400
Received: from verein.lst.de ([213.95.11.211]:44902 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727699AbgCZJ6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 05:58:21 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 711C068BFE; Thu, 26 Mar 2020 10:58:19 +0100 (CET)
Date:   Thu, 26 Mar 2020 10:58:19 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 22/27] ata: move sata_deb_timing_*() to libata-sata.c
Message-ID: <20200326095819.GP9596@lst.de>
References: <20200317144333.2904-1-b.zolnierkie@samsung.com> <CGME20200317144351eucas1p2020714aa775f0ab3aaea870d25f7fb92@eucas1p2.samsung.com> <20200317144333.2904-23-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317144333.2904-23-b.zolnierkie@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 03:43:28PM +0100, Bartlomiej Zolnierkiewicz wrote:
> * move sata_deb_timing_*() to libata-sata.c
> 
> * add static inline for sata_ehc_deb_timing() for
>   CONFIG_SATA_HOST=n case

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
