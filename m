Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCFE18CF8C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 14:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgCTN4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 09:56:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbgCTN4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:56:07 -0400
Received: from localhost (unknown [122.167.82.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D559720709;
        Fri, 20 Mar 2020 13:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584712566;
        bh=bQLfnNJ21tARCpyrrG8kAbYnLEtL50j8Wc8tG/DdL90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NavK74h2sYbbhdArU4x0jD1mqxNRojoZeiD2Qy9BRwIEIPCfkuC+cttylna7mGG05
         3T+ScfauWK8yJSIU57Kgg7uh7YuKBXjGJzKIjUsdwR+KV3jL0gVuXPAk+tXokSx3AM
         NAtOipTPMM2f+0SYs0ggJCObPHK0GAaWtS0N/pmY=
Date:   Fri, 20 Mar 2020 19:26:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, pierre-louis.bossart@linux.intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/2] soundwire: stream: Add read_only_wordlength flag to
 port properties
Message-ID: <20200320135602.GF4885@vkoul-mobl>
References: <20200311113545.23773-1-srinivas.kandagatla@linaro.org>
 <20200311113545.23773-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311113545.23773-2-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-03-20, 11:35, Srinivas Kandagatla wrote:
> According to SoundWire Specification Version 1.2.
> "A Data Port number X (in the range 0-14) which supports only one
> value of WordLength may implement the WordLength field in the
> DPX_BlockCtrl1 Register as Read-Only, returning the fixed value of
> WordLength in response to reads."
> 
> As WSA881x interfaces in PDM mode making the only field "WordLength"
> in DPX_BlockCtrl1" fixed and read-only. Behaviour of writing to this
> register on WSA881x soundwire slave with Qualcomm Soundwire Controller
> is throwing up an error. Not sure how other controllers deal with
> writing to readonly registers, but this patch provides a way to avoid
> writes to DPN_BlockCtrl1 register by providing a read_only_wordlength
> flag in struct sdw_dpn_prop

Applied, thanks

I will send a tag, so that mark can apply the second patch for asoc

Thanks
-- 
~Vinod
