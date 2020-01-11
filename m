Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08BB313836E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jan 2020 21:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731179AbgAKUCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jan 2020 15:02:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:56100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730994AbgAKUCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 15:02:11 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79CF42087F;
        Sat, 11 Jan 2020 20:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578772931;
        bh=ZBIqsTYG9Bnf5Rz+zTX6stlReOCRBtZYSfd8G4JzGR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZLlfuaS4izGTa0NGSQmCR6k3iG2+OMtZ9Ho5Bx+7tPGgjFt4W0pTdONhvpRRTss+V
         7ah3m4GNSOZSpwKFa8RHsxVrWYuqP2mMTqhP7ynrmwWAmI6GXWIxNdfuqKT9ojBPa8
         JOqLDdb4YrlxmQNjBWDl4woaz6Vwat7v+x89uhWw=
Date:   Sat, 11 Jan 2020 20:47:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhengbin <zhengbin13@huawei.com>
Cc:     jslaby@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] tty: use true,false for bool variable
Message-ID: <20200111194758.GB438314@kroah.com>
References: <1577180285-24904-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577180285-24904-1-git-send-email-zhengbin13@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 24, 2019 at 05:38:01PM +0800, zhengbin wrote:
> zhengbin (4):

I need a "real" name here, one that you use to sign documents.

Can you fix that up for all 4 of these patches and resend the series?

thanks,

greg k-h
