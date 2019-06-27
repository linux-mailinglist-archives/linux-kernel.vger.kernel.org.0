Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0E8F58976
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 20:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfF0SG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 14:06:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:42042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbfF0SG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 14:06:27 -0400
Received: from localhost (unknown [88.128.81.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D276208E3;
        Thu, 27 Jun 2019 18:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561658786;
        bh=3ity6AqO6NgzvyZi3EMjzA8TE7SWdEMp1Cbj45RUIWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wQMVG3vKug5/Wa1kPLk8S/EsbKRxWYwoWYkyzuVPJ7c8BeYSy8ZpjPLvIXqdyN41e
         x1Sjs3DXu6bYw5LLD5aNDJxqptlb8S73YLevihMLXm8AeSgu8Q6AKfOhlmza1wb1uZ
         FW0PyPOG5luPWJxshtokYMNNv/ievTMB35syAHs4=
Date:   Thu, 27 Jun 2019 20:06:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v2] staging: rtl8723bs: hal: sdio_halinit: Remove set but
 unused varilable pHalData
Message-ID: <20190627180623.GA13464@kroah.com>
References: <20190627180302.GA3186@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627180302.GA3186@hari-Inspiron-1545>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 11:33:02PM +0530, Hariprasad Kelam wrote:
> Remove set but unsed variable pHalData in below functions
> _InitOperationMode, SetHwReg8723BS.
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/staging/rtl8723bs/hal/sdio_halinit.c | 5 -----
>  1 file changed, 5 deletions(-)

What changed in v2?
