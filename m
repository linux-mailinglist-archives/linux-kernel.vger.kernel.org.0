Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A731D7A215
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 09:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbfG3HUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 03:20:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728856AbfG3HUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 03:20:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47BE8205F4;
        Tue, 30 Jul 2019 07:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564471205;
        bh=9y/PgAzXo/m4joi54xT8C0Iz0DdA8XYDsZHcV0xUO/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RdwyT9ZG7X9tDjx/BvLfCtHEWCuoh0oEvIRDutVVHHYuqo4FMoW7f4cjet4QQHQ1Y
         Pyu0SYue2LwM4uZG8/c6zuyy076SrXJYnKcEViTbzumnG/beEhJFGWZuFQOvKYOnF3
         0ISVore9s6e7RACEyqeWKiBMFsIZVKWf6wkxbX0A=
Date:   Tue, 30 Jul 2019 09:20:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        weidu.du@huawei.com, Fang Wei <fangwei1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH 01/22] staging: erofs: update source file headers
Message-ID: <20190730072003.GA31548@kroah.com>
References: <20190729065159.62378-1-gaoxiang25@huawei.com>
 <20190729065159.62378-2-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729065159.62378-2-gaoxiang25@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 02:51:38PM +0800, Gao Xiang wrote:
> - Use the correct style for all SPDX License Identifiers;
> - Get rid of the unnecessary license boilerplate;
> - Use "GPL-2.0-only" instead of "GPL-2.0" suggested-by Stephen.

Note, either tag works just fine, they are identical.  I'll take this,
but just be aware of this in the future please.

thanks,

greg k-h
