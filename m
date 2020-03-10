Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9A617F0C5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 07:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgCJGwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 02:52:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbgCJGwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 02:52:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 217EA24673;
        Tue, 10 Mar 2020 06:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583823128;
        bh=Oz3P5ayW5l9oGHl/hWJeil6IyaDGi7XQ8iU+vqSxfec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QGpOT9Y9V7egRs3bW8RQvwHK9bxrH+TJr/yXLHbzLRtQxJ9AFoq1zkzqGOrJJ6/PY
         Fccl9NRAqz01Q5o3lfpQHXuc3PkD1+cSWdSlapwG02U5gf1LBOztTep4y0Q/DYR2QW
         G6FfMOI3e0VNbSh4hysi1lzdcp32KirkOHavwxuI=
Date:   Tue, 10 Mar 2020 07:52:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] devices.txt: document minor for rfkill
Message-ID: <20200310065206.GA1967668@kroah.com>
References: <20200309223332.GB1634@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309223332.GB1634@duo.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 11:33:32PM +0100, Pavel Machek wrote:
> Rfkill is using	minor 242, document that.
> 
> Signed-off-by: Pavel Machek <pavel@denx.de>
> Fixes: 8670b2b8b029a6650d133486be9d2ace146fd29a

Please use the proper format as described in
Documentation/process/submitting-patches.rst for the Fixes: tag.

Can you do that and resend?

thanks,

greg k-h
