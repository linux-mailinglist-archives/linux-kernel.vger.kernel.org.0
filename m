Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 881787ACE9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 17:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbfG3PyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 11:54:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:38456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727206AbfG3PyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:54:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCF0920693;
        Tue, 30 Jul 2019 15:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564502039;
        bh=l8nzN+nXgwgDD78MwSCCpyT7umeFB1+m1UrVrS8noO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=emUSZKi93/O0li1rB2U7fVgC46Z2axkIh4b6Qm63TLEXppnoJmjVT2vgwXRu4bBr8
         qQ6uxR57lArfj9uLvI4iCn2+acDJzys7c7agbxUydr/Hbw7cm50AAImoVkfgtrx69Z
         aVNWqIH6FG3hOSjPP1C4prbgvu5bNto5pyUL6zCc=
Date:   Tue, 30 Jul 2019 17:53:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-serial@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/24] LPUART fixes and improvements
Message-ID: <20190730155357.GA5448@kroah.com>
References: <20190729195226.8862-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729195226.8862-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 12:52:02PM -0700, Andrey Smirnov wrote:
> Everyone:
> 
> This series contains fixes/improvements to LPUART dirver I came up
> with recently as well as fixes picked up from Toradex and NXP Vybrid
> repos.
> 
> Feedback is welcome!

Nice cleanups, all now queued up.

greg k-h
