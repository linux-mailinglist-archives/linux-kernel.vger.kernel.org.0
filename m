Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A91F1928C5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 13:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgCYMpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 08:45:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:32884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbgCYMpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:45:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 389F02076A;
        Wed, 25 Mar 2020 12:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585140299;
        bh=qgXKHtmY9kOCICENIGp4XHbWH+aHq+z99hqCOfHAILU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GL67TANSfKxEIUirrL8/8UplMEO6rupt82NWhq2mineXAYpsugsoqTCxXg1PiOxX2
         fOUbY3r4QUtvwKa//2yZ0I1yCol8/+7vOuhjhZS1WtdOBhcQ4hQIhhy408z0Lu3SI+
         /g+QtMlU0qRagpGkqZBsk/DyS/1jkd6G/li9UXY0=
Date:   Wed, 25 Mar 2020 13:44:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        nicholas.johnson-opensource@outlook.com.au
Subject: Re: [PATCH v3 2/2] nvmem: core: use is_bin_visible for permissions
Message-ID: <20200325124457.GA3511062@kroah.com>
References: <20200325122116.15096-1-srinivas.kandagatla@linaro.org>
 <20200325122116.15096-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325122116.15096-3-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 12:21:16PM +0000, Srinivas Kandagatla wrote:
> By using is_bin_visible callback to set permissions will remove a
> large list of attribute groups. These group permissions can be
> dynamically derived in the callback.
> 
> Also add checks for read/write callbacks and set permissions accordingly.
> 
> As part of this cleanup it does not make sense to have a separate
> nvmem-sysfs.c and nvmem.h file anymore, so move all the relevant
> data structures and functions to core.c

And because of that move, it's impossible to see the real changes made
here :(

Can you do this in two steps, one do the code/logic changes, and the
other do the "move into one file"?  That way it is actually reviewable,
as it is, it's impossible to do so.

I'll go queue up the first patch to make the series smaller :)

thanks,

greg k-h
