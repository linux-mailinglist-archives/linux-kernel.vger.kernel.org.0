Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFA506A1FD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 07:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731878AbfGPF7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 01:59:17 -0400
Received: from verein.lst.de ([213.95.11.211]:38821 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfGPF7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 01:59:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DF7ED68B05; Tue, 16 Jul 2019 07:59:14 +0200 (CEST)
Date:   Tue, 16 Jul 2019 07:59:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Paul Pawlowski <paul@mrarm.io>
Subject: Re: [PATCH 1/3] nvme: Pass the queue to SQ_SIZE/CQ_SIZE macros
Message-ID: <20190716055914.GA29414@lst.de>
References: <20190716004649.17799-1-benh@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716004649.17799-1-benh@kernel.crashing.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 10:46:47AM +1000, Benjamin Herrenschmidt wrote:
> This will make it easier to handle variable queue entry sizes
> later. No functional change.

Looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
