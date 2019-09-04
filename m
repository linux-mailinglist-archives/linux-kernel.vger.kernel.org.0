Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 525CDA7D11
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 09:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbfIDHxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 03:53:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727787AbfIDHxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 03:53:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27200206BB;
        Wed,  4 Sep 2019 07:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567583581;
        bh=tmMIKkRHa6g2/BLlTkNjkjnAHIGhAGpY/C/sVcBFQJc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ywyxb1m63X/hIBsYMEgeSYZNR3U/vzO1YwXTorX6LJyKRdYGw5x0lLxby0UDevtE9
         SuA3eihix0P54Tu+s7uKLyhFHkjVxEZIt+PYQ3dTHxMMn4oviPvEe+do/dfqdqNzFJ
         FyJNNYIS5i6pTQhosKEdSKj6Zp+gpaIxerpBFXps=
Date:   Wed, 4 Sep 2019 09:52:59 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 4/7] serial: fsl_linflexuart: Be consistent with the
 name
Message-ID: <20190904075259.GA10983@kroah.com>
References: <20190823191115.18490-1-stefan-gabriel.mirea@nxp.com>
 <20190823191115.18490-5-stefan-gabriel.mirea@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823191115.18490-5-stefan-gabriel.mirea@nxp.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 07:11:37PM +0000, Stefan-gabriel Mirea wrote:
> For consistency reasons, spell the controller name as "LINFlexD" in
> comments and documentation.
> 
> Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 2 +-
>  drivers/tty/serial/Kconfig                      | 8 ++++----
>  drivers/tty/serial/fsl_linflexuart.c            | 4 ++--
>  include/uapi/linux/serial_core.h                | 4 ++--
>  4 files changed, 9 insertions(+), 9 deletions(-)

Doesn't apply to my tty-next tree :(
