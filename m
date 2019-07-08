Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1909C62047
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 16:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731760AbfGHOQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 10:16:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728596AbfGHOQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 10:16:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E24821670;
        Mon,  8 Jul 2019 14:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562595409;
        bh=sleWZ930yek+6NmAYJ3H6wphPKORK+DVGdr0bMUX9QA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SlYjvlQ3DDyLrqPaKG+7BopCNv5julgpEUBDaHP2FpJcx5Od+o7LryVrCnsdNKGWg
         jIoYBjlV/qQ4ghftjEbNBFPzcQhbPCw+7WXDEbwJP4np7F/1jhBN6XhHBd0z6Q7YVV
         XdtSpn1H3vb0NsL8dyPyW8H3HUQWt7AP94Ua72WU=
Date:   Mon, 8 Jul 2019 16:16:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Subject: Re: [PATCH] habanalabs: remove write_open_cnt property
Message-ID: <20190708141646.GA24852@kroah.com>
References: <20190708141141.15300-1-oded.gabbay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708141141.15300-1-oded.gabbay@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 05:11:41PM +0300, Oded Gabbay wrote:
> This property has attempted to show the number of open file descriptors on
> the device. This was a stupid and futile attempt so remove this property
> completely.
> 
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
