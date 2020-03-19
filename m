Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB5AA18B91C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 15:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbgCSOOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 10:14:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbgCSOOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:14:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6CAE20CC7;
        Thu, 19 Mar 2020 14:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584627249;
        bh=EK3oqHnfW407s1LGO+NIAAIkdgKa4ahtcL59O1jVjEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=El71rJqCB3hX4oOYmlM2JqGy1pynzaDWorKEgZsRfUb5ds3eN3NOj6WMX8KtdFlPE
         chQ7BZEHSWYdLaqV8FA7QzZzMU4iyY/AfJkjVLkHLhD/Oqz7tq1ZFAHKDAAKXHR6mp
         QH2kF0Ac3asb+4bjQrJUpt2pQK9Psd/dHNCBfR4E=
Date:   Thu, 19 Mar 2020 15:14:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Camylla Goncalves Cantanheide <c.cantanheide@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Subject: Re: [PATCH v2] staging: rtl8192u: Corrects 'Avoid CamelCase' for
 variables
Message-ID: <20200319141406.GA41281@kroah.com>
References: <20200318211205.188-1-c.cantanheide@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318211205.188-1-c.cantanheide@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 09:12:05PM +0000, Camylla Goncalves Cantanheide wrote:
> The variables of function setKey triggered a 'Avoid CamelCase'
> warning from checkpatch.pl. This patch renames these
> variables to correct this warning.
> 
> Signed-off-by: Camylla Goncalves Cantanheide <c.cantanheide@gmail.com>
> ---
>  drivers/staging/rtl8192u/r8192U_core.c | 52 +++++++++++++-------------
>  1 file changed, 26 insertions(+), 26 deletions(-)

This does not apply to my tree at all :(


