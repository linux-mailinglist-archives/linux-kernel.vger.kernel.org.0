Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98FC119304B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 19:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbgCYSZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 14:25:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:45014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbgCYSZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 14:25:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BCD420740;
        Wed, 25 Mar 2020 18:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585160701;
        bh=jesObpaPKwpp2JzcCfU+MrP28anqjlNmEmTazhQyLrc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qukr9QXvSQvjXeVYdDvWrUP1nCXzUHdjbcH4msu3j7372g1XMuIX5Cn5bmXutXOfk
         ZW7xNvzJdZL2V6qi2/eIzqobkVPjCjFfaERcdHbnL4WfndjkqVbUCSNn/PXnIymj4m
         jxdnUaaWQ43iQvfTL5z7RPdpYFWfzkLP0G+wm+Uw=
Date:   Wed, 25 Mar 2020 19:24:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        nicholas.johnson-opensource@outlook.com.au
Subject: Re: [PATCH v4 0/2] nvmem: use is_bin_visible callback
Message-ID: <20200325182459.GA3801107@kroah.com>
References: <20200325131951.31887-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325131951.31887-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 01:19:49PM +0000, Srinivas Kandagatla wrote:
> As suggested I managed to use is_bin_visible for the existing code
> and also added few more checks for callbacks before setting
> permissions on the file. Which also means that Thunderbolt case
> for write-only should be fixed automatically with this patch.
> 
> As part of this cleanup it does not make any sense to keep
> nvmem-sysfs.c and nvmem.h anymore, so move all the relevant
> code to core.c
> 
> Changes since v3:
> 	- Split patch2 in to two patches for better review.
> 	- drop first patch to add root_only as its queued

Much nicer, and easier to follow, thanks for doing that.

All now queued up, if I've missed anything, please let me know.

greg k-h
