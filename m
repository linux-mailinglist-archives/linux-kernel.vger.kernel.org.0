Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAD3D12D3E5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Dec 2019 20:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfL3T37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Dec 2019 14:29:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:44184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727278AbfL3T37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 14:29:59 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05EBE20409;
        Mon, 30 Dec 2019 19:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577734198;
        bh=5dlefSjQ2BhDUs2WjGN6GSpDNfst/OjKz4LVEKPVBFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l1Ftye7rz611qmPHAzj0RXUOXjS4FoL5FuMZpZqKBP5IXjJZpuRPc2P0MIK0A8V44
         B3giMNBJURVVOFi1pAxlu33QFH0gNKyY1IM+fP1HW7Zmjb1b83yfo5PN0FGwAA5XaN
         /WGz+SBqDpsiitH2UxSf7VC3RxH+1hq1TPeOCPpA=
Date:   Mon, 30 Dec 2019 20:29:56 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: host: Enable compile testing for some of drivers
Message-ID: <20191230192956.GA1844196@kroah.com>
References: <20191230172215.17370-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230172215.17370-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 06:22:14PM +0100, Krzysztof Kozlowski wrote:
> Some of the USB host drivers can be compile tested to increase build
> coverage.  Add 'if' conditional to 'default y' so they will not get
> enabled by default on all other architectures.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/usb/host/Kconfig | 54 ++++++++++++++++++++--------------------
>  1 file changed, 27 insertions(+), 27 deletions(-)

Nice, thanks for these, they should help out a lot with development.

greg k-h
