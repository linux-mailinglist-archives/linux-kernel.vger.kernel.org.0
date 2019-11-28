Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 198A810C9F6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 14:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfK1N62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 08:58:28 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:64488 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfK1N62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:58:28 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47Nzgf2vq8zCF;
        Thu, 28 Nov 2019 14:55:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1574949360; bh=YbVoq25/hTlPA7F4rLBVhD7nrJGKHabWavLh0FzR5CQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yx1kH5OKPMYDRtcLwbdir/Q0QERwnwTnn2LjkvtlVrly0qfsTVHNF41Kt9CgGjB+g
         /BXaUIr0MWBndg0C9rvtZOlRusbhJxTSqph9jwvxWJF/jG1KG2rUDuYHE9KItnzc2O
         fxbiRryo692WcPlwHdNbMkinsif7m3NDNGsfHP/bESc1AWfzENVVKb/R8AE8Ah1ai9
         UZWEjCzYIevzAQVdGkxcSeHIYKK7eVit0sFitnVOzbGb55eoiAtKE80RAchXikg6Cx
         bJzrsk5f33VJyg7k3xTVdmGud4fsgZlE9+0g1oG5B2W1mlQ3pTccEAbc1HUFMr2N42
         /o8jKSrkwCI9Q==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Thu, 28 Nov 2019 14:58:22 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: at91: fix possible deadlock
Message-ID: <20191128135822.GA6522@qmqm.qmqm.pl>
References: <20191127171915.GK299836@piout.net>
 <20191128102531.817549-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191128102531.817549-1-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 11:25:31AM +0100, Alexandre Belloni wrote:
> Lockdep warns about a possible circular locking dependency because using
> syscon_node_to_regmap() will make the created regmap get and enable the
> first clock it can parse from the device tree. This clock is not needed to
> access the registers and should not be enabled at that time.
> 
> Use the recently introduced device_node_to_regmap to solve that as it looks
> up the regmap in the same list but doesn't care about the clocks.
> 
> Reported-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
[...]

Tested-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>

Thanks! Can you push this to stable?

Best Regards,
Micha³ Miros³aw
