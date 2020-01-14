Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 799C113A0F5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 07:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgANGaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 01:30:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:58222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbgANGaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 01:30:11 -0500
Received: from localhost (unknown [49.207.51.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAEA420678;
        Tue, 14 Jan 2020 06:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578983410;
        bh=I3Npm/q9Ap8kFw8/iit2SOHfjpnmrQRWzSLHCkZfV+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VbMtsrVKAdiDwRHx4pWUBzvGJtv6RXL4bpLxpWe2cbt+4iRKTDJs2Zzg5e1cfMzVg
         CBSJNaFpDUMOHKrO/aKfTnLRRXl2jGo0gPdW40aJe9sNUEMOErELn8EFbBLB2t5twR
         dC918ntBxf8WQ3VhlSxFHRRwpUIjHrSMtxDNZyLA=
Date:   Tue, 14 Jan 2020 12:00:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     robh@kernel.org, bgoswami@codeaurora.org, broonie@kernel.org,
        pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        spapothi@codeaurora.org
Subject: Re: [PATCH v6 0/2] soundwire: Add support to Qualcomm SoundWire
 master
Message-ID: <20200114063006.GE2818@vkoul-mobl>
References: <20200113132153.27239-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113132153.27239-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-01-20, 13:21, Srinivas Kandagatla wrote:
> Thanks for reviewing the v5 patchset.
> Here is new patchset addressing all the comments from v5
> 
> This patchset adds support for Qualcomm SoundWire Master Controller
> found in most of Qualcomm SoCs and WCD audio codecs.
> 
> This driver along with WCD934x codec and WSA881x Class-D Smart Speaker
> Amplifier drivers is tested on on DragonBoard DB845c based of SDM845
> SoC and Lenovo YOGA C630 Laptop based on SDM850.
> 
> SoundWire controller on SDM845 is integrated in WCD934x audio codec via
> SlimBus interface.
> 
> Currently this driver is very minimal and only supports PDM.
> 
> Most of the code in this driver is rework of Qualcomm downstream drivers
> used in Andriod. Credits to Banajit Goswami and Patrick Lai's Team.

Applied, thanks

-- 
~Vinod
