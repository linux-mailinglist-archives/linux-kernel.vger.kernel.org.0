Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48F96131E5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 18:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfECQNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 12:13:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbfECQNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 12:13:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3DDF20651;
        Fri,  3 May 2019 16:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556899994;
        bh=QrJ7cGk1ysDWSuHBM2EA0R/QM4wwfsHpv6X1Z/d/icQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mS4bm4GVsB8z1FbcgCkqbmXeOUkvxGvgq6QTBM8tHBetBOXXjT+X9GgF34xjH+C4b
         QMC7ngTEoI5XphZrGOKJBD4gOJzYY6wUi3U82ENo1fgyCaD1YKIRnf38lP6zxx3GEk
         QN88m32e8z7WoVl+NrEPr8+GVlpl1vTD9a2iP2g0=
Date:   Fri, 3 May 2019 18:13:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 20/22] intel_th: msu: Add a sysfs attribute showing
 possible modes
Message-ID: <20190503161311.GA9312@kroah.com>
References: <20190503084455.23436-1-alexander.shishkin@linux.intel.com>
 <20190503084455.23436-21-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503084455.23436-21-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 11:44:53AM +0300, Alexander Shishkin wrote:
> With the addition of dynamically loadable buffer drivers, there needs
> to be a way of knowing the currently available ones without having to
> scan the list of loaded modules or trial and error.
> 
> Add a sysfs file that lists all the currently available "modes", listing
> both the MSC hardware operating modes and loaded buffer drivers.

sysfs files are to be only "one value per file".  This violates that
rule by a lot.

> +static ssize_t
> +modes_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct msu_buffer *mbuf;
> +	ssize_t ret = 0;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(msc_mode); i++)
> +		ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s\n",
> +				 msc_mode[i]);

If you ever have to have a loop in a sysfs show function, you know you
are in trouble.  And here you have two of them.  Please do not do this.

thanks,

greg k-h
