Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B82CCDF55
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 12:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfJGK2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 06:28:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:39094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfJGK2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 06:28:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFBC7206BB;
        Mon,  7 Oct 2019 10:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570444111;
        bh=aD1WI8OBgBUNj/w60M7OWbmnZ/6/q1VQAbqU1+hyA1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OZQCysyb70+qo3q16j2r7puNwBpwFSqAsT7eQAS26bg8Fnguv81G4iCsLqxyqi5RX
         7mbyEblRKM7VUOfsXL1zyS3FkrQL8foU/57AbEEiorqzjIPA8nny6LzD6qEsortM7H
         E61gKvwh5iPiu9eYOVYYDfM4y1K3eQeIj1W6l7Xs=
Date:   Mon, 7 Oct 2019 12:28:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, forest@alittletooquiet.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6656: align arguments with open parenthesis
Message-ID: <20191007102828.GA366705@kroah.com>
References: <20191006191020.7435-1-gabrielabittencourt00@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191006191020.7435-1-gabrielabittencourt00@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2019 at 04:10:20PM -0300, Gabriela Bittencourt wrote:
> Cleans up CHECKs of "Alignment should match open parenthesis"
> 
> Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
> ---
>  drivers/staging/vt6656/rxtx.c | 63 +++++++++++++++++++++++------------
>  1 file changed, 41 insertions(+), 22 deletions(-)

This patch does not apply to my staging-next branch either :(

Please rebase and resend it.

thanks,

greg k-h
