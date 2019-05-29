Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4916E2E603
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 22:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfE2UZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 16:25:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:48270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfE2UZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 16:25:58 -0400
Received: from localhost (unknown [207.225.69.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFFAB2414F;
        Wed, 29 May 2019 20:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559161557;
        bh=vT1x3YJLmXO5Jj7uD1a9dJ/SMNM2QZG0wLSPMjlR9mw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XLfGpxZsm9I0AwKE4GeDbzz2ESSBHRxuy06Fak0Il6k/f/uCqPH7u6wUgk5lXddnn
         brZvZS4HLbfvK/9iaDyPmAw4O8ZfIDGfiPFWe8HPDklztE+gyHPL24wOeSDIEcepEn
         3YnGWavkFzvYjZL/P8dkhVjG8H25211XYMaJplUU=
Date:   Wed, 29 May 2019 13:25:57 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     valentina.manea.m@gmail.com, shuah@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usbip: usbip_host: fix stub_dev lock context imbalance
 regression
Message-ID: <20190529202557.GA27140@kroah.com>
References: <20190529194615.18765-1-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190529194615.18765-1-skhan@linuxfoundation.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 01:46:15PM -0600, Shuah Khan wrote:
> Fix the following sparse context imbalance regression introduced in
> a patch that fixed sleeping function called from invalid context bug.
> 
> kbuild test robot reported on:
> 
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git  usb-linus
> 
> Regressions in current branch:
> 
> drivers/usb/usbip/stub_dev.c:399:9: sparse: sparse: context imbalance in 'stub_probe' - different lock contexts for basic block
> drivers/usb/usbip/stub_dev.c:418:13: sparse: sparse: context imbalance in 'stub_disconnect' - different lock contexts for basic block
> drivers/usb/usbip/stub_dev.c:464:1-10: second lock on line 476
> 
> Error ids grouped by kconfigs:
> 
> recent_errors
> ├── i386-allmodconfig
> │   └── drivers-usb-usbip-stub_dev.c:second-lock-on-line
> ├── x86_64-allmodconfig
> │   ├── drivers-usb-usbip-stub_dev.c:sparse:sparse:context-imbalance-in-stub_disconnect-different-lock-contexts-for-basic-block
> │   └── drivers-usb-usbip-stub_dev.c:sparse:sparse:context-imbalance-in-stub_probe-different-lock-contexts-for-basic-block
> └── x86_64-allyesconfig
>     └── drivers-usb-usbip-stub_dev.c:second-lock-on-line
> 
> This is a real problem in an error leg where spin_lock() is called on an
> already held lock.
> 
> Fix the imbalance in stub_probe() and stub_disconnect().
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

I'll go add:

Fixes: 0c9e8b3cad65 ("usbip: usbip_host: fix BUG: sleeping function called from invalid context")
Cc: stable <stable@vger.kernel.org>

as the patch this fixes was tagged for stable.

thanks,

greg k-h
