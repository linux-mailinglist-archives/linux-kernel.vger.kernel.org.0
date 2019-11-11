Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E37DDF77BC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 16:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfKKPeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 10:34:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:60258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbfKKPeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 10:34:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 048FE214E0;
        Mon, 11 Nov 2019 15:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573486458;
        bh=8rH4p3fJ8H3Pd7FYS0/8Mgb/fDjsoOFr9jRaMm0oFO4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DQhc2JgKgYMPpASZNLzYd/fmY0aGcXB5/c5HwAWSnX3Cn453zL+IKZ10voO4o6ATG
         VgoMS3aRsp1fy87JaEHVhvLYlaHMXT1Cu3zzU4UZXel6526SU05Wb0r8XZQeqytkQY
         TYPPffEHhxHOPqPcrDMJEXZiqkJDo0B1RZ4Yh49A=
Date:   Mon, 11 Nov 2019 16:34:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] staging: wfx: wrap characters
Message-ID: <20191111153414.GA798254@kroah.com>
References: <20191111133055.214410-1-jbi.octave@gmail.com>
 <20191111133055.214410-2-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111133055.214410-2-jbi.octave@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 01:30:54PM +0000, Jules Irenge wrote:
> Wrap characters to fix line of over 80 characters.
> Issue detected by Checkpatch tool

You did other things in here as well:

>  {
> -	struct ieee80211_hdr *frame = (struct ieee80211_hdr *) skb->data;
> +	struct ieee80211_hdr *frame = (struct ieee80211_hdr *)skb->data;

Please only do "one type of change per patch".

thanks,

greg k-h
