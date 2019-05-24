Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8D829DF6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 20:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732061AbfEXSVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 14:21:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfEXSVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 14:21:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4269021773;
        Fri, 24 May 2019 18:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558722071;
        bh=uxrhq7UC6asnd6/ruglLDhNp79YsY599IHgjBgYss/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O9HoviPfN2d7T7fv/Lpe0ccKORQ9w14UwLdXrPbvBa1rgti6KyUyohx4UudHPWdMI
         KUEST3sVR0rx3H12+vjRl/lFIsBKqEp/Pnjq8YWKwLVSmSji5rYlL+TtgaUjwmCuSU
         kVzsRWUoAiJVaPXEpDtKtKmK+Bhoi2h/c5XCqWgQ=
Date:   Fri, 24 May 2019 20:21:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mariusz Bialonczyk <manio@skyboo.net>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] w1: ds2805: rename w1_family struct, fixing c-p typo
Message-ID: <20190524182109.GA26827@kroah.com>
References: <20190520070558.20142-1-manio@skyboo.net>
 <20190520070558.20142-4-manio@skyboo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520070558.20142-4-manio@skyboo.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 09:05:58AM +0200, Mariusz Bialonczyk wrote:
> Signed-off-by: Mariusz Bialonczyk <manio@skyboo.net>
> ---
>  drivers/w1/slaves/w1_ds2805.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

I can not take patches without any changelog text, sorry.

greg k-h
