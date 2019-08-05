Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 102A88188F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 13:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbfHEL6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 07:58:02 -0400
Received: from mail-yb1-f177.google.com ([209.85.219.177]:33290 "EHLO
        mail-yb1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728058AbfHEL6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 07:58:01 -0400
Received: by mail-yb1-f177.google.com with SMTP id c202so27793837ybf.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 04:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=BL4FDqdFf46+e9I2vAEFGGNJZn3DXMfGLwNszVDD44w=;
        b=szRSO5kf3F+LrelT+qVmszWs3+KIsII9/np5k+yIAs31OeFd93sHakUx1dic0hg7Wr
         Nvl+2Eca2a3E+QrLu/2YqwkFyo0Mb44LzsSjHE+ilqhSiFWlQVhChYNJWtX2ckb9f48f
         syMCXUqYOu0tH8taiWt93tU516bYLZLe3oh2CV/8wxgCOf+f/iYVFTlildNc0Vv8ucPZ
         iopX77ilKjepLFpMuRCtLVmpogXTzZMyPWfKvT1AtoRg1b4xiPu1rC9i7my7EGpMg/8U
         qeJjgDGTPczP4H0WmzlgXnf4EanZLb13JGr2HOhjdEfUJjj8Rsqb4O5h2G2t1gerLMYX
         +v1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BL4FDqdFf46+e9I2vAEFGGNJZn3DXMfGLwNszVDD44w=;
        b=aw0Tu3OFYfRXIEW3lf1uRlTGIWwPEYW73yjZF1cXglwDpbW9MpIPe88AsJw2u5gGPZ
         01I4i9cE9euSbm/I4tzB6ML5rZ0Wlkn81L2E4ARuxj/sC/FASsXH4qf9D7X3DaKfKBaU
         RU3FmMeI+9J6by9Ou0VGMetfmY5bTe6//0NJjCpvdPA0p++c6zU/2w/aguZF9DFKJhzQ
         mokirBjSNNuJTDsd29YodOzIFCN5M3KCqgUBluD3fkBxZWtRENR4F/yB9X05gvaZciVq
         RJOClxj5dtCIDqABT0WYsNNIrBqWFaDSILZd3KpsEvZy1Xn3uVPRPYp1eLUnwG7KbAcb
         osLg==
X-Gm-Message-State: APjAAAXlQ0ojxtcJsVuZ5RWXOKicDeAcbaNORsm9tm+fnJ8u1eq2xrub
        UQEJ4uj0u138yvf9FG9ARs1IXa/bzlFvV1w2pes1pL5Q
X-Google-Smtp-Source: APXvYqzIwfOd0J+adYuwXGmh2LsRgWesR1bKhdZjyVpn4uIIO7ixb1PaiM8jgsPuDrRJgMiXvcHWY7cXyr0Yi3QHz/U=
X-Received: by 2002:a25:db92:: with SMTP id g140mr3467786ybf.78.1565006280684;
 Mon, 05 Aug 2019 04:58:00 -0700 (PDT)
MIME-Version: 1.0
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Date:   Mon, 5 Aug 2019 19:57:54 +0800
Message-ID: <CABXRUiSuZc+W7884ek9YifKdx1eiJ_pmyRM42KK0ZhSK9xTkFw@mail.gmail.com>
Subject: Is it safe to kmalloc a large size of memory in interrupt handler?
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the implementation of kmalloc.
when the allocated size is larger than KMALLOC_MAX_CACHE_SIZE,
it will call kmalloc_large to allocate the memory.
kmalloc_large ->
kmalloc_order_trace->kmalloc_order->alloc_pages->alloc_pages_current->alloc_pages_nodemask->get_page_from_freelist->node_reclaim->__node_reclaim->shrink_node->shrink_node_memcg->get_scan_count

get_scan_count will call spin_unlock_irq which enables local interrupt.
As the local interrupt should be disabled in the interrupt handler.
It is safe to use kmalloc to allocate a large size of memory in
interrupt handler?
