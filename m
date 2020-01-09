Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC711355E4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 10:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbgAIJgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 04:36:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:46908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729623AbgAIJgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:36:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2EE4206ED;
        Thu,  9 Jan 2020 09:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578562591;
        bh=O0IOzD1Q90sz8rkxIw9Fl94JHAA27BGjXGmO0j99Dns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HgajU4MvE0XmWHUnefuxk9KEPByk1x4ar0+PO06NMPd0H8XDHaa3Z0NrD7ia+rAO2
         T0Mt5S9dDpSA7X7qimIyFzYwmqWjCJCRawJRjVZJmB41JSOrIuM4A+gTD9Ckzacljb
         47IksBYYKPpLfi0X6RwPv0gNf6h0QDL8eK3bhDdg=
Date:   Thu, 9 Jan 2020 10:36:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Kim, David" <david.kim@ncipher.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Magee, Tim" <tim.magee@ncipher.com>
Subject: Re: [PATCH v2] drivers: misc: Add support for nCipher HSM devices
Message-ID: <20200109093629.GB44349@kroah.com>
References: <20191220154738.31448-1-david.kim@ncipher.com>
 <20191220213036.GA27120@kroah.com>
 <46e2f36d770c462db487d0e918ad2b0b@exukdagfar01.INTERNAL.ROOT.TES>
 <20200107092827.GB1021817@kroah.com>
 <1578561832423.48959@ncipher.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1578561832423.48959@ncipher.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 09:23:52AM +0000, Kim, David wrote:
> > > A cryptographic accelerator uses key material which is stored on, and managed
> > > by, the host machine. Hardware security modules, such as nCipher’s Solo
> > > products, retain key material (i.e. secrets) within the secure boundary of the
> > > device, and implement various forms of access control to restrict use of that
> > > key material.
> > > 
> > > nCipher's product range started, in the early 1990s, as cryptographic
> > > accelerators.  The series of hardware security modules served by this driver
> > > still does do cryptography but their main function is the generation, management
> > > and use of keys within a secure boundary.
> > > 
> > > The driver doesn't do any cryptography. It provides the link between the
> > > userspace software and the HSM's firmware. Cryptography is done within the HSM's
> > > secure boundary.
> > 
> > So this should tie into the correct crypto/key apis that the kernel has
> > and not create a brand new user/kernel api, right?
> > 
> > Please work with the crypto kernel developers to get this right, I can't
> > take this until they agree that this code and api is correct.
> 
> 
> Although it is technically possible for us to use the linux crypto APIs, that
> doesn't fit in with how our hardware is meant to be used. Please see the
> explanation below from Ian, one of our architects. If you feel that our driver
> should instead be targeted to drivers/crypto, I can resubmit our patch to the
> crypto list and we'll discuss with the crypto maintainers.

As I said, please submit and get approval from the crypto
developers/maintainers first.  I need that before I can accept a
brand-new api for a one-off device that then needs to be supported for
40+ years.

thanks,

greg k-h
