Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFAABC0B20
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2019 20:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbfI0Scz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 14:32:55 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:35308 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfI0Scy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 14:32:54 -0400
Received: from localhost (231-157-167-83.reverse.alphalink.fr [83.167.157.231])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2BF3C153F0BAF;
        Fri, 27 Sep 2019 11:32:50 -0700 (PDT)
Date:   Fri, 27 Sep 2019 20:32:49 +0200 (CEST)
Message-Id: <20190927.203249.1546413118601715111.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     netanel@amazon.com, saeedb@amazon.com, zorik@amazon.com,
        akiyano@amazon.com, sameehj@amazon.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ena: clean up indentation issue
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190926112252.21498-1-colin.king@canonical.com>
References: <20190926112252.21498-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 27 Sep 2019 11:32:54 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Thu, 26 Sep 2019 12:22:52 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> There memset is indented incorrectly, remove the extraneous tabs.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.
