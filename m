Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBB7D3F41
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 14:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfJKMKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 08:10:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:55974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727198AbfJKMKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 08:10:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30579214E0;
        Fri, 11 Oct 2019 12:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570795829;
        bh=1HF5oDylqkQdNUE14J4LseEYxIdw2cU7F7CHxNQebnM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yfYHt8JFigyVnxTAUZn4PbN+TE7b6EO2Q/2QLGYU591yhUjaRPoAdmimQG9RL0faB
         ChwdYwQG+/2BVlVAZlbxKrNaLo/nvGHwl3H9W/tOigASyuzOW0oyDGRRbmfHgUT3He
         43BOz6yVsaDqaQuMdrTABWczp1W46zGW6Oe3rktU=
Date:   Fri, 11 Oct 2019 14:10:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jerome Pouiller <Jerome.Pouiller@silabs.com>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] staging: wfx: fix potential vulnerability to spectre
Message-ID: <20191011121027.GA1144221@kroah.com>
References: <20191011101551.30946-1-Jerome.Pouiller@silabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191011101551.30946-1-Jerome.Pouiller@silabs.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 10:15:54AM +0000, Jerome Pouiller wrote:
> From: J�r�me Pouiller <jerome.pouiller@silabs.com>
> 
> array_index_nospec() should be applied after a bound check.
> 
> Fixes: 9bca45f3d6924f19f29c0d019e961af3f41bdc9e ("staging: wfx: allow to send 802.11 frames")

No need for the full sha1, this should be:
	Fixes: 9bca45f3d692 ("staging: wfx: allow to send 802.11 frames")

The command:
	git show -s --abbrev-commit --abbrev=12 --pretty=format:"%h (\"%s\")%n"
will provide it in the correct format.

Can you fix this up and resend?

thanks,

greg k-h
