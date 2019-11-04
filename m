Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C446ED917
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 07:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfKDGf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 01:35:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:56768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727444AbfKDGf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 01:35:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1775E20578;
        Mon,  4 Nov 2019 06:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572849357;
        bh=2ylaMZwpQFEq7KbtUp1IjA0BtT8V/RGUrfcxOsVl/Xk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O2ONmdXV8hrw+KbLtA18nVhdm8j2MG8W5NegfGhDs8XXrAiikFvzMnrXFSkt5HcyD
         ldyXFTrEp8QC6EBPSHD4zHkej5aS1XDQ/8kbZUl+LZmEd5ptV1ffUM6yMbMUJJPoo7
         2Q2+D5k1ccM5VpgGlL0TGnWXKtdiptzACD/R44u0=
Date:   Mon, 4 Nov 2019 07:35:55 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [GIT PULL 1/7] intel_th: gth: Fix the window switching sequence
Message-ID: <20191104063555.GA1129732@kroah.com>
References: <20191028070651.9770-1-alexander.shishkin@linux.intel.com>
 <20191028070651.9770-2-alexander.shishkin@linux.intel.com>
 <20191102171419.GA484428@kroah.com>
 <877e4gf998.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877e4gf998.fsf@ashishki-desk.ger.corp.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 08:25:39AM +0200, Alexander Shishkin wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > On Mon, Oct 28, 2019 at 09:06:45AM +0200, Alexander Shishkin wrote:
> >> Commit 8116db57cf16 ("intel_th: Add switch triggering support") added
> >> a trigger assertion of the CTS, but forgot to de-assert it at the end
> >> of the sequence. This results in window switches randomly not happening.
> >> 
> >> Fix that by de-asserting the trigger at the end of the window switch
> >> sequence.
> >> 
> >> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> >> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >> ---
> >>  drivers/hwtracing/intel_th/gth.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >
> > Shouldn't this have a Fixes: tag and a cc: stable@ in it?
> >
> > I can add it if you say it's ok to.
> 
> Fixes: yes, but cc: stable shouldn't be required if this goes into 5.4,
> because the buggy commit is in 5.4-rc1.

8116db57cf16 ("intel_th: Add switch triggering support") was in the 5.2
kernel release.

