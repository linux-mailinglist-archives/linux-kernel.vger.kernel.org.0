Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42EF2456CF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 09:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbfFNHyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 03:54:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:57086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbfFNHyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 03:54:39 -0400
Received: from linux-8ccs (unknown [92.117.145.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5719B2133D;
        Fri, 14 Jun 2019 07:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560498878;
        bh=PvLi/3uJKuqXnNjSGw++iphQUNXLUGBA4QDUp5FLBLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JpY++WnUzAw3IJDTvRBUKK2iIPX3b97pKYzjW9Ei2V0Cavtbn7tXHUm5i72OZxKbp
         aaW6RaewocjHEJyMnB+01m6sLhNFazPaVvsTBPZmFn92HVG5g5c4ym8eLd9o1+FIP1
         Uzr7ERt11Q9jS8IIFNsTFIcil5R60M9fJixk+lr4=
Date:   Fri, 14 Jun 2019 09:54:33 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     gregkh@linuxfoundation.org, mbenes@suse.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] kernel/module: Fix mem leak in
 module_add_modinfo_attrs
Message-ID: <20190614075433.GA5820@linux-8ccs>
References: <20190603144554.18168-1-yuehaibing@huawei.com>
 <20190611150007.21064-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190611150007.21064-1-yuehaibing@huawei.com>
X-OS:   Linux linux-8ccs 5.1.0-rc1-lp150.12.28-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ YueHaibing [11/06/19 23:00 +0800]:
>In module_add_modinfo_attrs if sysfs_create_file
>fails, we forget to free allocated modinfo_attrs
>and roll back the sysfs files.
>
>Fixes: 03e88ae1b13d ("[PATCH] fix module sysfs files reference counting")
>Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied, thanks.

Jessica

