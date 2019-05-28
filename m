Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCB972C526
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 13:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfE1LGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 07:06:54 -0400
Received: from shell.v3.sk ([90.176.6.54]:37277 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfE1LGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 07:06:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id EBEB51048B5;
        Tue, 28 May 2019 13:06:50 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id z-URobh3VGwZ; Tue, 28 May 2019 13:06:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id AEC921048B7;
        Tue, 28 May 2019 13:06:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jospB53Cg9Z6; Tue, 28 May 2019 13:06:46 +0200 (CEST)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id A6D941048B5;
        Tue, 28 May 2019 13:06:46 +0200 (CEST)
Message-ID: <6db9830f1240fafb01dde94281d53f0c5ccd6230.camel@v3.sk>
Subject: Re: [PATCH -next 0/2] Platform: OLPC: Fix two randbuild error
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     YueHaibing <yuehaibing@huawei.com>, dvhart@infradead.org,
        andy@infradead.org
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Date:   Tue, 28 May 2019 13:06:45 +0200
In-Reply-To: <20190528092806.20080-1-yuehaibing@huawei.com>
References: <20190528092806.20080-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-05-28 at 17:28 +0800, YueHaibing wrote:
> Fix two randbuild error:
> 1) Fix build error with CONFIG_SPI is not set
> 2) Fix build error with CONFIG_INPUT is set to m
> 
> YueHaibing (2):
>   Platform: OLPC: Fix build error without CONFIG_SPI
>   Platform: OLPC: Add INPUT dependencies
> 
>  drivers/platform/olpc/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thanks. Both patches:

Reviewed-by: Lubomir Rintel <lkundrak@v3.sk>

