Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E91BD1809C1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 21:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbgCJU7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 16:59:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgCJU7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 16:59:41 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C536E215A4;
        Tue, 10 Mar 2020 20:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583873981;
        bh=3sPIdnBr9v7RZA4nE5B3Yg3InvtEVR8cOXudgA35fbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cVGBhmVTRQ3ln/30HZV9lX37+j5vxGkhfsG36xbMx/Gxyr2Lcev6OTDC/8GKSCRv8
         pv+OFFEoUKZ/wdX8Q3HKOQlFYsYpAnWiRNBEmN+/1Qwj6DAxkpW49BAl8JjfgNg9TJ
         RzcimG9dQxmBMRdxXfatt026qmRcFIfXkfxCVvDM=
Date:   Tue, 10 Mar 2020 13:59:38 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Prabhath Sajeepa <psajeepa@purestorage.com>
Cc:     axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        roland@purestorage.com
Subject: Re: [PATCH] nvme-rdma: Avoid double freeing of async event data
Message-ID: <20200310205938.GE604509@dhcp-10-100-145-180.wdl.wdc.com>
References: <1583788073-39681-1-git-send-email-psajeepa@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583788073-39681-1-git-send-email-psajeepa@purestorage.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 03:07:53PM -0600, Prabhath Sajeepa wrote:
> The timeout of identify cmd, which is invoked as part of admin queue
> creation, can result in freeing of async event data both in
> nvme_rdma_timeout handler and error handling path of
> nvme_rdma_configure_admin queue thus causing NULL pointer reference.
> Call Trace:
>  ? nvme_rdma_setup_ctrl+0x223/0x800 [nvme_rdma]
>  nvme_rdma_create_ctrl+0x2ba/0x3f7 [nvme_rdma]
>  nvmf_dev_write+0xa54/0xcc6 [nvme_fabrics]
>  __vfs_write+0x1b/0x40
>  vfs_write+0xb2/0x1b0
>  ksys_write+0x61/0xd0
>  __x64_sys_write+0x1a/0x20
>  do_syscall_64+0x60/0x1e0
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Signed-off-by: Prabhath Sajeepa <psajeepa@purestorage.com>
> Reviewed-by: Roland Dreier <roland@purestorage.com>

Thanks, applied to new branch for 5.6-rc6.
