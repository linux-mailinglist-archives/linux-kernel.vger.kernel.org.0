Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77267ABD8D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 18:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731649AbfIFQTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 12:19:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:42160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727805AbfIFQTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 12:19:01 -0400
Received: from localhost (unknown [89.248.140.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C2EB206CD;
        Fri,  6 Sep 2019 16:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567786741;
        bh=9JR/0RztC02zpm+rMuDn4vuBR9pFtNIfq7WpGGMOOk8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qv7QxCLK0akzGp/aWJtCSApckxdhXoDkU3zjElZjYbChWOO/P0UEMvjqq5TVqHKLx
         r8uorRp2vKP67C3cQ6rffnowSq8geny5GgzA8w0gnzlzaJ4XDsbIq7Mo6DvLXMI/rv
         tBeg+CB+3Hv3hcgSB0AZgynFArCm9CBVW1vEAV+Y=
Date:   Fri, 6 Sep 2019 18:18:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        devel@driverdev.osuosl.org,
        Valentin Vidic <vvidic@valentin-vidic.from.hr>,
        linux-kernel@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH 1/2] exfat stopusing CONFIG_FAT_DEFAULT_IOCHARSET
Message-ID: <20190906161857.GA2585@kroah.com>
References: <20190906150917.1025250-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906150917.1025250-1-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 05:09:04PM +0200, Arnd Bergmann wrote:
> When CONFIG_VFAT_FS is disabled, the reference to CONFIG_FAT_DEFAULT_IOCHARSET
> causes a link failure:
> 
> drivers/staging/exfat/exfat_super.c:46:41: error: use of undeclared identifier 'CONFIG_FAT_DEFAULT_IOCHARSET'
> static char exfat_default_iocharset[] = CONFIG_FAT_DEFAULT_IOCHARSET;
> 
> I could not figure out why the correct code is commented
> out, but using that fixes the problem.

For some reason I was getting a build error without that, I added those
commented out lines.  Odd.  Oh well, thanks for fixing this :)

greg k-h
