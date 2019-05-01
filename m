Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD801083D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 15:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfEANUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 09:20:20 -0400
Received: from verein.lst.de ([213.95.11.211]:52909 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbfEANUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 09:20:19 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 14E5168B02; Wed,  1 May 2019 15:20:02 +0200 (CEST)
Date:   Wed, 1 May 2019 15:20:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Klaus Birkelund Jensen <klaus@birkelund.eu>
Cc:     Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: fix psdt field for single segment sgls
Message-ID: <20190501132001.GB1645@lst.de>
References: <20190430165329.6984-1-klaus@birkelund.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430165329.6984-1-klaus@birkelund.eu>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.2.
