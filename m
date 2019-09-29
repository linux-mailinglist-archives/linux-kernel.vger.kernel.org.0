Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33720C142D
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2019 12:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbfI2KKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Sep 2019 06:10:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbfI2KKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 06:10:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3631207FA;
        Sun, 29 Sep 2019 10:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569751801;
        bh=pwJo+EJtrS9oVfQHiXOw4zn6GSy+QbPofSc0wlHv20s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TFd7ZaiHJmGnMYOpWsB+hf6lWfl1aKy5rGbTBM9Oyxp8fibSU2Fr4tkzgxJ/mLkvQ
         0pA/9PkQFJkwTHJk2L8PBd0ltvjwtawZLuGMJsrGoD5ttraMw0TNirVDDCnSXtM0ly
         M9yJz1N92jr9Mdn9I+6wWSoS+vRj7fKNm3zAAWsA=
Date:   Sun, 29 Sep 2019 12:09:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jesse Barton <jessebarton95@gmail.com>
Cc:     valdis.kletnieks@vt.edu, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: exfat: exfat_super.c: fixed camelcase coding
 style issue
Message-ID: <20190929100958.GA1906533@kroah.com>
References: <20190928231910.16898-1-jessebarton95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190928231910.16898-1-jessebarton95@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2019 at 06:19:10PM -0500, Jesse Barton wrote:
> Fixed a coding style issue.

What coding style issue?  Always be specific here.

> Signed-off-by: Jesse Barton <jessebarton95@gmail.com>
> ---
>  drivers/staging/exfat/exfat_super.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Also remember to follow the output of scripts/get_maintainer.pl to
properly find the maintainer to cc:, otherwise patches might get
overlooked.

thanks,

greg k-h
