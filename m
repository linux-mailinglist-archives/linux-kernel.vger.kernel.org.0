Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0BA92D258
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 01:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfE1XTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 19:19:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:58668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfE1XTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 19:19:09 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC72220989;
        Tue, 28 May 2019 23:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559085548;
        bh=gLXwtqoR2O8l7+c0291IGuJQqUwo3SYoHdpwuxGqWTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KUTdlo6jiZAm0NmzUUqNEqbn0E4XERNR67x5QN+XjxDmnnDOI46uGTSVxlFT72D7m
         4a5jy8JN+78qGYcwkFP+uLd67Y0qSmvSNcZxbEj/UISWXQGKdzI7LmtXPTdAvAM5AS
         2Uf76WTHDfIOMx7Ox6enmyyXgF/6NgkOkhf2f3JM=
Date:   Tue, 28 May 2019 16:19:08 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     richard.gong@linux.intel.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, dinguyen@kernel.org,
        atull@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sen.li@intel.com,
        Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCHv4 3/4] firmware: rsu: document sysfs interface
Message-ID: <20190528231908.GB28886@kroah.com>
References: <1559074833-1325-1-git-send-email-richard.gong@linux.intel.com>
 <1559074833-1325-4-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559074833-1325-4-git-send-email-richard.gong@linux.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 03:20:32PM -0500, richard.gong@linux.intel.com wrote:
> +What:		/sys/devices/.../stratix10-rsu.0/driver/fail_image
> +Date:		May 2019
> +KernelVersion:	5.3
> +Contact:	Richard Gong <richard.gong@intel.com>
> +Description:
> +		(RO) the version number of RSU firmware.

"fail_image" is the version number?  That doesn't match up with what the
code says :(

What happened to the version sysfs file?

thanks,

greg k-h
