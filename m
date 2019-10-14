Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8CD2D6175
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 13:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730899AbfJNLhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 07:37:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730178AbfJNLhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 07:37:21 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D42F20854;
        Mon, 14 Oct 2019 11:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571053040;
        bh=403xwyP/70Kt8i9pVbIBhgksMRYP8QYUMAOP8FwfGbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kOEa0ECOOFqA8ukLjf2YFtheiYS3OyEbJEfnYEdWEwJl3fa0yGyKUVzAVZkHZjgwp
         uPAd6w40HDZXc/ehyoYRBufeqO+CUmFprrfbsUI5KPJOVOZAF9K1NeL/fcH2IHKJBk
         gcx5hohZ3SCzfvPFF1B+ym0OC26vKeor/Hl+/OMw=
Date:   Mon, 14 Oct 2019 19:37:06 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Chris Healy <cphealy@gmail.com>, Cory Tusar <cory.tusar@zii.aero>,
        Jeff White <jeff.white@zii.aero>,
        Rick Ramstetter <rick@anteaterllc.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: vf610-zii-scu4-aib: Specify
 'i2c-mux-idle-disconnect'
Message-ID: <20191014113704.GO12262@dragon>
References: <20191004054115.26082-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004054115.26082-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 10:41:15PM -0700, Andrey Smirnov wrote:
> Specify 'i2c-mux-idle-disconnect' for both I2C switches present on the
> board, since both are connected to the same parent bus and all of
> their children have the same I2C address.
> 
> Fixes: ca4b4d373fcc ("ARM: dts: vf610: Add ZII SCU4 AIB board")
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Cory Tusar <cory.tusar@zii.aero>
> Cc: Jeff White <jeff.white@zii.aero>
> Cc: Rick Ramstetter <rick@anteaterllc.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> Shawn:
> 
> If this is possible, I'd like this one to go into 5.4.

Okay, applied as fix.

Shawn
