Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE2A11A68E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 10:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbfLKJOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 04:14:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:58930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728024AbfLKJOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 04:14:50 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3CD2214AF;
        Wed, 11 Dec 2019 09:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576055689;
        bh=sWqE+PcnhDwEJHLDzeVDWNdfl/id8Y+dl/d6YHFPhmA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mKolWP6/zNkaJDAq1mr0n9oO24i8kaPsJRDd3Dp/NZYOY7F9QumKj2uIhdgdsLMQu
         VZ+HrToPi4ZuQeae+gCZnhKKsFTFQTeETG9LbIfEuldpN/50LPbIfDXyawdzRESIsw
         fhqzZ4d6Md+Phzj1BzeVO5L+MidMps2jm/E3xrCM=
Date:   Wed, 11 Dec 2019 17:14:35 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Y.b. Lu" <yangbo.lu@nxp.com>
Cc:     Ashish Kumar <ashish.kumar@nxp.com>,
        Alexandru Marginean <alexandru.marginean@nxp.com>,
        Alison Wang <alison.wang@nxp.com>,
        "Amit Jain (aj)" <amit.jain_1@nxp.com>,
        "catalin.horghidan@nxp.com" <catalin.horghidan@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Jiafei Pan <jiafei.pan@nxp.com>, Leo Li <leoyang.li@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "rajat.srivastava@nxp.com" <rajat.srivastava@nxp.com>,
        Rajesh Bhagat <rajesh.bhagat@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Xiaobo Xie <xiaobo.xie@nxp.com>,
        Michael Walle <michael@walle.cc>, Yinbo Zhu <yinbo.zhu@nxp.com>
Subject: Re: [PATCH v1 3/4] arm64: dts: ls1028a: fix little-big endian issue
 for dcfg
Message-ID: <20191211091433.GU15858@dragon>
References: <20190814072649.8237-3-yinbo.zhu@nxp.com>
 <20191210000623.22321-1-michael@walle.cc>
 <VI1PR0401MB2237D2D6708807511BDB8788F85B0@VI1PR0401MB2237.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0401MB2237D2D6708807511BDB8788F85B0@VI1PR0401MB2237.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 02:34:30AM +0000, Y.b. Lu wrote:
> + Shawn,
> 
> > -----Original Message-----
> > From: Michael Walle <michael@walle.cc>
> > Sent: Tuesday, December 10, 2019 8:06 AM
> > To: Yinbo Zhu <yinbo.zhu@nxp.com>
> > Cc: Ashish Kumar <ashish.kumar@nxp.com>; Alexandru Marginean
> > <alexandru.marginean@nxp.com>; Alison Wang <alison.wang@nxp.com>;
> > Amit Jain (aj) <amit.jain_1@nxp.com>; catalin.horghidan@nxp.com; Claudiu
> > Manoil <claudiu.manoil@nxp.com>; devicetree@vger.kernel.org; Jiafei Pan
> > <jiafei.pan@nxp.com>; Leo Li <leoyang.li@nxp.com>;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > linuxppc-dev@lists.ozlabs.org; mark.rutland@arm.com;
> > rajat.srivastava@nxp.com; Rajesh Bhagat <rajesh.bhagat@nxp.com>;
> > robh+dt@kernel.org; Vabhav Sharma <vabhav.sharma@nxp.com>; Xiaobo Xie
> > <xiaobo.xie@nxp.com>; Y.b. Lu <yangbo.lu@nxp.com>; Michael Walle
> > <michael@walle.cc>
> > Subject: Re: [PATCH v1 3/4] arm64: dts: ls1028a: fix little-big endian issue for
> > dcfg
> > 
> 
> [Y.b. Lu] Acked-by: Yangbo Lu <yangbo.lu@nxp.com>
> 
> Hi Shawn, could you help to review and merge the two dts patches of this patch-set?
> Thanks.

Please resend them with me on recipients.

Shawn
