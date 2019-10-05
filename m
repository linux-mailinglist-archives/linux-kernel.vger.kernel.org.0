Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45D81CC87A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2019 08:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfJEGxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Oct 2019 02:53:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbfJEGxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 02:53:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 797AD2133F;
        Sat,  5 Oct 2019 06:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570258387;
        bh=xQ/9PkmdA4psfncbirvKStIGqZr1b9MHoU44bly1pZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OeXDFkmC0kke7PwKSM7PsKyJVyZOG3G9H7LFqnuv1x4VzJugUTr8tIWnQT5pWGHGo
         W/jbBi3DYJqmW0LMFv+jZ5vVc080E3Gr82eRxFtGSvg5DHM4GKoPnDuRLbuya6Oq5O
         8GajqyHgNLaKqjTxAddGrBgZOEBm9RdSvJPiYUhk=
Date:   Sat, 5 Oct 2019 08:53:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Richard Leitner <richard.leitner@skidata.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 06/10] usb: usb251xb: Use of_device_get_match_data()
Message-ID: <20191005065304.GB928719@kroah.com>
References: <20191004214334.149976-1-swboyd@chromium.org>
 <20191004214334.149976-7-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004214334.149976-7-swboyd@chromium.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 02:43:30PM -0700, Stephen Boyd wrote:
> Use the more modern API here instead of using of_match_device() and
> avoid casting away const from the returned pointer by pushing the const
> type through to the users. This nicely avoids referencing the match
> table when it is undefined with configurations where CONFIG_OF=n and
> avoids const issues.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Richard Leitner <richard.leitner@skidata.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: <linux-usb@vger.kernel.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 
> Please ack or pick for immediate merge so the last patch can be merged.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
