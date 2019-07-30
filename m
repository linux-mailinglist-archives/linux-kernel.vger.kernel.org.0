Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 485007ACED
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 17:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbfG3PyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 11:54:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:38628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbfG3PyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:54:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49D5320693;
        Tue, 30 Jul 2019 15:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564502063;
        bh=k6CX9KEHvBk/IiymUjhqZ6rZstuFcOFgtsdawlCcPrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y0TZQcG5HYJNHMqjmrglfX/lSzIIepTs/dWF31QCxJSbKJF+C0OwgJ3YmZYeYlvM/
         Exgylz96ytkVOE/kzMq0Oe0M1WnnWon1YJMoiSlRGZdDcm226IMIPrPm2Tadb8XD93
         rKbSP0oSnUuA8WXPa37XHgRfJ3rn4+6Q5omGPVcc=
Date:   Tue, 30 Jul 2019 17:54:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-serial@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/24] LPUART fixes and improvements
Message-ID: <20190730155421.GA15705@kroah.com>
References: <20190729195226.8862-1-andrew.smirnov@gmail.com>
 <20190730155357.GA5448@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730155357.GA5448@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 05:53:57PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jul 29, 2019 at 12:52:02PM -0700, Andrey Smirnov wrote:
> > Everyone:
> > 
> > This series contains fixes/improvements to LPUART dirver I came up
> > with recently as well as fixes picked up from Toradex and NXP Vybrid
> > repos.
> > 
> > Feedback is welcome!
> 
> Nice cleanups, all now queued up.

Oops, nope, not all, have a build error...
