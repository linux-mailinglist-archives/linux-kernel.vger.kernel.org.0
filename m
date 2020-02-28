Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA1E41731D2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 08:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgB1Hcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 02:32:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:44212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbgB1Hcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 02:32:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBD2F246A3;
        Fri, 28 Feb 2020 07:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582875172;
        bh=EJ819KBDu+k2dtkanbIAzQ59SFqTDwp5/gb56PSzO98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vpTK8H3PC+31WeXDZVDRv8EttvbleH1wcaGreWT5CjMg/9T8LYoDi2yjS9+Y33zO3
         jP3oHki6L93gMJK5J7kq4hjRyP3g8M7dqqQioVkMPt9t0c7j6sKa/Y84dDSCQe8ppJ
         7RsNJrhT1l1gaQr4bAC/HspSQtyYu2FkdDZdTxBc=
Date:   Fri, 28 Feb 2020 08:32:49 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>
Subject: Re: [PATCH 0/8] soundwire: remove platform devices, add SOF
 interfaces
Message-ID: <20200228073249.GB2898712@kroah.com>
References: <20200227223206.5020-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227223206.5020-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 04:31:58PM -0600, Pierre-Louis Bossart wrote:
> The first two patches were already reviewed by Greg KH in an earlier
> RFC. Since I only cleaned-up the error handling flow and removed an
> unnecessary wrapper, I took the liberty of adding Greg's Reviewed-by
> tag for these two patches.

That is fine, they still look sane to me :)
