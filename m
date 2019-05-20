Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF5622A23
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 05:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbfETDAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 May 2019 23:00:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfETDAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 23:00:16 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89B5D20644;
        Mon, 20 May 2019 03:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558321216;
        bh=jfXJLpbE4kXVGEV+hjaGh9tglvbqgZpjqOPGuhlXhw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q04B34MHld4TgcGDc2o8fyDiFEHWoWvO3RVgFsIzdQXhPoJ5V8FHCymqVcamGjl17
         cL2yBja8Ycz72rJgso+rQEPMEjf5HZcsDa+kQrSbmG9bcOQW3i2gdSKw9Yl4n6V4oC
         IqowJfnhugvmFMzNVO0J3SVwxICZoSaSQxBU7G+I=
Date:   Mon, 20 May 2019 10:59:28 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH RESEND] ARM: dts: imx6ul: add clock-frequency to CPU node
Message-ID: <20190520025927.GM15856@dragon>
References: <1557651135-12109-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557651135-12109-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 08:57:16AM +0000, Anson Huang wrote:
> Add clock-frequency property to CPU node. Avoids warnings like
> "/cpus/cpu@0 missing clock-frequency property" for "arm,cortex-a7".
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
