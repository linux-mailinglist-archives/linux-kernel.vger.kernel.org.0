Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1DE0F3148
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 15:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389375AbfKGOWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 09:22:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:37892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731082AbfKGOWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 09:22:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16AB7207FA;
        Thu,  7 Nov 2019 14:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573136555;
        bh=akvOYSauuJ0WgIPLTQ/bX/mbeqgYeGG21a58QOC9wzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h5SL8/+mQ+QmvPn7yQVU78E2E5oXPg/4NnOkx615xbu69yepjgXAdvWtPKfmE8qOx
         XFZ1qmY+9B86oJRKoI1UbuCVrZubN7sIThil4Dd+YfJm5z1QweWxLRP3yTzvCPQk2i
         0urWNfZcqFZhr1SOTw1SEic8nq8XyD5Y0HBrX478=
Date:   Thu, 7 Nov 2019 15:22:33 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Valery Ivanov <ivalery111@gmail.com>
Cc:     devel@drivrdev.osuosl.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Wambui Karuga <wambui.karugax@gmail.com>
Subject: Re: [PATCH] staging: octeon: fix missing a blank line after
 declaration
Message-ID: <20191107142233.GA120709@kroah.com>
References: <20191107141335.17641-1-ivalery111@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107141335.17641-1-ivalery111@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 02:13:22PM +0000, Valery Ivanov wrote:
> 	This patch fixes "WARNING: Missing a blank line after declarations"
> 	Issue found by checkpatch.pl

Why the huge indentation?

Please fix that up and send a v2.

thanks,

greg k-h
