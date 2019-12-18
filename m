Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64FD1125463
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 22:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfLRVMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 16:12:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:47070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbfLRVMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:12:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CC212072B;
        Wed, 18 Dec 2019 21:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576703553;
        bh=4RH/TmZuAJlI0q1kIVymXm7bQbzesZoCwVGj1lkpH5E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hPdJBKL/dFVrjaOmqF0b9io657NHPYcPlDsEj4JLr3jfzx3uu5FH4CRshTOfo1fYt
         JRUyrasO5JP2tOr6YO0CRArhfMGdYMor6HDpbURucAS08w5RJqT1TftYf3BjHb0M/3
         F1Wk8SGe0kHtRz4j3E8ZkjGRW0qEDyyPTBlt4bdQ=
Date:   Wed, 18 Dec 2019 22:12:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/24] Consolidate dummy_con initialization
Message-ID: <20191218211231.GA918900@kroah.com>
References: <20191218204002.30512-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218204002.30512-1-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 03:39:38PM -0500, Arvind Sankar wrote:
> This series moves initialization of conswitchp to dummy_con into vt.c,
> and configures DUMMY_CONSOLE unconditionally when CONFIG_VT is enabled.
> 
> The patches after the second one remove conswitchp = &dummy_con; from
> the various architecture setup functions where it currently appears. If
> the first two look ok, I was thinking of sending the others
> individually.
> 
> Arvind Sankar (24):
>   console/dummycon: Remove bogus depends on from DUMMY_CONSOLE
>   vt: Initialize conswitchp to dummy_con if unset
>   arch/setup: Drop dummy_con initialization
>   arch/setup: Drop dummy_con initialization

No two patches in a series should have the same subject line, let alone
20 of them.

Please fix up.

thanks,

greg k-h
