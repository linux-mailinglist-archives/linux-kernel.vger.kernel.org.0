Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A95FA4BFBA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 19:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730306AbfFSRfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 13:35:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfFSRfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 13:35:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F0EA2084E;
        Wed, 19 Jun 2019 17:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560965723;
        bh=MGqWGXerFhXwy/Lpmc/aCU5uOwJnTth3D7pghxksXm4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MS3HRMYCYUu4dW55AqMCT5dzuM4ePp+VyNy2dOw16/N9RKp5KfWL/tHCktL3cS6I7
         Y2tLo3ivZwMrukn2a8vnuWGmZErhNGenVGA7RY2+D3LDfhK6w2ql+wyVOXrWw6PgPx
         9uVa4QLRj4jnJkpe6fsRTZr27PP3uqwtQiEFFEMc=
Date:   Wed, 19 Jun 2019 19:35:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] nvmem: meson-mx-efuse: update with SPDX Licence
 identifier
Message-ID: <20190619173521.GB15147@kroah.com>
References: <20190614143221.32035-1-srinivas.kandagatla@linaro.org>
 <20190614143221.32035-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614143221.32035-3-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 03:32:17PM +0100, Srinivas Kandagatla wrote:
> From: Neil Armstrong <narmstrong@baylibre.com>
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/nvmem/meson-mx-efuse.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)

Same problem, I can't take patches without any changelog text.

thanks,

greg k-h-
