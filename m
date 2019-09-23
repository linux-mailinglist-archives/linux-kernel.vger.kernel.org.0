Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB22CBB6A7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 16:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439851AbfIWO0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 10:26:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437634AbfIWO0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 10:26:32 -0400
Received: from C02WT3WMHTD6 (unknown [67.133.97.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 757F520820;
        Mon, 23 Sep 2019 14:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569248792;
        bh=tD/iMTEyNBAhSK5JrhlSYSstldnqfYmpNxrduOLNqs4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IY17oT1Ilf0WMWp7TuCUHzx14ywB/SVQCpuD8BnSDFZ3bwKnLdL1LtSBL+D08r9xM
         KCjYPMFmsbDch7ZmPBEtBBHUG6tzF4ctoRPLkJPnjERvXDn7f6yyeqRT3E2ZpwiTth
         7pV4knZYBw2h8KzGvbHzILBRY8b/sTEH3TbCBsDQ=
Date:   Mon, 23 Sep 2019 08:26:30 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] nvme: fix an error code in nvme_init_subsystem()
Message-ID: <20190923142630.GA14804@C02WT3WMHTD6>
References: <20190923141836.GA31251@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923141836.GA31251@mwanda>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 05:18:36PM +0300, Dan Carpenter wrote:
> "ret" should be a negative error code here, but it's either success or
> possibly uninitialized.
> 
> Fixes: 32fd90c40768 ("nvme: change locking for the per-subsystem controller list")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks, patch looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>
