Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAE5212BB9C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Dec 2019 23:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfL0WbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Dec 2019 17:31:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:32906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbfL0WbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 17:31:01 -0500
Received: from localhost (unknown [173.246.202.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85E9620740;
        Fri, 27 Dec 2019 22:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577485861;
        bh=uhOMe72RhAkyJVD8fJRIfHJovB6OCUe8wryQwfWegMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TvZTw4BTBlQbswcu4EZxFZJVlc7YK2t0P+0HZHSyDV1cFwWNZCrUs4Wd6BUVXmH/S
         OscnTfGTZwRgExkiJlKPTrKHvy9SWPjeO1a/nGXVHX8eptKu5THjLBfcC+lpHR+5so
         YVG0Qquv1BsdXY2YM/t7FxzK6zDUdJU0Gnp3pk8Q=
Date:   Fri, 27 Dec 2019 17:30:52 -0500
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthew Hanzelik <mrhanzelik@gmail.com>
Cc:     jerome.pouiller@silabs.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: wfx: Fix style issues with hif_rx.c
Message-ID: <20191227223052.GA331959@kroah.com>
References: <20191227201656.3g426wagfubit5zy@mandalore.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191227201656.3g426wagfubit5zy@mandalore.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 27, 2019 at 03:16:56PM -0500, Matthew Hanzelik wrote:
> Fixes style issues with hif_rx.c.

Please be specific as to _what_ you did, this is pretty vague :(

thanks,

greg k-h
