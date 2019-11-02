Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69162ECFDD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2019 18:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfKBRKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Nov 2019 13:10:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbfKBRKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 13:10:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D148920862;
        Sat,  2 Nov 2019 17:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572714652;
        bh=fZkewWYuXTeElpKvFb4vXZ0PDkAB2kjd3Z1zk+ormOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tVC5iBHKzgLhuG1k/wU2jKqC+IpHhbDldsQsExkVTS0DmhBnV+yzREsBwNAmcBTrL
         bgYxZVS96AhudIYfZy5jgq5mrWQKHGOmW1hCR8YSF/9Kg+s9HT/aHMJi85vtmUANeq
         YO4PZTUB2ziU+QASc8CfIzKgz4oYI7mXXSW0dpmU=
Date:   Sat, 2 Nov 2019 18:10:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     akinobu.mita@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] fault-inject: use DEFINE_DEBUGFS_ATTRIBUTE to
 define debugfs fops
Message-ID: <20191102171050.GB479906@kroah.com>
References: <1572486977-14195-1-git-send-email-zhongjiang@huawei.com>
 <1572486977-14195-3-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572486977-14195-3-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 09:56:17AM +0800, zhong jiang wrote:
> It is more clearly to use DEFINE_DEBUGFS_ATTRIBUTE to define debugfs file
> operation rather than DEFINE_SIMPLE_ATTRIBUTE.
> 
> Meanwhile, debugfs_create_file() in debugfs_create_stacktrace_depth() can
> be replaced by debugfs_create_file_unsafe().

Why is it ok to do this replacement?  You should describe in detail how
you determined this was ok to do.

thanks,

greg k-h
