Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42B0F193C3C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 10:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgCZJtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 05:49:19 -0400
Received: from verein.lst.de ([213.95.11.211]:44824 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727699AbgCZJtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 05:49:18 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 00AE668C65; Thu, 26 Mar 2020 10:49:15 +0100 (CET)
Date:   Thu, 26 Mar 2020 10:49:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 11/27] ata: fix CodingStyle issues in PATA timings
 code
Message-ID: <20200326094915.GE9596@lst.de>
References: <20200317144333.2904-1-b.zolnierkie@samsung.com> <CGME20200317144346eucas1p201a88e2eb094f1a246d0eb541541131f@eucas1p2.samsung.com> <20200317144333.2904-12-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317144333.2904-12-b.zolnierkie@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 03:43:17PM +0100, Bartlomiej Zolnierkiewicz wrote:
> * fix the overly long line in ata_timing_quantize()
> 
> * use standard kernel CodingStyle in ata_timing_merge()
> 
> * do not use assignment in if condition in ata_timing_compute()
> 
> * fix non-standard comment style in ata_timing_compute()
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
