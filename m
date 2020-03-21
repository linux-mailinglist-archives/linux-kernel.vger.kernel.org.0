Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72D8E18DF7C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Mar 2020 11:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgCUKjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Mar 2020 06:39:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbgCUKjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 06:39:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60BC32072C;
        Sat, 21 Mar 2020 10:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584787192;
        bh=bCp40qIqmUuQz7X5ywaAdzCex0ePugSTNMhM578biFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EsrzvWE8dE7hDvPPNIiAkPHo8QI8KmjxF0FWVVX/K/sW6xsVA8yWyHi+nXekf9DXC
         2HsEBNN7jqOR/bIrFVU932u4a0u0Jblfn4+JIDIyUV+w1BqgMSFX6HK1FRwi0FiGdS
         kklLxMsdWm07eJUaT97n0CCvwwt61JrnKZBaNGdI=
Date:   Sat, 21 Mar 2020 11:39:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     mike.leach@linaro.org, suzuki.poulose@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 00/12] coresight: next v5.6-rc6
Message-ID: <20200321103950.GA1063010@kroah.com>
References: <20200320165303.13681-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320165303.13681-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 10:52:51AM -0600, Mathieu Poirier wrote:
> Hi Greg,
> 
> As requested here is another respin - the only thing that changed is
> the replacement of scnprintf() and all sysfs output are now singular,
> i.e don't need any parsing.  That triggered some modification to
> sysfs entries, which have been taken into account in the documentation.
> 
> Applies and compile cleanly on your char-misc-next branch.

Much nicer, thanks for these, all now queued up.

greg k-h
