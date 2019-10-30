Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD202E962E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 06:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfJ3F4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 01:56:01 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:64936
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726269AbfJ3F4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 01:56:01 -0400
X-IronPort-AV: E=Sophos;i="5.68,246,1569276000"; 
   d="scan'208";a="325074611"
Received: from ppp-seco11pareq2-46-193-149-47.wb.wifirst.net (HELO hadrien) ([46.193.149.47])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2019 06:55:58 +0100
Date:   Wed, 30 Oct 2019 06:55:57 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
cc:     outreachy-kernel@googlegroups.com, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org, trivial@kernel.org
Subject: Re: [Outreachy kernel] [PATCH] blk-mq: Fix typo in comment
In-Reply-To: <20191029223556.2289-1-gabrielabittencourt00@gmail.com>
Message-ID: <alpine.DEB.2.21.1910300655460.2471@hadrien>
References: <20191029223556.2289-1-gabrielabittencourt00@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 29 Oct 2019, Gabriela Bittencourt wrote:

> Fix typo in words: 'vector' and 'query'.
>
> Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>


> ---
>  block/blk-mq-virtio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/blk-mq-virtio.c b/block/blk-mq-virtio.c
> index 488341628256..7b8a42c35102 100644
> --- a/block/blk-mq-virtio.c
> +++ b/block/blk-mq-virtio.c
> @@ -16,7 +16,7 @@
>   * @first_vec:	first interrupt vectors to use for queues (usually 0)
>   *
>   * This function assumes the virtio device @vdev has at least as many available
> - * interrupt vetors as @set has queues.  It will then queuery the vector
> + * interrupt vectors as @set has queues.  It will then query the vector
>   * corresponding to each queue for it's affinity mask and built queue mapping
>   * that maps a queue to the CPUs that have irq affinity for the corresponding
>   * vector.
> --
> 2.20.1
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20191029223556.2289-1-gabrielabittencourt00%40gmail.com.
>
