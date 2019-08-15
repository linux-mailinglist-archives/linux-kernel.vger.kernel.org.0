Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFDD8EDE4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 16:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732854AbfHOONz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 10:13:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:51944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730032AbfHOONy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 10:13:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69F3A208C2;
        Thu, 15 Aug 2019 14:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565878433;
        bh=bJ5dZFOEmt/eB/4DIMS82pyskdcemPLevWTmdO5f/JQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YrjSnU0UFBWViBTCrXq/WGZST4nSM1PGZcK3VlwMWD34yAOUwVTkaZFCC6CfwpBT+
         8emd41REaV4OfACjDR66stiYuCtetsgDnsAjDBRUSNjXoIQNa+kJEAAbrfr/N1Ci4I
         bvrMS3jfttQSYOdrU4GimFx2b11ocp86ACRrW4Hs=
Date:   Thu, 15 Aug 2019 16:13:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-accelerators@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Kenneth Lee <liguozhu@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [PATCH 2/2] uacce: add uacce module
Message-ID: <20190815141351.GD23267@kroah.com>
References: <1565775265-21212-1-git-send-email-zhangfei.gao@linaro.org>
 <1565775265-21212-3-git-send-email-zhangfei.gao@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565775265-21212-3-git-send-email-zhangfei.gao@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 05:34:25PM +0800, Zhangfei Gao wrote:
> +int uacce_register(struct uacce *uacce)
> +{
> +	int ret;
> +
> +	if (!uacce->pdev) {
> +		pr_debug("uacce parent device not set\n");
> +		return -ENODEV;
> +	}
> +
> +	if (uacce->flags & UACCE_DEV_NOIOMMU) {
> +		add_taint(TAINT_CRAP, LOCKDEP_STILL_OK);
> +		dev_warn(uacce->pdev,
> +			 "Register to noiommu mode, which export kernel data to user space and may vulnerable to attack");
> +	}

THat is odd, why even offer this feature then if it is a major issue?

thanks,

greg k-h
