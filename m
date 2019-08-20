Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBCA595DAA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 13:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbfHTLo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 07:44:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729576AbfHTLo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 07:44:28 -0400
Received: from localhost (unknown [12.166.174.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70B12216F4;
        Tue, 20 Aug 2019 11:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566301467;
        bh=P1yW5brc0O8I54VClRZsik+Hm5OoF7VR73NufiSItxk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=coEaP44k35HzmtjHJ/kQCCkXuVWYeJKESm2zR35WUYCbByqdhXBgFgVBen+8p1d5l
         LoktXCdg8Uq4aJaPZ5WKyHhMe9BhAsILTgiSdkxuHHObryq+3mUoEetro/lBAm4flq
         55Vxg9XgdsD4HWaiGjYXdzCaYu7c2NB0Csd/UZEo=
Date:   Tue, 20 Aug 2019 04:44:26 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 3/4] intel_th: pci: Add support for another Lewisburg
 PCH
Message-ID: <20190820114426.GB15112@kroah.com>
References: <20190820101653.74738-1-alexander.shishkin@linux.intel.com>
 <20190820101653.74738-4-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820101653.74738-4-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 01:16:52PM +0300, Alexander Shishkin wrote:
> Add support for the Trace Hub in another Lewisburg PCH.
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> ---
>  drivers/hwtracing/intel_th/pci.c | 5 +++++
>  1 file changed, 5 insertions(+)

same here, ok for stable?

thanks,

greg k-h
