Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A85BBC3475
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 14:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387907AbfJAMjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 08:39:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:38306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387682AbfJAMjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:39:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4DC521920;
        Tue,  1 Oct 2019 12:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569933553;
        bh=sRAud6NV+fSyv8zj10Ky1hyi+v01ityWcJaK95EKrqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YBsl3SDKG3fcoMRkw/wkH2cPn57BF+K+bnCuVesyTN/CDnDhNPHs489qqqOA610I9
         KrM4r0eJOj0l1VibKsi6YpnVhkQ9MSsWWi/duobuvxj/2Z/lybekqPxWmd8Wt3n8TO
         nbA97wckz1Vk4+EbCDbx4w9M5IeSupQeZnaH5gnM=
Date:   Tue, 1 Oct 2019 14:39:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-usb@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Lukas Wunner <lukas@wunner.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 07/22] thunderbolt: Add default linking between ports
 if not provided by DROM
Message-ID: <20191001123911.GB2954373@kroah.com>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
 <20191001113830.13028-8-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001113830.13028-8-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 02:38:15PM +0300, Mika Westerberg wrote:
> Some cases the DROM information is not correct or is simply missing.

What is "DROM"?

> This prevents establishing lane bonding even if it would be possible
> otherwise. To make this work better provide default linking between
> ports if DROM has not provided that information.
> 
> This works with legacy devices where ports 1 and 2, and 3 and 4 are
> linked together and also with USB4.

"linked together" as in "bonded"?  Or something else?  Names are getting
confusing here :(

thanks,

greg k-h
