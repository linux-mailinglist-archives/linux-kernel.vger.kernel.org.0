Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55E5B193C79
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 11:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgCZKAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 06:00:48 -0400
Received: from verein.lst.de ([213.95.11.211]:44938 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727560AbgCZKAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 06:00:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5F07568BFE; Thu, 26 Mar 2020 11:00:45 +0100 (CET)
Date:   Thu, 26 Mar 2020 11:00:45 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 26/27] ata: move ata_eh_analyze_ncq_error() & co. to
 libata-sata.c
Message-ID: <20200326100045.GT9596@lst.de>
References: <20200317144333.2904-1-b.zolnierkie@samsung.com> <CGME20200317144353eucas1p120a8f1a0fa5c293ada61b8d06f7aa9ec@eucas1p1.samsung.com> <20200317144333.2904-27-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317144333.2904-27-b.zolnierkie@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 03:43:32PM +0100, Bartlomiej Zolnierkiewicz wrote:
> * move ata_eh_analyze_ncq_error() and ata_eh_read_log_10h() to
>   libata-sata.c
> 
> * add static inline for ata_eh_analyze_ncq_error() for
>   CONFIG_SATA_HOST=n case (link->sactive is non-zero only if
>   NCQ commands are actually queued so empty function body is
>   sufficient)

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
