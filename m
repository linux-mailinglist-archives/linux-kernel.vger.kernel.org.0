Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7534642B56
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 17:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730040AbfFLP4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 11:56:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbfFLP4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 11:56:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F3AE21019;
        Wed, 12 Jun 2019 15:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560354976;
        bh=k/hMtfgh0gnlFLV5ceDoWrjDlKxQhSfkQrUrVvqt2TE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oqwB1fhmzyUz3ozHx+V7Mtmc8jmTVMyKvkKpn6aQbZ3lqXW5YgZOXD0N/dLqBCn7W
         PFWeK66Q0m1jR8YCL+zijZ/09a5ZMz3AgMIPdZhoIZKL9zo67WNJzlZEaIasVH1GMB
         s6MMZU77KOYbtWfF8/6BKttKtsoymQ0ZIadzeanI=
Date:   Wed, 12 Jun 2019 17:56:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Brown <david.brown@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove myself as qcom maintainer
Message-ID: <20190612155614.GA27064@kroah.com>
References: <20190612155411.GA28186@davidb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612155411.GA28186@davidb.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 09:54:11AM -0600, David Brown wrote:
> I no longer regularly work on this platform, and only have a few
> increasingly outdated boards.  Andy has primarily been doing the
> maintenance.
> 
> Signed-off-by: David Brown <david.brown@linaro.org>
> ---
> MAINTAINERS | 1 -
> 1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 57f496cff999..27df8f46a283 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2050,7 +2050,6 @@ S:	Maintained
> 
> ARM/QUALCOMM SUPPORT
> M:	Andy Gross <agross@kernel.org>
> -M:	David Brown <david.brown@linaro.org>
> L:	linux-arm-msm@vger.kernel.org
> S:	Maintained
> F:	Documentation/devicetree/bindings/soc/qcom/

Your patch is corrupted by having the leading spaces eaten up :(

