Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8EB4760F3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 10:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfGZIhP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 26 Jul 2019 04:37:15 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:62992 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725842AbfGZIhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 04:37:14 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 17620769-1500050 
        for multiple; Fri, 26 Jul 2019 09:37:08 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Chenbo Feng <fengc@google.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190613223408.139221-3-fengc@google.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>, kernel-team@android.com
References: <20190613223408.139221-1-fengc@google.com>
 <20190613223408.139221-3-fengc@google.com>
Message-ID: <156413022619.30723.12163288418173479775@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH v5 2/3] dma-buf: add DMA_BUF_SET_NAME ioctls
Date:   Fri, 26 Jul 2019 09:37:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chenbo Feng (2019-06-13 23:34:07)
> From: Greg Hackmann <ghackmann@google.com>
> 
> This patch adds complimentary DMA_BUF_SET_NAME  ioctls, which lets
> userspace processes attach a free-form name to each buffer.
> 
> This information can be extremely helpful for tracking and accounting
> shared buffers.  For example, on Android, we know what each buffer will
> be used for at allocation time: GL, multimedia, camera, etc.  The
> userspace allocator can use DMA_BUF_SET_NAME to associate that
> information with the buffer, so we can later give developers a
> breakdown of how much memory they're allocating for graphics, camera,
> etc.

The name was never freed...
diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index d56993238501..0106b96da585 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -104,6 +104,8 @@ static int dma_buf_release(struct inode *inode, struct file *file)
        list_del(&dmabuf->list_node);
        mutex_unlock(&db_list.lock);

+       kfree(dmabuf->name);
+
        if (dmabuf->resv == (struct reservation_object *)&dmabuf[1])
                reservation_object_fini(dmabuf->resv);

This trusts that access to the name via the fs is serialised by the
refcount.

It would have been great if the inode would only be allocated for a
named dmabuf, but I expect that requires replacing struct file after it
is exposed (but maybe a struct file can be moved between fs?).
-Chris
