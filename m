Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66AEC4CCEF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 13:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731713AbfFTLbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 07:31:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbfFTLbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 07:31:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D2AD2085A;
        Thu, 20 Jun 2019 11:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561030298;
        bh=T9zyIGBTWEG9JgKSSKBceq6/1rh4Aqo73q8y+fqDCCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZOGfA2UVQ1Rxrk7fp022CkYJPGhijzIBS43s1iPYliZ/zO7L1qNlaKnF+pRC9SMtH
         fO4y9zRTrzvOr7GbAUaQvF0v9PCxFZeMtQjnObrhVpTag3/4y0WBSjiXtgERRpA/Mq
         nMmdM5bOPWfZhOyQY2UtBLBpKMPkYERWkjlLMKnQ=
Date:   Thu, 20 Jun 2019 13:31:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs fixes for 5.2-rc6
Message-ID: <20190620113136.GB2275@kroah.com>
References: <20190620092213.GA16781@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620092213.GA16781@ogabbay-VM>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 12:22:13PM +0300, Oded Gabbay wrote:
> Hi Greg,
> 
> This is a pull request containing fixes to be merged to 5.2-rc6.
> 
> It contains a single minor bug fix. See the tag comment for more details.
> 
> Thanks,
> Oded
> 
> The following changes since commit 6ad805b82dc5fc0ffd2de1d1f0de47214a050278:
> 
>   doc: fix documentation about UIO_MEM_LOGICAL using (2019-06-19 19:31:21 +0200)
> 
> are available in the Git repository at:
> 
>   git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-fixes-2019-06-20

Pulled and pushed out,t hanks.

greg k-h
