Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E29AFC3A72
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 18:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732835AbfJAQ1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 12:27:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726971AbfJAQ1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:27:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 023D120679;
        Tue,  1 Oct 2019 16:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569947233;
        bh=S16vIqGBsU7UMmMX2dbzcwOC4YMTdDCTctJpEhsGpxo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aggB0WjoiizzEjPBqSKoPUdTtKPsBilJaY2qDULia5dRlw/JyI+8oeYYB8QY+j1TP
         Yf5o2nisxp1fcjGslufNvpIfIzPg8zQ/ByAR/VL0FgUHVABC8ehwZ41xcbYAtNza1O
         Cn52fXqXCeq8Gk9hTZ9rO65lg4fSO9cvZDJrTRJE=
Date:   Tue, 1 Oct 2019 18:27:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mat King <mathewk@google.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        rafael@kernel.org, Ross Zwisler <zwisler@google.com>,
        Rajat Jain <rajatja@google.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: Re: New sysfs interface for privacy screens
Message-ID: <20191001162710.GB3526634@kroah.com>
References: <CAL_quvRknSSVvXN3q_Se0hrziw2oTNS3ENNoeHYhvciCRq9Yww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_quvRknSSVvXN3q_Se0hrziw2oTNS3ENNoeHYhvciCRq9Yww@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 10:09:46AM -0600, Mat King wrote:
> Resending in plain text mode
> 
> I have been looking into adding Linux support for electronic privacy
> screens which is a feature on some new laptops which is built into the
> display and allows users to turn it on instead of needing to use a
> physical privacy filter. In discussions with my colleagues the idea of
> using either /sys/class/backlight or /sys/class/leds but this new
> feature does not seem to quite fit into either of those classes.
> 
> I am proposing adding a class called "privacy_screen" to interface
> with these devices. The initial API would be simple just a single
> property called "privacy_state" which when set to 1 would mean that
> privacy is enabled and 0 when privacy is disabled.
> 
> Current known use cases will use ACPI _DSM in order to interface with
> the privacy screens, but this class would allow device driver authors
> to use other interfaces as well.
> 
> Example:
> 
> # get privacy screen state
> cat /sys/class/privacy_screen/cros_privacy/privacy_state # 1: privacy
> enabled 0: privacy disabled
> 
> # set privacy enabled
> echo 1 > /sys/class/privacy_screen/cros_privacy/privacy_state

What is "cros_privacy" here?

>  Does this approach seem to be reasonable?

Seems sane to me, do you have any code that implements this so we can
see it?

thanks,

greg k-h
