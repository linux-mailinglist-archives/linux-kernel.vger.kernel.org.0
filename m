Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC453EE1CC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 15:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbfKDODY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 09:03:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:37858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727782AbfKDODY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 09:03:24 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 617BA21D7F;
        Mon,  4 Nov 2019 14:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572876204;
        bh=wUE2UsX2jExZ4U8jqym3HZmW23JM6x8jZjt2SfrkeXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MxjNEJkd+9d7eWXpHsr6y1cvg71MC5AXxPXNJsv92n4tCiOi9AauB469GKmTyU9Ak
         k0A0LCFwQPO0dVAUPmtuBKEtpVRPH9ZBcDUT3BRGHX6duZKLbElPM10zuJNUF5SNGC
         dTsTcWIBySuN//Lo0iaaIKPRzNu6x7mtz3OjrXMg=
Date:   Mon, 4 Nov 2019 15:02:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 0/7] intel_th: Fixes for v5.4
Message-ID: <20191104140242.GA2178801@kroah.com>
References: <20191028070651.9770-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028070651.9770-1-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 09:06:44AM +0200, Alexander Shishkin wrote:
> Hi Greg,
> 
> These are the fixes I have for the v5.4 cycle. They are 4 fixes for the
> buffer management code that went in in the v5.4-rc1 and 2 new PCI IDs.
> The IDs are CC'd to stable. All checked with static checkers and Andy
> Shevchenko, who was kind enough to look them over. Signed tag at the URL
> below. Individual patches follow. Please consider pulling or applying.
> Thanks!

Applied them by hand due to the fixes needed for the first two.

thanks,

greg k-h
