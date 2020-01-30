Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89A7C14D8DC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 11:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgA3KXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 05:23:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:54502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbgA3KXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 05:23:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68EAD206D5;
        Thu, 30 Jan 2020 10:23:02 +0000 (UTC)
Date:   Thu, 30 Jan 2020 11:23:00 +0100
From:   Greg KH <greg@kroah.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH] USB: serial: relax unthrottle memory barrier
Message-ID: <20200130102300.GA927405@kroah.com>
References: <20200130100658.683-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130100658.683-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 11:06:58AM +0100, Johan Hovold wrote:
> Commit a8d78d9f3856 ("USB: serial: clean up throttle handling")
> converted the throttle handling to use atomic bitops. This means that we
> can relax the smp_mb() in unthrottle() to smp_mb__after_atomic(), which
> for example is a no-op on architectures like x86 that provide fully
> ordered atomics.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
