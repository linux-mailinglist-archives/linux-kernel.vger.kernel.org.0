Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDE7411F191
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2019 12:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfLNLab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Dec 2019 06:30:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:37878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbfLNLab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 06:30:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 348B824658;
        Sat, 14 Dec 2019 11:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576323030;
        bh=q2y9N8Cnn6tskS5OaENXs7tkDRQzZWS2X2Kmhua+vJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FKpWxHYvHh+BKnP9iz6bsgAju+FfD5lW+lt5ktNdUqad8DD6mxt1HkYDALdJv+513
         KWfMp9JluJiatu9llQL1ZLL02PMw3xAt0QPLMPUYI3wsYrb/zoe4y6YVAen21TUJWY
         80Fl3K9R8xtMyr6zSKLBPUectiSHaGFojei7KMbU=
Date:   Sat, 14 Dec 2019 12:30:27 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Bin Liu <b-liu@ti.com>, od@zcrc.me, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/7] usb: musb: jz4740: Code cleanup
Message-ID: <20191214113027.GB3335535@kroah.com>
References: <20191210171110.62141-1-paul@crapouillou.net>
 <20191210171110.62141-6-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210171110.62141-6-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 06:11:09PM +0100, Paul Cercueil wrote:
> Just some code maintenance; no functional change.
> 

Be very specific as to what you are doing here, and why.  "code
maintenance" is very vague and not descriptive at all.

thanks,

greg k-h
