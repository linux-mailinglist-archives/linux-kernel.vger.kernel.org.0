Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 453501812CB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 09:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbgCKIUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 04:20:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbgCKIUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 04:20:46 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 448342082E;
        Wed, 11 Mar 2020 08:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583914845;
        bh=GmJNbFRmVzHqNxMlbiejxZG/ZtZVxK9/BMxk9LgKxjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=01E/2LMki/OUi3TQ3TRpihzzOHd4Vf2dgE9WX9pv0K+9/tTS88ecvx99Chjul6Hr7
         hlTRQeClfWJmsW2mQM7RjdXSwDb8BZSxzQD8xt30PTc/Ncj7Rcp3MqpMm2ou4XZftV
         559aHT5QeU4LXQAoA0+jErbPkGmwdnk3KMTc0zPI=
Date:   Wed, 11 Mar 2020 16:20:38 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, leoyang.li@nxp.com, laurentiu.tudor@nxp.com,
        Xiaowei.Bao@nxp.com
Subject: Re: [PATCHv2] arm64: dts: layerscape: add iommu-map property to pci
 nodes
Message-ID: <20200311082037.GZ29269@dragon>
References: <20200302042027.15589-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302042027.15589-1-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 12:20:27PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Add the iommu-map property to the pci nodes so that the firmware
> fixes it up with the required values thus enabling iommu for
> devices connected over pci.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Applied, thanks.
