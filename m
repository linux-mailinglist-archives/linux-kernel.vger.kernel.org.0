Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6CD31659D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 16:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfEGO0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 10:26:53 -0400
Received: from mga07.intel.com ([134.134.136.100]:16286 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbfEGO0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 10:26:52 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 May 2019 07:26:52 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by FMSMGA003.fm.intel.com with ESMTP; 07 May 2019 07:26:51 -0700
Date:   Tue, 7 May 2019 08:21:17 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] nvme-pci: mark expected switch fall-through
Message-ID: <20190507142117.GE2219@localhost.localdomain>
References: <20190507142300.GA25717@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507142300.GA25717@embeddedor>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 09:23:00AM -0500, Gustavo A. R. Silva wrote:
> @@ -1296,6 +1296,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>  	switch (dev->ctrl.state) {
>  	case NVME_CTRL_DELETING:
>  		shutdown = true;
> +		/* fall through */
>  	case NVME_CTRL_CONNECTING:
>  	case NVME_CTRL_RESETTING:
>  		dev_warn_ratelimited(dev->ctrl.device,

Thanks, Looks good.

Reviewed-by: Keith Busch <keith.busch@intel.com>
