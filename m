Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFA7B2D261
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 01:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfE1XYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 19:24:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbfE1XYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 19:24:01 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC18C20B1F;
        Tue, 28 May 2019 23:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559085840;
        bh=cjihyfNS4yCB2h/Z4NzAtgFe9LPb9n/+Q0q+iL6WSXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cLpx3nCWUeMZyl1eVXl6udKfNsH8FmhlZZT/cXaMR2pc1o6lIagaM3Lj3qch/Ar1M
         xA4yTgNkGZj78ynLOWPdHHpPyZ0YzDQ3NAH+G70otMatrG0GnClmgYoX5YSb4wLIpk
         ant71oq3pIv8415gvM8x6l5E44ZtKgvrwOvBQvWs=
Date:   Tue, 28 May 2019 16:24:00 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     richard.gong@linux.intel.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, dinguyen@kernel.org,
        atull@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sen.li@intel.com,
        Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCHv4 2/4] firmware: add Intel Stratix10 remote system update
 driver
Message-ID: <20190528232400.GB29225@kroah.com>
References: <1559074833-1325-1-git-send-email-richard.gong@linux.intel.com>
 <1559074833-1325-3-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559074833-1325-3-git-send-email-richard.gong@linux.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 03:20:31PM -0500, richard.gong@linux.intel.com wrote:
> +static int rsu_send_msg(struct stratix10_rsu_priv *priv,
> +			enum stratix10_svc_command_code command,
> +	unsigned long arg,
> +	void (*callback)(struct stratix10_svc_client *client,
> +			 struct stratix10_svc_cb_data *data))

Odd indentation for arg, and then callback.

Why isn't callback a typedef to make this simpler to use?

thanks,

greg k-h
