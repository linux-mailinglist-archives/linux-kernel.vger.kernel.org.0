Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 810D2193C5A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 10:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgCZJzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 05:55:07 -0400
Received: from verein.lst.de ([213.95.11.211]:44888 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbgCZJzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 05:55:06 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D36AD68BFE; Thu, 26 Mar 2020 10:55:02 +0100 (CET)
Date:   Thu, 26 Mar 2020 10:55:02 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 19/27] ata: move sata_link_{debounce,resume}() to
 libata-sata.c
Message-ID: <20200326095502.GM9596@lst.de>
References: <20200317144333.2904-1-b.zolnierkie@samsung.com> <CGME20200317144350eucas1p2270ca7a1757769b238be42c2811172a1@eucas1p2.samsung.com> <20200317144333.2904-20-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317144333.2904-20-b.zolnierkie@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 03:43:25PM +0100, Bartlomiej Zolnierkiewicz wrote:
> * move sata_link_{debounce,resume}() to libata-sata.c
> 
> * add static inline for CONFIG_SATA_HOST=n case (only one,
>   for sata_link_resume() is needed)

This looks good for now:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But as a follow on I think it would make sene to just split
ata_std_prereset into a pata and a sata version, and then we don't
even need the non-static and potentially stubeed out sata_link_resume.
