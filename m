Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86FD0186147
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 02:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbgCPBVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Mar 2020 21:21:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729300AbgCPBVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 21:21:00 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7564F20663;
        Mon, 16 Mar 2020 01:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584321659;
        bh=zqqKWEeMI4XCGqU/56CUWSItvn0VZENyTnl2v7LzlUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tgTF2pK5MVVlM8d4HS3OPjQtx9LVuj3hE3e089EoOQQPewPNK9P38dSayHx/6W+jZ
         WSqBd4gpaKYftBgzJWU5uwGfuXZtflehVWhlh9IXtA77mgvImIjm0CtFYFkDFR/znI
         G9YJq2lLzC68rI4IQXj+AbrtHWSQU/VGDFB3DBco=
Date:   Mon, 16 Mar 2020 09:20:53 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, michael@walle.cc, leoyang.li@nxp.com,
        Mingkai.Hu@nxp.com, Minghuan.Lian@nxp.com, Xiaowei.Bao@nxp.com
Subject: Re: [PATCHv8] arm64: dts: ls1028a: Add PCIe controller DT nodes
Message-ID: <20200316012052.GO17221@dragon>
References: <20200311100339.46122-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311100339.46122-1-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 06:03:39PM +0800, Zhiqiang Hou wrote:
> From: Xiaowei Bao <xiaowei.bao@nxp.com>
> 
> LS1028a implements 2 PCIe 3.0 controllers.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Tested-by: Michael Walle <michael@walle.cc>

Applied, thanks.
