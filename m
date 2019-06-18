Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1147949DB9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 11:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbfFRJrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 05:47:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729203AbfFRJrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 05:47:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDB5A2070B;
        Tue, 18 Jun 2019 09:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560851221;
        bh=OTP9ShBQv4u3snFEba4lNlyAC4fuMaiv7D9tzssJMEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CC5Fs34+fOiPFbFFf7LGYWwmIgTQVn10KmGySNPRKaSIQEyFjVNRjK+69+o0nqao1
         xSPS+Wyw5v8giK02d6cr+v0cgYF6AVN2ulVuETenrAmMNFua9Qu0BFUbcKxssruzGQ
         oLtGFhx9q8Uar/fvGh9Dk7PItOsRtPNbrgDxm3Fo=
Date:   Tue, 18 Jun 2019 11:46:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Varadarajan, Kiruthika" <Kiruthika.Varadarajan@harman.com>
Cc:     Felipe Balbi <balbi@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kiruthikanv@gmail.com" <kiruthikanv@gmail.com>
Subject: Re: [EXTERNAL] Re: Kernel patch  in USB 4.4.138 Version
Message-ID: <20190618094658.GA10451@kroah.com>
References: <6e521b173bd24197930c764dc5fe9ad1@HICGWSMB01.ad.harman.com>
 <20190607135853.GB14665@kroah.com>
 <61ab2bb8e87e4c6a967722a4ae757a4a@HICGWSMB01.ad.harman.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61ab2bb8e87e4c6a967722a4ae757a4a@HICGWSMB01.ad.harman.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 08:43:56AM +0000, Varadarajan, Kiruthika wrote:
> Hi Greg,
>  Please ignore my previous email and here is the patch on top of 4.4.x stable version.
>  Could you please review the attached patch.

The 4.4.y kernel tree was released a few years ago, you have to create a
patch against the latest release, and ideally, the linux-next tree.
Please do that and follow the directions in
Documentation/SubmittingPatches and we will be glad to review it.

thanks,

greg k-h
