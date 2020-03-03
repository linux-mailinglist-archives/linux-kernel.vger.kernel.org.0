Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C470E177B22
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 16:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbgCCPyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 10:54:07 -0500
Received: from onstation.org ([52.200.56.107]:53686 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729819AbgCCPyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 10:54:07 -0500
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id CBFBA3E8F4;
        Tue,  3 Mar 2020 15:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1583250846;
        bh=0SaRxdWMTqtAwX4yYkP3ZWd6Ph0tbt9BtijuitXT26U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dU/J6MnwNC8dS+CNqc1YahheQQ1hS5esVK/moWdDsUW1CzpNx5ByB0CbmeEBFxCGx
         LSePqeKs3PxS23s4rBruD84d4V0InqePyp/kv5dfoaZxLjG+VENIw+8WmlfHCWsTRP
         +Rhz8S3aBaQ5fbFbbalxLM4M3B986pDvfufyTQKM=
Date:   Tue, 3 Mar 2020 10:54:05 -0500
From:   Brian Masney <masneyb@onstation.org>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>, Sean Paul <sean@poorly.run>,
        DTML <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh+dt@kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>
Subject: Re: [Freedreno] [PATCH v3 1/2] dt-bindings: display: msm: Convert
 GMU bindings to YAML
Message-ID: <20200303155405.GA11841@onstation.org>
References: <1583173424-21832-1-git-send-email-jcrouse@codeaurora.org>
 <1583173424-21832-2-git-send-email-jcrouse@codeaurora.org>
 <20200302204906.GA32123@ravnborg.org>
 <20200303154321.GA24212@jcrouse1-lnx.qualcomm.com>
 <CAOCk7NpP8chviZ0eM_4Fm3b2Jn+ngtVq=EYB=7yMK0H7rnfWMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOCk7NpP8chviZ0eM_4Fm3b2Jn+ngtVq=EYB=7yMK0H7rnfWMg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 08:50:28AM -0700, Jeffrey Hugo wrote:
> On Tue, Mar 3, 2020 at 8:43 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
> >
> > On Mon, Mar 02, 2020 at 09:49:06PM +0100, Sam Ravnborg wrote:
> > > Hi Jordan.
> > >
> > > On Mon, Mar 02, 2020 at 11:23:43AM -0700, Jordan Crouse wrote:
> > > > Convert display/msm/gmu.txt to display/msm/gmu.yaml and remove the old
> > > > text bindings.
> > > >
> > > > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > > > ---
> > > >
> > > >  .../devicetree/bindings/display/msm/gmu.txt        | 116 -------------------
> > > > -
> > > > -Required properties:
> > > > -- compatible: "qcom,adreno-gmu-XYZ.W", "qcom,adreno-gmu"
> > > > -    for example: "qcom,adreno-gmu-630.2", "qcom,adreno-gmu"
> > > > -  Note that you need to list the less specific "qcom,adreno-gmu"
> > > > -  for generic matches and the more specific identifier to identify
> > > > -  the specific device.
> > > > -- reg: Physical base address and length of the GMU registers.
> > > > -- reg-names: Matching names for the register regions
> > > > -  * "gmu"
> > > > -  * "gmu_pdc"
> > > > -  * "gmu_pdc_seg"
> > > > -- interrupts: The interrupt signals from the GMU.
> > > > -- interrupt-names: Matching names for the interrupts
> > > > -  * "hfi"
> > > > -  * "gmu"
> > > > -- clocks: phandles to the device clocks
> > > > -- clock-names: Matching names for the clocks
> > > > -   * "gmu"
> > > > -   * "cxo"
> > > > -   * "axi"
> > > > -   * "mnoc"
> > > The new binding - and arch/arm64/boot/dts/qcom/sdm845.dtsi agrees that
> > > "mnoc" is wrong.
> > >
> > > > -- power-domains: should be:
> > > > -   <&clock_gpucc GPU_CX_GDSC>
> > > > -   <&clock_gpucc GPU_GX_GDSC>
> > > > -- power-domain-names: Matching names for the power domains
> > > > -- iommus: phandle to the adreno iommu
> > > > -- operating-points-v2: phandle to the OPP operating points
> > > > -
> > > > -Optional properties:
> > > > -- sram: phandle to the On Chip Memory (OCMEM) that's present on some Snapdragon
> > > > -        SoCs. See Documentation/devicetree/bindings/sram/qcom,ocmem.yaml.
> > > This property is not included in the new binding.
> >
> > Yeah, that guy shouldn't be here. I'm not sure how it got there in the first
> > place but I'll update the commit log. Thanks for the poke.
> 
> I thought this was something Brian M added for older targets (A4XX?).
> Perhaps he should chime in?

Yes, this is needed for older systems with a3xx and a4xx GPUs.

Brian
