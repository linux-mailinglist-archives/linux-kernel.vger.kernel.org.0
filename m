Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 935C7122583
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 08:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbfLQHcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 02:32:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:39948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfLQHcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 02:32:45 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AA6A2067C;
        Tue, 17 Dec 2019 07:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576567964;
        bh=LvGNy4jwZcjZ2FC9z7SzUSrcjdGGjkvtUBsizwqfRIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S4SFvWVceGxQnXWAiN2fBl4g5EcVvzzbnsVSf6ldZ4u2JU8aYqjCUnTNqhJjkwC4F
         JnLv95zXmo7VA34W4BbezHPtqgxU5+8RwTyt2zESbKbuffhTKTWJf/q2xAk+DQqaiz
         agU7IKALm/WwtEbo3p/SGjPZQSriOot5Dcv5PIc4=
Date:   Tue, 17 Dec 2019 08:32:42 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pan Zhang <zhangpan26@huawei.com>
Cc:     hushiyuan@huawei.com, ulf.hansson@linaro.org, allison@lohutok.net,
        tglx@linutronix.de, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mmc: host: use kzalloc instead of kmalloc and memset
Message-ID: <20191217073242.GB2472756@kroah.com>
References: <1576567086-11469-1-git-send-email-zhangpan26@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576567086-11469-1-git-send-email-zhangpan26@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 03:18:06PM +0800, Pan Zhang wrote:
> Signed-off-by: Pan Zhang <zhangpan26@huawei.com>
> ---
>  drivers/mmc/host/vub300.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

What changed from v1?  Always put that below the --- line.
