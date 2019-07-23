Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1759712FB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 09:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732753AbfGWHgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 03:36:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729217AbfGWHgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 03:36:54 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A55C2251A;
        Tue, 23 Jul 2019 07:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563867413;
        bh=k3LA9hzAaxtEeLK7HegCGPVUaZoeagWVAfV3MLEBScg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ndm2K1U35TJz0HsSn7XNKjEdJsC6PfuMcpyNN13EPwKh7K/wCiro22wPbo8NDUTKt
         hxf+Si135oYBcLCQ29u7AVvJPSrBW4XTiEDPuOqhb4BEX7y6LmTe4onklrmgoJrj3r
         YZB6od8m+8tOmC751ZmE7zolY9OuTDyKpXFqbatc=
Date:   Tue, 23 Jul 2019 15:36:24 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ARM: dts: vf610-zii-spb4: Drop unused pinctrl_i2c1
 pinmux config
Message-ID: <20190723073623.GH15632@dragon>
References: <20190717150253.20107-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717150253.20107-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 08:02:51AM -0700, Andrey Smirnov wrote:
> Pinctrl_i2c1 pinmux config is not used anywhere. Drop it.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Cory Tusar <cory.tusar@zii.aero>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

Applied all, thanks.
