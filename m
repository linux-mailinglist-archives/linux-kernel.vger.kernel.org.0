Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00A7C374B8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 15:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfFFNBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 09:01:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfFFNBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 09:01:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2CEC2089E;
        Thu,  6 Jun 2019 13:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559826071;
        bh=ofvxe6eU0L3MopT9XvfHB0T9R5oht8qnvjkRglfSXvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W7pqdQXKlLGxu6LluEbWWsefeH55YjQScgvgl/E0wAaKdA3spXn36jl8IY8sPTUCx
         0/6/lT5Y7jqXfb9oNto0PomC9grVQdiHeL73QPEXwhxhs6siXm5NbXGWKYr6Ydwhce
         6YIkaNtjBsSccz4/P2a922PmSA8vJBDK3qYnNtZk=
Date:   Thu, 6 Jun 2019 15:01:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Deepak Mishra <linux.dkm@gmail.com>
Cc:     linux-kernel@vger.kernel.org, joe@perches.com,
        Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com
Subject: Re: [PATCH v3 2/4] staging: rtl8712: Fixed CamelCase cmdThread
 rename to cmd_thread
Message-ID: <20190606130108.GC1140@kroah.com>
References: <cover.1559615579.git.linux.dkm@gmail.com>
 <2fd1b5a477158e8f308c5a74e0b432389d1a9491.1559615579.git.linux.dkm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fd1b5a477158e8f308c5a74e0b432389d1a9491.1559615579.git.linux.dkm@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 09:51:34AM +0530, Deepak Mishra wrote:
> This patch renames CamelCase cmdThread to cmd_thread in struct _adapter and related
> files drv_types.h,os_intfs.c
> CHECK: Avoid CamelCase: <cmdThread>

What is this "CHECK:" line from?

thanks,

greg k-h
