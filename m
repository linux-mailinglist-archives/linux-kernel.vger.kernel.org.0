Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49AC3197FB5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 17:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbgC3Ped (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 11:34:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:48488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729296AbgC3Pec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 11:34:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0745B20780;
        Mon, 30 Mar 2020 15:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585582472;
        bh=nT9E0EIzMVAN0cQacmLsqIEENgu2oOgTG3sdhXwWc7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CFqN0lovfebTDaI6FpGHzh8WR108etKaM5Vp3J9TokvlFW/RBUPVuwqyr6YJ3MoQk
         ShpF6tPSljJmsD1HmdQzwRGMyWTvopbbvys6HoqJbsiczRaD7JzLTD6D+CdF1jQBfi
         J+bn3Nd8/8nFibtPhFc7d7YE87GEGFkJDa3Xl4qo=
Date:   Mon, 30 Mar 2020 17:34:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, groeck@chromium.org,
        bleung@chromium.org, dtor@chromium.org, gwendal@chromium.org,
        Collabora Kernel ML <kernel@collabora.com>,
        vbendeb@chromium.org, andy@infradead.org,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jeremy Soller <jeremy@system76.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mattias Jacobsson <2pi@mok.nu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3] platform: x86: Add ACPI driver for ChromeOS
Message-ID: <20200330153430.GA750889@kroah.com>
References: <20200330150617.1132570-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330150617.1132570-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 05:06:17PM +0200, Enric Balletbo i Serra wrote:
> This driver attaches to the ChromeOS ACPI device and then exports the values
> reported by the ACPI in a sysfs directory. These values are not exported
> via the standard ACPI tables, hence a specific driver is needed to do
> it. The ACPI values are presented in the string form (numbers as decimal
> values) or binary blobs, and can be accessed as the contents of the
> appropriate read only files in the standard ACPI devices sysfs directory tree.

Any reason why you didn't send this to the ACPI maintainers and
developer mailing list?

They would be the best ones to review this...

thanks,

greg k-h
