Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B00383122D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 18:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbfEaQVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 12:21:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbfEaQVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 12:21:12 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A8DA26BE0;
        Fri, 31 May 2019 16:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559319672;
        bh=EaLL25OmeV1g1vArLXJvZ/uhaYD9wKtPGoLI7ehD9E0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XqshSsVGx8xGEpX24MUxub0WcNLt3d7H7KOJxVlEQtq6DBEWGS9+Fcv/vCLF41As/
         LXBakWa/16KjUXkoFYcnmkXr8BuDkrD1fop0ZCHCKVOVe//gWiLX26HVJQ0WxzFxKv
         FDDPWsldjGRkBJq1+7YLde4YJm4NQ07H0IBwSNyE=
Date:   Fri, 31 May 2019 09:21:11 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull v2] habanalabs fixes for 5.2-rc2/3
Message-ID: <20190531162111.GB15130@kroah.com>
References: <20190524194930.GA13219@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524194930.GA13219@ogabbay-VM>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 10:49:30PM +0300, Oded Gabbay wrote:
> Hi Greg,
> 
> This is the pull request containing fixes for 5.2-rc2/3. It is now
> correctly rebased on your char-misc-linux branch.
> 
> It supersedes the pull request from 12/5, so you can discard that pull
> request, as I see you didn't merge it anyway.
> 
> It contains 3 fixes and 1 change to a new IOCTL that was introduced to
> kernel 5.2 in the previous pull requests.

Pulled and pushed out, thanks.

greg k-h
