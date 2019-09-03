Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34F96A6567
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 11:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbfICJdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 05:33:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728836AbfICJdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 05:33:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66E5522DBF;
        Tue,  3 Sep 2019 09:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567503214;
        bh=NRTEkLhjDekB8QQSnVDsDRRMHjFNQ3z8KPm/6p9Qc6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hRB4E5qWMntCDKmwywBVHqSDJPNT/kRUZUhDPZRlYoI3yNmqoP8KKIeI1OadLa+ab
         LEUEJLoffIt6gZBqGZzP4e92ppjUMP+AnaOpWbxyPHR9d/IrGS8U9cv9+cczfWgpOj
         jdm8conexHveJcBEjBQ4biHJenordlxJ0h/lYkm8=
Date:   Tue, 3 Sep 2019 11:33:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Prakhar Sinha <prakharsinha2808@gmail.com>
Cc:     tobias.niessen@stud.uni-hannover.de, kim.jamie.bradley@gmail.com,
        pakki001@umn.edu, sabrina-gaube@web.de, nishkadg.linux@gmail.com,
        qader.aymen@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rts5208: Modified nested if blocks.
Message-ID: <20190903093332.GC12325@kroah.com>
References: <20190903090240.GA6104@MeraComputer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903090240.GA6104@MeraComputer>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 02:32:40PM +0530, Prakhar Sinha wrote:
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

Please keep the full line without wrapping them in these messages.

And your subject is a big odd, look at the documentation for how to
create a good subject line.

thanks,

greg k-h
