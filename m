Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13E444BF7D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 19:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbfFSRWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 13:22:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:58488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfFSRWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 13:22:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA98720657;
        Wed, 19 Jun 2019 17:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560964932;
        bh=qudgsa4JBO21wfrHksBOfNpmj6WRBH0JrFui2GVg8vM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PF2KC0yVK8/lE9hVQzG8eEXzJzYxGlkM7IpE6w4fqBNNR3Y2gZPvnMRR1X73UyGvo
         lzWioJ+uNNAQd7BccWdekRo5InifD7j9h6Mm6VeksgR2zSJvJIi0A8sP2nxrBhoaEn
         TIpfzeljboqiLw+JOclbQ/mX41DCVdDUV1JJfP54=
Date:   Wed, 19 Jun 2019 19:22:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Thunderbolt fixes for v5.2-rc6
Message-ID: <20190619172210.GA22445@kroah.com>
References: <20190619110802.GT2640@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619110802.GT2640@lahna.fi.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 02:08:02PM +0300, Mika Westerberg wrote:
> Hi Greg,
> 
> The following changes since commit d1fdb6d8f6a4109a4263176c84b899076a5f8008:
> 
>   Linux 5.2-rc4 (2019-06-08 20:24:46 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git tags/thunderbolt-fixes-for-v5.2-rc6

Pulled and pushed out, thanks.

greg k-h
