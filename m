Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1B359494
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 09:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfF1HJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 03:09:12 -0400
Received: from verein.lst.de ([213.95.11.210]:45741 "EHLO newverein.lst.de"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726947AbfF1HJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 03:09:12 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 4424468CFE; Fri, 28 Jun 2019 09:09:09 +0200 (CEST)
Date:   Fri, 28 Jun 2019 09:09:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        keith.busch@intel.com, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH -next] nvme-pci: Make nvme_dev_pm_ops static
Message-ID: <20190628070909.GD28268@lst.de>
References: <20190626020902.38240-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626020902.38240-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.3.
