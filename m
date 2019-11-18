Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 541BF1000E6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 10:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfKRJCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 04:02:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:48232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbfKRJCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 04:02:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F077920727;
        Mon, 18 Nov 2019 09:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574067753;
        bh=TKMuZyK//t+R6v6Kt7HRzwqOZ5rOSn1PZJ7DDmWkSnY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qh7DaaFfJTgikuq6n4WyPPdua8jTvdDP3TgiFxlT2IxPRX7kfIc9Pzxj/j6Lul+av
         udn0d4GQK5dHQ4+W3VsLsPAsJcHArqG/mVCDUgcrQ3ljVVaArJktmwuOkygVPWhra1
         VTC9MjlmQzmtpF5Ut3Jil0+KLWTltI38cs3qdmik=
Date:   Mon, 18 Nov 2019 10:02:30 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     patrick.rudolph@9elements.com
Cc:     linux-kernel@vger.kernel.org, coreboot@coreboot.org,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arthur Heymans <arthur@aheymans.xyz>
Subject: Re: [PATCH v2 0/3] firmware: google: Fix minor bugs
Message-ID: <20191118090230.GB150384@kroah.com>
References: <20191118083241.18894-1-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118083241.18894-1-patrick.rudolph@9elements.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 09:32:35AM +0100, patrick.rudolph@9elements.com wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> This patch series fixes 3 independent bugs in the google firmware
> drivers.
> 
> Patch 1-2 do proper cleanup at kernel module unloading.
> 
> Patch 3 adds a check if the optional GSMI SMM handler is actually
> present in the firmware and responses to the driver.
> 
> Changes in v2:
>  - Add missing return statement
>  - Add s-o-b on GSMI patches
>  - Add define for reserved GSMI command

Oh wait, is this connected to the other 3 patches you sent?  What
happened to the email threading?

that's odd...

greg k-h
