Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF9EE171C2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 08:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfEHGh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 02:37:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbfEHGhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 02:37:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC3E32054F;
        Wed,  8 May 2019 06:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557297445;
        bh=T0FrpxoRHBchoQt2g4MiY1olLJ9HjffT47QH8iMBIkw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ek2LsxxVpZtrm8idGE2/+QUmm8gmMmawn3+cQfl8wpTQrSsfu8qxG31xPYY5D5Gc7
         DBFU17xMcgPEq5sdQOyOV1vDjG+rUvBO5WUozXb6tEhx84Ql4BCgLvmfCdQJ4vqkb5
         0dBIY6mB4mG4thokr9BGHrvXvq7uhzL4IVBgY24U=
Date:   Wed, 8 May 2019 08:37:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "Angus Ainslie (Purism)" <angus@akkea.ca>, angus.ainslie@puri.sm,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] usb: typec: tcpci: Clear the fault status register
Message-ID: <20190508063723.GA14085@kroah.com>
References: <20190508002749.14816-1-angus@akkea.ca>
 <20190508002749.14816-2-angus@akkea.ca>
 <5f0bec69-9579-f153-c3fd-d7b8deea75c4@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f0bec69-9579-f153-c3fd-d7b8deea75c4@roeck-us.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 05:49:14PM -0700, Guenter Roeck wrote:
> On 5/7/19 5:27 PM, Angus Ainslie (Purism) wrote:
> > If the fault status register doesn't get cleared then
> > the ptn5110 interrupt gets stuck on. As the fault register gets
> > set everytime the ptn5110 powers on the interrupt is always stuck.
> > 
> > Fixes: fault status register stuck
> 
> That is not how Fixes: tags are supposed to work. This should probably be
> 
> Fixes: 74e656d6b0551 ("staging: typec: Type-C Port Controller Interface driver (tcpci)")

Nit:
Fixes: 74e656d6b055 ("staging: typec: Type-C Port Controller Interface driver (tcpci)")

You only need 12 characters of the sha1 :)

