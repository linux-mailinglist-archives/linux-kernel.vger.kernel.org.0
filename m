Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADB36167955
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 10:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbgBUJZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 04:25:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:39110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbgBUJZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 04:25:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26B5120722;
        Fri, 21 Feb 2020 09:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582277142;
        bh=3OdwtR+kNO4djZW2+oyAKDoEMYvTKrgiyYMXvaf9vDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xZzl7uv6QnP2tWpNeRwsIcxrU6CkkJWUOY6Tz6qPcgDthCeLoENBn4hZ4okqakAVO
         ps7hKcvPVDfX3cF5YHpXwVJHGiPiwfEees9nUaIy2HWHY6xTggiRjACU0Zcf+neoP6
         Fo5v2YdTboR/aA7j7KF5p9OFdL6DznoAnS38/b1Q=
Date:   Fri, 21 Feb 2020 10:25:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] driver core: Call sync_state() even if supplier
 has no consumers
Message-ID: <20200221092540.GA71325@kroah.com>
References: <20200221080510.197337-1-saravanak@google.com>
 <20200221080510.197337-2-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221080510.197337-2-saravanak@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 12:05:08AM -0800, Saravana Kannan wrote:
> The initial patch that added sync_state() support didn't handle the case
> where a supplier has no consumers. This was because when a device is
> successfully bound with a driver, only its suppliers were checked to see
> if they are eligible to get a sync_state(). This is not sufficient for
> devices that have no consumers but still need to do device state clean
> up. So fix this.
> 
> Fixes: fc5a251d0fd7ca90 (driver core: Add sync_state driver/bus callback)

Should be:
Fixes: fc5a251d0fd7 ("driver core: Add sync_state driver/bus callback")

> Signed-off-by: Saravana Kannan <saravanak@google.com>

So this needs to go to 5.5 also, right?

thanks,

greg k-h
