Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72D4C29EC4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 21:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391618AbfEXTEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 15:04:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbfEXTEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 15:04:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 234CE21848;
        Fri, 24 May 2019 19:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558724651;
        bh=+Ljjnw/DvlVxiX3j7z/OH3g1FmEAAQfgPnF+JE7yyEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t4FjFl1ktvIqAo8X88jpOJF7YZjvmLLSCRSz7PCaX+05g4bof96YnxWTsFwCK+avX
         g+YwoGbSB9RuJ00cvmFWNR0Kaq/Q1QMem4OW4PMGWR1kwgndtDvR+aiSveIfb9BUhu
         JGcnMHsH5co4wSc8kkZKHxY1M1zKOlH9YplhwAXg=
Date:   Fri, 24 May 2019 21:04:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Prateek Sood <prsood@codeaurora.org>
Cc:     rafael@kernel.org, sramana@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drivers: core: Remove glue dirs early only when
 refcount is 1
Message-ID: <20190524190409.GA29565@kroah.com>
References: <20190501065313.GA30616@kroah.com>
 <1556711999-16898-1-git-send-email-prsood@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556711999-16898-1-git-send-email-prsood@codeaurora.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 05:29:59PM +0530, Prateek Sood wrote:
> While loading firmware blobs parallely in different threads, it is possible
> to free sysfs node of glue_dirs in device_del() from a thread while another
> thread is trying to add subdir from device_add() in glue_dirs sysfs node.

<snip>

Is this the same fix that:
	Subject: [PATCH v4] driver core: Fix use-after-free and double free on glue directory
is also trying to fix?

Why is it doing so in such a different way?

thanks,

greg k-h
