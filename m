Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE2F134840
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 17:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgAHQn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 11:43:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:33340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbgAHQnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:43:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF1DB20692;
        Wed,  8 Jan 2020 16:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578501805;
        bh=4R8uMMsjnzXH2laWYCGEUYCq1jjHskPjUvVPAWKtrCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AbJXCvfMQJIPjr+a4Lk15D/STmO6IfqH6AmEZMQnJaxLBgJO1yzdwlWdQLdIXE3eq
         nYTou9NVq6Nsi2s3hEKNwYhEoo8tCRoOLqa1/7mHolPEDusia3dKSxHcu5H+I+8PYC
         JWv7RtKXBpC8FGM800Na4iQUaF6FDQ3Lo5lKLmNg=
Date:   Wed, 8 Jan 2020 17:43:23 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     atmgnd <atmgnd@protonmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: missing parentheses in USE_NEW_SCHEME
Message-ID: <20200108164323.GB2494836@kroah.com>
References: <ht4mtag8ZP-HKEhD0KkJhcFnVlOFV8N8eNjJVRD9pDkkLUNhmEo8_cL_sl7xy9mdajdH-T8J3TFQsjvoYQT61NFjQXy469Ed_BbBw_x4S1E=@protonmail.com>
 <20200104114603.GB1288021@kroah.com>
 <HdXgMrky4rCGyM4q7eTsrfOB4yGZRUNwV9YSXBPh98r2UZeFzREQj35K60r-8Lf9LYVgVuKCcmQ2l7ihAD9DoqAdluQrA3zbQrF03VtNC-0=@protonmail.com>
 <20200105081721.GC1667342@kroah.com>
 <RCWksfFWQHlnigRaJXhtDAVRhJyOLVg8X0quHP9R6YiddyTUkLWt00rhYgDrmGXxTmR_1T3BFfAf-uIh1Iwhe-GTkT-0RDfbN64ePPiqNY4=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <RCWksfFWQHlnigRaJXhtDAVRhJyOLVg8X0quHP9R6YiddyTUkLWt00rhYgDrmGXxTmR_1T3BFfAf-uIh1Iwhe-GTkT-0RDfbN64ePPiqNY4=@protonmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 05, 2020 at 11:35:30AM +0000, atmgnd wrote:
> I have already resend you a new patch with 'Signed-off-by: Qi Zhou <atmgnd@protonmail.com>', Can you just use that one ? thanks.

Ugh, I have to edit it by hand, but will do so.

Please work on fixing up your email system, 'git send-email' should work
with just about any MTA out there.

greg k-h
