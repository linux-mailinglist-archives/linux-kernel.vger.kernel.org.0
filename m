Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF7CD5B57
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 08:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbfJNGWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 02:22:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfJNGWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 02:22:06 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FAB12089C;
        Mon, 14 Oct 2019 06:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571034126;
        bh=Jjj99LoxCmtMpzWzfLoU7hX03YIEXAcoDRPAZxbv1d8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CMCQ0cSRswKmQ6g9H8pNkHrvXFekn/GdKq9hibcG0vVCGTH+FfweKsk9NoRIhColI
         egntYbNiNnBhF7R2XVwIQ5ZmllHOyf2OCx5NRj1EuhgnRthnTQRFJr5kM3u7K2wFnf
         XChMGX5tYtundrxQ/XHpkBwzzCQbNKQ65qPQx7is=
Date:   Mon, 14 Oct 2019 14:21:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Wen He <wen.he_1@nxp.com>
Cc:     "linux-devel@linux.nxdi.nxp.com" <linux-devel@linux.nxdi.nxp.com>,
        Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXT] Re: [v2 2/2] arm64: dts: ls1028a: Update the DT node
 definition for dpclk
Message-ID: <20191014062150.GC12262@dragon>
References: <20190920083419.5092-1-wen.he_1@nxp.com>
 <20190920083419.5092-2-wen.he_1@nxp.com>
 <20191007123512.GM7150@dragon>
 <DB7PR04MB5195760127B83B88B68CC602E29A0@DB7PR04MB5195.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB7PR04MB5195760127B83B88B68CC602E29A0@DB7PR04MB5195.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 04:08:57AM +0000, Wen He wrote:
> 
> 
> > -----Original Message-----
> > From: Shawn Guo <shawnguo@kernel.org>
> > Sent: 2019年10月7日 20:35
> > To: Wen He <wen.he_1@nxp.com>
> > Cc: linux-devel@linux.nxdi.nxp.com; Leo Li <leoyang.li@nxp.com>; Rob Herring
> > <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org
> > Subject: [EXT] Re: [v2 2/2] arm64: dts: ls1028a: Update the DT node definition
> > for dpclk
> > 
> > 
> > On Fri, Sep 20, 2019 at 04:34:19PM +0800, Wen He wrote:
> > > Update DT node name clock-controller to clock-display,
> > 
> > The node name clock-controller is so good, and I do not understand why you
> > need to change it.
> > 
> 
> The node name clock-controller used for the system clockgen and this clock only used for
> the Display core. 
> To clearly the node, that why I have to use clock-display to instead of the clock-controller

Label is being used to specify things, and node name should just be as
generic as possible.

Shawn
