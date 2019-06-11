Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4358241711
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 23:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407694AbfFKVo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 17:44:27 -0400
Received: from namei.org ([65.99.196.166]:38582 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404730AbfFKVo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 17:44:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x5BLiHHk015933;
        Tue, 11 Jun 2019 21:44:17 GMT
Date:   Wed, 12 Jun 2019 07:44:17 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     YueHaibing <yuehaibing@huawei.com>
cc:     serge@hallyn.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH -next] security: Make capability_hooks static
In-Reply-To: <20190611134815.16612-1-yuehaibing@huawei.com>
Message-ID: <alpine.LRH.2.21.1906120743490.12833@namei.org>
References: <20190611134815.16612-1-yuehaibing@huawei.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2019, YueHaibing wrote:

> Fix sparse warning:
> 
> security/commoncap.c:1347:27: warning:
>  symbol 'capability_hooks' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  security/commoncap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks!

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-lsm

-- 
James Morris
<jmorris@namei.org>

