Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB734A629B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 09:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbfICHf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 03:35:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727454AbfICHf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 03:35:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E69022CF8;
        Tue,  3 Sep 2019 07:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567496126;
        bh=g/tGl9iVFuPLvexhXY0vB0nltXebd6VJ1xSVyJPY2HY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M3ejSkoP+yquxFEF3viM+aBqK/yI4qmLZSzekWST6NVNnwvJ+m1jNyIIuI9vmrPCP
         NeigJMrlsTca7Kda1n7bvVSi0G/CbWHBvMZ1d4yX8+DliYSsqncfJgGWQEmNe29pmk
         RePsJGb8bW9P6uFiXgnXryTIcoktlVrnsaO7D6So=
Date:   Tue, 3 Sep 2019 09:35:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Prakhar Sinha <prakharsinha2808@gmail.com>
Cc:     tobias.niessen@stud.uni-hannover.de, kim.jamie.bradley@gmail.com,
        pakki001@umn.edu, sabrina-gaube@web.de, nishkadg.linux@gmail.com,
        qader.aymen@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rts5208: Fixed checkpatch warning.
Message-ID: <20190903073524.GB21543@kroah.com>
References: <20190831074055.GA10177@MeraComputer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190831074055.GA10177@MeraComputer>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 31, 2019 at 01:10:55PM +0530, Prakhar Sinha wrote:
> This patch solves the following checkpatch.pl's messages in
> drivers/staging/rts5208/sd.c
> 
> WARNING: line over 80 characters
> 4517: FILE: drivers/staging/rts5208/sd.c:4517:
> +                                               sd_card->sd_lock_status &=
> ~(SD_UNLOCK_POW_ON | SD_SDR_RST);
> 
> WARNING: line over 80 characters
> 4518: FILE: drivers/staging/rts5208/sd.c:4518:
> +                                               goto
> sd_execute_write_cmd_failed;
> 
> WARNING: line over 80 characters
> 4522: FILE: drivers/staging/rts5208/sd.c:4522:
> +                               sd_card->sd_lock_status &= ~(SD_UNLOCK_POW_ON |
> SD_SDR_RST);
> 
> Signed-off-by: Prakhar Sinha <prakharsinha2808@gmail.com>
> ---
>  drivers/staging/rts5208/sd.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)

Same subject line as your previous patch, please fix it up to be unique.

thanks,

greg k-h
