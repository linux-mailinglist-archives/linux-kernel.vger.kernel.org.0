Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADA19EF1B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 17:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbfH0Pib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 11:38:31 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:37063 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726190AbfH0Pib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 11:38:31 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id BA06436D8;
        Tue, 27 Aug 2019 11:38:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 27 Aug 2019 11:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=animalcreek.com;
         h=date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=mesmtp; bh=gHaKtllJNGmTopA+xkS0vfLF
        y3HD/TMPeBCAy1enc6Y=; b=VHLgrUBZADvRutTeTEkzbBUTw/QF8BF61HYNYnoW
        dRbFwJS9q3ZltD5Im5mzHewi630Peelwyp8e/iqrWbfP7/LheygLPaz2uEOCN/HC
        gsJkrtYnTsNkWduNLQsZq9r+wW2JfKefe6l7pntevVpAjFWakKyiCY7hn8GnUPrB
        1qE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=gHaKtl
        lJNGmTopA+xkS0vfLFy3HD/TMPeBCAy1enc6Y=; b=p5/dni8K8u25RiXSt8QIvy
        i+eSqD6/Azc54kgcJgI63Qu0UWA25x03f13ZT/7R3LmIJ1IxgfQolF3wPjbBciST
        A4XSOJTD38XGz61pMUb4uIoVQoNp96/hSfaKbOIKg5gq5G1LIwCyjAaUQY+Zoram
        U/q1dJ/rKRGrNXodopnIZeWE03iMMYpxe/rfUS7Fv5ViTtZDxVwUajNTxlsUSi+D
        VHFgSuM2blxYAzs9LyT/3StKiffd0P73C9eSGmlsL9CkoKEce61QFoDQ7iU8Hvxr
        UpXeAOMdblmbxdn/vcGUyfRq8H3dBKr5xBAdqHNMNGDaPhtn3rUutyWY3h1MoMVg
        ==
X-ME-Sender: <xms:dE5lXfh57OFmcA4zx2vnYh_HkDFbKhGEEthCk3OLmPtpSUpyIjezZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudehkedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjohgfsehttdertddtredvnecuhfhrohhmpeforghr
    khcuifhrvggvrhcuoehmghhrvggvrhesrghnihhmrghltghrvggvkhdrtghomheqnecukf
    hppeeikedrvddrkedvrddujedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehmghhrvggv
    rhesrghnihhmrghltghrvggvkhdrtghomhenucevlhhushhtvghrufhiiigvpedu
X-ME-Proxy: <xmx:dE5lXXKvy54PRi81-ArXBqtrvBUVoKsk7aeOPqLOF6_30XnplahO6Q>
    <xmx:dE5lXZZP5gxalHX7Af02wPR2C5yEeF07eEZgKejF4PErgPqHx4aE3Q>
    <xmx:dE5lXY2eoXobTPyPO4KtvOl9L2IemykqDm2QCNafB9kpTYNXXJ2z7A>
    <xmx:dU5lXW_gmmLl6kqyQ660BbIKeeITqOvJf10hJPpCGYtdMhZF9c5SSBf6Sz0>
Received: from blue.animalcreek.com (ip68-2-82-171.ph.ph.cox.net [68.2.82.171])
        by mail.messagingengine.com (Postfix) with ESMTPA id 47DD980060;
        Tue, 27 Aug 2019 11:38:28 -0400 (EDT)
Received: by blue.animalcreek.com (Postfix, from userid 1000)
        id B2E0CA21E58; Tue, 27 Aug 2019 08:38:27 -0700 (MST)
Date:   Tue, 27 Aug 2019 08:38:27 -0700
From:   Mark Greer <mgreer@animalcreek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        elder@kernel.org, johan@kernel.org, linux-kernel@vger.kernel.org,
        Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        David Lin <dtwlin@gmail.com>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>
Subject: Re: [PATCH 7/9] staging: greybus: move core include files to
 include/linux/greybus/
Message-ID: <20190827153827.GB26138@animalcreek.com>
References: <20190825055429.18547-1-gregkh@linuxfoundation.org>
 <20190825055429.18547-8-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190825055429.18547-8-gregkh@linuxfoundation.org>
Organization: Animal Creek Technologies, Inc.
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 25, 2019 at 07:54:27AM +0200, Greg Kroah-Hartman wrote:
> With the goal of moving the core of the greybus code out of staging, the
> include files need to be moved to include/linux/greybus.h and
> include/linux/greybus/
> 
> Cc: Vaibhav Hiremath <hvaibhav.linux@gmail.com>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Alex Elder <elder@kernel.org>
> Cc: Vaibhav Agarwal <vaibhav.sr@gmail.com>
> Cc: Mark Greer <mgreer@animalcreek.com>
> Cc: Viresh Kumar <vireshk@kernel.org>
> Cc: Rui Miguel Silva <rmfrfs@gmail.com>
> Cc: David Lin <dtwlin@gmail.com>
> Cc: "Bryan O'Donoghue" <pure.logic@nexus-software.ie>
> Cc: greybus-dev@lists.linaro.org
> Cc: devel@driverdev.osuosl.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---

Acked-by: Mark Greer <mgreer@animalcreek.com>
