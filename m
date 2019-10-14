Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B305D63AF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 15:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731295AbfJNNTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 09:19:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:33954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729858AbfJNNTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:19:35 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 951792089C;
        Mon, 14 Oct 2019 13:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571059174;
        bh=MU22sQWtNGFLaZ7VVqgGHyuBGYvlxHzP0ot2WRE8360=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x1IPsy689yDs6DOJ+UDQFYiFEPtUfEEg2ylZHz+HN23IhQD8lS5HaltQMyR8fv3k9
         SFLdKbJ6UcFj0XnYJ7Yb7XMhNYLboGNr+mleC2gMYP2WTyxpqrVXMSFYKGihBc/Fbd
         ZCd61AiUskpO1DDYa6I4420bsg6mkBgsWGKvKESk=
Date:   Mon, 14 Oct 2019 21:18:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Yinbo Zhu <yinbo.zhu@nxp.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, xiaobo.xie@nxp.com,
        jiafei.pan@nxp.com, Ran Wang <ran.wang_1@nxp.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64: dts: enable otg mode for dwc3 usb ip on
 layerscape
Message-ID: <20191014131847.GX12262@dragon>
References: <20191008025642.19519-1-yinbo.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008025642.19519-1-yinbo.zhu@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 10:56:42AM +0800, Yinbo Zhu wrote:
> layerscape otg function should be supported HNP SRP and ADP protocol
> accroing to rm doc, but dwc3 code not realize it and use id pin to
> detect who is host or device(0 is host 1 is device) this patch is to
> enable OTG mode on ls1028ardb ls1088ardb and ls1046ardb in dts
> 
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>

Applied, thanks.
