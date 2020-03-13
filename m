Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8068A18459E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 12:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgCMLJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 07:09:15 -0400
Received: from verein.lst.de ([213.95.11.211]:41995 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbgCMLJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 07:09:15 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6D18968C4E; Fri, 13 Mar 2020 12:09:13 +0100 (CET)
Date:   Fri, 13 Mar 2020 12:09:13 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Balbir Singh <sblbir@amazon.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, axboe@kernel.dk,
        Chaitanya.Kulkarni@wdc.com, hch@lst.de,
        Someswarudu Sangaraju <ssomesh@amazon.com>
Subject: Re: [PATCH v3 1/5] block/genhd: Notify udev about capacity change
Message-ID: <20200313110913.GA8264@lst.de>
References: <20200313053009.19866-1-sblbir@amazon.com> <20200313053009.19866-2-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313053009.19866-2-sblbir@amazon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 05:30:05AM +0000, Balbir Singh wrote:
> Allow block/genhd to notify user space (via udev) about disk size changes
> using a new helper set_capacity_revalidate_and_notify(), which is a wrapper
> on top of set_capacity(). set_capacity_revalidate_and_notify() will only
> notify via udev if the current capacity or the target capacity is not zero
> and iff the capacity changes.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Someswarudu Sangaraju <ssomesh@amazon.com>
> Signed-off-by: Balbir Singh <sblbir@amazon.com>
> Reviewed-by: Bob Liu <bob.liu@oracle.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
