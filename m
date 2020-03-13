Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35DCA1845B1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 12:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgCMLLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 07:11:16 -0400
Received: from verein.lst.de ([213.95.11.211]:42031 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgCMLLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 07:11:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E0D5A68C4E; Fri, 13 Mar 2020 12:11:14 +0100 (CET)
Date:   Fri, 13 Mar 2020 12:11:14 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Balbir Singh <sblbir@amazon.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, axboe@kernel.dk,
        Chaitanya.Kulkarni@wdc.com, hch@lst.de
Subject: Re: [PATCH v3 5/5] scsi: Convert to use
 set_capacity_revalidate_and_notify
Message-ID: <20200313111114.GE8264@lst.de>
References: <20200313053009.19866-1-sblbir@amazon.com> <20200313053009.19866-6-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313053009.19866-6-sblbir@amazon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 05:30:09AM +0000, Balbir Singh wrote:
> block/genhd provides set_capacity_revalidate_and_notify() for sending RESIZE
> notifications via uevents. This notification is newly added to scsi sd.
> 
> Signed-off-by: Balbir Singh <sblbir@amazon.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
