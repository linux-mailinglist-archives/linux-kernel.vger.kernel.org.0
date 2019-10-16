Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6AA5D87BD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 07:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731402AbfJPFG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 01:06:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbfJPFG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 01:06:57 -0400
Received: from localhost (unknown [171.76.123.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70D8E2168B;
        Wed, 16 Oct 2019 05:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571202417;
        bh=o+A/U2VnXX3Zvppg5SibdIVbnX7GPO5TpyuirHKgZF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dSTbjdP2CwapIv/mxs0CWXPnZDfZDGVmgpcgdWgMDnYWiCOeaxQKvtsx9kqgZNMr7
         PcpcSa/RLp3c4jkAVxqoUtvlHSSyoyFCsmvVxsgMesEAf2GWyiGdGLHmsOwL9uKUmE
         WYU844oJuf8iZlRfDNHbvkSZS9ND9BBBiCJTJFLM=
Date:   Wed, 16 Oct 2019 10:36:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [PATCH 0/2] soundwire: Kconfig/build improvements
Message-ID: <20191016050652.GZ2654@vkoul-mobl>
References: <20190916185739.32184-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916185739.32184-1-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-09-19, 13:57, Pierre-Louis Bossart wrote:
> The Intel kbuild test reported issues with COMPILE_TEST or
> cross-compilation when SOF is enabled, fix. This has no functional
> impact.

Applied, thanks

-- 
~Vinod
