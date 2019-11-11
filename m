Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2579CF7A2A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 18:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfKKRsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 12:48:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:38830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbfKKRsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 12:48:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0C0C20818;
        Mon, 11 Nov 2019 17:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573494485;
        bh=6apzf/QJW6InjRsMKp2H1gCrorF/S5IqlNmELXJRJMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ajW/hvNbKXLtoiys8q9LrhFm/MZBB4fpadxcyPzO5gPhOJrnYWIJllehnGYFCEdcr
         fKQqocWmLenLfjlvFILyvXYatxhl3GoLfaqb4YRsDc1w+2KELLHtkg2Zi7f+TpsdaV
         i4iRzQV+FmImINVaQH6S4g4F69WBe1tbu6W+E5SE=
Date:   Mon, 11 Nov 2019 18:48:02 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Jerome Pouiller <Jerome.Pouiller@silabs.com>
Cc:     Jules Irenge <jbi.octave@gmail.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] staging: wfx: replace uintXX_t to uXX and intXX_t
 to sXX
Message-ID: <20191111174802.GA1083018@kroah.com>
References: <20191111133055.214410-1-jbi.octave@gmail.com>
 <22806545.kYr6eE9xQE@pc-42>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22806545.kYr6eE9xQE@pc-42>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 05:04:49PM +0000, Jerome Pouiller wrote:
> I know that uXX is prefered over uintXX_t. However, I dislike to change 
> 650 lines of code only for this purpose in one batch. It will generate 
> plenty of conflicts with branches currently in development. 

Now that the code is in the kernel tree, any "branches currently in
development" have to deal with what is merged upstream no matter if they
are tiny or big patches.  That's just the joy of working with upstream,
sorry.

If you want to do out-of-tree development, that's fine, but you can't
also want the code in-tree at the same time.

thanks,

greg k-h
