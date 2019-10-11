Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1D8D3BD3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 11:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbfJKJBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 05:01:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbfJKJBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 05:01:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D28002084C;
        Fri, 11 Oct 2019 09:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570784463;
        bh=dip7WC1d3rYrivzNjiGrxb+JxW/shzeEbWuhLH4bGU4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OeoZJMrz6g7GMmqtbXAue4SM8x4nJovtuam288P3K9MefGoPi+gXjDeWLkcB10tCC
         JUmUCoaRNjKC0W1+YBri/KJIfafpU/7nWO/grf4/BdSwzK6xU+F0RuClWm6bjLhJwj
         6Wcy9Tsl1by9TdfFqlEqxndt7IyHlWBYuUyeJsbA=
Date:   Fri, 11 Oct 2019 11:01:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wambui Karuga <wambui.karugax@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Remove declarations of new typedef in
Message-ID: <20191011090100.GA1076760@kroah.com>
References: <cover.1570773209.git.wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1570773209.git.wambui.karugax@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 09:02:37AM +0300, Wambui Karuga wrote:
> This patchset removes various typedef declarations of new data types
> in drivers/staging/octeon/octeon-stubs.h.
> The series also changes their old uses with the new declaration
> format.

The subject line of this email seems to be lacking something :)

thanks,

greg k-h
