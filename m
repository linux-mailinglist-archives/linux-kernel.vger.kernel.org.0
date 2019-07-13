Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31716678F8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2019 09:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfGMH0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jul 2019 03:26:05 -0400
Received: from verein.lst.de ([213.95.11.211]:43704 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbfGMH0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 03:26:04 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5FAB568B02; Sat, 13 Jul 2019 09:26:03 +0200 (CEST)
Date:   Sat, 13 Jul 2019 09:26:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH] nvmet-file: fix nvmet_file_flush() always returning an
 error
Message-ID: <20190713072603.GA17589@lst.de>
References: <20190712224207.22061-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712224207.22061-1-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 04:42:07PM -0600, Logan Gunthorpe wrote:
> errno_to_nvme_status() doesn't take into account the case
> when errno=0, all other use cases only call it if there is actually
> an error.

Might it make more sense to handle 0 in errno_to_nvme_status to avoid
future problems like this one as well?  That would also match the
similar blk_to_nvme_status function better.
