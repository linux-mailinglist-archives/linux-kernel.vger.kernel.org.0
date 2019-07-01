Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7555948E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 09:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfF1HFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 03:05:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbfF1HFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 03:05:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75CCA204EC;
        Fri, 28 Jun 2019 07:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561705511;
        bh=5fkzHE/or/BO94Lut0W45FpjZpard5Gpc23HG0C1h6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NN+rYYnlxvQr/pH2B8u53CEDmV68MlIT++3BNUr+YE7CvnRFQXtFrYK/xl82nlId+
         c7rUEEImQUxLdARAmWxSCm1/gAbE2JuybZtf00IDL7ben/NUWXKpePorOD8cX8d4bc
         1LvWrApkYFMWxcKH3hMMxk3aydWQaP/lnukwt6lI=
Date:   Fri, 28 Jun 2019 09:05:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Harsh Jain <harshjain32@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        harshjain.prof@gmail.com
Subject: Re: [PATCH] staging:kpc2000:Fix sparse warnings
Message-ID: <20190628070507.GA10932@kroah.com>
References: <20190627185138.26214-1-harshjain32@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627185138.26214-1-harshjain32@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 12:21:38AM +0530, Harsh Jain wrote:
> From: root <harshjain32@gmail.com>

Interesting user name :)

> Fix following sparse warning
> symbol was not declared. Should it be static?
> Using plain integer as NULL pointer

Don't do multiple things in the same patch.  Please break thsi up into
two different patches and fix up your email address.

Also never do kernel development as root on your system, it's easy to
break things...

thanks,

greg k-h
