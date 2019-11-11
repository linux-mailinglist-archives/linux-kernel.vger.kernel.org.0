Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17F36F73F9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 13:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfKKMeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 07:34:06 -0500
Received: from first.geanix.com ([116.203.34.67]:35130 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbfKKMeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 07:34:06 -0500
Received: from localhost (87-49-44-45-mobile.dk.customer.tdc.net [87.49.44.45])
        by first.geanix.com (Postfix) with ESMTPSA id 5BF5C8ED32;
        Mon, 11 Nov 2019 12:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1573475489; bh=vA/ubZR8WQd44V047oybkMR4vUaL0pxjJypRZvbCbbs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To;
        b=hjBW8tL26FwkpKD8J+BU7qs8IoykYAp7kKcMG9wO7Iov5uOUV4FUMPUVxzl/glzAc
         Sn0czBzaUarv/s6i1n3/ftKsZRMHfTSbYhePNmwVV3r12SgJesoRbaXVzan8CdvpZJ
         MB/Rjgm7S1ev1Z5f5/TLqUcIzio7vV+kozbdPe/upd0SpAl/l+kIUnQ1QIilf3+Fst
         iHXClrWfpGVZ/dJZ2tCq4U3/Osg11niramaMZuuPSLLeqrt1p9xf3eHv+mYtOi2AmI
         VcL50cvfn3p91/E9D44XxuSFrhbSi0avGLLi3AXmxi7PjGdEw3RZKTeNlOdsq9w+iK
         /URiJp6QPthzg==
From:   Esben Haabendal <esben@geanix.com>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] net: ll_temac: Remove set but not used variable 'start_p'
References: <20191110103937.124600-1-zhengyongjun3@huawei.com>
Date:   Mon, 11 Nov 2019 13:34:02 +0100
In-Reply-To: <20191110103937.124600-1-zhengyongjun3@huawei.com> (Zheng
        Yongjun's message of "Sun, 10 Nov 2019 18:39:37 +0800")
Message-ID: <87r22ed22t.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=4.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on b0d531b295e6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zheng Yongjun <zhengyongjun3@huawei.com> writes:

> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/net/ethernet/xilinx/ll_temac_main.c: In function temac_start_xmit:
> drivers/net/ethernet/xilinx/ll_temac_main.c:737:13: warning: variable start_p set but not used [-Wunused-but-set-variable]
>
> start_p is never used, so remove it.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

Acked-by: Esben Haabendal <esben@geanix.com>
