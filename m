Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1933131ED
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 18:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfECQPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 12:15:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:52358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbfECQPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 12:15:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A13F220651;
        Fri,  3 May 2019 16:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556900122;
        bh=yBM6Zw3ym2qSK0OwkrGOK3OzIKqy9vGcn7FW2qxfvHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=reUM0+DgfH4Qn8l2JM5PvZwrNDzGob2pqFlXBmfB4zY/RJR7cENyRb3TBaIH3f0D3
         CN5zFuioj12bdAtNyLXHYjy78HHC/wmDm4O5+/LHJ3eQxxz+F+nWDeLOB7HkQ/+aQ/
         sFudsqGKhDYohxzCL9CPp5E+xg9lx7nd7V0KVw3s=
Date:   Fri, 3 May 2019 18:15:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 12/22] intel_th: msu: Support multipage blocks
Message-ID: <20190503161519.GA8488@kroah.com>
References: <20190503084455.23436-1-alexander.shishkin@linux.intel.com>
 <20190503084455.23436-13-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503084455.23436-13-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 11:44:45AM +0300, Alexander Shishkin wrote:
> @@ -1481,7 +1501,7 @@ nr_pages_show(struct device *dev, struct device_attribute *attr, char *buf)
>  	else if (msc->mode == MSC_MODE_MULTI) {
>  		list_for_each_entry(win, &msc->win_list, entry) {
>  			count += scnprintf(buf + count, PAGE_SIZE - count,
> -					   "%d%c", win->nr_blocks,
> +					   "%d%c", win->nr_pages,
>  					   msc_is_last_win(win) ? '\n' : ',');
>  		}
>  	} else {

Why do you have a sysfs file that has multiple values?  I will not take
a patch that adds to this mess, please remove this file and fix it up
properly.

thanks,

greg k-h
