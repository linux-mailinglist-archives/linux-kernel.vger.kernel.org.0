Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBBF6BC14
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 14:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfGQMC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 08:02:56 -0400
Received: from gate.crashing.org ([63.228.1.57]:55836 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfGQMC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 08:02:56 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x6HC2cat029785;
        Wed, 17 Jul 2019 07:02:39 -0500
Message-ID: <2cc90b8cfa935e345ec2b185b087f1859a040176.camel@kernel.crashing.org>
Subject: Re: [PATCH v2 2/3] nvme-pci: Add support for variable IO SQ element
 size
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Minwoo Im <minwoo.im.dev@gmail.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Pawlowski <paul@mrarm.io>, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Date:   Wed, 17 Jul 2019 22:02:37 +1000
In-Reply-To: <20190717115145.GB10495@minwoo-desktop>
References: <20190717004527.30363-1-benh@kernel.crashing.org>
         <20190717004527.30363-2-benh@kernel.crashing.org>
         <20190717115145.GB10495@minwoo-desktop>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-17 at 20:51 +0900, Minwoo Im wrote:
> -	struct nvme_command *sq_cmds;
> > +	void *sq_cmds;
> 
> It would be great if it can remain the existing data type for the
> SQEs...  But I'm fine with this also.
> 
> It looks good to me.

I changed it on purpose so we aren't tempted to index the array, since
that's not always valid.

Cheers,
Ben.


