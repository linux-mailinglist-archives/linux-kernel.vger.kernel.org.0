Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5DB25216D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 05:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfFYDyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 23:54:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbfFYDyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 23:54:01 -0400
Received: from localhost (unknown [116.226.249.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46DAB20881;
        Tue, 25 Jun 2019 03:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561434840;
        bh=XFOziIOM9oCu/OsWx9RnmlS+cF5ZLW17HEIlZAqOimY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZX3zvzlmNRbixI1+LVRfKTQyDeWhML4ya2bKjMyZ4vz3QOLIT8+uvcED6v14tRaER
         4haun38H99VjEAFN/GUrWwuiXWjy+Dba35v3ZpruSScBfefS76bGrsNUM4/VcV//0z
         8VIIVE0LCzZmJ5UtM4SeHg5DJQQFCthwS/cUGpDc=
Date:   Tue, 25 Jun 2019 11:53:13 +0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sandeep Patil <sspatil@android.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        David Collins <collinsd@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [RESEND PATCH v1 0/5] Solve postboot supplier cleanup and
 optimize probe ordering
Message-ID: <20190625035313.GA13239@kroah.com>
References: <20190604003218.241354-1-saravanak@google.com>
 <20190624223707.GH203031@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624223707.GH203031@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 03:37:07PM -0700, Sandeep Patil wrote:
> We are trying to make sure that all (most) drivers in an Aarch64 system can
> be kernel modules for Android, like any other desktop system for
> example. There are a number of problems we need to fix before that happens
> ofcourse.

I will argue that this is NOT an android-specific issue.  If the goal of
creating an arm64 kernel that will "just work" for a wide range of
hardware configurations without rebuilding is going to happen, we need
to solve this problem with DT.  This goal was one of the original wishes
of the arm64 development effort, let's not loose sight of it as
obviously, this is not working properly just yet.

It just seems that Android is the first one to actually try and
implement that goal :)

thanks,

greg k-h
