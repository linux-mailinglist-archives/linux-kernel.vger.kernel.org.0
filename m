Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45DFB126757
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 17:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfLSQno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 11:43:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:48844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbfLSQnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 11:43:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B21FD227BF;
        Thu, 19 Dec 2019 16:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576773823;
        bh=pcJ4a6QvxXMKk4Na2Uivr/fvL4Gj3iHEUcovlk9Ojxo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EYWkOokTPIzUhevzN6FaJ0QrViq1XnC7SQHq8pUg0CUMg2AmWTnHfAPIPcGRWjAVp
         uQ+AEhljFKWwdq00bQ/+SjmdJ8O2Wp5oC00CGrNkgECXolI3GNA6USOKF0jA1UmRNO
         nvhsGDUD3JSiLnxp2Z0HKhhN+ukpz9sPXAJFBIvQ=
Date:   Thu, 19 Dec 2019 17:43:40 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "jslaby@suse.com" <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH 2/3] tty: serial: lpuart: support UPIO_MEM32 for lpuart32
Message-ID: <20191219164340.GA2032929@kroah.com>
References: <1576637626-19317-1-git-send-email-peng.fan@nxp.com>
 <1576637626-19317-4-git-send-email-peng.fan@nxp.com>
 <AM0PR04MB4481D6C5CD27F410359F53A788530@AM0PR04MB4481.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB4481D6C5CD27F410359F53A788530@AM0PR04MB4481.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 12:26:09PM +0000, Peng Fan wrote:
> Hi Greg,
> 
> > Subject: [PATCH 2/3] tty: serial: lpuart: support UPIO_MEM32 for lpuart32
> 
> This patch was sent out wrongly. Not affect the other three patches which
> belongs the whole patch set described in cover-letter.
> 
> Should I sent out v2? Or you are fine if the other 3 patches are ok?

Please send out a whole new v2 series.

thanks,

greg k-h
