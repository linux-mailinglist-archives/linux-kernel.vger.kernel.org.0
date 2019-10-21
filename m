Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88918DE320
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 06:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfJUEV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 00:21:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbfJUEV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 00:21:26 -0400
Received: from localhost (unknown [122.167.89.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90285205ED;
        Mon, 21 Oct 2019 04:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571631686;
        bh=aKV0GI2LaBZexbyO2kDe7uvFBubaBAfSXZDSi1+3jrM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=00LqS1fAywMwgzZDkaA4wUXkNntXhF2/biX4ZwRPRe+H3nQoLyUSHXedpmUoU1k+9
         MD21JXUWro4CPAcjg0Ew5ewuIoGXuoqOBGx+zhf2qKo5hsx8d3UUxmNgoTfZ9E/DBA
         n6MiPppKQuMRlZQYgGqtvQCIWg9n4d1/fg4hTkig=
Date:   Mon, 21 Oct 2019 09:51:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [PATCH 0/6] soundwire: intel/cadence: simplify PDI handling
Message-ID: <20191021042117.GZ2654@vkoul-mobl>
References: <20190916192348.467-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916192348.467-1-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-09-19, 14:23, Pierre-Louis Bossart wrote:
> These patches were originally submitted as '[RFC PATCH 00/11]
> soundwire: intel: simplify DAI/PDI handling'. There were no comments
> received.
> 
> This series only provides the PDI changes, which makes it simpler to
> review. The DAI changes will be provided with the complete series for
> ASoC/SOF integration, which is a larger change.

Applied all, thanks

-- 
~Vinod
