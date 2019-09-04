Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91288A7BC7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 08:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbfIDGfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 02:35:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbfIDGfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 02:35:20 -0400
Received: from localhost (unknown [122.182.201.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84AFF2087E;
        Wed,  4 Sep 2019 06:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567578919;
        bh=fX0AE40pfxtbRZ5P+J2OtsTCuel/OpN/4yspy4TH4pw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KRQY8Pf6YpUV//wJzt3ZA6wEV276BQDhJszhb7paLxspZ8oE4twpu3EPeQOlVy6hp
         AyDlvIg6SYnEseAhudnCHQS/PNH+Qx+hn7N8sFsethMwx5WW8pzlf50MKcAoh/pfy0
         KJKg7UxdRViS7qn5hNcfJ7oyLLrbsMCXHKoScEh0=
Date:   Wed, 4 Sep 2019 12:04:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com,
        gregkh@linuxfoundation.org, Blauciak@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soundwire: bus: set initial value to port_status
Message-ID: <20190904063410.GH2672@vkoul-mobl>
References: <20190829181135.16049-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829181135.16049-1-yung-chuan.liao@linux.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-08-19, 02:11, Bard liao wrote:
> From: Bard Liao <yung-chuan.liao@linux.intel.com>
> 
> port_status[port_num] are assigned for each port_num in some if
> conditions. So some of the port_status may not be initialized.

Applied, thanks

-- 
~Vinod
