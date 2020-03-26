Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 075A7193C50
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 10:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgCZJwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 05:52:31 -0400
Received: from verein.lst.de ([213.95.11.211]:44865 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727699AbgCZJwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 05:52:31 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C355F68BFE; Thu, 26 Mar 2020 10:52:29 +0100 (CET)
Date:   Thu, 26 Mar 2020 10:52:29 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 17/27] ata: move sata_scr_*() to libata-sata.c
Message-ID: <20200326095229.GK9596@lst.de>
References: <20200317144333.2904-1-b.zolnierkie@samsung.com> <CGME20200317144349eucas1p1a2e79758cbdf36c747c8a82cd4ddbd74@eucas1p1.samsung.com> <20200317144333.2904-18-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317144333.2904-18-b.zolnierkie@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 03:43:23PM +0100, Bartlomiej Zolnierkiewicz wrote:
> * move sata_scr_*() to libata-sata.c
> 
> * add static inlines for CONFIG_SATA_HOST=n case

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
