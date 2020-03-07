Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABAB17CD12
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Mar 2020 09:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgCGIzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Mar 2020 03:55:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:44582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbgCGIzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 03:55:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 639FC2070A;
        Sat,  7 Mar 2020 08:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583571347;
        bh=1u8UwniH8fZ2bwB27hJE5oeh1VxEwwuy2nb1KunbV3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZAp2SksvWHujtLHO2DVTUH8NkpDeI26/Svk9pw3HtPXPJd4bqKAOIid0Tfn+G12Cz
         S9dwpUyDg43FHf0FM6GFDEFIZ8C+8QT7B1cxp6/NE0Tv+Hx+dY21dYnoR8XMqPA449
         yhek0zo/WQYI2xu6AwXh6RxoO8C/LzROYrvRwVmU=
Date:   Sat, 7 Mar 2020 09:55:43 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: serial: lpuart: add ls1028a
 compatibility
Message-ID: <20200307085543.GA3878741@kroah.com>
References: <20200306205703.30634-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306205703.30634-1-michael@walle.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 09:57:02PM +0100, Michael Walle wrote:
> Signed-off-by: Michael Walle <michael@walle.cc>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/serial/fsl-lpuart.txt          | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

I can't take a patch without any changelog text, sorry.
