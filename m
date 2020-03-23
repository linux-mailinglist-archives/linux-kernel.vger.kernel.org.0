Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADE918FD4B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 20:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgCWTGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 15:06:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727324AbgCWTGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 15:06:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 162B42051A;
        Mon, 23 Mar 2020 19:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584990396;
        bh=/efnpJ3/+VWOgwxxrq/cYFizl0FsfppgSbbpEJcIWZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xXM9vxVJKkkZl4UxPhQeBdzBie+8bANyqudfgiUZD3QleNzhhgW+Z+rtteI7/oLQg
         yz8c5usjpNd8Je5u/nk1ftsUNV6YywCjytzkDTUuua4kyQUpScyIm4rOJrEiPmAbwd
         HaNuLD4yoy89hGpEIpMoFKeyiuvYDuaRh6FFH+Xc=
Date:   Mon, 23 Mar 2020 20:06:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] nvmem: patches (set 2) for 5.7
Message-ID: <20200323190634.GA651127@kroah.com>
References: <20200323150007.7487-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323150007.7487-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 03:00:02PM +0000, Srinivas Kandagatla wrote:
> Hi Greg,
> 
> Here are some nvmem patches for 5.7 which includes
> - sprd nvmem provider fixes 
> - mxs-ocotp driver cleanup
> - add proper checks for read/write callbacks and support root-write only
> 
> If its not too late, Can you please queue them up for 5.7.

I've applied the first 4 patches, and provided review comments on the
last.

thanks,

greg k-h
