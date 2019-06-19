Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2BF34BFB6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 19:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbfFSRe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 13:34:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfFSRe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 13:34:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F38C2084E;
        Wed, 19 Jun 2019 17:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560965696;
        bh=5dGsP15TCl6xKVN7yuchEkLms4SNKp04ZY/9bj3U7So=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RE1CGksgzFsksk/TD34kq9yYlkESNZKcFLdFhfrjicTuJKDzLjD+/WWTWDvFDH2WN
         iP2cQIZXNX8Rex9oBHc1HQuWFSMYRwwP6cKOaK7xnme8y8/Ml+JTbI8h/RpCoJrtDO
         vQ59ING3kVfGed3hUuvMVnmxfa1EXfZTZInt9tUM=
Date:   Wed, 19 Jun 2019 19:34:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] nvmem: meson-efuse: update with SPDX Licence
 identifier
Message-ID: <20190619173452.GA15147@kroah.com>
References: <20190614143221.32035-1-srinivas.kandagatla@linaro.org>
 <20190614143221.32035-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614143221.32035-2-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 03:32:16PM +0100, Srinivas Kandagatla wrote:
> From: Neil Armstrong <narmstrong@baylibre.com>
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/nvmem/meson-efuse.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)

I can't take patches without any changelog text, sorry.

greg k-h
