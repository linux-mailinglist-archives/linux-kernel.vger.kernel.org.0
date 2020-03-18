Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CED2C189A85
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 12:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbgCRLUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 07:20:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:52506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726733AbgCRLUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 07:20:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34B362076C;
        Wed, 18 Mar 2020 11:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584530450;
        bh=uq8u0Aa6WFSUjOG4Ft9NPUaLrB7xenkdbE4wIC6cEmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WdqBofIhEe6boNDAlms4c/pRL3tD7jpW1XIQF5YGIcIwr3G44WuNkMBEh2QbxYt8o
         VtU7aLNseK7L2sxjmTNQhVB3WVJyKjAq7cAloCFPHeGKjqZTcQI95v8JQw4OKmFx69
         QGgSOaXgLYraZuuQW6Nn8g7IJ1fH/gSI+NFVMHwM=
Date:   Wed, 18 Mar 2020 12:20:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Richard Gong <richard.gong@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, mdf@kernel.org, dinguyen@kernel.org,
        Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCH 0/2] Patches for firmware
Message-ID: <20200318112047.GA2308768@kroah.com>
References: <1583428346-13307-1-git-send-email-richard.gong@linux.intel.com>
 <7c63fe9d-d8fb-b3ea-7ec8-2bb136cc512b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c63fe9d-d8fb-b3ea-7ec8-2bb136cc512b@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 11:10:08AM -0500, Richard Gong wrote:
> Hi Greg,
> 
> Sorry for asking.
> 
> When you get chance, please help to take these 2 firmware patches.

Sorry for the delay, lots of patches to review, will get to this soon...

greg k-h
