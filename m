Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57B04277CD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 10:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbfEWIQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 04:16:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:51130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbfEWIQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 04:16:34 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2970920665;
        Thu, 23 May 2019 08:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558599393;
        bh=NZf4YLD4LHzsJ7Iw0Ui8Zne1NY8VX4JKe1guPQ0sIXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w0FJxcelTJh94Ds1oI87eUSzKc7ByFngW438dgYJnRvVoSdEPHHoX5VfYgyAtKB4j
         MxulVl3rGw6Non02hQG2DmpTpK6O3kc9Qrj8hcOylDuyquvMQ/DxvWzO9O0Q0Z9Uul
         g+Xx2ocuExBRfGkJyQ3hF/nqrNOkbetNiOPQ9sRk=
Date:   Thu, 23 May 2019 16:15:34 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Xiaowei Bao <xiaowei.bao@nxp.com>
Cc:     Leo Li <leoyang.li@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCHv2] arm64: dts: ls1028a: add flexspi nodes
Message-ID: <20190523081533.GJ9261@dragon>
References: <20190515110924.13726-1-xiaowei.bao@nxp.com>
 <20190523080049.GI9261@dragon>
 <AM5PR04MB32997EA37551AFC88FCBE2C6F5010@AM5PR04MB3299.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM5PR04MB32997EA37551AFC88FCBE2C6F5010@AM5PR04MB3299.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 08:06:42AM +0000, Xiaowei Bao wrote:
> > +             compatible = "nxp,lx2160a-fspi", "simple-bus";
> > +             #address-cells = <1>;
> > +             #size-cells = <0>;
> > +             reg = <0x0 0x20c0000 0x0 0x10000>,
> > +                 <0x0 0x20000000 0x0 0x10000000>;
> 
> Fix the indentation to git it aligned with above '<'.
> [Xiaowei Bao] this is aligned, I don't know why it is not aligned in email. Thanks.

That's fine then.

Shawn
