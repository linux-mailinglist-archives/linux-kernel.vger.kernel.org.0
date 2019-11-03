Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50E28ED38B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2019 15:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbfKCOQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Nov 2019 09:16:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:42736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727444AbfKCOQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 09:16:48 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83F2120663;
        Sun,  3 Nov 2019 14:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572790608;
        bh=5fdRE0Vf9HsjaP8y0vf5TwsptV7mEynWeNXAagIs/RA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TzeJVEBYPhxfzXDpw7cQT/WHPK28cfEViYLjWQMjPF3EEj8tGlHdcOpWPGF0hfYbe
         m/KJC3AKuagNksKGDLcpXI+hrzPV07myxb48iguDV53tz68nSymy5BGL8pboUQRdid
         mGOH4d1vUs2P4JiggrI45B/HQJJ+Rd6QPCnluaI4=
Date:   Sun, 3 Nov 2019 15:16:45 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "yanghui.def@gmail.com" <yanghui.def@gmail.com>
Cc:     linux-kernel@vger.kernel.org, mirq-linux@rere.qmqm.pl,
        balbi@kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 2/2] USB(u_serial.c): it has a NULL point
Message-ID: <20191103141645.GA661271@kroah.com>
References: <5dbeddab.1c69fb81.244fa.5f8c@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dbeddab.1c69fb81.244fa.5f8c@mx.google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2019 at 10:01:11PM +0800, yanghui.def@gmail.com wrote:

html email is deleted by the list :(
