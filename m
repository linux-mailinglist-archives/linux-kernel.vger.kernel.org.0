Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 757378CA08
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 06:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfHNEHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 00:07:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725265AbfHNEHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 00:07:14 -0400
Received: from localhost (unknown [106.51.111.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 880172083B;
        Wed, 14 Aug 2019 04:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565755633;
        bh=Fbm2JsgKb3+Qlou7UbRECn9QYyevRyLZgAJEMCqmHWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zU9dzbXhkI60XVNZEJ6lsxWo6ZERKeZNY/HTiPGo+cOjKQbAQHef8g3IbRPXVvS9i
         cJcW9Rce0NQbCcPKbtOthsbYweUwJ2ErWgf1s4z6h9pQEkP2Qzn4lU9s8DqDXgmoED
         5TFQaxjUC7ez9J2peuPkimAmtOf07SNknQHeuh9k=
Date:   Wed, 14 Aug 2019 09:35:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
        linux-kernel@vger.kernel.org, plai@codeaurora.org,
        lgirdwood@gmail.com, robh+dt@kernel.org, spapothi@codeaurora.org
Subject: Re: [PATCH v2 1/5] soundwire: Add compute_params callback
Message-ID: <20190814040558.GT12733@vkoul-mobl.Dlink>
References: <20190813083550.5877-1-srinivas.kandagatla@linaro.org>
 <20190813083550.5877-2-srinivas.kandagatla@linaro.org>
 <7e462330-a357-698a-b259-5ff136963a57@linux.intel.com>
 <1a02f190-0aab-d512-ceb0-4a21014705e8@linaro.org>
 <3fd3c98c-eb25-7040-3089-f5e5bc9d24ee@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fd3c98c-eb25-7040-3089-f5e5bc9d24ee@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-08-19, 14:08, Pierre-Louis Bossart wrote:
> On 8/13/19 1:17 PM, Srinivas Kandagatla wrote:
> > 
> > 
> > On 13/08/2019 15:34, Pierre-Louis Bossart wrote:
> > > On 8/13/19 3:35 AM, Srinivas Kandagatla wrote:
> > > > From: Vinod Koul <vkoul@kernel.org>
> > > > 
> > > > This callback allows masters to compute the bus parameters required.
> > > 
> > > This looks like a partial use of the patch ('soundwire: Add Intel
> > > resource management algorithm')? see comments below
> > > 
> > 
> > Yes it duplicate indeed!
> > 
> > I will use that patch!
> 
> Actually please don't...
> we found issues with the Intel allocation so I'd rather have the big Intel
> patch split into two parts, with callbacks+prepare/deprepare changes going
> in first. It'll be much faster/nicer for everyone.

I was about to say that as well. I think lets take this as is and Intel
algo can be on top of this. That seems easier for everyone to sort
dependencies

-- 
~Vinod
