Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5581306C5
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jan 2020 09:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgAEIRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jan 2020 03:17:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:55816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgAEIRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 03:17:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42486217F4;
        Sun,  5 Jan 2020 08:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578212244;
        bh=LqM9zIbStZx6zb0OXX8znhaKl/1ObykLsIUQMpp85M4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bmPavKNJljFGe7eXVmB1ZmJ/yHeeN6iV2xfGwO5+RdUoemXGYF1Q26rmR6iNeaa9d
         PGI6EXAEWIQ9OCYEef4cB4H+44MaFftRWsimOxJnECQiBtDV/1V3GU+NNIZkLCGQb6
         Fk0aK6JZOnJnUcdlm5QkrcctdPqS4ruA4zLB5E5o=
Date:   Sun, 5 Jan 2020 09:17:21 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     atmgnd <atmgnd@protonmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: missing parentheses in USE_NEW_SCHEME
Message-ID: <20200105081721.GC1667342@kroah.com>
References: <ht4mtag8ZP-HKEhD0KkJhcFnVlOFV8N8eNjJVRD9pDkkLUNhmEo8_cL_sl7xy9mdajdH-T8J3TFQsjvoYQT61NFjQXy469Ed_BbBw_x4S1E=@protonmail.com>
 <20200104114603.GB1288021@kroah.com>
 <HdXgMrky4rCGyM4q7eTsrfOB4yGZRUNwV9YSXBPh98r2UZeFzREQj35K60r-8Lf9LYVgVuKCcmQ2l7ihAD9DoqAdluQrA3zbQrF03VtNC-0=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HdXgMrky4rCGyM4q7eTsrfOB4yGZRUNwV9YSXBPh98r2UZeFzREQj35K60r-8Lf9LYVgVuKCcmQ2l7ihAD9DoqAdluQrA3zbQrF03VtNC-0=@protonmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 05, 2020 at 01:15:41AM +0000, atmgnd wrote:
> Is that ok ? Ordinarily I dont use protonmail, only because outlook mail is blocked by kernel email system.
> So I register this email to send plain/text emails.
> I will resend it.

Just add a "From:" line in the first line of the changelog text to match
up with your "real" email address.  The kernel and git documentation
should show this.

thanks,

greg k-h
