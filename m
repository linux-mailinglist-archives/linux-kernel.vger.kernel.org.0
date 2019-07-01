Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB18E3A50B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2019 13:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbfFILKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jun 2019 07:10:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728095AbfFILKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 07:10:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 948672067C;
        Sun,  9 Jun 2019 11:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560078613;
        bh=1d9+J7XDay3F1wx37n9MwAgAdU4jSPS6LL7Q6F/OeZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ocsi9h86devrkvfAio+pTO7vwHNLSXbMPsJCVHQnxUecA4Ynn+LFLmWdgCm7xjI+3
         9jQtUlJyAh6WhiW/o+50oSLe54g5ZrAqW9TmaxeFtw8HXxgHKQj3+rupHMHi4LyE84
         QDCQGIvX0VnHuKY7VmXp5NAWmyst0dYDQO/jCmak=
Date:   Sun, 9 Jun 2019 13:10:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Deepak Mishra <linux.dkm@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, straube.linux@gmail.com
Subject: Re: [PATCH v4 0/6] staging: rtl8712: cleanup struct _adapter
Message-ID: <20190609111010.GA28875@kroah.com>
References: <cover.1559990697.git.linux.dkm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1559990697.git.linux.dkm@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 08, 2019 at 04:26:55PM +0530, Deepak Mishra wrote:
> In process of cleaning up rtl8712 struct _adapter in drv_types.h I have
> tried to remove some unused variables and redundant lines of code
> associated with those variables. I have also fixed some CamelCase
> reported by checkpatch.pl  
> 
> Deepak Mishra (6):
>   staging: rtl8712: Fixed CamelCase for EepromAddressSize
>   staging: rtl8712: Removed redundant code from function
>     oid_rt_pro_write_register_hdl
>   staging: rtl8712: Fixed CamelCase cmdThread rename to cmd_thread
>   staging: rtl8712: removed unused variables from struct _adapter
>   staging: rtl8712: Renamed CamelCase wkFilterRxFF0 to wk_filter_rx_ff0
>   staging: rtl8712: Renamed CamelCase lockRxFF0Filter to
>     lock_rx_ff0_filter

If this is a "v4" series, I do not see a list of what has changed from
the previous versions at all here :(

Please list it somewhere, usually in the individual patches below the
--- line, or you can put it here in the 00/XX email as well.

v5 please?

thanks,

greg k-h
