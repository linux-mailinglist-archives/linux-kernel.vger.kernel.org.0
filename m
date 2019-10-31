Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F113EACD4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 10:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfJaJst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 05:48:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbfJaJss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 05:48:48 -0400
Received: from localhost (lns-bzn-32-82-254-4-138.adsl.proxad.net [82.254.4.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4EDD2086D;
        Thu, 31 Oct 2019 09:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572515328;
        bh=pQ2TZ8AZGjE832CFWtP12FmqR4rocBUFpuSdy3IhJps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ecnwFU71ceqdrL0AkjJR5tVBlshMAAl40bFLHlhvuyeRilCtOSdIqM3aUH9rIYomt
         uqFUHzTJvOCzAUGfbJ5UJsB7+hWo0abFBvUSVWS2cfwZF0MxNWWQkothYzO2b6ulSn
         Ag1eINk53eyrnibM0eL5ntAKipomJK0pgdMDeTI8=
Date:   Thu, 31 Oct 2019 10:48:37 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     mark.rutland@arm.com, robh+dt@kernel.org, wens@csie.org,
        jernej.skrabec@siol.net, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 1/3] ARM64: dts: sun50i-h6-pine-h64: state that the DT
 supports the modelB
Message-ID: <20191031094837.wy4gj6xo4youao75@hendrix>
References: <1572438255-26107-1-git-send-email-clabbe@baylibre.com>
 <1572438255-26107-2-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572438255-26107-2-git-send-email-clabbe@baylibre.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 12:24:13PM +0000, Corentin Labbe wrote:
> The current sun50i-h6-pine-h64 DT does not specify which model (A or B)
> it supports.
> When this file was created, only modelA was existing, but now both model
> exists and with the time, this DT drifted to support the model B since it is
> the most common one.
> Furtheremore, some part of the model A does not work with it like ethernet and
> HDMI connector (as confirmed by Jernej on IRC).
>
> So it is time to settle the issue, and the easiest way is to state that
> this DT is for model B.

No, this DT was introduced for model A, and we have to keep that. If
some model B changes crept in, that's unfortunate, but it should be
reverted, instead of changing the assumptions like this.

Maxime
