Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A015522ED6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 10:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730599AbfETIac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 04:30:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727878AbfETIab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:30:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5A9B20815;
        Mon, 20 May 2019 08:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558341029;
        bh=tZDNdez/lL2GlN0vbsvNhon4IRZJAWq0k4THPvqcEfo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D5TPMne8RFbuCiGQUHl7kfJHoAQXsPj5GkN6D2NI9WF5vWKj8scGDEdiFEN1NhJPP
         BW2yAH3DYEgiqxu8qoSjDBSGdYZ5tRq/j6t7eVwr/BByB2fcR4SVx88HirLzKfjP9P
         huzb74C4c9Iw8Se9qG4CBPrlVZFcwH10BHIolKZk=
Date:   Mon, 20 May 2019 10:30:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Geordan Neukum <gneukum1@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Updates to staging driver: kpc_i2c
Message-ID: <20190520083026.GA13877@kroah.com>
References: <cover.1558146549.git.gneukum1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1558146549.git.gneukum1@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 18, 2019 at 02:29:55AM +0000, Geordan Neukum wrote:
> Attached are an assortment of updates to the kpc_i2c driver in the
> staging subtree.

All now queued up.  I'll rebase my patches that move this file on top of
yours, as kbuild found some problems with mine, and I'll resend them to
the list.

thanks,

greg k-h
