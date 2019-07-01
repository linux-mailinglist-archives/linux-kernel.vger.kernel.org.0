Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4B52D24F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 01:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfE1XP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 19:15:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:57522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbfE1XP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 19:15:58 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 858F720989;
        Tue, 28 May 2019 23:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559085357;
        bh=/c4ol7KgiJXfMCOGnsBf9AXiqdwtZ1LxO0jkVUQ/WmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vb8z0WIXDH1wtTC+kZSdaVf9u2rL+abnYjQyiGh6DAKzlG+i5w0SFikCrDS2sYSlV
         UgQh7hYaM7lqZ7SBoLKgTWRfQ/SI5q8WzR1heucddOzOVzxfgfB3+2J8RwIOE8ZZvH
         ZO7dMa3E3VoOtjYvuJnCrCbaVxmw8iSqAg5xlUqI=
Date:   Tue, 28 May 2019 16:15:57 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     richard.gong@linux.intel.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, dinguyen@kernel.org,
        atull@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sen.li@intel.com,
        Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCHv4 2/4] firmware: add Intel Stratix10 remote system update
 driver
Message-ID: <20190528231557.GA28886@kroah.com>
References: <1559074833-1325-1-git-send-email-richard.gong@linux.intel.com>
 <1559074833-1325-3-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559074833-1325-3-git-send-email-richard.gong@linux.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 03:20:31PM -0500, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> The Intel Remote System Update (RSU) driver exposes interfaces access
> through the Intel Service Layer to user space via sysfs interface.
> The RSU interfaces report and control some of the optional RSU features
> on Intel Stratix 10 SoC.
> 
> The RSU feature provides a way for customers to update the boot
> configuration of a Intel Stratix 10 SoC device with significantly reduced
> risk of corrupting the bitstream storage and bricking the system.
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> Reviewed-by: Alan Tull <atull@kernel.org>

Is Alan reviewing all of these new versions before you post them
publicly?  If so, great, if not, don't add tags to new versions when you
change things around...

thanks,

greg k-h
