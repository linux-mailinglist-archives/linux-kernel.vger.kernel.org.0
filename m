Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9881A7D34
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 09:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbfIDH5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 03:57:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:50244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728745AbfIDH5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 03:57:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B24BA206BB;
        Wed,  4 Sep 2019 07:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567583852;
        bh=zZT9qswhDNJhn64mNjOW0BtVJMlFpOvNGomJi8t1+U0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MXzYPPBeo/p1QJoE1EugCldwQTsClxrQhiSthRF9jPgbKLoYnZLvmurd/bfiuf8Z2
         1lIPH5jxvZTqclpZarJdktrOyFEysY1L+6WP/7asNnfEJsnc/WiaZiIlKLZ5kV3sqW
         Wj/cFttkcm1vsLDFHt9ExBK6oUWLq0PC5dffByDE=
Date:   Wed, 4 Sep 2019 09:57:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] eeprom: Deprecate the legacy eeprom driver
Message-ID: <20190904075729.GA22307@kroah.com>
References: <20190902104838.058725c2@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902104838.058725c2@endymion>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2019 at 10:48:38AM +0200, Jean Delvare wrote:
> Time has come to get rid of the old eeprom driver. The at24 driver
> should be used instead. So mark the eeprom driver as deprecated and
> give users some time to migrate. Then we can remove the legacy
> eeprom driver completely.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/misc/eeprom/Kconfig |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

You might also want to add a big printk() message when the driver is
loaded that it shouldn't be used.

thanks,

greg k-h
