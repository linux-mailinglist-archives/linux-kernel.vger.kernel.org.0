Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFA3109BAB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 11:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfKZKDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 05:03:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:59228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727624AbfKZKDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 05:03:07 -0500
Received: from localhost (unknown [84.241.194.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0B2C20748;
        Tue, 26 Nov 2019 10:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574762587;
        bh=xGCbmWzbnll5u+eUEBhlLq9PaIZXUzSktU0Zep/ysCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pVv/S5rB/RT7k38s/y6I+wBOdR3BXz5AqD5h0tdiW1EU+8mfMW6Lw5CQ5gi1rbo82
         mdB5e6nGtA8MDtZQ/UPNyEVDn/oiWN0RF2Q3UoADk/xYiBkSVWE/j8ZSmuOxiywDaU
         iJOm4EXzr4rfykmeYGl8TLSHdVT7cSRyeZDBbufs=
Date:   Tue, 26 Nov 2019 10:57:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     kc27041980@gmail.com
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] block/drbd/drbd_debugfs.c: Protect &connection->kref
 with resource->req_lock
Message-ID: <20191126095738.GA1415341@kroah.com>
References: <1574742858-23131-1-git-send-email-KC17041980@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574742858-23131-1-git-send-email-KC17041980@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 10:04:18AM +0530, kc27041980@gmail.com wrote:
> From: KC27041980 <kc27041980@gmail.com>
> 
> Protect &connection->kref by moving it under resource->req_lock.
> 
> Signed-off-by: KC27041980 <kc27041980@gmail.com>

We need a real name here, something you sign legal documents with.
Please see the in-kernel documentation about submitting patches for all
of the details.

thanks,

gre gk-h
